import React, { useState, useEffect } from 'react';
import { loadStripe } from '@stripe/stripe-js';
import { Elements } from '@stripe/react-stripe-js';
import * as helpers from '../../services/serviceHelpers';
import * as payment from '../../services/paymentService';
import CheckoutForm from './CheckoutForm';
import { Container } from 'react-bootstrap';
import toastr from 'toastr';
import './css/product.css';
import './css/stripe.css';
import debug from 'sabio-debug';
const _logger = debug.extend('StripeCheckout');
const stripePromise = loadStripe(helpers.STRIPE_API_KEY);

const StripeCheckout = (currentUser) => {
    const [clientSecret, setClientSecret] = useState('');
    const [productInfo] = useState({
        amount: 12000,
        currency: 'usd',
    });

    _logger(clientSecret);

    const onCreateIntentSuccess = (response) => {
        setClientSecret(response.value.client_secret);
    };

    const onCreateIntentError = (error) => {
        toastr.error(error);
    };

    useEffect(() => {
        payment.createIntent(productInfo).then(onCreateIntentSuccess).catch(onCreateIntentError);
    }, []);

    const appearance = {
        theme: 'stripe',
    };
    const options = {
        clientSecret,
        appearance,
    };

    return (
        <Container>
            {clientSecret && (
                <Elements options={options} stripe={stripePromise}>
                    <CheckoutForm user={currentUser} />
                </Elements>
            )}
        </Container>
    );
};

export default StripeCheckout;
