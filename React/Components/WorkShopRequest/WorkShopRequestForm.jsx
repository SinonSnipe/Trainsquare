import React, { useState } from 'react';
import toastr from 'toastr';
import * as workshoprequestService from '../../services/workshoprequestService';
import debug from 'sabio-debug';
import workShopRequestSchema from '../../schema/workShopRequestSchema';
import { Formik, Form, Field, ErrorMessage } from 'formik';
import { Card } from 'react-bootstrap';
const _logger = debug.extend('WorkShopRequestForm');
const Workshoprequestform = () => {
    const [requestFormData] = useState({
        user: {
            name: '',
            email: '',
            topic: '',
            shortDescription: '',
        },
    });

    const handleSubmit = (values) => {
        _logger('Request Form Data', values);
        workshoprequestService.create(values).then(onAddSuccess).catch(onAddFail);
    };
    const onAddSuccess = (response) => {
        _logger(response);
        toastr.info('Successfully Submitted Your Request', response);
    };
    const onAddFail = (response) => {
        _logger(response, 'FAIL');
        toastr.error('FAIL', response);
    };
    return (
        <React.Fragment>
            <div className="container formContainer center">
                <Card className="mx-5 ">
                    <Card.Header className="header">
                        <h2 className="header-font text-center">Trainsquare</h2>
                    </Card.Header>
                    <Card.Body>
                        <div className="text-center w-75 m-auto">
                            <h4 className="text-dark-50 text-center mt-0 fw-bold">WorkShop Request Form</h4>
                            <p className="text-muted mb-4">Fill out the following to submit your request:</p>
                        </div>
                        <Formik
                            enableReinitialize={true}
                            initialValues={requestFormData.user}
                            onSubmit={handleSubmit}
                            validationSchema={workShopRequestSchema}>
                            <Form>
                                <div className="form-group form-new">
                                    <label htmlFor="name">Name</label>
                                    <Field type="text" name="name" className="form-control" />
                                    <ErrorMessage name="name" component="div" className="has-error" />
                                </div>
                                <div className="form-group form-new">
                                    <label htmlFor="email">Email</label>
                                    <Field type="text" name="email" className="form-control" />
                                    <ErrorMessage name="email" component="div" />
                                </div>
                                <div className="form-group form-new">
                                    <label htmlFor="topic">Topic</label>
                                    <Field type="text" name="topic" className="form-control" />
                                    <ErrorMessage name="topic" component="div" />
                                </div>
                                <div className="form-group form-new">
                                    <label htmlFor="shortDescription">Short Description</label>
                                    <Field component="textarea" name="shortDescription" className="form-control" />
                                    <ErrorMessage name="shortDescription" component="div" />
                                </div>
                                <p></p>
                                <button type="submit" className="btn btn-primary">
                                    Submit
                                </button>
                            </Form>
                        </Formik>
                    </Card.Body>
                </Card>
            </div>
        </React.Fragment>
    );
};

export default Workshoprequestform;

// import React, { useState } from 'react';
// import toastr from 'toastr';
// import * as workshoprequestService from '../../services/workshoprequestService';
// import debug from 'sabio-debug';
// import workShopRequestSchema from '../../schema/workShopRequestSchema';
// import { Formik, Form, Field, ErrorMessage } from 'formik';

// import { Card } from 'react-bootstrap';
// const _logger = debug.extend('WorkShopRequestForm');

// const Workshoprequestform = () => {
//     const [requestFormData] = useState({
//         user: {
//             name: '',
//             email: '',
//             topic: '',
//             briefDescription: '',
//         },
//     });

//     const handleSubmit = (values) => {
//         _logger('Request Form Data', values);
//         workshoprequestService.create(values).then(onAddSuccess).catch(onAddFail);
//     };

//     const onAddSuccess = (response) => {
//         _logger(response);
//         toastr.info('Successfully Submitted Your Request', response);
//     };

//     const onAddFail = (response) => {
//         _logger(response, 'FAIL');
//         toastr.error('FAIL', response);
//     };

//     return (
//         <React.Fragment>
//             <div className="container formContainer center">
//                 <Card className="mx-5 ">
//                     <Card.Header className="header">
//                         <h2 className="header-font text-center">Trainsquare</h2>
//                     </Card.Header>
//                     <Card.Body>
//                         <div className="text-center w-75 m-auto">
//                             <h4 className="text-dark-50 text-center mt-0 fw-bold">WorkShop Request Form</h4>
//                             <p className="text-muted mb-4">Fill out the following to submit your request:</p>
//                         </div>

//                         <Formik
//                             enableReinitialize={true}
//                             initialValues={requestFormData.user}
//                             onSubmit={handleSubmit}
//                             validationSchema={workShopRequestSchema}>
//                             <Form>
//                                 <div className="form-group form-new">
//                                     <label htmlFor="name">FullName</label>
//                                     <Field type="text" name="name" className="form-control" />
//                                     <ErrorMessage name="name" component="div" />
//                                 </div>
//                                 <div className="form-group form-new">
//                                     <label htmlFor="email">Email</label>
//                                     <Field type="text" name="email" className="form-control" />
//                                     <ErrorMessage name="email" component="div" />
//                                 </div>
//                                 <div className="form-group form-new">
//                                     <label htmlFor="topic">Topic</label>
//                                     <Field type="text" name="topic" className="form-control" />
//                                     <ErrorMessage name="topic" component="div" />
//                                 </div>
//                                 <div className="form-group form-new">
//                                     <label htmlFor="briefDescription">Brief Description</label>
//                                     <Field component="textarea" name="briefDescription" className="form-control" />
//                                     <ErrorMessage name="briefDescription" component="div" />
//                                 </div>
//                                 <p></p>
//                                 <button type="submit" className="btn btn-primary">
//                                     Submit
//                                 </button>
//                             </Form>
//                         </Formik>
//                     </Card.Body>
//                 </Card>
//             </div>
//         </React.Fragment>
//     );
// };

// export default Workshoprequestform;
