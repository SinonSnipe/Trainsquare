import { React, useState } from 'react';
import PropTypes from 'prop-types';
import { Card, Row, Col, Button, Modal } from 'react-bootstrap';
import debug from 'sabio-debug';
const _logger = debug.extend('NewsletterCard');

const NewslettersCard = (props) => {
    const aNewsletter = props.oneNewsletter;
    let datePublishedConvert = new Date(aNewsletter.dateToPublish).toDateString();
    let dateExpiredConvert = new Date(aNewsletter.dateToExpire).toDateString();
    const onNewsLetterClicked = props.onNewsLetterClicked;

    const [modal, setModal] = useState(false);

    const openModalForDeleteConfirm = () => {
        toggle();
    };

    const toggle = () => {
        setModal(!modal);
    };

    _logger('props', props);
    const onLocalNewsDeleteClicked = (evt) => {
        evt.preventDefault();
        _logger('delete clicked');
        onNewsLetterClicked(props.oneNewsletter, evt);
    };

    return (
        <>
            <div className="col-md-6 p-1 ">
                <div className="card p-3 mb-1">
                    <Card.Header as="h4" align="center">
                        {aNewsletter?.name}
                    </Card.Header>

                    <Card.Body>
                        <img
                            alt="coverPhoto"
                            className="card-img-top img-fluid"
                            style={{ width: '100%', height: '25vw', ObjectFit: 'cover' }}
                            src={aNewsletter?.coverPhoto || 'https://bit.ly/3w5XLBs'}
                        />
                        <Card.Footer>
                            <Row>
                                <Col align="center">
                                    <p>Publish Date: {datePublishedConvert}</p>
                                    <p>Expire Date: {dateExpiredConvert}</p>
                                </Col>
                            </Row>
                            <Row></Row>
                        </Card.Footer>
                        <Row>
                            <Col align="center">
                                <Button className="btn-icon btn-secondary" onClick={openModalForDeleteConfirm}>
                                    <i className="mdi mdi-delete ms-1 me-1"></i>
                                </Button>

                                <Modal show={modal} onHide={toggle} closeButton>
                                    <Modal.Body>
                                        <h4 className="mt-0" align="center">
                                            {' '}
                                            Please Confirm You Want To Delete This Newsletter.
                                        </h4>
                                    </Modal.Body>
                                    <Modal.Footer
                                        style={{ display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
                                        <button
                                            className="btn btn-secondary mb-2 back rounded-pill shadow"
                                            onClick={toggle}>
                                            Cancel
                                        </button>{' '}
                                        <button
                                            className="btn btn-danger mb-2 back rounded-pill shadow"
                                            onClick={onLocalNewsDeleteClicked}>
                                            <i className="mdi mdi-delete"></i>
                                            Delete
                                        </button>
                                    </Modal.Footer>
                                </Modal>
                            </Col>
                        </Row>
                    </Card.Body>
                </div>
            </div>
        </>
    );
};

NewslettersCard.propTypes = {
    oneNewsletter: PropTypes.shape({
        id: PropTypes.number.isRequired,
        templateId: PropTypes.number.isRequired,
        name: PropTypes.string.isRequired,
        coverPhoto: PropTypes.string,
        dateToPublish: PropTypes.string,
        dateToExpire: PropTypes.string,
    }),

    onNewsLetterClicked: PropTypes.func.isRequired,
};

export default NewslettersCard;
