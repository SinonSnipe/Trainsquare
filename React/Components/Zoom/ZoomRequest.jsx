import React, { useState, useEffect } from 'react';
import { Formik, Form, Field, ErrorMessage } from 'formik';
import FileParserCsv from '../files/FileParserCsv';
import debug from 'sabio-debug';
import * as zoomService from '../../services/zoomService';
import * as emailService from '../../services/emailService';
import * as zoomSchema from '../../schema/zoomSchema';
import PropTypes from 'prop-types';
import './zoom-meeting.css';
import toastr from '../../utils/toastr';

const _logger = debug.extend('Zoom');

const ZoomRequest = (props) => {
    const [meeting, setMeeting] = useState({
        requested: false,
        hostUrl: null,
        joinUrl: null,
        hostEmail: 'admin@test.com',
        hostName: 'Trainsquare',
        manualEntry: false,
    });

    const [meetingFormData] = useState({
        hasAcceptedTerms: false,
        name: '',
        startDate: '',
        startTime: '',
    });

    const [emailFormData, setEmailFormData] = useState({
        isReady: false,
        message: '',
        subject: '',
        joinUrl: '',
        columnTitles: [],
        selectedColumn: '',
    });

    const [fileParseData, setFileParseData] = useState({ columnTitles: null, parsedData: null });

    useEffect(() => {
        if (fileParseData.columnTitles) {
            setEmailFormData((prevState) => {
                const data = { ...prevState };
                data.isReady = true;
                data.columnTitles = fileParseData.columnTitles;
                return data;
            });
        }
    }, [fileParseData]);

    const onSubmitForm = (values) => {
        const meetingData = {
            topic: values.name,
            duration: 60,
            date: `${values.startDate}T${values.startTime}`,
            type: 2,
        };
        _logger('payload->', meetingData);

        zoomService.createMeeting(meetingData).then(onGetMeetingSuccess).catch(onGetMeetingError);
    };

    const onGetMeetingSuccess = (response) => {
        const zResponse = response.item;
        //_logger('success->', zResponse);

        const hostZak = zResponse.start_url.split('=').pop();
        //_logger('zak->', hostZak);

        setMeeting((prevState) => {
            const md = { ...prevState };
            md.requested = true;
            md.hostUrl = response.item.start_url;
            md.joinUrl = response.item.join_url;
            //md.hostEmail = response.item.host_email; Will be true host URL in prod
            return md;
        });

        setEmailFormData((prevState) => {
            const ed = { ...prevState };
            ed.joinUrl = response.item.join_url;
            ed.subject = response.item.topic;
            return ed;
        });

        const payload = { role: 1, meetingId: `${zResponse.id}` };

        zoomService.getSdkToken(payload).then((response) => {
            _logger('gettoken->', response.item);
            props.setZoomData((prevState) => {
                const zd = { ...prevState };
                zd.userName = zResponse.host_email;
                zd.meetingNumber = zResponse.id;
                zd.zak = hostZak;
                zd.signature = response.item;
                return zd;
            });
        });
    };

    const onGetMeetingError = (err) => {
        _logger('error->', err);

        setMeeting((prevState) => {
            const md = { ...prevState };
            md.requested = false;
            md.hostUrl = null;
            md.joinUrl = null;
            // md.hostEmail = null; Will be true host URL in prod
            return md;
        });
    };

    const onSubmitEmailForm = (values) => {
        const emailsArray = fileParseData.parsedData.map((data) => {
            return data[values.selectedColumn];
        });

        const emailData = {
            hostEmail: meeting.hostEmail,
            hostName: meeting.hostName,
            toEmails: emailsArray.join(),
            subject: values.subject,
            message: values.message,
            meetingUrl: values.joinUrl,
        };

        _logger('email->', emailData);

        emailService.sendMeetingLink(emailData).then(onSendMeetingLinkSuccess).catch(onSendMeetingLinkError);
    };

    const onSendMeetingLinkSuccess = (response) => {
        _logger('email sent->', response);
        toastr.success('Emails sent succesfully');
    };

    const onSendMeetingLinkError = (err) => {
        _logger('email failed->', err);
        toastr.error('Emails were not be able to be sent, please verify column/data in .csv file.');
    };

    const mapColumnOptions = (title, index) => {
        return (
            <option key={`${title}_${index}`} value={title}>
                {title}
            </option>
        );
    };

    return (
        <>
            {!meeting.requested && (
                <div className="col">
                    <h4>Create A Virtual Meeting</h4>
                    <p>Request a host and join link for virtual meeting.</p>

                    <div>
                        <Formik
                            enableReinitialize={true}
                            onSubmit={onSubmitForm}
                            initialValues={meetingFormData}
                            validationSchema={zoomSchema.meetingSchema}>
                            {({ values }) => (
                                <Form>
                                    <div className="form-group col mt-2">
                                        <label htmlFor="name">Meeting Name</label>
                                        <Field type="text" name="name" className="form-control" />
                                        <ErrorMessage name="name" component="div" className="has-error" />
                                    </div>
                                    <div className="form-group col mt-2">
                                        <label htmlFor="startDate">Start Date</label>
                                        <Field type="date" name="startDate" className="form-control" />
                                        <ErrorMessage name="startDate" component="div" className="has-error" />
                                    </div>
                                    <div className="form-group col mt-2">
                                        <label htmlFor="startTime">Start Time</label>
                                        <Field type="time" name="startTime" className="form-control" />
                                        <ErrorMessage name="startTime" component="div" className="has-error" />
                                    </div>

                                    <div className="form-check col mt-2">
                                        <Field type="checkbox" name="hasAcceptedTerms" className="form-check-input" />
                                        <label htmlFor="hasAcceptedTerms" className="form-check-label">
                                            {values.hasAcceptedTerms
                                                ? 'Thank you for accepting Trainsquare terms and conditions.'
                                                : 'Please check the box to accept Trainsquare terms and conditions.'}
                                        </label>
                                        <ErrorMessage name="hasAcceptedTerms" component="div" className="has-error" />
                                    </div>
                                    <br />
                                    <button type="submit" className="btn btn-primary btn mb-2">
                                        Create Meeting
                                    </button>
                                </Form>
                            )}
                        </Formik>
                    </div>
                </div>
            )}
            {meeting.requested && (
                <div className="col-6">
                    <h4>Email Meeting Details to Attendees</h4>
                    {!meeting.manualEntry && (
                        <>
                            <h5>Meeting Details</h5>
                            <h6>Link for meeting host only:</h6>
                            <a href={meeting.hostUrl}>Host Link</a>
                            <br />
                            <h6>Link for meeting participants:</h6>
                            <a href={meeting.joinUrl}>Participant Link</a>
                            <br />
                        </>
                    )}

                    <h5>Upload list of registered attendee emails (.csv):</h5>
                    <FileParserCsv setParseData={setFileParseData} />

                    {emailFormData.isReady && (
                        <Formik
                            enableReinitialize={true}
                            onSubmit={onSubmitEmailForm}
                            initialValues={emailFormData}
                            validationSchema={zoomSchema.emailSchema}>
                            {({ values, handleChange }) => (
                                <Form>
                                    <div className="form-group col mt-2">
                                        <label htmlFor="columnTitles">Column Containing Recipient Emails</label>
                                        <Field
                                            as="select"
                                            multiple={false}
                                            name="selectedColumn"
                                            className="form-control"
                                            value={values.selectedColumn}
                                            onChange={handleChange}>
                                            <option value="">Select an option</option>
                                            {emailFormData.columnTitles.map(mapColumnOptions)}
                                        </Field>
                                        <ErrorMessage name="columnTitles" component="div" className="has-error" />
                                    </div>
                                    <div className="form-group col mt-2">
                                        <label htmlFor="subject">Subject Line</label>
                                        <Field type="text" name="subject" className="form-control" />
                                        <ErrorMessage name="subject" component="div" className="has-error" />
                                    </div>
                                    <div className="form-group col mt-2">
                                        <label htmlFor="message">Custom Message</label>
                                        <Field type="text" name="message" className="form-control" />
                                        <ErrorMessage name="message" component="div" className="has-error" />
                                    </div>

                                    <button type="submit" className="btn btn-primary btn mt-2">
                                        Email Link to Attendees
                                    </button>
                                </Form>
                            )}
                        </Formik>
                    )}
                </div>
            )}
        </>
    );
};

ZoomRequest.propTypes = {
    setZoomData: PropTypes.func,
};

export default ZoomRequest;
