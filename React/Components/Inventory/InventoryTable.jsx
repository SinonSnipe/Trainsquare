import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import PropTypes from 'prop-types';
import UpdateInventory from './UpdateInventory';
import toastr from 'toastr';
import * as service from '../../services/inventoryService';
import { Card, OverlayTrigger, Table, Tooltip, Modal, Button } from 'react-bootstrap';
import debug from 'sabio-debug';

const _logger = debug.extend('InventoryTable');

const InventoryTable = (props) => {
    const aInventoryItem = props.invtry;

    const [show, setShow] = useState(false);

    const handleShow = () => setShow(true);
    const handleClose = () => setShow(false);
    _logger('inventory props', props, aInventoryItem);

    const onLocalEditClicked = () => {
        handleShow();
        props.editHandle(aInventoryItem);
    };

    const onLocalInventoryRowClicked = (e) => {
        e.preventDefault();
        props.onInventoryRowClicked(props.invtry, e);
    };

    const updateInventory = (e) => {
        e.preventDefault();

        const data = {
            workshopId: aInventoryItem.workshopId.id,
            workShopName: aInventoryItem.workShopName,
            basePrice: aInventoryItem.basePrice,
            quantity: aInventoryItem.quantity,
            createdBy: aInventoryItem.createdBy,
            modifiedBy: aInventoryItem.quantity,
            id: aInventoryItem.id,
        };
        service.update(data, data.id).then(onEditSuccess).catch(onEditError);
    };

    const onEditSuccess = (response) => {
        _logger(response, 'You have successfully updated an inventory item.');
        toastr.success('You have successfully updated an inventory item.');
    };

    const onEditError = (response) => {
        _logger(response, 'error when editing a new post');
        toastr.error('There was an issue updating the inventory item');
    };

    return (
        <div>
            <Card>
                <Card.Body>
                    <Table responsive className="table-centered mb-1">
                        <tbody>
                            <tr>
                                <td width="20%">
                                    <h5 className="font-14 my-1 fw-normal">{aInventoryItem.workShopName}</h5>

                                    <span className="text-muted font-13">Workshop Name</span>
                                </td>
                                <td width="30%">
                                    <h5 className="font-14 my-1 fw-normal">{aInventoryItem.summary}</h5>
                                    <span className="text-muted font-13">Description</span>
                                </td>
                                <td width="15%">
                                    <h5 className="font-14 my-1 fw-normal">${aInventoryItem.basePrice}</h5>
                                    <span className="text-muted font-13">Base Price</span>
                                </td>
                                <td width="5%">
                                    <h5 className="font-14 my-1 fw-normal">{aInventoryItem.quantity}</h5>
                                    <span className="text-muted font-13">Quantity</span>
                                </td>
                                <td width="20%">
                                    <h5 className="font-14 my-1 fw-normal">
                                        {aInventoryItem.createdBy.firstName} {aInventoryItem.createdBy.lastName}
                                    </h5>
                                    <span className="text-muted font-13">POC</span>
                                </td>

                                <td width="10%">
                                    <OverlayTrigger placement="top" overlay={<Tooltip>Edit</Tooltip>}>
                                        <Link to="#" className="font-18 text-info me-2" onClick={onLocalEditClicked}>
                                            <i className="mdi mdi-pencil"></i>
                                        </Link>
                                    </OverlayTrigger>
                                    <OverlayTrigger placement="top" overlay={<Tooltip>Delete</Tooltip>}>
                                        <Link
                                            to="#"
                                            className="font-18 text-danger"
                                            onClick={onLocalInventoryRowClicked}>
                                            <i className="mdi mdi-trash-can-outline"></i>
                                        </Link>
                                    </OverlayTrigger>
                                </td>
                            </tr>
                        </tbody>
                    </Table>
                </Card.Body>
            </Card>

            <Modal show={show} onHide={handleClose} aria-labelledby="contained-modal-title-vcenter" centered>
                <Modal.Header closeButton>
                    <Modal.Title>Edit Inventory Item</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <UpdateInventory aInventoryItem={aInventoryItem} />
                </Modal.Body>
                <Modal.Footer>
                    <Button variant="secondary" onClick={handleClose}>
                        Close
                    </Button>
                    <Button variant="primary" type="submit" onClick={updateInventory}>
                        Save Changes
                    </Button>
                </Modal.Footer>
            </Modal>
        </div>
    );
};

InventoryTable.propTypes = {
    invtry: PropTypes.shape({
        id: PropTypes.number,
        quantity: PropTypes.number.isRequired,
        workShopName: PropTypes.string,
        summary: PropTypes.string,
        basePrice: PropTypes.number,
        workshopId: PropTypes.shape({
            id: PropTypes.number,
        }),
        modifiedBy: PropTypes.shape({
            id: PropTypes.number,
            firstName: PropTypes.string,
            lastName: PropTypes.string,
            avatarUrl: PropTypes.string,
        }),
        createdBy: PropTypes.shape({
            id: PropTypes.number,
            firstName: PropTypes.string,
            lastName: PropTypes.string,
            avatarUrl: PropTypes.string,
        }),
    }),
    onInventoryRowClicked: PropTypes.func.isRequired,
    editHandle: PropTypes.func.isRequired,
};

export default React.memo(InventoryTable);
