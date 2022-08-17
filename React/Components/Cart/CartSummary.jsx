// @flow
import React from 'react';

import { Table } from 'react-bootstrap';

import PropTypes from 'prop-types';

const CartSummary = (props) => {
    const summary = props.summary || {};

    return (
        <>
            <div className="border p-3 mt-4 mt-lg-0 rounded">
                <h4 className="header-title mb-3">Order Summary</h4>

                <Table responsive className="mb-0">
                    <tbody>
                        <tr>
                            <td>Grand Total :</td>
                            <td>${summary.grossTotal.toFixed(2)}</td>
                        </tr>
                        <tr>
                            <td>Discount : </td>
                            <td>-${summary.discount.toFixed(2)}</td>
                        </tr>
                        <tr>
                            <td>Estimated Tax : </td>
                            <td>${summary.tax.toFixed(2)}</td>
                        </tr>
                        <tr>
                            <th>Total :</th>
                            <th>${summary.netTotal.toFixed(2)}</th>
                        </tr>
                    </tbody>
                </Table>
            </div>
        </>
    );
};

CartSummary.propTypes = {
    summary: PropTypes.shape({
        grossTotal: PropTypes.number,
        discount: PropTypes.number,
        tax: PropTypes.number,
        netTotal: PropTypes.number,
    }),
};

export default CartSummary;
