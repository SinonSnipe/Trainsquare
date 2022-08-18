import React, { useState, useEffect, useCallback } from 'react';
import PrivateBookingCard from '../../components/privatebooking/PrivateBookingCard';
import { Link } from 'react-router-dom';
import { useDebounce } from '../surveys/Debounce';
import Pagination from 'rc-pagination';
import locale from 'rc-pagination/lib/locale/en_US';
import 'rc-pagination/assets/index.css';
import * as privateBookingService from '../../services/privateBookingService';
import toastr from 'toastr';
import debug from 'sabio-debug';

const _logger = debug.extend('PrivateBooking');

const PrivateBooking = () => {
    const [pageData] = useState({
        arrayOfBookings: [],
        bookingComponents: [],
    });
    _logger(pageData);

    const [pagination, setPagination] = useState({
        inventory: [],
        inventoryComponents: [],
        currentPage: 0,
        pageSize: 4,
        totalCount: 0,
    });

    const [searchInput, setSearchInput] = useState('');
    const debouncedSearchInput = useDebounce(searchInput, 500);

    useEffect(() => {
        if (searchInput.length > 0) {
            privateBookingService
                .getBookingSearch(pagination.currentPage, pagination.pageSize, searchInput)
                .then(onGetWorkshopSuccess)
                .catch(onGetWorkshopError);
        } else {
            privateBookingService
                .paginateBooking(pagination.currentPage, pagination.pageSize)
                .then(onGetWorkshopSuccess)
                .catch(onGetWorkshopError);
        }
    }, [debouncedSearchInput]);

    const mapBooking = (aBooking) => {
        return (
            <PrivateBookingCard
                booking={aBooking}
                key={`list A - ${aBooking.id}`}
                onBookingClicked={onHandleDelete}></PrivateBookingCard>
        );
    };

    const onHandleDelete = useCallback((myBooking) => {
        const handler = getDeleteSuccessHandler(myBooking.id);
        privateBookingService.deleteBooking(myBooking.id).then(handler).catch(onDeleteBookingError);
    }, []);

    const getDeleteSuccessHandler = (idToBeDeleted) => {
        return () => {
            setPagination((prevState) => {
                const pd = { ...prevState };
                const bookingArray = [...pd.inventory];

                const idxOf = bookingArray.findIndex((booking) => {
                    let result = false;

                    if (booking.id === idToBeDeleted) {
                        result = true;
                    }

                    return result;
                });
                if (idxOf >= 0) {
                    bookingArray.splice(idxOf, 1);
                    const updatedComponents = bookingArray.map(mapBooking);
                    pd.inventory = bookingArray;
                    pd.inventoryComponents = updatedComponents;
                }
                return pd;
            });
            toastr['success']('Successfully deleted!', 'Success');
        };
    };

    const onDeleteBookingError = () => {
        toastr['error']('failed to delete!', 'error!');
    };

    const onGetWorkshopSuccess = (data) => {
        _logger('success --->', data);
        let inventory = data.item.pagedItems;
        let pageIndex = data.item.pageIndex;
        let pageSize = data.item.pageSize;
        let totalCount = data.item.totalCount;

        setPagination((prevState) => {
            const newState = { ...prevState };
            newState.inventory = inventory;
            newState.currentPage = pageIndex;
            newState.pageSize = pageSize;
            newState.totalCount = totalCount;

            newState.inventoryComponents = inventory.map(mapBooking);
            return newState;
        });
    };

    const onGetWorkshopError = (data) => {
        _logger('Error', data);
    };

    const changeHandler = (e) => {
        e.preventDefault();
        setSearchInput(e.target.value);
        _logger(e.target.value);
    };

    const onChange = (page) => {
        privateBookingService
            .paginateBooking(page - 1, pagination.pageSize)
            .then(onGetWorkshopSuccess)
            .catch(onGetWorkshopError);

        setPagination((prevState) => {
            let newState = { ...prevState };
            newState.currentPage = page;

            return newState;
        });
    };

    return (
        <React.Fragment>
            <div className="container">
                <div className="row ">
                    <h1 className="row justify-content-center my-3">Private Workshop Requests</h1>
                </div>
                <div className="row align-items-center">
                    <div className="col">
                        <Link to="/booking/new" className="btn btn-info" type="button">
                            Add
                        </Link>
                    </div>
                    <div className="col text-center">
                        <Pagination
                            onChange={onChange}
                            current={pagination.currentPage - 1}
                            pageSize={pagination.pageSize}
                            total={pagination.totalCount}
                            locale={locale}
                        />
                    </div>
                    <div className="col text-end">
                        <div className="form-group">
                            <input
                                type="text"
                                name="search"
                                placeholder="Search..."
                                style={{ styles: 'styles-pb' }}
                                value={searchInput}
                                onChange={changeHandler}
                            />
                        </div>
                    </div>
                </div>
            </div>
            <div className="container mt-3">
                <div className="row">{pagination.inventory.map(mapBooking)}</div>
            </div>
        </React.Fragment>
    );
};

export default PrivateBooking;
