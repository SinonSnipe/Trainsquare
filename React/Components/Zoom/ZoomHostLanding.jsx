import React, { useState } from 'react';
import { Formik, Form, Field, ErrorMessage } from 'formik';
import ZoomRequest from './ZoomRequest';
import { useNavigate } from 'react-router-dom';

import debug from 'sabio-debug';

const _logger = debug.extend('Zoom');

function ZoomHostLanding() {
    const [zoomData, setZoomData] = useState({
        signature: '',
        meetingNumber: '',
        passWord: '',
        userName: '',
        zak: '',
        isLiveStream: false,
    });

    const navigate = useNavigate();

    const onSubmitForm = (values) => {
        const zoomFormData = { ...zoomData };
        zoomFormData.meetingNumber = values.meetingNumber;

        const stateForTransport = { type: 'ZOOM_DATA', payload: zoomFormData };
        _logger('hostlanding payload for transport ->', stateForTransport);

        navigate('/zoomstream', { state: stateForTransport });
    };

    return (
        <>
            <div className="container">
                <div className="row">
                    <ZoomRequest setZoomData={setZoomData} />

                    {zoomData.signature && zoomData.isLiveStream && (
                        <div className="col-6">
                            <h4>Start Virtual Meeting</h4>
                            <p>Go live in our app after Creating A Meeting.</p>
                            <Formik initialValues={zoomData} enableReinitialize={true} onSubmit={onSubmitForm}>
                                {() => (
                                    <Form>
                                        <h5>Please verify meeting number before starting session.</h5>
                                        <div className="form-group col mt-2">
                                            <label htmlFor="meetingNumber">Meeting Number</label>
                                            <Field type="text" name="meetingNumber" className="form-control" />
                                            <ErrorMessage name="meetingNumber" component="div" className="has-error" />
                                        </div>
                                        <br />
                                        <button type="submit" className="btn btn-primary btn mb-2">
                                            Start Meeting
                                        </button>
                                    </Form>
                                )}
                            </Formik>
                        </div>
                    )}
                </div>
            </div>
        </>
    );
}

export default ZoomHostLanding;
