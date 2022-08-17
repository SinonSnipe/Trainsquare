import React, { useState, useContext } from 'react';
import { Card, Row, Col } from 'react-bootstrap';
import { Link, useNavigate } from 'react-router-dom';
import logger from 'sabio-debug';
import { Formik, Form, Field, ErrorMessage } from 'formik';
import { LoginContext } from '../../constants/loginContext';
import * as auth from '../../services/authService';
import * as twoFactorAuth from '../../services/smsService';
import { getUserProfile } from '../../services/userDashBoardServices';
import { loginSchema } from '../../schema/authSchema';
import toastr from '../../utils/toastr';
import './login.css';

const _logger = logger.extend('Login');

const Login = () => {
    const { setCurrentUser } = useContext(LoginContext);
    const navigate = useNavigate();

    const [loginFormData] = useState({
        user: {
            email: '',
            password: '',
        },
    });
    const [showPassword, setShowPassword] = useState(false);

    const handleClick = () => {
        setShowPassword(!showPassword);
    };

    const handleSubmit = (values) => {
        auth.login(values).then(onLoginSuccess).catch(onLoginError);
    };

    const onLoginSuccess = (response) => {
        _logger(response);
        auth.currentUser().then(onGetCurrentUserSuccess).catch(onGetCurrentUserError);
        twoFactorAuth.getTFA().then(onGetTfaSuccess).catch(onGetTFAError);
    };

    const onLoginError = (response) => {
        _logger(response.response);
        toastr.error('Please verify login credentials and try again.', 'Login Unsuccessful.');
    };

    const onGetCurrentUserSuccess = (response) => {
        const userCredentials = response.data.item;

        getUserProfile(userCredentials.id).then(getProfileSuccess);

        const loginUser = { type: 'LOGIN', payload: userCredentials };
        const userRoles = userCredentials.roles;

        _logger('Get Current User Success Response loginUser & state Info', loginUser, userRoles);

        setCurrentUser((prevState) => {
            return {
                ...prevState,
                id: loginUser.payload.id,
                email: loginUser.payload.name,
                roles: loginUser.payload.roles,
                isLoggedIn: true,
            };
        });

        if (userRoles[0] === 'Admin') {
            navigate('/dashboard');
        } else if (userRoles[0] === 'Host') {
            navigate('/dashboard/host');
        } else if (userRoles[0] === 'User') {
            navigate('/dashboard');
        }
    };

    const getProfileSuccess = (response) => {
        const userProfile = response.data.item;

        _logger('userProfile', userProfile);

        setCurrentUser((prevState) => {
            return {
                ...prevState,
                fullName: userProfile.firstName,
                profilePic: userProfile.avatarUrl,
            };
        });
    };

    const onGetCurrentUserError = (response) => {
        _logger('Get Current User Error Response', response);
    };
    const onGetTfaSuccess = (data) => {
        const tfaInfo = { type: 'TWO_FACTOR_AUTH', payload: data.item };
        _logger('TFA GRAB SUCCESS', tfaInfo);
        if (tfaInfo.payload.isTwoFactorEnabled === true) {
            setCurrentUser((prevState) => {
                return {
                    ...prevState,
                    isLoggedIn: false,
                };
            });
            navigate('/twofactorauth', { state: tfaInfo });
        }
    };
    const onGetTFAError = (error) => {
        _logger('TFA ERROR', error);
    };

    return (
        <div className="container formContainer center">
            <Card className="mx-5 ">
                <Card.Header className="header">
                    <h2 className="header-font text-center">Trainsquare</h2>
                </Card.Header>
                <Card.Body>
                    <div className="text-center w-75 m-auto">
                        <h4 className="text-dark-50 text-center mt-0 fw-bold">Sign In</h4>
                        <p className="text-muted mb-4">Enter your email address and password</p>
                    </div>
                    <Formik
                        enableReinitialize={true}
                        initialValues={loginFormData.user}
                        onSubmit={handleSubmit}
                        validationSchema={loginSchema}>
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
                            <Link to="/forgotPassword" className="text-muted float-end">
                                <small>Forgot your password?</small>
                            </Link>
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

                            <button type="submit" className="btn btn-primary">
                                Log In
                            </button>
                        </Form>
                    </Formik>
                </Card.Body>
            </Card>
            <Row className="mt-3">
                <Col className="text-center">
                    <p className="text-muted">
                        Dont have an account?
                        <Link to={'/register'} className="text-muted ms-1">
                            <b>Sign Up</b>
                        </Link>
                    </p>
                </Col>
            </Row>
        </div>
    );
};

export default Login;
