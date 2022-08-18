import React, { useEffect, useState } from 'react';
import { Card } from 'react-bootstrap';
import lookup from '../../services/lookupService';
import logger from 'sabio-debug';
import { Formik, Form, Field, ErrorMessage } from 'formik';
import workshopSchema from '../../schema/workshopSchema';
import DatePickerFormik from '../sessions/DatePickerFormik';
import { useLocation } from 'react-router-dom';
import * as toastr from 'toastr';
import * as workshop from '../../services/workShopService';
import './work-shop.css';
const _logger = logger.extend('Create Workshop');

const WorkshopForm = () => {
    const [workshopFormData, setWorkshopForm] = useState({
        workshop: {
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
        },
    });

    const [workshopId, setWorkshopId] = useState({ id: 0 });

    const [workshopType, setWorkshopType] = useState([]);

    const [venueData, setVenueData] = useState([]);

    const [languageData, setLanguageData] = useState([]);

    const [statusData, setStatusData] = useState([]);

    const location = useLocation();

    const workshopFromLocation = () => {
        let newId = location.state.id;
        setWorkshopForm((prevState) => {
            let fd = { ...prevState.workshop };
            fd.name = location.state.name;
            fd.summary = location.state.summary;
            fd.shortDescription = location.state.shortDescription;
            fd.venueId = location.state.venueId;
            fd.workShopTypeId = location.state.workShopTypeId;
            fd.workShopStatusId = location.state.workShopStatusId;
            fd.imageUrl = location.state.imageUrl;
            fd.externalSiteUrl = location.state.externalSiteUrl;
            fd.languageId = location.state.languageId;
            fd.isFree = location.state.isFree;
            fd.numberOfSessions = location.state.numberOfSessions;
            fd.dateStart = new Date(location.state.dateStart);
            fd.dateEnd = new Date(location.state.dateEnd);
            return { workshop: fd };
        });
        setWorkshopId((prevState) => {
            let wd = { ...prevState };
            wd.id = newId;
            return wd;
        });
    };

    const timePickerEndDate = new Date();
    timePickerEndDate.setFullYear(timePickerEndDate.getFullYear() + 2);

    const onAddWorkshopSuccess = (data) => {
        let newId = data.item;
        _logger(data);
        toastr.success('Workshop Added');
        setWorkshopId((prevState) => {
            let wd = { ...prevState };
            wd.id = newId;
            return wd;
        });
    };

    const onAddWorkshopError = (data) => {
        toastr.error('Workshop failed to add');
        _logger(data);
    };

    const onUpdateWorkshopSuccess = (data) => {
        toastr.success('Workshop Updated');
        _logger(data);
    };

    const onUpdateWorkshopError = (data) => {
        toastr.error('Workshop failed to update');
        _logger(data);
    };

    const handleSubmit = (values) => {
        if (workshopId.id > 1) {
            workshop.update(values, workshopId.id).then(onUpdateWorkshopSuccess).catch(onUpdateWorkshopError);
        } else {
            workshop.add(values).then(onAddWorkshopSuccess).catch(onAddWorkshopError);
        }
    };

    const mapVenueList = (venue) => {
        return (
            <option key={`${venue.id}_venue`} value={venue.id}>
                {venue.name}
            </option>
        );
    };

    const mapWorkshopTypeList = (workshopType) => {
        return (
            <option key={`${workshopType.id}_type`} value={workshopType.id}>
                {workshopType.name}
            </option>
        );
    };

    const mapLanguageList = (language) => {
        return (
            <option key={`${language.id}_language`} value={language.id}>
                {language.name}
            </option>
        );
    };

    const mapStatusList = (status) => {
        return (
            <option key={`${status.id}_status`} value={status.id}>
                {status.name}
            </option>
        );
    };
    const onGetVenuesSuccess = (data) => {
        let mappedVenues = data.item.workshopVenues?.map(mapVenueList);

        setVenueData(mappedVenues);
    };

    const onGetVenuesError = (response) => {
        _logger('Error', response);
    };

    const onGetWorkshopTypeSuccess = (data) => {
        _logger('types', data);
        let mappedTypes = data.item.workShopTypes?.map(mapWorkshopTypeList);
        setWorkshopType(mappedTypes);
    };

    const onGetWorkshopTypeError = (response) => {
        _logger('Error', response);
    };

    const onGetLanguagesSuccess = (data) => {
        _logger('types', data);
        let mappedLanguages = data.item.workshopLanguages?.map(mapLanguageList);
        setLanguageData(mappedLanguages);
    };

    const onGetLanguagesError = (response) => {
        _logger('Error', response);
    };

    const onGetStatusSuccess = (data) => {
        _logger('types', data);
        let mappedStatus = data.item.workShopStatus?.map(mapStatusList);
        setStatusData(mappedStatus);
    };

    const onGetStatusError = (response) => {
        _logger('Error', response);
    };

    useEffect(() => {
        lookup(['WorkShopTypes']).then(onGetWorkshopTypeSuccess).catch(onGetWorkshopTypeError);
        lookup(['WorkshopVenues']).then(onGetVenuesSuccess).catch(onGetVenuesError);
        lookup(['WorkshopLanguages']).then(onGetLanguagesSuccess).catch(onGetLanguagesError);
        lookup(['WorkShopStatus']).then(onGetStatusSuccess).catch(onGetStatusError);
        if (location.state) {
            workshopFromLocation();
        }
    }, []);

    return (
        <div className="container">
            <Card className="mx-5 my-4 ">
                <Card.Header>
                    <h2 className="text-center">Trainsquare Workshops</h2>
                </Card.Header>
                <Card.Body>
                    <div className="text-center ">
                        <h4 className="text-dark-50 text-center mt-0 fw-bold">Fill in Workshop information</h4>
                        <p className="text-muted mb-4"></p>
                    </div>
                    <Formik
                        enableReinitialize={true}
                        initialValues={workshopFormData.workshop}
                        onSubmit={handleSubmit}
                        validationSchema={workshopSchema}>
                        {({ setFieldValue, values }) => (
                            <Form>
                                <div className="form-group my-3">
                                    <Field
                                        name="name"
                                        type="text"
                                        placeholder="Enter a workshop name"
                                        className="form-control"
                                    />
                                    <ErrorMessage name="name" component="div" className="has-error" />
                                </div>
                                <div className="form-group my-3">
                                    <Field
                                        name="summary"
                                        type="text"
                                        placeholder="Enter a workshop summary"
                                        className="form-control"
                                    />
                                    <ErrorMessage name="summary" component="div" className="has-error" />
                                </div>
                                <div className="form-group my-3">
                                    <Field
                                        component="textarea"
                                        name="shortDescription"
                                        type="text"
                                        placeholder="Enter a short description"
                                        className="form-control"></Field>

                                    <ErrorMessage name="shortDescription" component="div" className="has-error" />
                                </div>
                                <div className="form-group row my-3">
                                    <div className="col-3">
                                        <Field
                                            as="select"
                                            type="text"
                                            name="venueId"
                                            className="dropdown-border btn btn-small">
                                            <option defaultValue={0}>Choose a Venue</option>
                                            {venueData}
                                        </Field>
                                        <ErrorMessage name="venueId" component="div" className="has-error" />
                                    </div>
                                    <div className="col">
                                        <Field
                                            as="select"
                                            name="workShopTypeId"
                                            type="text"
                                            className="dropdown-border btn btn-small">
                                            <option defaultValue={0}>Choose a workshop type</option>
                                            {workshopType}
                                        </Field>
                                        <ErrorMessage name="workShopTypeId" component="div" className="has-error" />
                                    </div>
                                </div>

                                <div className="form-group row my-3">
                                    <div className="col-3">
                                        <Field
                                            as="select"
                                            name="workShopStatusId"
                                            type="text"
                                            placeholder="going to change"
                                            className="dropdown-border btn btn-small">
                                            {' '}
                                            <option defaultValue={0}>Set workshop status</option>
                                            {statusData}
                                        </Field>
                                        <ErrorMessage name="workShopStatusId" component="div" className="has-error" />
                                    </div>

                                    <div className="col">
                                        <Field
                                            as="select"
                                            name="languageId"
                                            type="text"
                                            className="dropdown-border btn btn-small">
                                            <option defaultValue={0}>Choose a language</option>
                                            {languageData}
                                        </Field>
                                        <ErrorMessage name="languageId" component="div" className="has-error" />
                                    </div>
                                </div>
                                <div className="form-group my-3">
                                    <Field
                                        name="imageUrl"
                                        type="text"
                                        placeholder="Enter a workshop image url"
                                        className="form-control"
                                    />
                                    <ErrorMessage name="imageUrl" component="div" className="has-error" />
                                </div>
                                <div className="form-group  my-3">
                                    <Field
                                        name="externalSiteUrl"
                                        type="text"
                                        placeholder="Enter a workshop external website url"
                                        className="form-control"
                                    />
                                    <ErrorMessage name="externalSiteUrl" component="div" className="has-error" />
                                </div>

                                <div className="form-group row my-3">
                                    <div className="col-3">
                                        <label htmlFor=""> Is this event free?&nbsp;&nbsp; </label>
                                        <Field type="checkbox" name="isFree" className="form-check-input" />

                                        <ErrorMessage name="isFree" component="div" className="has-error" />
                                    </div>{' '}
                                    <div className="col">
                                        <label htmlFor=""> Input the number of sessions&nbsp;&nbsp;</label>
                                        <Field
                                            name="numberOfSessions"
                                            type="number"
                                            placeholder="0"
                                            className="drop btn btn-small"
                                        />
                                        <ErrorMessage name="numberOfSessions" component="div" className="has-error" />
                                    </div>
                                </div>

                                <div className="row">
                                    <div className="col-lg-4">
                                        <DatePickerFormik
                                            start={new Date().toLocaleDateString()}
                                            end={timePickerEndDate.toLocaleDateString()}
                                            name="dateStart"
                                            value={values.dateStart}
                                            onChange={setFieldValue}
                                        />
                                        <ErrorMessage name="dateStart" component="div" style={{ color: 'red' }} />
                                    </div>
                                    <div className="col-lg-4">
                                        <DatePickerFormik
                                            start={new Date().toLocaleDateString()}
                                            end={timePickerEndDate.toLocaleDateString()}
                                            name="dateEnd"
                                            value={values.dateEnd}
                                            onChange={setFieldValue}
                                        />
                                        <ErrorMessage name="dateEnd" component="div" style={{ color: 'red' }} />
                                    </div>
                                </div>

                                <button type="submit" className="btn btn-primary">
                                    Post workshop
                                </button>
                            </Form>
                        )}
                    </Formik>
                </Card.Body>
            </Card>
        </div>
    );
};

export default WorkshopForm;
