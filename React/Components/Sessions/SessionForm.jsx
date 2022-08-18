import React, { useEffect, useState } from 'react';
import { ErrorMessage, Field, Form, Formik } from 'formik';
import DatePickerFormik from './DatePickerFormik';
import TimePickerFormik from './TimePickerFormik';
import sessionValid from '../../schema/sessionSchema';
import sessionFunctions from '../../services/sessionService';
import toastr from '../../utils/toastr';
import { useLocation } from 'react-router-dom';

import debug from 'sabio-debug';
const _logger = debug.extend('SessionForm');

function SessionForm() {
    const [sessionForm, setSessionForm] = useState({
        workShopId: '',
        openSlots: 0,
        totalSlots: 0,
        date: new Date(),
        startTime: '',
        endTime: '',
    });

    const [workshopDates, setWorkshopDates] = useState({
        workShopId: '',
        dateStart: new Date(),
        dateEnd: new Date(),
    });

    const [sessionId, setSessionId] = useState();

    const [mode, setMode] = useState({
        className: 'btn-primary btn',
        text: 'Submit',
        heading: 'Create a Session',
    });

    const editMode = () => {
        setMode({
            className: 'btn-info btn',
            text: 'Edit',
            heading: 'Edit Session',
        });
    };

    const location = useLocation();

    useEffect(() => {
        _logger('location', location);
        if (location.state?.type === 'create') {
            const payload = location.state.payload;
            setWorkshopDates(payload);
            setSessionForm((prevState) => {
                return { ...prevState, workShopId: payload.workShopId };
            });
        } else if (location.state?.type === 'edit') {
            const payload = location.state.payload;
            editMode();
            setSessionForm(payload.session);
            setSessionId(payload.session.id);
            setWorkshopDates(payload.workshopDates);
        }
    }, []);

    const onSubmit = (values) => {
        values.date = new Date(values.date).toLocaleDateString();

        if (sessionId) {
            sessionFunctions.update(sessionId, values).then(onUpdateSuccess).catch(onUpdateError);
        } else {
            sessionFunctions.add(values).then(onAddSuccess).catch(onAddError);
        }
    };

    const onAddSuccess = () => {
        toastr.success('Successfully created the session!');
    };

    const onAddError = () => {
        toastr.error('Something went wrong, please try again later.');
    };

    const onUpdateSuccess = () => {
        toastr.success('Successfully edited the session!');
    };

    const onUpdateError = () => {
        toastr.error('Something went wrong, please try again later.');
    };

    const timeSpanToLocaleTime = (time) => {
        //converts military time to standard
        let temp = new Date();
        temp.setHours(time.slice(0, 2), time.slice(3, 5), time.slice(6));
        return temp.toLocaleTimeString();
    };
    return (
        <div>
            <h1>{mode.heading}</h1>
            <div className="card">
                <div className="card-body">
                    <Formik
                        enableReinitialize={true}
                        initialValues={sessionForm}
                        onSubmit={onSubmit}
                        validationSchema={sessionValid}>
                        {({ handleReset, setFieldValue, values }) => (
                            <Form>
                                <div className="row">
                                    <div className="col">
                                        <div className="form-group mt-2">
                                            <label htmlFor="totalSlots">Total Slots</label>
                                            <Field name="totalSlots" type="number" className="form-control" />
                                            <ErrorMessage name="totalSlots" component="div" style={{ color: 'red' }} />
                                        </div>
                                    </div>
                                    <div className="col">
                                        <div className="form-group mt-2">
                                            <label htmlFor="openSlots">Open Slots</label>
                                            <Field name="openSlots" type="number" className="form-control" />
                                            <ErrorMessage name="openSlots" component="div" style={{ color: 'red' }} />
                                        </div>
                                    </div>
                                </div>
                                <div className="row mt-4">
                                    <div className="col-lg-4">
                                        <DatePickerFormik
                                            start={workshopDates.dateStart}
                                            end={workshopDates.dateEnd}
                                            name="date"
                                            value={values.date}
                                            onChange={setFieldValue}
                                        />
                                        <ErrorMessage name="date" component="div" style={{ color: 'red' }} />
                                    </div>
                                    <div className="col">
                                        <div className="col">
                                            <label htmlFor={`startTime`}>Start Time</label>
                                            <TimePickerFormik
                                                isStart={true}
                                                onChange={setFieldValue}
                                                name={`startTime`}
                                                timeSpanChange={timeSpanToLocaleTime}
                                                value={values.startTime}
                                            />
                                            <ErrorMessage name="startTime" component="div" style={{ color: 'red' }} />
                                        </div>
                                        <div className="col mt-2">
                                            <label htmlFor={`endTime`}>End Time</label>
                                            <TimePickerFormik
                                                isStart={false}
                                                onChange={setFieldValue}
                                                startTime={values.startTime}
                                                timeSpanChange={timeSpanToLocaleTime}
                                                name={`endTime`}
                                                value={values.endTime}
                                            />
                                            <ErrorMessage name="endTime" component="div" style={{ color: 'red' }} />
                                        </div>
                                        <div className="row justify-content-end">
                                            <div className="col-lg-2 mt-4">
                                                <button
                                                    onClick={() => {
                                                        handleReset();
                                                    }}
                                                    type="button"
                                                    className="btn btn-warning">
                                                    Reset
                                                </button>
                                            </div>
                                            <div className="col-lg-3 mt-4">
                                                <button type="submit" className={mode.className}>
                                                    {mode.text}
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </Form>
                        )}
                    </Formik>
                </div>
            </div>
        </div>
    );
}

export default SessionForm;
