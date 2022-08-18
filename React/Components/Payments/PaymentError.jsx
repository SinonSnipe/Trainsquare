import React, { useEffect } from 'react';
import { Container } from 'react-bootstrap';
import { useSearchParams } from 'react-router-dom';
import * as orderService from '../../services/orderService';
import debug from 'sabio-debug';

const _logger = debug.extend('Payment Error');

const PaymentError = () => {
    const [searchParams] = useSearchParams();

    useEffect(() => {
        _logger(searchParams.get('session_id'));
        orderService.update(searchParams.get('session_id'));
    }, []);

    return (
        <Container className="text-center m-5 text-dark">
            <h1>Payment cancelled</h1>
            <h4>Your payment method was not charged.</h4>
            <p>Please reach out to us if you need assistance. </p>
        </Container>
    );
};

export default PaymentError;
