import React, { useState } from 'react';
import { Modal } from 'react-bootstrap';
import debug from 'sabio-debug';
import PropTypes from 'prop-types';
import moment from 'moment';

const _logger = debug.extend('ViewButton');

function ViewButton({ viewData }) {
    const [scroll, setScroll] = useState(null);
    const [size, setSize] = useState(null);
    const [className, setClassName] = useState(null);
    const [modal, setModal] = useState(false);

    const [viewInfo] = useState({
        workshopName: viewData.workshopName,
        tagsTypeId: viewData.tag.name,
        notes: viewData.notes,
        sessionDate: viewData.sessionDate,
    });

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
    _logger({ viewData });

    return (
        <React.Fragment>
            <button className="btn btn-link" onClick={openModalWithScroll}>
                View Note
            </button>
            <Modal show={modal} onHide={toggle} dialogClassName={className} size={size} scrollable={scroll}>
                <Modal.Header onHide={toggle} closeButton>
                    <h4 className="modal-title">Note</h4>
                </Modal.Header>
                <Modal.Body>
                    <div className="form-group mb-3 my-2 mx-2">
                        <label htmlFor="workShop">Name of Workshop</label>
                        <p>{viewInfo.workshopName}</p>
                    </div>

                    <div className="form-group mb-3  my-2 mx-2">
                        <label htmlFor="tagsTypeId">Workshop Tag </label>
                        <p>{viewInfo.tagsTypeId}</p>
                    </div>
                    <div className="form-group mb-3  my-2 mx-2">
                        <div>
                            <label htmlFor="notes">Notes</label>
                            <p>{viewInfo.notes}</p>
                        </div>
                    </div>

                    <div className="form-group mb-3 my-2 mx-2">
                        <label htmlFor="dateModified">Date of Session</label>
                        <p>{moment(viewInfo.sessionDate).format('MMM Do YYYY')}</p>
                    </div>
                </Modal.Body>
                <Modal.Footer>
                    <div className="d-grip gap-2 d-md-flex justify-content-md-end"></div>
                    <button className="btn btn-secondary mb-2 back rounded-pill shadow" onClick={toggle}>
                        Close
                    </button>
                </Modal.Footer>
            </Modal>
        </React.Fragment>
    );
}

ViewButton.propTypes = {
    viewData: PropTypes.shape({
        id: PropTypes.number,
        notes: PropTypes.string,
        tag: PropTypes.shape({ id: PropTypes.number, name: PropTypes.string }),
        workshopName: PropTypes.string,
        sessionDate: PropTypes.string,
    }),
};

export default ViewButton;
