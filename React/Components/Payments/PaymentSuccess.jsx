import { React, useEffect, useState } from 'react';
import { Link, useSearchParams } from 'react-router-dom';
import { Card, Container } from 'react-bootstrap';
import * as orderService from '../../services/orderService';
import './css/product.css';
import EmailPdfButton from '../pdf/EmailPdf';
import PDFButton from '../pdf/PDFButton';
import Loader from '../Loader';
import debug from 'sabio-debug';

const _logger = debug.extend('Payment Success');

const PaymentSuccess = () => {
    const [loading, setLoading] = useState(true);

    const [invoiceData, setInvoiceData] = useState({
        data: {
            invoice: 0,
            discount: 0,
            tax: 0,
            fees: 0,
            billTo: {
                firstName: '',
                lastName: '',
                email: '',
                street: '',
                city: '',
                zipCode: '',
                state: '',
                phoneNumber: '',
                appartmentNumber: '',
            },
            shipTo: {
                firstName: '',
                lastName: '',
                email: '',
                street: '',
                city: '',
                zipCode: '',
                state: '',
                phoneNumber: '',
            },
            dataTable: [{ item: '', quantity: 0, price: 0 }],
        },
    });

    const [summary, setSummary] = useState({
        total: 0,
    });

    const [searchParams] = useSearchParams();

    useEffect(() => {
        const sessionId = searchParams.get('session_id');
        orderService.update(sessionId).then(onUpdateOrderSuccess).catch(onUpdateOrderError);
    }, []);

    const onUpdateOrderSuccess = async () => {
        const orderId = searchParams.get('orderId');
        _logger(orderId);

        const response = await orderService.getById(orderId);
        const order = response.item;

        setInvoiceData((prevState) => {
            const newState = { ...prevState };

            newState.data = { ...prevState.data };

            newState.data.billTo = {
                ...prevState.data.billTo,
                firstName: order.firstName,
                lastName: order.lastName,
                street: order.billingAddress.line1,
                city: order.billingAddress.city,
                zipCode: order.billingAddress.postalCode,
                state: order.billingAddress.state,
                phoneNumber: order.phoneNumber,
            };

            newState.data.invoice = order.id;
            newState.data.dataTable = order.orderItems.map((item) => {
                return {
                    item: item.name,
                    quantity: item.quantity,
                    price: item.basePrice,
                };
            });

            return newState;
        });

        setSummary((prevState) => {
            const newState = { ...prevState };
            newState.total = order.total;

            return newState;
        });

        setLoading(false);
    };

    const onUpdateOrderError = async (err) => {
        _logger(err);
    };

    return (
        <>
            {loading ? (
                <Loader />
            ) : (
                <Container className="justify-content-center payment-success-center payment-background">
                    <Card className="text-center payment-card">
                        <Card.Body>
                            <Container>
                                <h1 className="text-success m-4">Your payment was successful!</h1>
                            </Container>
                            <div className="table-responsive">
                                <table className="table mb-0">
                                    <thead className="table-light">
                                        <tr>
                                            <th>Item</th>
                                            <th>Quantity</th>
                                            <th>Price</th>
                                            <th>Subtotal</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {invoiceData.data.dataTable.map((item, idx) => {
                                            return (
                                                <tr key={idx}>
                                                    <td>{item.item}</td>
                                                    <td>{item.quantity}</td>
                                                    <td>{'$ ' + item.price}</td>
                                                    <td>{'$ ' + (item.price * item.quantity).toFixed(2)}</td>
                                                </tr>
                                            );
                                        })}
                                    </tbody>
                                </table>
                            </div>
                            <div className="table-responsive">
                                <table className="table mb-0">
                                    <tbody>
                                        <tr>
                                            <th className="text-dark">Total :</th>
                                            <td>{'$ ' + summary.total}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div className="d-grid">
                                <div>
                                    <PDFButton type="invoice" data={invoiceData.data} />
                                    <EmailPdfButton type="invoice" data={invoiceData.data} />
                                </div>
                                <Link type="btn" className="success-button" to={'/'}>
                                    Click here to go back to the home page
                                </Link>
                            </div>
                        </Card.Body>
                    </Card>
                </Container>
            )}
        </>
    );
};

export default PaymentSuccess;
