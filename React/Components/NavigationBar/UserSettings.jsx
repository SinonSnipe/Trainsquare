import React, { useEffect, useState, useContext } from 'react';
import debug from 'sabio-debug';
import './user-settings.css';
import { LoginContext } from '../../constants/loginContext';
import * as newsletterSubscriptionService from '../../services/newsletterSubscriptionService';
import { Button, Modal, Row } from 'react-bootstrap';
import toastr from '../../utils/toastr';
import { Formik, Form, Field, ErrorMessage } from 'formik';
import * as userService from '../../services/userService';
import { passwordChangeSchema } from '../../schema/authSchema';

const _logger = debug.extend('UserSetting');
_logger('E-ChangePassword');

function UserSettings() {
    const { currentUser } = useContext(LoginContext);
    const [userSettingsData, setUserSettingsData] = useState({
        email: '',
    });

    const [passwordChangeData, setPasswordChangeData] = useState({
        oldPassword: '',
        newPassword: '',
        newPasswordConfirm: '',        
    });

    const onPasswordFieldChange = (event) => {
        _logger({ event });
        const target = event.target;
        const userValue = target.value;
        const nameOfField = target.name;

        setPasswordChangeData((prevState) => {
            const userObject = { ...prevState };
            userObject[nameOfField] = userValue;
            return userObject;
        });
    };

    const [showOldPassword, setShowOldPassword] = useState(false);

    const handleClickOld = () => {
        setShowOldPassword(!showOldPassword);
    };

    const [showNewPassword, setShowNewPassword] = useState(false);

    const handleClickNew = () => {
        setShowNewPassword(!showNewPassword);
    };
    const [showNewPasswordConfirm, setShowNewPasswordConfirm] = useState(false);

    const handleClickConfirm = () => {
        setShowNewPasswordConfirm(!showNewPasswordConfirm);
    };

    const [info, setInfo] = useState(false);
    const [size, setSize] = useState(null);
    const [scroll, setScroll] = useState(null);

    const toggle = () => {
        setInfo(!info);
    };

    const openModalWithSize = (size) => {
        setSize(size);
        setScroll(null);
        toggle();
    };

    const onChangePasswordClicked = () => {
        openModalWithSize('lg');
    };

    const onFormFieldChange = (event) => {
        _logger({ event });
        const target = event.target;
        const userValue = target.value;
        const nameOfField = target.name;

        setUserSettingsData((prevState) => {
            const userObject = {
                ...prevState,
            };
            userObject[nameOfField] = userValue;
            return userObject;
        });
    };

    useEffect(() => {
        if (currentUser) {
            _logger(currentUser);
            setUserSettingsData((prevState) => {
                let editUserState = { ...prevState, ...currentUser };
                editUserState.email = currentUser.email;
                return editUserState;
            });
        }
    }, [currentUser]);

    const handleUnsubscribe = () => {
        _logger(currentUser.email);
        newsletterSubscriptionService
            .unsubscribe(currentUser.email)
            .then(onUnsubscribeSuccess)
            .catch(onUnsubscribeError);
    };

    const onUnsubscribeSuccess = (response) => {
        _logger(response);
        toastr.success('Success!', 'You have successfully UNSUBSCRIBED');
    };

    const onUnsubscribeError = (err) => {
        _logger(err);
        toastr.error('Not Successful', 'You will need to UNSUBSCRIBE again');
    };

    const handleChangePassword = () => {
        _logger(currentUser);

        userService.changePassword(passwordChangeData).then(onChangeSuccess).catch(onChangeError);
    };

    const onChangeSuccess = (res) => {
        _logger('onPasswordChangeSuccess', res);
        toastr.success('Your password has been changed.');
    };

    const onChangeError = (err) => {
        _logger('ConfirmTokenError.', err.response);
        toastr.error('Your password failed to change.');
    };

    return (
        <div className="container">
            <div className="row justify-content-center p-5">
                <h1 className="card-text-title">User Settings</h1>
            </div>

            <div className="container">
                <div className="row justify-content-center">
                    <form>
                        <div className="form-group">
                            <div className="row justify-content-center">
                                <div className="col-sm-4">
                                    <label className="strong-text-email p-1">Email</label>
                                    <br></br>
                                    <input
                                        type="text"
                                        className="form-control lg-text-pholder"
                                        id="email"
                                        aria-describedby="email"
                                        placeholder="Enter Email Address"
                                        name="email"
                                        value={userSettingsData.email}
                                        onChange={onFormFieldChange}></input>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div className="row">
                    <div className="col">
                        <button
                            onClick={handleUnsubscribe}
                            className="btn btn-unsub btn-hover-unsub"
                            type="submit"
                            id="unSubscribe">
                            Unsubscribe From Newsletter
                        </button>
                    </div>
                </div>
                <div className="row">
                    <div className="col">
                        <button
                            onClick={onChangePasswordClicked}
                            className="btn btn-cha btn-hover-change"
                            type="submit"
                            id="change">
                            Change Password
                        </button>
                    </div>
                </div>
            </div>

            <Modal show={info} onHide={toggle} size={size} scrollable={scroll}>
                <Modal.Header onHide={toggle} closeButton>
                    <h4>Change Password</h4>
                </Modal.Header>
                <Modal.Body>
                    <Row>
                        <Formik
                            enableReinitialize={true}
                            initialValues={passwordChangeData}
                            validationSchema={passwordChangeSchema}>
                            <Form>
                                <label className="modal-label-pword">Old Password</label>
                                <div className="input-group mb-3">
                                    <Field
                                        name="oldPassword"
                                        type={showOldPassword ? 'text' : 'password'}
                                        placeholder="Enter your old password"
                                        className="form-control"
                                        onChange={onPasswordFieldChange}
                                    />
                                    <div className="input-group-prepend">
                                        <span className="input-group-text pointer" onClick={handleClickOld}>
                                            {showOldPassword ? (
                                                <i className="mdi mdi-eye"></i>
                                            ) : (
                                                <i className="mdi mdi-eye-off"></i>
                                            )}
                                        </span>
                                    </div>
                                    <ErrorMessage name="oldPassword" component="div" className="has-error" />
                                </div>
                                <label className="modal-label-pword">New Password</label>
                                <div className="input-group mb-3">
                                    <Field
                                        name="newPassword"
                                        type={showNewPassword ? 'text' : 'password'}
                                        placeholder="Enter your new password"
                                        className="form-control"
                                        onChange={onPasswordFieldChange}
                                    />
                                    <div className="input-group-prepend">
                                        <span className="input-group-text pointer" onClick={handleClickNew}>
                                            {showNewPassword ? (
                                                <i className="mdi mdi-eye  "></i>
                                            ) : (
                                                <i className="mdi mdi-eye-off"></i>
                                            )}
                                        </span>
                                    </div>
                                    <ErrorMessage name="newPassword" component="div" className="has-error" />
                                </div>
                                <label className="modal-label-pword">Confirm New Password</label>

                                <div className="input-group mb-3">
                                    <Field
                                        name="newPasswordConfirm"
                                        type={showNewPasswordConfirm ? 'text' : 'password'}
                                        placeholder="Confirm your new password"
                                        className="form-control"
                                        onChange={onPasswordFieldChange}
                                    />
                                    <div className="input-group-prepend">
                                        <span className="input-group-text pointer" onClick={handleClickConfirm}>
                                            {showNewPasswordConfirm ? (
                                                <i className="mdi mdi-eye  "></i>
                                            ) : (
                                                <i className="mdi mdi-eye-off"></i>
                                            )}
                                        </span>
                                    </div>
                                    <ErrorMessage name="newPasswordConfirm" component="div" className="has-error" />
                                </div>
                            </Form>
                        </Formik>
                    </Row>
                </Modal.Body>
                <Modal.Footer>
                    <Button variant="primary" onClick={handleChangePassword}>
                        Submit New Password
                    </Button>
                    <Button variant="danger" onClick={toggle}>
                        Cancel
                    </Button>
                </Modal.Footer>
            </Modal>
        </div>
    );
}

export default UserSettings;
