import React from 'react';
import { useNavigate } from 'react-router-dom';
import PropTypes from 'prop-types';
import debug from 'sabio-debug';

function PrivateBookingCard(props) {
    const _logger = debug.extend('PrivateBookingCard');
    _logger('PrivateBookingCard');

    const navigate = useNavigate();

    const aBooking = props.booking;

    const workshop = props.workshopData;

    const onLocalDeleteClicked = (evt) => {
        evt.preventDefault();
        props.onBookingClicked(aBooking, evt);
    };

    _logger(workshop);

    const navigateOnEditBookingClick = () => {
        const state = { type: 'PRIVATEBOOKING_VIEW', payload: aBooking };
        navigate(`/workshoprequests/${aBooking.id}/new`, { state });
    };

    return (
        <div className="col-md-3">
            <div className="card">
                <div className="card-body">
                    <h4>Name</h4>
                    <p className="card-text">{aBooking.name}</p>
                    <h4>Email</h4>
                    <p className="card-text">{aBooking.email}</p>
                    <h4>Number Of People Attending</h4>
                    <p className="card-text">{aBooking.numberOfPeopleAttending}</p>
                    <h4>Number Of Sessions</h4>
                    <p className="card-text">{aBooking.numberOfSessions}</p>
                    <button className="btn btn-primary" onClick={navigateOnEditBookingClick}>
                        Edit
                    </button>
                    <button className="btn btn-danger" onClick={onLocalDeleteClicked}>
                        Delete
                    </button>
                </div>
            </div>
        </div>
    );
}

PrivateBookingCard.propTypes = {
    onBookingClicked: PropTypes.func.isRequired,
    booking: PropTypes.shape({
        id: PropTypes.number.isRequired,
        name: PropTypes.string.isRequired,
        email: PropTypes.string.isRequired,
        numberOfPeopleAttending: PropTypes.number.isRequired,
        numberOfSessions: PropTypes.number.isRequired,
        workshopId: PropTypes.number.isRequired,
        userId: PropTypes.number.isRequired,
    }),
    workshopData: PropTypes.shape({
        id: PropTypes.number.isRequired,
        name: PropTypes.string.isRequired,
        imageUrl: PropTypes.string.isRequired,
        summary: PropTypes.string,
        shortDescription: PropTypes.string,
    }),
};

export default PrivateBookingCard;
