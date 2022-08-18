import React, { useState, useEffect } from 'react';
import { Card, Table, Button, Pagination, Modal, Row, Col } from 'react-bootstrap';
import debug from 'sabio-debug';
import propTypes from 'prop-types';

import CardTitle from '../cardtitles/CardTitle';
import WorkShopsSearch from './WorkShopsSearch';
import * as workshopService from '../../../../services/workShopService';
import '../userDashboard.css';
import toastr from 'toastr';

const _logger = debug.extend('Workshops'); //sabio:Workshops
_logger('Nolden-Workshops');

const Workshops = (props) => {
    const [info, setInfo] = useState(false);
    const [size, setSize] = useState(null);
    const [scroll, setScroll] = useState(null);
    const [selectedWorkshop, setSelectedWorkshop] = useState({});
    const [userWorkshops, setUserWorkshops] = useState([
        {
            workshopId: 0,
            registrationStatus: '',
        },
    ]);
    const [isRegistered, setIsRegistered] = useState(false);
    const [userInput, setUserInput] = useState('');
    const [workshops, setWorkshops] = useState({
        currentPage: 1,
        pageIndex: 0,
        pageSize: 5,
        workshops: [],
    });

    const toggle = () => {
        setInfo(!info);
    };
    const openModalWithSize = (size) => {
        setSize(size);
        setScroll(null);
        toggle();
    };

    useEffect(() => {
        if (userInput) {
            workshopService
                .search(workshops.pageIndex, workshops.pageSize, userInput)
                .then(onGetWorkShopSuccess)
                .catch(onGetWorkShopError);
        } else {
            workshopService
                .paginate(workshops.pageIndex, workshops.pageSize)
                .then(onGetWorkShopSuccess)
                .catch(onGetWorkShopError);
        }
        workshopService.getWorkshopIdByUser().then(onGetWorkshopIdsSuccess).catch(onGetWorkshopIdsError);
    }, [workshops.pageIndex, userInput, isRegistered]);

    const mapWorkshops = (workshop) => {
        return <WorkShopsSearch workshopData={workshop} key={`${workshop.id}w`} />;
    };

    const onSearchInputChanged = (e) => {
        const { value } = e.target;
        setUserInput(() => value);
    };

    const onInfoClick = (id) => {       
        const result = workshops.workshops.filter((workshop) => workshop.id === id);
        if (Array.isArray(result) && result.length > 0) {
            setSelectedWorkshop(result[0]);
            openModalWithSize('lg');
            _logger('ID sent to INFOCLICK', id);

            if (userWorkshops) {
                let idx = userWorkshops.findIndex(
                    (workshop) =>
                        workshop.workshopId === id && workshop.registrationStatus === ('Registered' || 'Pending')
                );

                if (idx !== -1) {
                    setIsRegistered(true);
                } else {
                    setIsRegistered(false);
                }
            } else {
                setIsRegistered(false);
            }
        }
    };

    const onRegisterButtonClick = (selectedWorkshopId) => {
        if (userWorkshops) {
            let wsToUnregi = userWorkshops.filter(
                (workshop) => workshop.workshopId === selectedWorkshopId && workshop.registrationStatus === 'Registered'
            );

            if (wsToUnregi.length > 0) {
                workshopService
                    .unregisterUpdate(selectedWorkshopId, 4)
                    .then(onUnregisterSuccess)
                    .catch(onUnregisterError);
            } else {
                workshopService.registerAdd(selectedWorkshopId, 3).then(onRegisterSuccess).catch(onRegisterError);
            }
        } else {
            workshopService.registerAdd(selectedWorkshopId, 3).then(onRegisterSuccess).catch(onRegisterError);
        }
    };

    const onGetWorkshopIdsSuccess = (response) => {
        let userWorkshops = response.item;

        _logger('drilled Get Success response will be STATE -> registeredWorkshopIds', userWorkshops);
        setUserWorkshops((prevState) => {
            let ids = { ...prevState };
            ids = userWorkshops;
            return ids;
        });
    };

    const onGetWorkshopIdsError = (response) => {
        _logger('On Error', response);
    };

    const onGetWorkShopSuccess = (data) => {
        let arrayOfWorkshops = data.item.pagedItems;
        let pageIndex = data.item.pageIndex;
        let ps = data.item.pageSize;
        let totalPages = data.item.totalPage;
        let totalCount = data.item.totalCount;

        setWorkshops((prevState) => {
            const wsd = { ...prevState };
            wsd.workshops = arrayOfWorkshops;
            wsd.currentPage = pageIndex;
            wsd.pageSize = ps;
            wsd.totalPages = totalPages;
            wsd.totalCount = totalCount;
            wsd.workshopComponents = arrayOfWorkshops.map(mapWorkshops);
            return wsd;
        });
        props.setUptotal(totalCount);
    };

    const onGetWorkShopError = (data) => {
        _logger('Error', data);
    };

    const onRegisterSuccess = (response) => {
        _logger('On Add Success', response);
        toastr.success('Successfully registered for workshop');

        let newWorkshopRegistered = response.id;

        setUserWorkshops((prevState) => {
            let addId = { ...prevState };
            addId = newWorkshopRegistered;
            _logger('new registered Id', addId);
            return addId;
        });

        setIsRegistered(true);
    };

    const onRegisterError = (response) => {
        _logger('On Error', response);
        toastr.error('Error unregistering for workshop. Please try again.');
    };

    const onUnregisterSuccess = (response) => {
        _logger('On Add Success', response);
        toastr.success('Successfully unregistered for workshop');

        let workshopUnregistered = response.id;

        setUserWorkshops((prevState) => {
            let removeId = { ...prevState };
            removeId = workshopUnregistered;
            _logger('new registered Id', removeId);
            return removeId;
        });

        setIsRegistered(false);
    };

    const onUnregisterError = (response) => {
        _logger('On Error', response);
        toastr.error('Error registering for workshop. Please try again.');
    };

    const handleDateTime = (dateTime) => {
        const months = [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July',
            'August',
            'September',
            'October',
            'November',
            'December',
        ];
        if (dateTime) {
            const date = new Date(dateTime).getDate();
            const month = new Date(dateTime).getMonth();
            const year = new Date(dateTime).getFullYear();
            const hour = new Date(dateTime).getHours();
            const minutes = new Date(dateTime).getMinutes();
            return `${months[month - 1]} ${date}, ${year} Time ${hour}:${minutes}`;
        }
    };

    const mapWorkshop = (aWorkshop) => {
        const { id, name, dateStart, workShopStatus, isFree, dateEnd, host, summary } = aWorkshop;

        const newDateStart = new Date(dateStart);
        const start = newDateStart.toLocaleDateString();

        const newDateEnd = new Date(dateEnd);
        const end = newDateEnd.toLocaleDateString();

        return (
            <tr key={`id, ${id}`}>
                <td>
                    <h5 className="font-14 my-1">
                        <span className="text-body">{name}</span>
                    </h5>
                    <span className="text-muted font-13">Start on {start}</span>
                </td>
                <td>
                    <span className="text-muted font-13">Summary</span>
                    <h5 className="font-14 mt-1 fw-normal">{summary}</h5>
                </td>
                <td>
                    <span className="text-muted font-13">Status</span> <br />
                    <span className={`badge badge-${workShopStatus === 'Active' ? 'success' : 'warning'}-lighten`}>
                        {' '}
                        {workShopStatus}
                    </span>
                </td>

                <td>
                    <span className="text-muted font-13">Cost</span>
                    <h5 className="font-14 mt-1 fw-normal">{isFree ? 'Free' : 'Paid'}</h5>
                </td>
                <td>
                    <span className="text-muted font-13">Host By</span>
                    <h5 className="font-14 mt-1 fw-normal">
                        {host.firstName} {host.lastName}
                    </h5>
                </td>
                <td>
                    <span className="text-muted font-13">Available Until</span>
                    <h5 className="font-14 mt-1 fw-normal"> {end}</h5>
                </td>
                <td className="table-action" style={{ width: '90px' }}>
                    <Button className="btn-sm mt-1" variant="info" onClick={() => onInfoClick(id)}>
                        Info
                    </Button>
                </td>
            </tr>
        );
    };

    return (
        <>
            <Card>
                <Card.Body>
                    <CardTitle
                        containerClass="d-flex align-items-center justify-content-between mb-2"
                        title="Workshops"
                    />
                    <WorkShopsSearch userInput={userInput} onSearchInputChanged={onSearchInputChanged} />
                    <p>Workshop Names</p>
                    <div className="workshopTable">
                        <Table responsive hover className="table-centered table-nowrap mb-0">
                            <tbody>{workshops.workshops.map(mapWorkshop)}</tbody>
                        </Table>
                    </div>
                </Card.Body>
                <div style={{ display: 'flex', justifyContent: 'center' }}>
                    <Pagination>
                        <Pagination.First />
                        <Pagination.Prev />
                        <Pagination.Item active>{1}</Pagination.Item>

                        <Pagination.Next />
                        <Pagination.Last />
                    </Pagination>
                </div>
            </Card>
            <Modal show={info} onHide={toggle} size={size} scrollable={scroll}>
                <Modal.Header onHide={toggle} closeButton>
                    <h4 className="modal-title">{selectedWorkshop.name}</h4>
                </Modal.Header>
                <Modal.Body>
                    <img
                        src={selectedWorkshop.imageUrl}
                        alt=""
                        style={{ maxWidth: '100%', height: '300px', display: 'block', margin: '0 auto 16px' }}
                    />
                    <Row>
                        <Col sm={6}>
                            <div style={{ textAlign: 'center' }}>
                                <h4>About Workshop</h4>
                            </div>
                            <p>{selectedWorkshop.shortDescription}</p>
                            <p>Cost: {selectedWorkshop.isFree ? 'Free' : 'Pay for Entry'}</p>
                            <p>Sessions: {selectedWorkshop.numberOfSessions}</p>
                            <p>Start Date: {handleDateTime(selectedWorkshop.dateStart)}</p>
                            <p>End Date: {handleDateTime(selectedWorkshop.dateEnd)}</p>
                        </Col>
                        <Col sm={6}>
                            <div style={{ textAlign: 'center' }}>
                                <h4>About Host</h4>
                                <img
                                    src={selectedWorkshop?.host?.avatarUrl}
                                    alt=""
                                    className="img-thumbnail avatar-xl rounded-circle"
                                />
                                <p>
                                    {selectedWorkshop?.host?.firstName} {selectedWorkshop?.host?.lastName}{' '}
                                </p>
                            </div>
                            <div style={{ textAlign: 'center' }}>
                                <Button variant="primary" onClick={() => onRegisterButtonClick(selectedWorkshop.id)}>
                                    {isRegistered ? 'Unregister From' : 'Register For'}
                                    <br />
                                    {selectedWorkshop.name}
                                </Button>
                            </div>
                        </Col>
                    </Row>
                </Modal.Body>
                <Modal.Footer>
                    <Button variant="light" onClick={toggle}>
                        Close
                    </Button>{' '}
                    <Button variant="danger" onClick={toggle}>
                        Cancel
                    </Button>
                </Modal.Footer>
            </Modal>
        </>
    );
};

Workshops.propTypes = {
    workshopData: propTypes.arrayOf(
        propTypes.shape({
            name: propTypes.string.isRequired,
            id: propTypes.number.isRequired,
            isFree: propTypes.bool.isRequired,
            workShopStatus: propTypes.string.isRequired,
            dateStart: propTypes.string.isRequired,
            dateEnd: propTypes.string.isRequired,
        })
    ),
    setUptotal: propTypes.func,
};

export default Workshops;
