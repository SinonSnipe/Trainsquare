import React from 'react';
import PropTypes from 'prop-types';
import {Card} from 'react-bootstrap';


const LocationCard = (props) => {
    const location = props.location;
    const onDeleteClicked = (evt) => {
        evt.preventDefault();
        props.onClickDeleteLocation(location);
    };
    const onUpdateClicked = (evt) => {
        evt.preventDefault();
        props.onClickUpdateLocation(location);
    };
    return(
        <Card  style={{border: "dashed", borderRadius: '1rem', width: '18rem', height: '22rem', margin: '1rem'}} >
            <Card.Header className='text-center'>{location.locationType}</Card.Header>
            <Card.Body>
                <p>{location.lineOne}</p>  
                <p>{location.lineTwo}</p>
                <p>{location.city}, {location.zip} {location.state}</p>
                <p>Latitude: {location.latitude}</p> 
                <span>Longitude: {location.longitude}</span>
            </Card.Body>
            <Card.Footer>
            <a onClick ={onUpdateClicked} 
            >edit</a>
            <a> | </a>
            <a onClick ={onDeleteClicked} 
            >delete</a>
            </Card.Footer>
        </Card>
    )};

    LocationCard.propTypes = {
        location: PropTypes.shape({
            city: PropTypes.string.isRequired,
            id: PropTypes.number.isRequired,
            latitude: PropTypes.number.isRequired,
            lineOne:  PropTypes.string.isRequired,
            lineTwo:  PropTypes.string,
            locationType:  PropTypes.string.isRequired,
            longitude: PropTypes.number.isRequired,
            state:  PropTypes.string.isRequired,
            zip:  PropTypes.string,
        }),
        onClickDeleteLocation: PropTypes.func,
        onClickUpdateLocation: PropTypes.func,
    };


    export default LocationCard;