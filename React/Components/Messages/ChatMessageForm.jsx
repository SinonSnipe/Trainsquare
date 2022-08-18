import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { Row, Col } from 'react-bootstrap';
import PropTypes from 'prop-types';
import basicSchema from '../../schema/messageSchema';
import { Formik, Form, Field, ErrorMessage } from 'formik';

function ChatMessageForm(props) {
    const [formData] = useState({
        newMessage: '',
    });

    const handleSubmit = (values, { resetForm }) => {
        props.onSendClicked(values);
        resetForm({ values: '' });
    };

    return (
        <Row className="px-3 pb-3">
            <Col>
                <div className="mt-2 bg-light p-3 rounded">
                    <Formik
                        enableReinitialize={true}
                        initialValues={formData}
                        onSubmit={handleSubmit}
                        validationSchema={basicSchema}>
                        <Form name="chat-form" id="chat-form">
                            <div className="row">
                                <div className="col mb-2 mb-sm-0">
                                    <Field
                                        type="text"
                                        name="newMessage"
                                        className="border-0 form-control"
                                        placeholder="Enter your text"
                                    />
                                    <ErrorMessage name="newMessage" component="div" />
                                </div>
                                <div className="col-sm-auto">
                                    <div className="btn-group">
                                        <Link to="#" className="btn btn-light">
                                            <i className="uil uil-paperclip"></i>
                                        </Link>
                                        <Link to="#" className="btn btn-light">
                                            {' '}
                                            <i className="uil uil-smile"></i>{' '}
                                        </Link>
                                        <button type="submit" className="btn btn-success chat-send btn-block">
                                            <i className="uil uil-message">Send</i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </Form>
                    </Formik>
                </div>
            </Col>
        </Row>
    );
}

ChatMessageForm.propTypes = {
    onSendClicked: PropTypes.func.isRequired,
};

export default ChatMessageForm;
