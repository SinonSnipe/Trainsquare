import React, { useState } from 'react';
import './css/note-card.css';
import PropTypes from 'prop-types';
import EditBtnModal from './EditBtnModal';
import debug from 'sabio-debug';
import { Modal } from 'react-bootstrap';
const _logger = debug.extend('NoteCardTemplate');

function NoteCardTemplate(props) {
    _logger(props, 'Note Card Template');
    const aNote = props.notes;

    const [modal, setModal] = useState(false);

    const openModalWithHeaderClass = () => {
        toggle();
    };

    const toggle = () => {
        setModal(!modal);
    };

    const onLocalDeleteClicked = (e) => {
        props.onDeleteNoteClicked(props.notes, e);
    };

    return (
        <div className="col-md-3 mt-2 mx-3 my-2" style={{ width: 300 }}>
            <div className="notes-card">
                <div className="notes-upper-container"></div>
                <div className="notes-lower-container">
                    <h3> {aNote.workShops.name} </h3>
                    <h4> {aNote.tag.name} </h4>
                    <p> {aNote.notes} </p>
                    <EditBtnModal cardData={aNote} />
                    <button
                        className="btn btn-secondary mt-1 mx-1 back rounded-pill shadow"
                        onClick={openModalWithHeaderClass}>
                        <i className="mdi mdi-delete"></i>
                        Delete
                    </button>

                    <Modal show={modal} onHide={toggle}>
                        <Modal.Header onHide={toggle} closeButton></Modal.Header>
                        <Modal.Body>
                            <h5 className="mt-0"> Are you sure you want to delete this Note?</h5>
                        </Modal.Body>
                        <Modal.Footer>
                            <button className="btn btn-primary mb-2 back rounded-pill shadow" onClick={toggle}>
                                Cancel
                            </button>{' '}
                            <button
                                className="btn btn-danger mb-2 back rounded-pill shadow"
                                onClick={onLocalDeleteClicked}>
                                <i className="mdi mdi-delete"></i>
                                Delete
                            </button>
                        </Modal.Footer>
                    </Modal>
                </div>
            </div>
        </div>
    );
}

NoteCardTemplate.propTypes = {
    notes: PropTypes.shape({
        id: PropTypes.number.isRequired,
        notes: PropTypes.string,
        workShops: PropTypes.shape({ id: PropTypes.number.isRequired, name: PropTypes.string }),
        tag: PropTypes.shape({ id: PropTypes.number.isRequired, name: PropTypes.string }),
        dateCreated: PropTypes.string,
        dateModified: PropTypes.string,
        createdBy: PropTypes.number,
        modifiedBy: PropTypes.number,
    }),
    onDeleteNoteClicked: PropTypes.func,
    onUpdateRequested: PropTypes.func,
};

export default NoteCardTemplate;
