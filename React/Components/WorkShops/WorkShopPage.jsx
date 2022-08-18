import React, { useEffect, useState } from 'react';
import WorkshopCard from './WorkshopCard';
import { Row, Container, CardGroup } from 'react-bootstrap';
import { Link } from 'react-router-dom';
import { useDebounce } from '../surveys/Debounce';
import * as inventoryService from '../../services/inventoryService';
import locale from 'rc-pagination/lib/locale/en_US';
import Pagination from 'rc-pagination';
import debug from 'sabio-debug';
import './work-shop.css';

const _logger = debug.extend('workShops');

const WorkShops = () => {
    const [inventoryData, setInventoryData] = useState({
        inventory: [],
        inventoryComponents: [],
        workshopsRandom: [],
        workshopRandomComponents: [],
        currentPage: 0,
        pageSize: 3,
        totalPages: 0,
    });

    const [searchInput, setSearchInput] = useState('');
    const debouncedSearchInput = useDebounce(searchInput, 500);

    useEffect(() => {
        if (searchInput.length > 0) {
            inventoryService
                .paginateV2Search(inventoryData.currentPage, inventoryData.pageSize, searchInput)
                .then(onGetWorkShopSuccess)
                .catch(onGetWorkShopError);
        } else {
            inventoryService
                .paginateV2(inventoryData.currentPage, inventoryData.pageSize)
                .then(onGetWorkShopSuccess)
                .catch(onGetWorkShopError);
        }
    }, [debouncedSearchInput]);

    const onGetWorkShopError = (data) => {
        _logger('Error', data);
    };

    const onGetWorkShopSuccess = (data) => {
        _logger('success', data);
        let inventory = data.item.pagedItems;
        let pageIndex = data.item.pageIndex;
        let pageSize = data.item.pageSize;
        let totalPages = data.item.totalPages;

        setInventoryData((prevState) => {
            const newState = { ...prevState };
            newState.inventory = inventory;
            newState.currentPage = pageIndex;
            newState.pageSize = pageSize;
            newState.totalPages = totalPages;

            newState.inventoryComponents = inventory.map(mapInventory);
            return newState;
        });
    };

    const mapInventory = (inventoryItem) => {
        return <WorkshopCard inventoryData={inventoryItem} key={inventoryItem.id} />;
    };

    const changeHandler = (e) => {
        e.preventDefault();
        setSearchInput(e.target.value);
        _logger(e.target.value);
    };

    const onChange = (page) => {
        inventoryService
            .paginateV2(page - 1, inventoryData.pageSize)
            .then(onGetWorkShopSuccess)
            .catch(onGetWorkShopError);

        setInventoryData((prevState) => {
            let newState = { ...prevState };
            newState.currentPage = page;

            return newState;
        });
    };

    return (
        <Container>
            <div className="d-flex justify-content-end">
                <Link to="loki" className="m-3">
                    <button className="btn btn-primary">Host a workshop</button>
                </Link>
            </div>
            <Row>
                <div className="d-flex justify-content-between align-items-center">
                    <h3 className="text-dark mt-3 mb-3">View all workshops</h3>
                    <input
                        type="text"
                        className="form-control w-25 p-3 h-50"
                        placeholder="Search..."
                        value={searchInput}
                        onChange={changeHandler}
                    />
                </div>

                <CardGroup className="container gap-5 d-flex justify-content-center">
                    {inventoryData.inventoryComponents}
                </CardGroup>
            </Row>
            <Row className="text-center m-3">
                <Pagination
                    onChange={onChange}
                    currentPage={inventoryData.currentPage}
                    total={inventoryData.totalPages * 10}
                    locale={locale}
                />
            </Row>
        </Container>
    );
};

export default WorkShops;
