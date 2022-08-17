import React, { useEffect, useState, useContext } from 'react';
import PropTypes from 'prop-types';
import { Card } from 'react-bootstrap';
import { Formik, Form, Field, ErrorMessage } from 'formik';
import { LoginContext } from '../../constants/loginContext';
import { useNavigate, useLocation } from 'react-router-dom';
import * as twoFactorAuth from '../../services/smsService';
import * as toastr from 'toastr';
import debug from 'sabio-debug';
const _tfaLogger = debug.extend('TFALOGGER');

const TwoFactorAuth = () => {
    const { state } = useLocation();
    const { setCurrentUser } = useContext(LoginContext);
    const navigate = useNavigate();
    const [code] = useState({
        smsCode: '',
    });

    const [secretCode, setSecretCode] = useState('');

    _tfaLogger('WILL THIS WORK', state);

    useEffect(() => {
        twoFactorAuth.generateTFA().then(onSuccess).catch(onError);

    }, []);

    const onSuccess = (data) => {
        _tfaLogger('TFA GENERATE SUCCESS', data);
        twoFactorAuth.getTFA().then(onGetTfaSuccess).catch(onGetTFAError);
    };
    const onError = (error) => {
        _tfaLogger('TFA GENERATE ERROR', error);
    };

    const handleSubmit = (values) => {

        _tfaLogger("User TYPED CODE", values, values.smsCode, secretCode);
        if (values.smsCode === secretCode) {
            toastr.success('SUCCESS CODE');
            setCurrentUser((prevState) => {
                return {
                    ...prevState,
                    isLoggedIn: true,
                };
            });
            navigate('/dashboard');

        } else {
            toastr.error('WRONG CODE');
        }
    };

    const onGetTfaSuccess = (data) => {
        _tfaLogger('TFA GET SUCCESS', data.item.code);
        setSecretCode(data.item.code);

    };
    const onGetTFAError = (error) => {
        _tfaLogger('TFA GET ERROR', error);
    };

    return (
        <div className="container formContainer center">
            <Card className="mx-5 ">
                <Card.Header className="header">
                    <h2 className="header-font text-center">Trainsquare</h2>
                </Card.Header>
                <Card.Body>
                    <div className="text-center w-75 m-auto">
                        <h4 className="text-dark-50 text-center mt-0 fw-bold">Two Factor Authentication</h4>
                        <p className="text-muted mb-4">Enter your Two Factor Authentication Code</p>
                    </div>
                    <Formik enableReinitialize={true} initialValues={code} onSubmit={handleSubmit}>
                        <Form>
                            <div className="form-group my-3">
                                <label>SMS Code</label>
                                <Field name="smsCode" placeholder="Enter a valid code" className="form-control" />
                                <ErrorMessage name="code" component="div" className="has-error" />
                            </div>

                            <button type="submit" className="btn btn-primary">
                                Submit
                            </button>
                        </Form>
                    </Formik>
                </Card.Body>
            </Card>
        </div>
    );
};

TwoFactorAuth.propTypes = {
    state: PropTypes.shape({
        id: PropTypes.number,
        isTwoFactorEnabled: PropTypes.bool,
        phoneNumber: PropTypes.string,
        imageUrl: PropTypes.string,
        status: PropTypes.shape({
            id: PropTypes.number,
            name: PropTypes.string,
        }),
        twoFactorType: PropTypes.shape({
            id: PropTypes.number,
            name: PropTypes.string,
        }),
        user: PropTypes.shape({
            id: PropTypes.number,
            firstName: PropTypes.string,
            lastName: PropTypes.string,
            avatarUrl: PropTypes.string,
        }),
        dateCreated: PropTypes.string,
        dateModified: PropTypes.string,
    }),
};

export default TwoFactorAuth;
