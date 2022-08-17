import React, { useEffect, useState } from 'react';
import { Card } from 'react-bootstrap';
import logger from 'sabio-debug';
import * as emailService from '../../services/userService';
import mailSent from '../../assets/images/mail_sent.svg';
import { Link } from 'react-router-dom';
import './confirm.css';
const _logger = logger.extend('Confirm');

const Confirm = () => {
    const [message, setMessage] = useState({
        message: '',
    });

    const onConfirmTokenSuccess = (res) => {
        _logger('ConfirmTokenSuccess!', res);
        setMessage({
            message: 'Your email is confirmed!',
        });
    };

    const onConfirmTokenError = (err) => {
        _logger('ConfirmTokenError.', err.response);
        setMessage({
            message: 'Sorry, your email can not be confirmed.',
        });
    };
    const queryParams = new URLSearchParams(window.location.search);
    const token = queryParams.get('token');

    useEffect(() => {
        _logger('Token', token);

        emailService.confirmRegisterToken(token).then(onConfirmTokenSuccess).catch(onConfirmTokenError);
    }, []);

    return (
        <div className="container formContainer center">
            <Card className="mx-5">
                <Card.Header className="header">
                    <h2 className="header-font text-center">Trainsquare</h2>
                </Card.Header>
                <Card.Body>
                    {' '}
                    <div className="text-center m-auto">
                        <img src={mailSent} alt="mail sent" height="64" className="my-1" />
                        <h5 className="text-dark-50 text-center mt-4 fw-bold">
                            Please wait while we verify your email.
                        </h5>
                        <p className="text-muted mb-4"></p>
                        <p className="text-center">{message.message}</p>
                        <Link className="btn btn-primary" to="/login">
                            Back to Login
                        </Link>
                    </div>
                </Card.Body>
            </Card>
        </div>
    );
};

export default Confirm;
