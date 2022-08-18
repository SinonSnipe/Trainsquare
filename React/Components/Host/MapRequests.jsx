import React from 'react';
import PropTypes from 'prop-types';
import { Card, Col } from 'react-bootstrap';

import debug from 'sabio-debug';
const _log = debug.extend('MapRequests');

const MapRequests = (request) => {
    _log('MapRequests', request.request);
    const WorkshopRequest = request.request;
    
    return (
        <Col sm={3}>
            <Card className="request-card">
                
                <img src={WorkshopRequest.avatarUrl} alt="https://tinyurl.com/5fpfafj7" className="request-img" />
                <h4>{WorkshopRequest.topic}</h4>
                <p className="card-text workshop-p-text">{`${WorkshopRequest.briefDescription}`}</p>
            </Card>
        </Col>
    );
};

MapRequests.propTypes = {
    request: PropTypes.shape({
        avatarUrl: PropTypes.string.isRequired,
        briefDescription: PropTypes.string.isRequired,
        dateCreated: PropTypes.string.isRequired,
        dateModified: PropTypes.string.isRequired,
        firstName: PropTypes.string.isRequired,
        hostId: PropTypes.number.isRequired,
        id: PropTypes.number.isRequired,
        lastName: PropTypes.string.isRequired,
        topic: PropTypes.string.isRequired,
        userId: PropTypes.number.isRequired,
    }).isRequired,
};

export default MapRequests;
