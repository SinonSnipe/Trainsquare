import { Formik, Form, Field, ErrorMessage } from 'formik';
import { React, useState } from 'react';
import debug from 'sabio-debug';
import newsletterTemplatesSchema from '../../schema/newsletterTemplatesSchema';
import PropTypes from 'prop-types';
import * as newsletterTemplatesService from '../../services/newsletterTemplatesService';
import { Card, Col, Row } from 'react-bootstrap';
import toastr from '../../utils/toastr';
import Dropzone from '../files/Dropzone';

const EditNewsletterTemplate = ({ formData, newsletterTemplateId }) => {
    const _logger = debug.extend('template form');
    _logger('Edit Template', formData, newsletterTemplateId);

    const [form] = useState(formData);

    const handleSubmit = (formData) => {
        _logger('HANDLE SUBMIT', formData);
        toastr.success('Congrats You Successfully Edited Your Newsletter Template');
        newsletterTemplatesService.update(formData, newsletterTemplateId).then(onUpdateSuccess).catch(onUpdateError);
    };

    const onUpdateSuccess = (aNewsletterTemplate) => {
        toastr.success('Congrats You Successfully Edited Your Newsletter Template');
        _logger('Edit Newsletter Template Success', aNewsletterTemplate);
        window.location.reload();
    };

    const onUpdateError = (error) => {
        toastr.error('Edit Newsletter Template Failed - Please Try Again!');
        _logger('Edit Failed', error);
    };
    return (
        <>
            <Formik
                enableReinitialize={true}
                initialValues={form}
                onSubmit={handleSubmit}
                validationSchema={newsletterTemplatesSchema}>
                {({ values, setFieldValue }) => (
                    <Row>
                        <Col lg={6}>
                            <Form>
                                <div className="form-group">
                                    <label htmlFor="name">Name</label>
                                    <Field type="text" name="name" className="form-control" />
                                    <ErrorMessage
                                        name="name"
                                        component="div"
                                        className="newsletter-template-inputField"
                                    />
                                </div>
                                <div className="form-group mb-2">
                                    <label htmlFor="description">Description</label>
                                    <Field type="text" name="description" className="form-control" />
                                    <ErrorMessage
                                        name="description"
                                        component="div"
                                        className="newsletter-template-inputField"
                                    />
                                </div>
                                <div className="form-group mb-2">
                                    <label htmlFor="primaryImage">Upload Template Image</label>
                                    <Dropzone
                                        uploadedFiles={(fileData) => {
                                            setFieldValue('primaryImage', fileData[0].url);
                                        }}
                                    />
                                    <ErrorMessage
                                        name="primaryImage"
                                        component="div"
                                        className="newsletter-template-inputField"
                                    />
                                </div>

                                <div className="col-md-6 p-1 float-center">
                                    <button type="submit" className="btn btn-primary">
                                        Submit
                                    </button>
                                </div>
                            </Form>
                        </Col>

                        <Col lg={6}>
                            <Card className="p-2 mb-2">
                                <img
                                    alt="PrimaryImage"
                                    className="card-img-top img-fluid"
                                    style={{ width: '100%', height: '35vw', ObjectFit: 'cover' }}
                                    src={values?.primaryImage || 'https://bit.ly/3PhEzIz'}
                                />
                                <Card.Header as="h4">{values?.name}</Card.Header>
                                <Card.Body>
                                    <Card.Text>{values?.description}</Card.Text>
                                </Card.Body>
                            </Card>
                        </Col>
                    </Row>
                )}
            </Formik>
        </>
    );
};
EditNewsletterTemplate.propTypes = {
    oneNewsletterTemplate: PropTypes.shape({
        id: PropTypes.number.isRequired,
        primaryImage: PropTypes.string.isRequired,
        name: PropTypes.string.isRequired,
        description: PropTypes.string.isRequired,
    }),
    formData: PropTypes.shape({}).isRequired,
    newsletterTemplateId: PropTypes.number.isRequired,
};

export default EditNewsletterTemplate;
