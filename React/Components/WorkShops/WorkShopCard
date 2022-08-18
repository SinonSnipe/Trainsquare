import React, { useState } from 'react';
import { Card } from 'react-bootstrap';
import { useNavigate } from 'react-router-dom';
import PropTypes from 'prop-types';
import * as cartItemsService from '../../services/cartItemsService';
import toastr from '../../utils/toastr.js';
import debug from 'sabio-debug';
import FavoriteWorkshops from '../favoriteWorkshops/FavoriteWorkshops';

const _logger = debug.extend('workshopcard');
function WorkshopCard(props) {
    const navigate = useNavigate();
    const aWorkshop = props.inventoryData;
    _logger('WorkshopCard', aWorkshop);

    const [disabled, setDisabled] = useState(false);

    function onSubmit() {
        setDisabled(true);
        const payload = {
            inventoryId: props.inventoryData.id,
            quantity: 1,
        };
        cartItemsService.addToCart(payload).then(onAddSuccess).catch(onAddError);
    }

    function onAddSuccess() {
        toastr.success('Item added to cart', props.inventoryData.workshop.name);
        setDisabled(false);
    }

    function onAddError() {
        toastr.error('Not enough stock', props.inventoryData.workshop.name);
        setDisabled(false);
    }

    const onClick = () => {
        navigate('/workshops/details', { state: { type: 'WORKSHOP', payload: props.inventoryData } });
    };
    const onSessionClick = () => {
        navigate(`/workshops/${props.inventoryData.id}/sessions`);
    };

    const navigateOnRequestAPrivateWorkshop = () => {
        const state = { type: 'WORKSHOP', payload: aWorkshop };
        navigate(`/workshoprequests/${aWorkshop.id}/new`, { state });
    };

    return (
        <Card style={{ minWidth: '300px', maxWidth: '300px' }}>
            <Card.Img
                onClick={onClick}
                style={{ objectFit: 'cover', height: '250px', cursor: 'pointer' }}
                src={props.inventoryData.workshop.imageUrl}
                className="w-100"
            />
            <Card.Body className="d-flex flex-column justify-content-between">
                <Card.Title as="div" className="d-flex justify-content-between align-items-center">
                    <div>
                        <h4 style={{ cursor: 'pointer' }} onClick={onClick} className="text-dark pointer">
                            {props.inventoryData.workshop.name}
                        </h4>
                        <h4>
                            <FavoriteWorkshops data={aWorkshop.workshop.id} />
                        </h4>
                    </div>
                    <h3>{'$' + props.inventoryData.basePrice}</h3>
                </Card.Title>
                <Card.Text>{props.inventoryData.workshop.shortDescription}</Card.Text>
                <button
                    disabled={disabled}
                    type="button"
                    onClick={onSubmit}
                    className="btn btn-danger"
                    style={{ height: '50px' }}>
                    <i className="mdi mdi-cart me-1"></i> Add to cart
                </button>
                <button className="btn btn-primary" onClick={navigateOnRequestAPrivateWorkshop}>
                    Request A Private Workshop
                </button>
                <div>
                    <button className="btn btn-link" style={{ float: 'right' }} onClick={onSessionClick}>
                        View Sessions
                    </button>
                </div>
            </Card.Body>
        </Card>
    );
}

WorkshopCard.propTypes = {
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

export default WorkshopCard;
