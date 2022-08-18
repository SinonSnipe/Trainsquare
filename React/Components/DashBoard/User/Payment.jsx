import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { Row, Col, Card, Button } from 'react-bootstrap';
import classNames from 'classnames';
import propTypes from 'prop-types';
import Table from '../payment/PaymentTable';
import debug from 'sabio-debug';
import { orders } from './dataOrder';
import { Pagination } from 'react-bootstrap';

const _logger = debug.extend('Orders'); //sabio:Orders

const OrderColumn = (props) => {
    const { row } = props;
    _logger(row);
    return (
        <>
            <div className="text-body fw-bold">#BM{row.original.orderId}</div>
        </>
    );
};

const OrderDateColumn = (props) => {
    const { row } = props;
    return (
        <>
            {row.original.orderDate} <small className="text-muted">{row.original.orderTime}</small>
        </>
    );
};

const PaymentStatusColumn = (props) => {
    const { row } = props;
    return (
        <>
            <h5>
                <span
                    className={classNames('badge', {
                        'badge-success-lighten': row.original.paymentStatus === 'Paid',
                        'badge-danger-lighten': row.original.paymentStatus === 'Payment Failed',
                        'badge-info-lighten': row.original.paymentStatus === 'Unpaid',
                        'badge-warning-lighten': row.original.paymentStatus === 'Awaiting Authorization',
                    })}>
                    {row.original.paymentStatus === 'Paid' && <i className="mdi mdi-coin me-1"></i>}
                    {row.original.paymentStatus === 'Payment Failed' && <i className="mdi mdi-cancel me-1"></i>}
                    {row.original.paymentStatus === 'Unpaid' && <i className="mdi mdi-cash me-1"></i>}
                    {row.original.paymentStatus === 'Awaiting Authorization' && (
                        <i className="mdi mdi-timer-sand me-1"></i>
                    )}
                    {row.original.paymentStatus}
                </span>
            </h5>
        </>
    );
};

/* status column render */
const StatusColumn = (props) => {
    const { row } = props;
    return (
        <>
            <h5>
                <span
                    className={classNames('badge', {
                        'badge-success-lighten': row.original.orderStatus === 'Delivered',
                        'badge-danger-lighten': row.original.orderStatus === 'Cancelled',
                        'badge-info-lighten': row.original.orderStatus === 'Shipped',
                        'badge-warning-lighten': row.original.orderStatus === 'Processing',
                    })}>
                    {row?.original?.orderStatus}
                </span>
            </h5>
        </>
    );
};

/* action column render */
const ActionColumn = () => {
    return (
        <>
            <Link to="#" className="action-icon">
                {' '}
                <i className="mdi mdi-square-edit-outline"></i>
            </Link>
        </>
    );
};

const columns = [
    {
        Header: 'Order ID',
        accessor: 'orderId',
        Cell: OrderColumn,
    },
    {
        Header: 'Date',
        accessor: 'orderDate',
        Cell: OrderDateColumn,
    },
    {
        Header: 'Payment Status',
        accessor: 'paymentStatus',
        Cell: PaymentStatusColumn,
    },
    {
        Header: 'Total',
        accessor: 'total',
    },
    {
        Header: 'Payment Method',
        accessor: 'paymentMethod',
    },
    {
        Header: 'Status',
        accessor: 'orderStatus',
        Cell: StatusColumn,
    },
    {
        Header: 'Action',
        accessor: 'action',
        classes: 'table-action',
        Cell: ActionColumn,
    },
];

// main component
const Orders = () => {
    const [orderList] = useState(orders);

    return (
        <>
            <Row>
                <Col xs={12}>
                    <Card>
                        <Card.Body>
                            <Row className="mb-2">
                                <Col xl={8}></Col>

                                <Col xl={4}>
                                    <div className="text-lg-end mt-xl-0 mt-2">
                                        <Button variant="light" className="mb-2">
                                            Export
                                        </Button>
                                    </div>
                                </Col>
                            </Row>

                            <Table columns={columns} data={orderList} theadClass="table-light" searchBoxClass="mb-2" />
                        </Card.Body>
                        <div style={{ display: 'flex', justifyContent: 'center' }}>
                            <Pagination>
                                <Pagination.First />
                                <Pagination.Prev />
                                <Pagination.Item active>{1}</Pagination.Item>
                                <Pagination.Next />
                                <Pagination.Last />
                            </Pagination>
                        </div>
                    </Card>
                </Col>
            </Row>
        </>
    );
};
OrderColumn.propTypes = {
    row: propTypes.shape({
        original: propTypes.shape({
            orderId: propTypes.string.isRequired,
        }),
    }),
};

OrderDateColumn.propTypes = {
    row: propTypes.shape({
        original: propTypes.shape({
            orderDate: propTypes.string.isRequired,
            orderTime: propTypes.string.isRequired,
        }),
    }),
};

PaymentStatusColumn.propTypes = {
    row: propTypes.shape({
        original: propTypes.shape({
            paymentStatus: propTypes.string.isRequired,
        }),
    }),
};

StatusColumn.propTypes = {
    row: propTypes.shape({
        original: propTypes.shape({
            orderStatus: propTypes.string.isRequired,
        }),
    }),
};

export default Orders;
