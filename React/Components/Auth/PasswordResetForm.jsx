import React, { useState } from 'react';
import { Card, Row, Col } from 'react-bootstrap';
import logger from 'sabio-debug';
import * as emailService from '../../services/userService';
import { Link } from 'react-router-dom';
import { Formik, Form, Field, ErrorMessage } from 'formik';
import { passwordResetSchema } from '../../schema/authSchema';
import './passwordReset.css';

const _logger = logger.extend('PasswordReset');

const Confirm = () => {
    const [message, setMessage] = useState({
        message: '',
    });

    const [passwordResetData] = useState({
        user: {
            password: '',
            passwordConfirm: '',
        },
    });

    const [showPassword, setShowPassword] = useState(false);

    const handleClick = () => {
        setShowPassword(!showPassword);
    };

    const [showPasswordConfirm, setShowPasswordConfirm] = useState(false);

    const handleClickConfirm = () => {
        setShowPasswordConfirm(!showPasswordConfirm);
    };

    const onPasswordResetSuccess = (res) => {
        _logger('onPasswordResetSuccess', res);
        setMessage({
            message: 'Your password has been reset.',
        });
    };

    const onPasswordResetError = (err) => {
        _logger('ConfirmTokenError.', err.response);
        setMessage({
            message: 'Sorry, your password failed to reset',
        });
    };
    const queryParams = new URLSearchParams(window.location.search);
    const token = queryParams.get('token');

    const handleSubmit = (value) => {
        _logger('token', token);
        _logger('value', value);
        emailService.confirmPasswordResetToken(token, value).then(onPasswordResetSuccess).catch(onPasswordResetError);
    };

    return (
        <React.Fragment>
            <div className="container formContainer center">
                <Card className="mx-5">
                    <Card.Header className="header">
                        <h2 className="header-font text-center">Trainsquare</h2>
                    </Card.Header>
                    <Card.Body>
                        {' '}
                        <div className="text-center m-auto">
                            <h5 className="text-dark-50 text-center mt-4 fw-bold">
                                Please wait while we verify your account.
                            </h5>
                            <p className="text-muted mb-4"></p>
                            <p className="text-center">{message.message}</p>

                            <Formik
                                enableReinitialize={true}
                                initialValues={passwordResetData.user}
                                onSubmit={handleSubmit}
                                validationSchema={passwordResetSchema}>
                                <Form>
                                    <label>Password</label>
                                    <div className="input-group mb-3">
                                        <Field
                                            name="password"
                                            type={showPassword ? 'text' : 'password'}
                                            placeholder="Enter your password"
                                            className="form-control"
                                        />
                                        <div className="input-group-prepend">
                                            <span className="input-group-text pointer" onClick={handleClick}>
                                                {showPassword ? (
                                                    <i className="mdi mdi-eye  "></i>
                                                ) : (
                                                    <i className="mdi mdi-eye-off"></i>
                                                )}
                                            </span>
                                        </div>
                                        <ErrorMessage name="password" component="div" className="has-error" />
                                    </div>
                                    <label>Password Confirm</label>

                                    <div className="input-group mb-3">
                                        <Field
                                            name="passwordConfirm"
                                            type={showPasswordConfirm ? 'text' : 'password'}
                                            placeholder="Confirm your password"
                                            className="form-control"
                                        />
                                        <div className="input-group-prepend">
                                            <span className="input-group-text pointer" onClick={handleClickConfirm}>
                                                {showPasswordConfirm ? (
                                                    <i className="mdi mdi-eye  "></i>
                                                ) : (
                                                    <i className="mdi mdi-eye-off"></i>
                                                )}
                                            </span>
                                        </div>
                                        <ErrorMessage name="passwordConfirm" component="div" className="has-error" />
                                    </div>
                                    <button className="btn btn-primary">Confirm new password</button>
                                </Form>
                            </Formik>
                        </div>
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

export default Confirm;
