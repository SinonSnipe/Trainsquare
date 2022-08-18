import React, { useState, useEffect } from 'react';
import { Card, Table, Button, Pagination, Modal, Row, Col } from 'react-bootstrap';
import debug from 'sabio-debug';
import propTypes from 'prop-types';
import CardTitle from '../dashboard/user/cardtitles/CardTitle';
import WorkShopsSearch from '../dashboard/user/workshops/WorkShopsSearch';
import * as favoriteWorkshopService from '../../services/favoriteWorkshopService';
import '../dashboard/user/userDashboard.css';
import './FavoriteWorkshops.css';
import FavoriteWorkshops from './FavoriteWorkshops';

const _logger = debug.extend('FavoriteWorkshop');

const Workshops = (props) => {
    _logger('props', props);

    const [userInput, setUserInput] = useState('');
    const [favoriteWorkshops, setFavoriteWorkshops] = useState({
        currentPage: 1,
        pageIndex: 0,
        pageSize: 5,
        workshops: [],
    });

    // _logger('favorite workshops', favoriteWorkshops.workshops);

    useEffect(() => {
        if (userInput) {
            favoriteWorkshopService
                .search(favoriteWorkshops.pageIndex, favoriteWorkshops.pageSize, userInput)
                .then(onGetFavoriteWorkshopsSuccess)
                .catch(onGetFavoriteWorkshopsError);
        } else {
            favoriteWorkshopService
                .getUserFavoriteWorkshops(favoriteWorkshops.pageIndex, favoriteWorkshops.pageSize)
                .then(onGetFavoriteWorkshopsSuccess)
                .catch(onGetFavoriteWorkshopsError);
        }
    }, [favoriteWorkshops.pageIndex, userInput]);

    const onFavoriteSearchInputChanged = (e) => {
        const { value } = e.target;
        setUserInput(() => value);
        _logger('e', e);
    };

    const onGetFavoriteWorkshopsSuccess = (data) => {
        let arrayOfWorkshops = data.item.pagedItems;
        let pageIndex = data.item.pageIndex;
        let ps = data.item.pageSize;
        let totalPages = data.item.totalPages;
        let totalCount = data.item.totalCount;
        _logger('success', arrayOfWorkshops);
        setFavoriteWorkshops((prevState) => {
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

    const mapWorkshops = (workshop) => {
        return <WorkShopsSearch workshopData={workshop} key={`${workshop.id}w`} />;
    };

    const onGetFavoriteWorkshopsError = (data) => {
        _logger('Error', data);
    };

    const [info, setInfo] = useState(false);
    const [size, setSize] = useState(null);
    const [scroll, setScroll] = useState(null);

    const [selectedFavoriteWorkshop, setselectedFavoriteWorkshop] = useState({});

    const toggle = () => {
        setInfo(!info);
    };

    const openModalWithSize = (size) => {
        setSize(size);
        setScroll(null);
        toggle();
    };

    const onInfoClick = (id) => {
        const result = favoriteWorkshops.workshops.filter((workshop) => workshop.id === id);
        _logger('onInfoClick', favoriteWorkshops.workshops);
        if (result.length > 0) {
            setselectedFavoriteWorkshop(result[0]);
            openModalWithSize('lg');
        }
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

    const mapFavoriteWorkshop = (aWorkshop) => {
        const { id, name, dateStart, workShopStatus, isFree, dateEnd, host, summary } = aWorkshop;
        const newDateStart = new Date(dateStart);
        const start = newDateStart.toLocaleDateString();
        const newDateEnd = new Date(dateEnd);
        const end = newDateEnd.toLocaleDateString();
        return (
            <tr key={`id, ${id}`}>
                <td>
                    <h5 className="font-14 my-1">
                        <FavoriteWorkshops data={aWorkshop.id} />
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
                        title="Favorite Workshops"
                    />
                    <WorkShopsSearch searchInput={userInput} onSearchInputChanged={onFavoriteSearchInputChanged} />
                    <p>Workshop Names</p>
                    <div className="workshopTable">
                        <Table responsive hover className="table-centered table-nowrap mb-0">
                            <tbody>{favoriteWorkshops.workshops.map(mapFavoriteWorkshop)}</tbody>
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
                    <h4 className="modal-title">{selectedFavoriteWorkshop.name}</h4>
                </Modal.Header>
                <Modal.Body>
                    <img src={selectedFavoriteWorkshop.imageUrl} alt="" className="modal-body" />
                    <Row>
                        <Col sm={6}>
                            <div style={{ textAlign: 'center' }}>
                                <h4>About Workshop</h4>
                            </div>
                            <p>{selectedFavoriteWorkshop.shortDescription}</p>
                            <p>Cost: {selectedFavoriteWorkshop.isFree ? 'Free' : 'Pay for Entry'}</p>
                            <p>Sessions: {selectedFavoriteWorkshop.numberOfSessions}</p>
                            <p>Start Date: {handleDateTime(selectedFavoriteWorkshop.dateStart)}</p>
                            <p>End Date: {handleDateTime(selectedFavoriteWorkshop.dateEnd)}</p>
                        </Col>
                        <Col sm={6}>
                            <div style={{ textAlign: 'center' }}>
                                <h4>About Host</h4>
                                <img
                                    src={selectedFavoriteWorkshop?.host?.avatarUrl}
                                    alt=""
                                    className="img-thumbnail avatar-xl rounded-circle"
                                />
                                <p>
                                    {selectedFavoriteWorkshop?.host?.firstName}{' '}
                                    {selectedFavoriteWorkshop?.host?.lastName}{' '}
                                </p>
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
    setUptotal: propTypes.func,
};

export default Workshops;
