import React, { useState, useEffect } from 'react';
import { Formik, Form, Field, ErrorMessage } from 'formik';
import { useLocation, useNavigate } from 'react-router-dom';
import * as privateBookingService from '../../services/privateBookingService';
import WorkshopRequestsCard from './WorkshopRequestsCard';
import { PropTypes } from 'prop-types';
import toastr from 'toastr';
import debug from 'sabio-debug';
import { Card } from 'react-bootstrap';
import privateBookingSchema from '../../schema/privateBookingSchema';
import './privateBooking.css';

const NewPrivateBooking = (props) => {
    const [bookingData, setBookingData] = useState({
        name: '',
        Email: '',
        numberOfPeopleAttending: 0,
        numberOfSessions: 0,
    });

    const [workshopInfo, setWorkshopInfo] = useState({
        imageUrl: '',
        name: '',
        basePrice: '',
        shortDescription: '',
    });

    const aWorkshop = props.workshopData;

    const _logger = debug.extend('NewPrivateBooking');
    _logger('----> aWorkshop', aWorkshop);
    _logger('bookingData', bookingData);
    _logger('workshopInfo -->', workshopInfo);

    const { state } = useLocation();
    _logger('state here --->', state);
    const navigate = useNavigate();

    useEffect(() => {
        if (state && state?.type === 'WORKSHOP') {
            _logger(state);
            setBookingData((prev) => {
                let workshopData = state.payload;
                let workshopDataId = state.payload?.id;
                _logger(workshopDataId);
                _logger('workShopData', workshopData);
                _logger('description -->', workshopData.shortDescription);
                let editBookingData = {
                    ...prev,
                    workshopId: workshopData.workshop.id,
                };
                return editBookingData;
            });
            setWorkshopInfo((prev) => {
                let workshopInfo = state.payload;
                let editWorkshopData = {
                    ...prev,
                    imageUrl: workshopInfo.workshop.imageUrl,
                    name: workshopInfo.workshop.name,
                    basePrice: workshopInfo.basePrice,
                    shortDescription: workshopInfo.workshop.shortDescription,
                };
                _logger('editWorkshopData --- --- --->', editWorkshopData);
                return editWorkshopData;
            });
        }
    }, []);

    const mapWorkshopRequestsCard = (workshopInfo) => {
        return <WorkshopRequestsCard booking={workshopInfo}></WorkshopRequestsCard>;
    };
    _logger('mapWorkshopRequestsCard', mapWorkshopRequestsCard);

    const onSubmitClicked = (values) => {
        _logger('bookingData in onSubmitClicked -->', values);
        let payload = values;
        privateBookingService.createBooking(payload).then(onCreateBookingSuccess).catch(onCreateBookingError);
    };

    const onCreateBookingSuccess = (response) => {
        _logger('AppOnCreateBookingSuccess', response);
        toastr.success('Successfully Created a new Private Workshop!', response.name);
        navigate('/workshops');
    };

    const onCreateBookingError = (err) => {
        toastr.error('Failed to create request!', err);
    };

    return (
        <>
            <div className="container">
                <h1 className="row justify-content-center my-4 mb-4">Request Private Workshop</h1>
                <div className="row justify-content-center">
                    <div className="col-4 mx-1">
                        <div className="card">
                            <img src={workshopInfo.imageUrl} className="card-img-top" alt={workshopInfo.name} />
                            <div className="card-body">
                                <h5 className="card-title">
                                    {workshopInfo.name} {`${'$' + workshopInfo.basePrice}`}
                                </h5>
                                <h5 className="card-text">{workshopInfo.shortDescription}</h5>
                            </div>
                        </div>
                    </div>
                    <div className="col-4 mx-1">
                        <Card>
                            <Card.Body>
                                <Formik
                                    enableReinitialize={true}
                                    initialValues={bookingData}
                                    validationSchema={privateBookingSchema}
                                    onSubmit={onSubmitClicked}>
                                    <Form className="ms-3">
                                        <div className="form-group">
                                            <label htmlFor="name">Name</label>
                                            <Field type="text" name="name" />
                                            <ErrorMessage name="name" component="div"></ErrorMessage>
                                        </div>
                                        <div className="form-group">
                                            <label htmlFor="email">Email</label>
                                            <Field type="text" name="email" />
                                            <ErrorMessage name="email" component="div"></ErrorMessage>
                                        </div>
                                        <div className="form-group">
                                            <label htmlFor="numberOfPeopleAttending">Number Of People Attending</label>
                                            <Field type="text" name="numberOfPeopleAttending" />
                                            <ErrorMessage name="numberOfPeopleAttending" component="div"></ErrorMessage>
                                        </div>
                                        <div className="form-group">
                                            <label htmlFor="numberOfSessions">Number Of Sessions</label>
                                            <Field type="text" name="numberOfSessions" />
                                            <ErrorMessage name="numberOfSessions" component="div"></ErrorMessage>
                                        </div>
                                        <button type="submit" className="btn btn-primary mt-2">
                                            Submit
                                        </button>
                                    </Form>
                                </Formik>
                            </Card.Body>
                        </Card>
                    </div>
                </div>
            </div>
        </>
    );
};

NewPrivateBooking.propTypes = {
    workshopData: PropTypes.shape({
        id: PropTypes.number.isRequired,
        name: PropTypes.string.isRequired,
        imageUrl: PropTypes.string.isRequired,
        summary: PropTypes.string,
        description: PropTypes.string,
    }),
};

export default NewPrivateBooking;
