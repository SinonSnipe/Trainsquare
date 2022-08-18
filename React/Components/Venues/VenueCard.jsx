import React from 'react';
import debug from 'sabio-debug';
import PropTypes from 'prop-types';
import './venue.css';
import Rating from 'react-rating';
import { Card } from 'react-bootstrap';
import Swal from 'sweetalert2';


const _logger = debug.extend('VenueCard');

function VenueCard(props) {
    const aVenue = props.venue;
    _logger('venue props', props, aVenue);

    const onLocalEditClicked = () => {
        props.editHandle(aVenue);
        return aVenue;
    };

    const onLocalVenueClicked = (evt) => {
        Swal.fire({
            title: `Are you sure want to delete ${aVenue.name}?`,
            text: 'Venue will be deleted.',
            icon: 'warning',
            confirmButtonText: 'Confirm Delete',
            showCancelButton: true,
            showConfirmButton: true,
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire('Venue Deleted!', 'success');
                props.onDeleteClicked(props.venue, evt);
            }
        });
    };

    const onLocalBookVenueClicked = () => {
        props.bookVenueHandle(aVenue);
        return aVenue;
    }
    return (
        <Card.Body>
            <div className="container col col-lg-6" style={{ width: "500px"}}>
    
                <div style={{ display: "flex", height: "800px" }} className="card border border-dark rounded bg-gradient bg-light text-black m-1 shadow-lg">
           
                    <img src={aVenue.imageUrl} className="card-img-top" style={{height: "250px"}} alt={aVenue.name} />
                    <div className="card-body" style={{height: "350px"}}>
                        <h5 className="card-title">{aVenue.name}</h5>
                        <p className="card-text">{aVenue.description}</p>
                        <a className="card-text" href={aVenue.url}>
                            {aVenue.url}
                        </a>
                        <h5 className="card-text">Address</h5>
                        
                        <p className="card-text">
                            {aVenue.location.lineOne}, {aVenue.location.city} {aVenue.location.zip}
                        </p>
                        
                    </div>
                    <div className="row">      
                        <h4 className="header-title mx-3">Rating</h4>
                        <Rating
                            className="mx-3"
                            initialRating={2}
                            emptySymbol="mdi mdi-star-outline font-22 text-muted"
                            fullSymbol="mdi mdi-star font-22 text-warning"
                            fractions={2}
                        />
                    </div>
                    <div className="card-body text-center">
                        <button className="btn btn-info" onClick={onLocalBookVenueClicked}>
                            Book Venue
                        </button>
                        <button className="btn btn-primary buttonspacing" onClick={onLocalEditClicked}>
                            Edit
                        </button>
                        <button className="btn btn-danger" onClick={onLocalVenueClicked}>
                            Remove
                        </button>
                    </div>
                </div>
            </div>
        </Card.Body>
    );
}

VenueCard.propTypes = {
    venue: PropTypes.shape({
        id: PropTypes.number,
        name: PropTypes.string.isRequired,
        description: PropTypes.string.isRequired,
        url: PropTypes.string.isRequired,
        locationId: PropTypes.number,
        imageUrl: PropTypes.string,
        location: PropTypes.string,
    }),
    onDeleteClicked: PropTypes.func.isRequired,
    editHandle: PropTypes.func.isRequired,
    bookVenueHandle: PropTypes.func.isRequired,
};

export default VenueCard;
