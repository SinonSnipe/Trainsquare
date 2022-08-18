import React, { useState } from 'react';
import { Card, Table, Button, Pagination, Modal, Row, Col } from 'react-bootstrap';
import propTypes from 'prop-types';
import CardTitle from '../dashboard/user/cardtitles/CardTitle';
import WorkShopsSearch from '../dashboard/user/workshops/WorkShopsSearch';
import './FavoriteWorkshops.css';

import debug from 'sabio-debug';
const _logger = debug.extend('Favorites Admin Dashboard');

const FavoriteWorkshopsAdminDashboard = (props) => {
    _logger(props);

    const { favoriteWorkshop } = props;

    const [info, setInfo] = useState(false);
    const [size, setSize] = useState(null);
    const [scroll, setScroll] = useState(null);

    const [selectedWorkshop, setSelectedWorkshop] = useState({});

    const toggle = () => {
        setInfo(!info);
    };
    const openModalWithSize = (size) => {
        setSize(size);
        setScroll(null);
        toggle();
    };

    const onInfoClick = (id) => {
        const result = favoriteWorkshop.filter((workshop) => workshop.id === id);
        if (result.length > 0) {
            setSelectedWorkshop(result[0]);
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

    const nextClicked = () => {
        _logger('Next button clicked');
    };

    _logger(favoriteWorkshop);

    const mapWorkshop = (aWorkshop) => {
        _logger(aWorkshop);
        const { id, name, dateStart, workShopStatus, isFree, dateEnd, host, summary, totalFavorited } = aWorkshop;

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
                    <h5 className="font-14 my-1">
                        <span className="text-body">Total Favorites</span>
                    </h5>
                    <span className="text-muted font-13">{totalFavorited}</span>
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
                        title="Top Favorited Workshops"
                    />
                    <WorkShopsSearch />
                    <div className="workshopTable">
                        <Table responsive hover className="table-centered table-nowrap mb-0">
                            <tbody>{favoriteWorkshop.map(mapWorkshop)}</tbody>
                        </Table>
                    </div>
                </Card.Body>
                <div style={{ display: 'flex', justifyContent: 'center' }}>
                    <Pagination>
                        <Pagination.First />
                        <Pagination.Prev />
                        <Pagination.Item active>{1}</Pagination.Item>

                        <Pagination.Next onClick={nextClicked} />
                        <Pagination.Last />
                    </Pagination>
                </div>
            </Card>
            <Modal show={info} onHide={toggle} size={size} scrollable={scroll}>
                <Modal.Header onHide={toggle} closeButton>
                    <h4 className="modal-title">{selectedWorkshop.name}</h4>
                </Modal.Header>
                <Modal.Body>
                    <img src={selectedWorkshop.imageUrl} alt="" className="modal-body" />
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
FavoriteWorkshopsAdminDashboard.propTypes = {
    favoriteWorkshop: propTypes.arrayOf(
        propTypes.shape({
            name: propTypes.string.isRequired,
            id: propTypes.number.isRequired,
            isFree: propTypes.bool.isRequired,
            workShopStatus: propTypes.string.isRequired,
            dateStart: propTypes.string.isRequired,
            dateEnd: propTypes.string.isRequired,
        })
    ),
};
export default FavoriteWorkshopsAdminDashboard;
