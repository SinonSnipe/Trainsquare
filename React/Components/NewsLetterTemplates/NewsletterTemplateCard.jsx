import { React, useState } from 'react';
import PropTypes from 'prop-types';
import { Card, Col, Modal, ModalBody, ModalTitle, Row, Button } from 'react-bootstrap';
import debug from 'sabio-debug';
import EditNewsletterTemplate from './EditNewsletterTemplate';
const _logger = debug.extend('NewsletterTemplateCard');

const NewsletterTemplateCard = (props) => {
    const aNewsletterTemplate = props.oneNewsletterTemplate;
    const onNewsLetterTemplateClicked = props.onNewsLetterTemplateClicked;
    const onEditClicked = props.onEditClicked;
    const [modal, setModal] = useState(false);

    const openModalForDeleteConfirm = () => {
        toggle();
    };

    const toggle = () => {
        setModal(!modal);
    };
    _logger('props', props);
    const onLocalNewsTempDeleteClicked = (e) => {
        e.preventDefault();
        _logger('delete clicked');
        onNewsLetterTemplateClicked(props.oneNewsletterTemplate, e);
    };
    const onLocalEditClicked = (e) => {
        onEditClicked(props.oneNewsletterTemplate, e);
        _logger('edit clicked');
    };

    const [show, setShow] = useState(false);

    return (
        <>
            <div className="col-md-4 p-1">
                <div className="card-deck">
                    <div className="card p-3 mb-1">
                        <img
                            alt="PrimaryImage"
                            className="card-img-top img-fluid"
                            style={{ display: 'flex', ObjectFit: 'cover' }}
                            src={aNewsletterTemplate?.primaryImage || 'https://bit.ly/3PhEzIz'}
                        />

                        <Card.Header as="h4">{aNewsletterTemplate?.name}</Card.Header>
                        <Card.Body>
                            <Card.Text>{aNewsletterTemplate?.description}</Card.Text>
                            <Row>
                                <Col align="center">
                                    <Button className="btn-icon btn-secondary" onClick={openModalForDeleteConfirm}>
                                        <i className="mdi mdi-delete ms-1 me-1"></i>
                                    </Button>

                                    <Modal show={modal} onHide={toggle} closeButton>
                                        <Modal.Body>
                                            <h4 className="mt-0" align="center">
                                                {' '}
                                                Please Confirm You Want To Delete This Template.
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
                                                onClick={onLocalNewsTempDeleteClicked}>
                                                <i className="mdi mdi-delete"></i>
                                                Delete
                                            </button>
                                        </Modal.Footer>
                                    </Modal>
                                </Col>

                                <Col align="center">
                                    <Button
                                        className="btn-icon btn-secondary"
                                        data-id={aNewsletterTemplate.id}
                                        onClick={() => {
                                            setShow(true);
                                            onLocalEditClicked();
                                        }}>
                                        <i className="mdi mdi-pencil ms-1 me-1"></i>
                                    </Button>
                                </Col>

                                <Modal size="xl" show={show} onHide={() => setShow(false)}>
                                    <Modal.Header closeButton>
                                        <ModalTitle>Edit Newsletter Template</ModalTitle>
                                    </Modal.Header>
                                    <ModalBody>
                                        <EditNewsletterTemplate
                                            formData={props.oneNewsletterTemplate}
                                            newsletterTemplateId={
                                                props.oneNewsletterTemplate.id
                                            }></EditNewsletterTemplate>
                                    </ModalBody>
                                </Modal>
                            </Row>
                        </Card.Body>
                        <div className="card-footer"></div>
                    </div>
                </div>
            </div>
        </>
    );
};

NewsletterTemplateCard.propTypes = {
    oneNewsletterTemplate: PropTypes.shape({
        id: PropTypes.number.isRequired,
        primaryImage: PropTypes.string.isRequired,
        name: PropTypes.string.isRequired,
        description: PropTypes.string.isRequired,
    }),
    onNewsLetterTemplateClicked: PropTypes.func.isRequired,
    onEditClicked: PropTypes.func.isRequired,
};

export default NewsletterTemplateCard;
