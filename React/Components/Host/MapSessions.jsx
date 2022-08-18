import React from 'react';
import { Col, Card } from 'react-bootstrap';
import PropTypes from 'prop-types';
import './host.css';

import debug from 'sabio-debug';
const _log = debug.extend('Sessions');

const MapSessions = (props) => {
    const session = props.session;
    _log(session);

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

            return `${months[month - 1]} ${date}, ${year}`;
        }
    };

    return (
        <Col sm={3}>
            <Card className="ws-card">
                <img
                    src={session.imageUrl}
                    referrerPolicy="no-referrer"
                    alt="https://tinyurl.com/5fpfafj7"
                    className="ws-img"
                />
                <h4>{session.name}</h4>
                <h6>{handleDateTime(session.date)}</h6>
                <p className="card-text workshop-p-text">{`${session.totalSlots - session.openSlots} seats filled`}</p>
            </Card>
        </Col>
    );
};

MapSessions.propTypes = {
    session: PropTypes.shape({
        id: PropTypes.number.isRequired,
        imageUrl: PropTypes.string.isRequired,
        name: PropTypes.string.isRequired,
        date: PropTypes.string.isRequired,
        totalSlots: PropTypes.number.isRequired,
        openSlots: PropTypes.number.isRequired,
        startTime: PropTypes.string.isRequired,
        endTime: PropTypes.string.isRequired,
    }),
};

export default MapSessions;
