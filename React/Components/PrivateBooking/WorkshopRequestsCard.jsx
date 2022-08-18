import React from 'react';
import { Card } from 'react-bootstrap';
import PropTypes from 'prop-types';
import debug from 'sabio-debug';

const _logger = debug.extend('workshoprequestscard');
function WorkshopRequestsCard(props) {
    const aWorkshop = props.inventoryData;
    _logger(aWorkshop);

    return (
        <Card style={{ minWidth: '300px', maxWidth: '300px' }}>
            <Card.Img
                style={{ objectFit: 'cover', height: '250px', cursor: 'pointer' }}
                src={props.inventoryData.workshop.imageUrl}
                className="w-100"
            />
            <Card.Body className="d-flex flex-column justify-content-between">
                <Card.Title as="div" className="d-flex justify-content-between align-items-center">
                    <div>
                        <h4 style={{ cursor: 'pointer' }} className="text-dark pointer">
                            {props.inventoryData.workshop.name}
                        </h4>
                    </div>
                    <h3>{'$' + props.inventoryData.basePrice}</h3>
                </Card.Title>
                <Card.Text>{props.inventoryData.workshop.shortDescription}</Card.Text>
            </Card.Body>
        </Card>
    );
}

WorkshopRequestsCard.propTypes = {
    inventoryData: PropTypes.shape({
        id: PropTypes.number.isRequired,
        workshop: PropTypes.shape({
            id: PropTypes.number.isRequired,
            name: PropTypes.string.isRequired,
            imageUrl: PropTypes.string.isRequired,
            summary: PropTypes.string,
            shortDescription: PropTypes.string,
            host: PropTypes.shape({
                id: PropTypes.number,
                firstName: PropTypes.string,
                lastName: PropTypes.string,
                avatarUrl: PropTypes.string,
            }),
            venueId: PropTypes.number.isRequired,
        }),
        quantity: PropTypes.number.isRequired,
        basePrice: PropTypes.number.isRequired,
    }),
    workshop: PropTypes.shape({
        id: PropTypes.number.isRequired,
        name: PropTypes.string.isRequired,
        imageUrl: PropTypes.string.isRequired,
        summary: PropTypes.string,
        shortDescription: PropTypes.string,
        topic: PropTypes.string,
    }),
};

export default WorkshopRequestsCard;
