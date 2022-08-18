import React, { useState } from 'react';
import * as externalLinksService from '../../services/externalLinksService.js';
import toastr from 'toastr';
import PropTypes, { number, string } from 'prop-types';
import debug from 'sabio-debug';
import { Form } from 'react-bootstrap';

const _logger = debug.extend('ExternalLinksAddOrEdit');

function ExternalLinksAddOrEdit() {
    const [currentForm, setCurrentForm] = useState({
        userId: number,
        urlTypeId: number,
        url: string,
        entityId: number,
        entityTypeId: number,
    });
    const [currentId, setCurrentId] = useState({});

    const onFormFieldChange = (e) => {
        _logger('onChange', { syntheticEvent: e });
        const target = e.target;
        const value = target.value;
        const property = target.name;
        setCurrentForm((prevState) => {
            _logger('updater onChange');
            const newLink = {
                ...prevState,
            };
            newLink[property] = value;
            return newLink;
        });
        setCurrentId((prevState) => {
            _logger('updater onChange');
            const editedLink = {
                ...prevState,
            };
            editedLink[property] = value;
            return editedLink;
        });
    };

    const onAddClick = (e) => {
        e.preventDefault();
        externalLinksService.AddExternalLink(currentForm).then(onAddExternalLinkSuccess).catch(onAddExternalLinkError);
    };
    const onAddExternalLinkSuccess = (response) => {
        const id = response.data.item;
        _logger(response, `onAddExternalLinkSuccess: ${id}`);
        toastr.success(`Success Adding External Link ID: ${id}`);
    };
    const onAddExternalLinkError = (error) => {
        _logger(error, 'onAddExternalLinkError');
        const errorData = error.data;
        toastr.error(`Add External Link Error: ${errorData}`);
    };

    const onUpdateClick = (e) => {
        e.preventDefault();
        const payload = currentForm;
        externalLinksService
            .UpdateExternalLink(payload, currentId.id)
            .then(onEditExternalLinkSuccess)
            .catch(onEditExternalLinkError);
    };
    const onEditExternalLinkSuccess = (response) => {
        _logger(response, 'onEditExternalLinkSuccess');
        const id = response.data.item;
        toastr.success(`Success Editing External Link ID: ${id}`);
    };
    const onEditExternalLinkError = (error) => {
        _logger(error, 'onEditExternalLinkError');
        const errorData = error.data;
        toastr.error(`Edit External Link Error: ${errorData}`);
    };

    return (
        <React.Fragment>
            <br></br>
            <br></br>
            <div className="container">
                <h4>Add or Edit External Link</h4>
            </div>
            <div className="mx-auto mt-4" style={{ width: 400 }}>
                <form>
                    <div className="form-group mb-3">
                        <label htmlFor="id">Record ID: this box for UPDATEs ONLY</label>
                        <input
                            type="text"
                            className="form-control"
                            id="id"
                            name="id"
                            placeholder="This box ONLY for UPDATEs"
                            value={currentId.id}
                            onChange={onFormFieldChange}
                        />
                    </div>
                    <div className="form-group mb-3">
                        <label htmlFor="userId">User ID</label>
                        <input
                            type="text"
                            className="form-control"
                            id="userId"
                            name="userId"
                            placeholder="Enter User ID"
                            value={currentForm.userId}
                            onChange={onFormFieldChange}
                        />
                    </div>
                    <div className="form-group mb-3">
                        <label htmlFor="url">URL Type</label>
                        <Form.Select
                            className="form-select"
                            id="urlTypeId"
                            name="urlTypeId"
                            value={currentForm.urlTypeId}
                            onChange={onFormFieldChange}>
                            <option>Select URL Type</option>
                            <option value="1">Facebook</option>
                            <option value="2">Instagram</option>
                            <option value="3">LinkedIn</option>
                            <option value="4">Twitter</option>
                            <option value="5">TikTok</option>
                        </Form.Select>
                    </div>
                    <div className="form-group mb-3">
                        <label htmlFor="url">URL</label>
                        <input
                            type="text"
                            className="form-control"
                            id="url"
                            name="url"
                            placeholder="Enter URL"
                            value={currentForm.url}
                            onChange={onFormFieldChange}
                        />
                    </div>
                    <div className="form-group mb-3">
                        <label htmlFor="entityTypeId">Entity Type</label>
                        <Form.Select
                            className="form-select"
                            id="entityTypeId"
                            name="entityTypeId"
                            value={currentForm.entityTypeId}
                            onChange={onFormFieldChange}>
                            <option>Select Entity Type</option>
                            <option value="1">Private Non-Commercial</option>
                            <option value="2">Information & Communications Technology</option>
                            <option value="3">Publishing</option>
                            <option value="4">Investment & Finance</option>
                            <option value="5">Travel</option>
                            <option value="6">Entertainment</option>
                            <option value="7">Sports & Outdoors</option>
                            <option value="8">Training</option>
                            <option value="9">Workshop</option>
                            <option value="10">NGO</option>
                        </Form.Select>
                    </div>
                    <div className="form-group mb-3">
                        <label htmlFor="entityId">Entity ID</label>
                        <input
                            type="text"
                            className="form-control"
                            id="entityId"
                            name="entityId"
                            placeholder="Enter Entity ID"
                            value={currentForm.entityId}
                            onChange={onFormFieldChange}
                        />
                    </div>
                    <br></br>
                    <button type="submit" className="btn btn-primary" id="addButton" onClick={onAddClick}>
                        ADD
                    </button>
                    <button type="submit" className="btn btn-info ms-3" id="addOrEditButton" onClick={onUpdateClick}>
                        UPDATE
                    </button>
                </form>
            </div>
            <br></br>
        </React.Fragment>
    );
}

ExternalLinksAddOrEdit.propTypes = {
    userId: PropTypes.number.isRequired,
    urlTypeId: PropTypes.number.isRequired,
    url: PropTypes.string.isRequired,
    entityId: PropTypes.number.isRequired,
    entityTypeId: PropTypes.number.isRequired,
};

export default ExternalLinksAddOrEdit;
