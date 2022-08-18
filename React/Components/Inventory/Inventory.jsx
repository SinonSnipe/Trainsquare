import React, { useState, useEffect, useCallback } from 'react';
import PageTitle from './PageTitle';
import * as service from '../../services/inventoryService';
import InventoryTable from './InventoryTable';
import { Row, Col } from 'react-bootstrap';
import AddInventory from './AddInventory';
import toastr from 'toastr';
import debug from 'sabio-debug';

const _logger = debug.extend('Inventory');

const Inventory = () => {
    const [page] = useState({
        pageIndex: 0,
        pageSize: 10,
    });

    const [pageData, setPageData] = useState({
        inventory: [],
        inventoryComponents: [],
        isShown: false,
    });

    const [workShopInfo, setWorkShop] = useState({
        workShopName: '',
        summary: '',
        shortDescription: '',
        imageUrl: '',
        numberOfSessions: '',
        startTime: '',
        endTime: '',
        externalSiteUrl: '',
    });

    _logger(workShopInfo);

    const onDeleteRequested = useCallback((myInventory, eObj) => {
        _logger(myInventory.id, { myInventory, eObj });

        const handler = getDeleteSuccessHandler(myInventory.id);

        service.deleteById(myInventory.id).then(handler).catch(onDeleteError);
    }, []);

    const getDeleteSuccessHandler = (idToBeDeleted) => {
        _logger('getDeleteSuccessHandler', idToBeDeleted);
        toastr.success('You have successfully removed an inventory item.');

        setPageData((prevState) => {
            const pd = { ...prevState };
            pd.inventory = [...pd.inventory];

            const idxOf = pd.inventory.findIndex((inventory) => {
                let result = false;

                if (inventory.id === idToBeDeleted) {
                    result = true;
                }
                return result;
            });

            if (idxOf >= 0) {
                pd.inventory.splice(idxOf, 1);
                pd.inventoryComponents = pd.inventory.map(mapInventory);
            }

            return pd;
        });
    };

    const onDeleteError = (error) => {
        _logger('Deleteing', error);
    };

    _logger(pageData);

    const mapInventory = (aInventoryItem) => {
        return (
            <InventoryTable
                invtry={aInventoryItem}
                key={aInventoryItem.id}
                onInventoryRowClicked={onDeleteRequested}
                editHandle={editHandle}
            />
        );
    };

    useEffect(() => {
        _logger('firing useEffect for getInventory');
        callInventory();
    }, []);

    const callInventory = () => {
        service.paginate(page.pageIndex, page.pageSize).then(onGetInventorySuccess).catch(onGetInventoryError);
    };

    const onGetInventorySuccess = (data) => {
        _logger(data);

        let arrayOfInventory = data.data.item.pagedItems;
        _logger({ arrayOfInventory });

        setPageData((prevState) => {
            const pd = { ...prevState };
            pd.inventory = arrayOfInventory;
            pd.inventoryComponents = arrayOfInventory.map(mapInventory);
            return pd;
        });

        setWorkShop({
            workShopName: arrayOfInventory[0].workShopName,
            shortDescription: arrayOfInventory[0].shortDescription,
            summary: arrayOfInventory[0].summary,
            imageUrl: arrayOfInventory[0].imageUrl,
        });
    };

    const onGetInventoryError = (error) => {
        _logger('error getting Inventory', error);
    };

    const editHandle = (aInventoryItem) => {
        _logger('inventory edit handle running', aInventoryItem);
    };

    return (
        <>
            <PageTitle
                breadCrumbItems={[{ label: 'Inventory', path: '/inventory', active: true }]}
                title={'Inventory'}
            />

            <Row>
                <Col xl={5} lg={6}>
                    <AddInventory />
                </Col>
                <Col xl={7} lg={6}>
                    <div>
                        <h4>Inventory Table</h4>
                    </div>
                    <div className="col">
                        <div className="d-grid gap-2 d-md-flex justify-content-md-end">
                            <input
                                type="text"
                                className="form-control"
                                name="query"
                                placeholder="Search"
                                aria-label="query"
                            />

                            <button className="btn btn-secondary me-md-2" type="button">
                                Search
                            </button>
                        </div>
                        {pageData.inventory.map(mapInventory)}
                    </div>
                </Col>
            </Row>
        </>
    );
};

export default Inventory;
