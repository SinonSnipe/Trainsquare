import React, { useRef, useEffect, forwardRef } from 'react';
import { useTable, useSortBy, usePagination, useGlobalFilter, useAsyncDebounce, useRowSelect } from 'react-table';
import classNames from 'classnames';

import Pagination from './Pagination';
import debug from 'sabio-debug';
import PropTypes from 'prop-types';

const _logger = debug.extend('Table');

const GlobalFilter = ({ preGlobalFilteredRows, globalFilter, setGlobalFilter, searchBoxClass }) => {
    const count = preGlobalFilteredRows.length;
    const [value, setValue] = React.useState(globalFilter);
    const onChange = useAsyncDebounce((value) => {
        setGlobalFilter(value || undefined);
    }, 200);

    _logger({ preGlobalFilteredRows, globalFilter, setGlobalFilter, searchBoxClass });

    return (
        <div className={classNames(searchBoxClass)}>
            <span className="d-flex align-items-center">
                Search :{' '}
                <input
                    value={value || ''}
                    onChange={(e) => {
                        setValue(e.target.value);
                        onChange(e.target.value);
                    }}
                    placeholder={`${count} records...`}
                    className="form-control w-auto ms-1"
                />
            </span>
        </div>
    );
};

const IndeterminateCheckbox = forwardRef(({ indeterminate, ...rest }, ref) => {
    const defaultRef = useRef();
    const resolvedRef = ref || defaultRef;

    useEffect(() => {
        resolvedRef.current.indeterminate = indeterminate;
    }, [resolvedRef, indeterminate]);

    return (
        <>
            <div className="form-check">
                <input type="checkbox" className="form-check-input" ref={resolvedRef} {...rest} />
                <label htmlFor="form-check-input" className="form-check-label"></label>
            </div>
        </>
    );
});

const Table = (props) => {
    const isSearchable = props['isSearchable'] || false;
    const isSortable = props['isSortable'] || false;
    const pagination = props['pagination'] || false;
    const isSelectable = props['isSelectable'] || false;

    const dataTable = useTable(
        {
            columns: props['columns'],
            data: props['data'],
            initialState: { pageSize: props['pageSize'] || 10 },
        },
        isSearchable && useGlobalFilter,
        isSortable && useSortBy,
        pagination && usePagination,
        isSelectable && useRowSelect,
        (hooks) => {
            isSelectable &&
                hooks.visibleColumns.push((columns) => [
                    {
                        id: 'selection',
                        Header: ({ getToggleAllPageRowsSelectedProps }) => (
                            <div>
                                <IndeterminateCheckbox {...getToggleAllPageRowsSelectedProps()} />
                            </div>
                        ),
                        Cell: ({ row }) => (
                            <div>
                                <IndeterminateCheckbox {...row.getToggleRowSelectedProps()} />
                            </div>
                        ),
                    },
                    ...columns,
                ]);
        }
    );

    let rows = pagination ? dataTable.page : dataTable.rows;

    return (
        <>
            {isSearchable && (
                <GlobalFilter
                    preGlobalFilteredRows={dataTable.preGlobalFilteredRows}
                    globalFilter={dataTable.state.globalFilter}
                    setGlobalFilter={dataTable.setGlobalFilter}
                    searchBoxClass={props['searchBoxClass']}
                />
            )}

            <div className="table-responsive">
                <table
                    {...dataTable.getTableProps()}
                    className={classNames('table table-centered react-table', props['tableClass'])}>
                    <thead className={props['theadClass']}>
                        {dataTable.headerGroups.map((headerGroup, index) => (
                            <tr {...headerGroup.getHeaderGroupProps()} key={index}>
                                {headerGroup.headers.map((column, index) => (
                                    <th
                                        key={index}
                                        {...column.getHeaderProps(column.sort && column.getSortByToggleProps())}
                                        className={classNames({
                                            sortingDesc: column.isSortedDesc === true,
                                            sortingAsc: column.isSortedDesc === false,
                                            sortable: column.sort === true,
                                        })}>
                                        {column.render('Header')}
                                    </th>
                                ))}
                            </tr>
                        ))}
                    </thead>
                    <tbody {...dataTable.getTableBodyProps()}>
                        {(rows || []).map((row, index) => {
                            dataTable.prepareRow(row);
                            return (
                                <tr key={index} {...row.getRowProps()}>
                                    {row.cells.map((cell, index) => {
                                        return (
                                            <td key={index} {...cell.getCellProps()}>
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

            {pagination && <Pagination tableProps={dataTable} sizePerPageList={props['sizePerPageList']} />}
        </>
    );
};

Table.propTypes = {
    columns: PropTypes.arrayOf(PropTypes.shape({})),
    data: PropTypes.arrayOf(PropTypes.shape({})),
    isSearchable: PropTypes.bool.isRequired,
    isSortable: PropTypes.bool.isRequired,
    isSelectable: PropTypes.bool.isRequired,
    sizePerPageList: PropTypes.arrayOf(
        PropTypes.shape({
            text: PropTypes.string,
            value: PropTypes.number,
        })
    ),
    tableClass: PropTypes.string,
    theadClass: PropTypes.string,
    pageSize: PropTypes.number,
    pagination: PropTypes?.bool,
    searchBoxClass: PropTypes.string,
    getToggleAllPageRowsSelectedProps: PropTypes.func,
    row: PropTypes.func,
};
GlobalFilter.propTypes = {
    preGlobalFilteredRows: PropTypes.arrayOf(PropTypes.shape({})),
    globalFilter: PropTypes.string,
    setGlobalFilter: PropTypes.func,
    searchBoxClass: PropTypes.string,
};
IndeterminateCheckbox.propTypes = {
    indeterminate: PropTypes?.bool,
};

export default Table;
