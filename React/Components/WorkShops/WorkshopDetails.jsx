import React, { useState, useEffect } from 'react';
import { useLocation } from 'react-router-dom';
import PropTypes from 'prop-types';
import CommentsByEntity from '../comments/CommentsByEntity';
import logger from 'sabio-debug';
import './work-shop.css';
import * as cartItemsService from '../../services/cartItemsService';
import toastr from '../../utils/toastr.js';

const _logger = logger.extend('WorkshopDetails');

const WorkshopDetails = () => {
    const [disabled, setDisabled] = useState(false);
    const [workshopData, setWorkshopData] = useState({
        workshop: {
            id: 0,
            name: '',
            summary: '',
            shortDescription: '',
            venueId: 0,
            workShopTypeId: 0,
            workShopStatusId: 0,
            imageUrl: '',
            externalSiteUrl: '',
            languageId: 0,
            isFree: true,
            numberOfSessions: 0,
            dateStart: new Date(),
            dateEnd: new Date(),
            entityTypeId: 9,
        },
    });

    const [inventoryData, setInventoryData] = useState();

    function onSubmit() {
        setDisabled(true);
        const payload = {
            inventoryId: inventoryData.id,
            quantity: 1,
        };
        cartItemsService.addToCart(payload).then(onAddSuccess).catch(onAddError);
    }

    function onAddSuccess() {
        toastr.success('Item added to cart', inventoryData.workshop.name);
        setDisabled(false);
    }

    function onAddError() {
        toastr.error('Not enough stock', inventoryData.workshop.name);
        setDisabled(false);
    }

    const entityTypeId = 9;

    const location = useLocation();

    const [show, setShow] = useState(false);
    _logger(workshopData);

    const workshopFromLocation = () => {
        setWorkshopData((prevState) => {
            _logger(prevState);
            return { ...prevState.workshop, workshop: location.state.payload.workshop };
        });
        setInventoryData((prevState) => {
            let newState = { ...prevState };
            newState = location.state.payload;
            return newState;
        });
    };

    useEffect(() => {
        if (location.state && location.state.type === 'WORKSHOP') {
            workshopFromLocation();
        }
    }, []);

    return (
        <React.Fragment>
            <div className="row d-flex justify-content-center">
                <div className="mb-3 col-6" style={{ width: '25rem' }}>
                    <img src={workshopData.workshop?.imageUrl} alt="workshop" className="img-fluid rounded-corners" />
                    <div className="d-flex align-items-center justify-content-between">
                        <h4>{workshopData.workshop?.name}</h4>
                        <h3>{'$' + inventoryData?.basePrice}</h3>
                    </div>
                    <p className="card-text">
                        {show
                            ? workshopData.workshop?.shortDescription
                            : `${workshopData.workshop?.shortDescription?.slice(0, 55)}...`}
                        <strong
                            className="view-more"
                            onClick={() => {
                                setShow(!show);
                            }}>
                            view more
                        </strong>
                    </p>
                    <div className="d-flex justify-content-end">
                        <button
                            disabled={disabled}
                            type="button"
                            onClick={onSubmit}
                            className="btn btn-danger"
                            style={{ height: '50px' }}>
                            <i className="mdi mdi-cart me-1"></i> Add to cart
                        </button>
                    </div>
                </div>
            </div>
            {workshopData.workshop.id >= 1 ? (
                <CommentsByEntity entity={workshopData.workshop} entityTypeId={entityTypeId} />
            ) : (
                <CommentsByEntity />
            )}
        </React.Fragment>
    );
};

export default WorkshopDetails;

WorkshopDetails.propTypes = {
    workshopData: PropTypes.shape({
        id: PropTypes.number.isRequired,
        name: PropTypes.string.isRequired,
        imageUrl: PropTypes.string.isRequired,
        summary: PropTypes.string,
        shortDescription: PropTypes.string,
    }),
};
