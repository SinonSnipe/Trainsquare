import React from 'react';
import { useTable } from 'react-table';
import debug from 'sabio-debug';
import propTypes from 'prop-types';
import classNames from 'classnames';
import '../userDashboard.css';

const _logger = debug.extend('Table'); //sabio:Table

const Table = (props) => {
    const { columns, data, tableClass, theadClass } = props;
    _logger(columns);
    _logger(data);

    const dataTable = useTable({ columns, data });

    let rows = dataTable.rows;

    return (
        <>
            <div className="paymentTable">
                <div className="table-responsive">
                    <table
                        {...dataTable.getTableProps()}
                        className={classNames('table table-centered react-table', tableClass)}>
                        <thead className={theadClass}>
                            {dataTable.headerGroups.map((headerGroup, i) => (
                                <tr {...headerGroup.getHeaderGroupProps()} key={i}>
                                    {headerGroup.headers.map((column, j) => (
                                        <th
                                            {...column.getHeaderProps(column.sort)}
                                            key={j}
                                            className={classNames({
                                                sortingDesc: column.isSortedDesc === true,
                                                sortingAsc: column.isSortedDesc === false,
                                            })}>
                                            {column.render('Header')}
                                        </th>
                                    ))}
                                </tr>
                            ))}
                        </thead>
                        <tbody {...dataTable.getTableBodyProps()}>
                            {(rows || []).map((row, i) => {
                                dataTable.prepareRow(row);
                                return (
                                    <tr {...row.getRowProps()} key={i}>
                                        {row.cells.map((cell, j) => {
                                            return (
                                                <td {...cell.getCellProps()} key={j}>
                                                    {cell.render('Cell')}
                                                </td>
                                            );
                                        })}
                                    </tr>
                                );
                            })}
                        </tbody>
                    </table>
                </div>
            </div>
        </>
    );
};

Table.propTypes = {
    columns: propTypes.arrayOf(propTypes.shape({ headers: propTypes.string })),
    data: propTypes.arrayOf(propTypes.shape({ cell: propTypes.string })),
    tableClass: propTypes.string,
    theadClass: propTypes.string,
};
export default Table;
