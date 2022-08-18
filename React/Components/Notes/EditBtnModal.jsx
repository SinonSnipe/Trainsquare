import React, { useState, useEffect } from 'react';
import { Modal, Form } from 'react-bootstrap';
import debug from 'sabio-debug';
import lookup from '../../services/lookupService';
import toastr from '../../utils/toastr';
import PropTypes from 'prop-types';
import noteService from '../../services/noteService';
const _logger = debug.extend('EditBtnModal');

function EditBtnModal({ cardData }) {
    _logger(cardData);

    const [scroll, setScroll] = useState(null);
    const [size, setSize] = useState(null);
    const [className, setClassName] = useState(null);
    const [modal, setModal] = useState(false);

    const [formInfo, setFormInfo] = useState({
        workShop: cardData.workShops.name,
        tagsTypeId: cardData.tag.name,
        notes: cardData.notes,
        dateModified: '',
    });

    const [tagsContent, setTagsContent] = useState([]);
    useEffect(() => {
        lookup(['TagsTypes']).then(onLookupSuccess).catch(onLookupError);
    }, []);
    const onLookupSuccess = (response) => {
        setTagsContent((prevState) => {
            let newType = { ...prevState };
            newType = response.item.tagsTypes;
            return newType;
        });
    };
    const onLookupError = (response) => {
        _logger(response, 'error retrieving lookup table');
    };

    const onFormChange = (e) => {
        const target = e.target;
        const newFieldValue = target.value;
        _logger(newFieldValue);
        const nameOfField = target.name;

        const updatedFormData = { ...formInfo };
        updatedFormData[nameOfField] = newFieldValue;
        _logger({ updatedFormData });
        setFormInfo(updatedFormData);
    };

    const handleSubmit = (values) => {
        debugger;
        values.preventDefault();
        _logger(values, 'SUBMIT EDIT BUTTON', 'values:');
        noteService.update(cardData.id, formInfo).then(onUpdateSuccess).catch(onUpdateError);
    };

    const onUpdateSuccess = (response) => {
        toastr.success('Note Successfully Updated');
        window.location.reload();
        _logger(response.item, 'update response');
    };

    const onUpdateError = (error) => {
        toastr.error('Unable to Update Note');
        _logger(error);
    };

    const openModalWithScroll = () => {
        setScroll(true);
        setSize(null);
        setClassName(null);
        toggle();
        setModal(!modal);
    };

    const toggle = () => {
        setModal(!modal);
    };
    _logger({ cardData });

    return (
        <React.Fragment>
            <button className="btn btn-primary mt-1 mx-1  back rounded-pill shadow-lg" onClick={openModalWithScroll}>
                <i className="mdi mdi-pencil"></i>
                Edit
            </button>
            <Modal show={modal} onHide={toggle} dialogClassName={className} size={size} scrollable={scroll}>
                <Modal.Header onHide={toggle} closeButton>
                    <h4 className="modal-title">Workshop Name: {formInfo.workShop} </h4>
                </Modal.Header>
                <Modal.Body>
                    <Form>
                        <div className="form-group mb-3 my-2 mx-2">
                            <label htmlFor="workShop">Workshop</label>
                            <input
                                type="text"
                                className="form-control"
                                value={formInfo.workShop}
                                onChange={onFormChange}
                                placeholder="Enter Workshop Name"
                                name="workShop"
                            />
                        </div>

                        <div className="form-group mb-3 my-2 mx-2">
                            <label htmlFor="workShopId">Workshop Id</label>
                            <input
                                type="text"
                                className="form-control"
                                value={formInfo.workShopId}
                                onChange={onFormChange}
                                placeholder="Enter Workshop Id"
                                name="workShopId"
                            />
                        </div>

                        <div className="form-group mb-3  my-2 mx-2">
                            <label htmlFor="tagsTypeId">Workshop Tag </label>
                            <select
                                className="form-control"
                                name="tagsTypeId"
                                onChange={onFormChange}
                                value={formInfo.tagsTypeId}>
                                <option value="">Select a Tag Type</option>
                                {tagsContent.map((tagsTypeId, index) => (
                                    <option value={tagsTypeId.id} key={`${tagsTypeId}_${index}`}>
                                        {tagsTypeId.name}
                                    </option>
                                ))}
                            </select>
                        </div>
                        <div className="form-group mb-3  my-2 mx-2">
                            <div>
                                <label htmlFor="notes">Notes</label>

                                <textarea
                                    className="form-control"
                                    name="notes"
                                    value={formInfo.notes}
                                    onChange={onFormChange}
                                    rows="7"
                                    placeholder="Enter Workshop Notes"
                                />
                            </div>
                        </div>

                        <div className="form-group mb-3 my-2 mx-2">
                            <label htmlFor="dateModified">Date Modified</label>
                            <input
                                type="date"
                                className="form-control"
                                value={formInfo.dateModified}
                                onChange={onFormChange}
                                name="dateModified"
                            />
                        </div>
                    </Form>
                </Modal.Body>
                <Modal.Footer>
                    <div className="d-grip gap-2 d-md-flex justify-content-md-end"></div>
                    <button className="btn btn-secondary mb-2 back rounded-pill shadow" onClick={toggle}>
                        Cancel
                    </button>
                    <button
                        type="submit"
                        className="btn btn-primary mb-2 back rounded-pill shadow"
                        onClick={handleSubmit}>
                        Submit
                    </button>
                </Modal.Footer>
            </Modal>
        </React.Fragment>
    );
}
EditBtnModal.propTypes = {
    cardData: PropTypes.shape({
        id: PropTypes.number,
        notes: PropTypes.string,
        tag: PropTypes.shape({ id: PropTypes.number, name: PropTypes.string }),
        workShops: PropTypes.shape({ id: PropTypes.number, name: PropTypes.string }),
        dateCreated: PropTypes.string,
        dateModified: PropTypes.string,
        createdBy: PropTypes.number,
        modifiedBy: PropTypes.number,
    }),
    onUpdateRequested: PropTypes.func,
    handleSubmit: PropTypes.func,
};
export default EditBtnModal;
