import { Formik, Form, Field, ErrorMessage } from 'formik';
import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import * as service from '../../services/inventoryService';
import inventorySchema from '../../schema/inventorySchema';
import toastr from '../../utils/toastr';
import debug from 'sabio-debug';

const _logger = debug.extend('UpdateInventory');
const UpdateInventory = (props) => {
    const [newInventoryData, setNewInventoryData] = useState({
        workshopId: '',
        createdBy: '',
        modifiedBy: '',
        basePrice: '',
        quantity: '',
    });

    useEffect(() => {
        if (props.aInventoryItem) {
            setNewInventoryData((prevState) => {
                return { ...prevState, ...props.aInventoryItem };
            });
        }
    }, []);
    _logger('inv', props.aInventoryItem);

    const onFormFieldChange = (e) => {
        _logger('onChange', { syntheticEvent: e });

        const target = e.target;
        const newInventoryValue = target.value;
        const nameOfField = target.name;

        _logger({ nameOfField, newInventoryValue });

        setNewInventoryData((prevState) => {
            _logger('updater onChange');

            const newInventoryObject = {
                ...prevState,
            };

            newInventoryObject[nameOfField] = newInventoryValue;

            return newInventoryObject;
        });

        _logger('end onChange');
    };

    const handleSubmit = (values) => {
        _logger('val', values);
        service.update(values).then(onUpdateInventorySuccess).catch(onUpdateInventoryError);
    };

    const onUpdateInventorySuccess = (response) => {
        _logger({ inventory: response });
        toastr.success('You have successfully edited inventory.' + response);
    };

    const onUpdateInventoryError = (error) => {
        _logger('onUpdateInventoryError', error);
        toastr.error('There was an issue updating. Please try again.');
    };

    return (
        <React.Fragment>
            <div className="row">
                <div className="col">
                    <div className="form-group">
                        <Formik
                            enableReinitialize={true}
                            initialValues={newInventoryData}
                            onSubmit={handleSubmit}
                            validationSchema={inventorySchema}>
                            <Form className="w-50 p-3 mx-auto form-group">
                                <div className="mb-3">
                                    <label htmlFor="workshopId">
                                        <strong>Workshop Id</strong>
                                    </label>
                                    <Field
                                        type="text"
                                        name="workshopId"
                                        className="form-control"
                                        id="workshopId"
                                        value={newInventoryData.workshopId.Id}
                                        onChange={onFormFieldChange}
                                        placeholder="Enter WorkShop Id Here"
                                    />
                                    <ErrorMessage name="workshopId" component="div" className="has-error" />
                                </div>

                                <br />
                                <div className="mb-3">
                                    <label htmlFor="basePrice">
                                        <strong>Price</strong>
                                    </label>
                                    <Field
                                        type="text"
                                        name="basePrice"
                                        className="form-control"
                                        id="basePrice"
                                        value={newInventoryData.basePrice}
                                        onChange={onFormFieldChange}
                                        placeholder="Enter Price Here"
                                    />
                                    <ErrorMessage name="basePrice" component="div" className="has-error" />
                                </div>
                                <br />
                                <div className="mb-3">
                                    <label htmlFor="quantity">
                                        <strong>Quantity</strong>
                                    </label>
                                    <Field
                                        type="text"
                                        name="quantity"
                                        className="form-control"
                                        id="quantity"
                                        value={newInventoryData.quantity}
                                        onChange={onFormFieldChange}
                                        placeholder="Enter Quantity Here"
                                    />
                                    <ErrorMessage name="quantity" component="div" className="has-error" />
                                </div>
                            </Form>
                        </Formik>
                    </div>
                </div>
            </div>
        </React.Fragment>
    );
};

UpdateInventory.propTypes = {
    aInventoryItem: PropTypes.shape({
        id: PropTypes.number,
        quantity: PropTypes.number.isRequired,
        summary: PropTypes.string,
        basePrice: PropTypes.number,
        workshopId: PropTypes.shape({
            id: PropTypes.number,
            workShopName: PropTypes.string,
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
    setAInventoryItem: PropTypes.func,
};

export default UpdateInventory;
