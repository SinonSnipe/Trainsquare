import React, { useState } from 'react';
import { Card, Row, Col } from 'react-bootstrap';
import { Link } from 'react-router-dom';
import * as emailService from '../../services/userService';
import logger from 'sabio-debug';
import { Formik, Form, Field, ErrorMessage } from 'formik';
import { forgotPasswordSchema } from '../../schema/authSchema';
import './forgotPassword.css';

const _logger = logger.extend('forgotPassword');

const ForgotPassword = () => {
    const [emailData] = useState({
        user: {
            email: '',
        },
    });

    const [message, setMessage] = useState({
        message: '',
    });

    const handleSubmit = (value) => {
        emailService.forgotPassword(value).then(onforgotPasswordSuccess).catch(onforgotPasswordError);
    };

    const onforgotPasswordSuccess = (res) => {
        _logger('forgotpasswordSuccess!', res);
        setMessage({
            message: 'An email with instructions on how to reset your password has been sent',
        });
    };

    const onforgotPasswordError = (err) => {
        _logger('forgotpasswordError', err.response);
        setMessage({
            message: 'User account with this email not found.',
        });
    };

    return (
        <React.Fragment>
            <div className="container formContainer center">
                <Card className="mx-5 ">
                    <Card.Header className="header">
                        <h2 className="header-font text-center">Trainsquare</h2>
                    </Card.Header>
                    <Card.Body>
                        <div className="text-center w-75 m-auto">
                            <h4 className="text-dark-50 text-center mt-0 fw-bold">Reset Password</h4>
                            <p className="text-muted mb-4">
                                Enter your email address and we will send you instructions to reset your password.
                            </p>
                            <p className="text-center">{message.message}</p>
                        </div>
                        <Formik
                            enableReinitialize={true}
                            initialValues={emailData.user}
                            onSubmit={handleSubmit}
                            validationSchema={forgotPasswordSchema}>
                            <Form>
                                <div className="form-group my-3">
                                    <label>Email</label>
                                    <Field
                                        name="email"
                                        type="email"
                                        placeholder="Email address"
                                        className="form-control"
                                    />
                                    <ErrorMessage name="email" component="div" className="has-error" />
                                </div>

                                <button type="submit" className="btn btn-primary">
                                    Continue
                                </button>
                            </Form>
                        </Formik>
                    </Card.Body>
                </Card>
                <Row className="mt-3">
                    <Col className="text-center">
                        <p className="text-muted">
                            <Link to={'/login'} className="text-muted ms-1">
                                <b>Back to Trainsquare login</b>
                            </Link>
                        </p>
                    </Col>
                </Row>
            </div>
        </React.Fragment>
    );
};

export default ForgotPassword;
