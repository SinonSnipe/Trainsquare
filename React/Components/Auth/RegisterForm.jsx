import React, { useState } from 'react';
import { Card, Row, Col } from 'react-bootstrap';
import { Link, useNavigate } from 'react-router-dom';
import logger from 'sabio-debug';
import { Formik, Form, Field, ErrorMessage } from 'formik';
import { registerSchema } from '../../schema/authSchema';
import * as auth from '../../services/authService';
import './register.css';

const _logger = logger.extend('Register');

const Register = () => {
    const [registerFormData] = useState({
        user: {
            email: '',
            password: '',
            passwordConfirm: '',
        },
    });

    const navigate = useNavigate();

    const handleSubmit = (values) => {
        _logger("Register Form Data", values);
        auth.register(values).then(onRegisterSuccess).catch(onRegisterError);
    };

    const [showPassword, setShowPassword] = useState(false);

    const handleClick = () => {
        setShowPassword(!showPassword);
    };

    const [showPasswordConfirm, setShowPasswordConfirm] = useState(false);

    const handleClickConfirm = () => {
        setShowPasswordConfirm(!showPasswordConfirm);
    };

    const onRegisterSuccess = (response) => {
        _logger('response', response);

        navigate('/checkEmail');
    };

    const onRegisterError = (response) => {
        _logger(response.response);
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
                            <h4 className="text-dark-50 text-center mt-0 fw-bold">Free Sign Up</h4>
                            <p className="text-muted mb-4">
                                Dont have an account? Create your account, it takes less than a minute.
                            </p>
                        </div>
                        <Formik
                            enableReinitialize={true}
                            initialValues={registerFormData.user}
                            onSubmit={handleSubmit}
                            validationSchema={registerSchema}>
                            <Form>
                                <div className="form-group my-3">
                                    <label>Email</label>
                                    <Field
                                        name="email"
                                        type="email"
                                        placeholder="Enter a valid email"
                                        className="form-control"
                                    />
                                    <ErrorMessage name="email" component="div" className="has-error" />
                                </div>
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

                                <button type="submit" className="btn btn-primary">
                                    Sign Up
                                </button>
                            </Form>
                        </Formik>
                    </Card.Body>
                </Card>
                <Row className="mt-3">
                    <Col className="text-center">
                        <p className="text-muted">
                            Already have account?
                            <Link to={'/login'} className="text-muted ms-1">
                                <b>Log In</b>
                            </Link>
                        </p>
                    </Col>
                </Row>
            </div>
        </React.Fragment>
    );
};

export default Register;
