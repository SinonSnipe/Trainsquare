import React, { useState } from 'react';
import * as service from '../../services/inventoryService';
import { useLocation } from 'react-router-dom';
import toastr from 'toastr';
import { Formik, Form, Field, ErrorMessage } from 'formik';
import inventorySchema from '../../schema/inventorySchema';
import debug from 'sabio-debug';

const _logger = debug.extend('AddInventory');
function AddNewInventory() {
    const [newInventoryData, setNewInventoryData] = useState({
        workshopId: '',
        createdBy: '',
        modifiedBy: '',
        basePrice: '',
        quantity: '',
        workshopName: '',
    });

    const { state } = useLocation();

    _logger(state);

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
        service.add(values).then(onSubmitSuccess).catch(onSubmitError);

        _logger(values);
    };

    const onSubmitSuccess = (response) => {
        _logger('onSubmitSuccess', response.data.item);
        toastr.success('You have successfully added an inventory item.' + response.data.item);
        _logger(response);

        setNewInventoryData((prevState) => {
            const newInventory = { ...prevState, id: response.id };
            return newInventory;
        });
    };

    const onSubmitError = (error) => {
        _logger('onSubmitError', error);
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
                                        value={newInventoryData.workshopId}
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
                                <br />

                                <button type="submit" className="btn btn-primary">
                                    Submit
                                </button>
                            </Form>
                        </Formik>
                    </div>
                </div>
            </div>
        </React.Fragment>
    );
}

export default AddNewInventory;
