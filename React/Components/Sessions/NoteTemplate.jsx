import React, { useState } from 'react';
import debug from 'sabio-debug';
import './css/note-card.css';
import PropTypes from 'prop-types';
import moment from 'moment';
import { Modal } from 'react-bootstrap';
import EditButton from './EditButton';
import ViewButton from './ViewButton';

const _logger = debug.extend('NoteTemplate');

function NoteTemplate(props) {
    _logger(props, 'Note Card Template');
    const aSessionNote = props.noted;
    //proptypes  instance of

    const toggle = () => {
        setModal(!modal);
    };

    const [modal, setModal] = useState(false);

    const openModalWithHeaderClass = () => {
        toggle();
    };

    const onLocalDeleteClicked = (e) => {
        props.onDeleteNoteClicked(props.noted, e);
    };

    return (
        <div className="col-md-3 mt-2 mx-3 my-2" style={{ width: 300 }}>
            <div className="notes-card">
                <div className="notes-upper-container"></div>
                <div className="notes-lower-container">
                    <h3> {aSessionNote.workshopName} </h3>
                    <h4> {aSessionNote.tag.name} </h4>
                    <p> {aSessionNote.notes} </p>
                    <p>{moment(aSessionNote.sessionDate).format('MMM Do YYYY')}</p>

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
                <a>
                    <ViewButton viewData={aSessionNote} className="text-left" />
                </a>
                <div className="text-center">
                    <EditButton cardData={aSessionNote} />
                    <button
                        className="btn btn-danger mt-1 mx-1 back rounded-pill shadow mdi mdi-trash-can"
                        onClick={openModalWithHeaderClass}>
                        Delete
                    </button>
                </div>
            </div>
        </div>
    );
}

NoteTemplate.propTypes = {
    noted: PropTypes.shape({
        id: PropTypes.number.isRequired,
        workshopName: PropTypes.string.isRequired,
        tag: PropTypes.shape({ id: PropTypes.number.isRequired, name: PropTypes.string }),
        notes: PropTypes.string,
        sessionDate: PropTypes.string,
    }),
    onDeleteNoteClicked: PropTypes.func,
};

export default NoteTemplate;
