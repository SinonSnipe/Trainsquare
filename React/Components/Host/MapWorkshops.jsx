import React from 'react';
import { Col, Card } from 'react-bootstrap';
import PropTypes from 'prop-types';
import './host.css';
//import debug from 'sabio-debug';

//const _log = debug.extend('mapWorkshops');

const MapWorkShops = (props) => {
    const workshop = props.workshop;

    return (
        <Col sm={3}>
            <Card className="ws-card">
                <img
                    src={workshop.imageUrl}
                    referrerPolicy="no-referrer"
                    alt="https://tinyurl.com/5fpfafj7"
                    className="ws-img"
                />
                <h4>{workshop.name}</h4>
                <p className="card-text workshop-p-text">{`${workshop.shortDescription}`}</p>
            </Card>
        </Col>
    );
};

MapWorkShops.propTypes = {
    workshop: PropTypes.shape({
        id: PropTypes.number,
        name: PropTypes.string,
        summary: PropTypes.string,
        shortDescription: PropTypes.string,
        venueId: PropTypes.number,
        hostId: PropTypes.number,
        dateCreated: PropTypes.string,
        dateModified: PropTypes.string,
        statusId: PropTypes.number,
        dateStart: PropTypes.string,
        dateEnd: PropTypes.string,
        imageUrl: PropTypes.string,
        length: PropTypes.string,
    }).isRequired,
};
export default MapWorkShops;
