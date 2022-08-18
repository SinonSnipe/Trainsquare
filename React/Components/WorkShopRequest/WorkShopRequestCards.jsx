import { Card, Dropdown } from 'react-bootstrap';
import Toast from 'react-bootstrap/Toast';
import ToastContainer from 'react-bootstrap/ToastContainer';
import './css/news.css';
import debug from 'sabio-debug';
import React, { useState } from 'react';
import PropTypes from 'prop-types';

const _loggerBasic = debug.extend('WorkShopRequestCards');

const FormTemplate = (props) => {
    _loggerBasic('aRequest props', props.isCurrent);
    const [showToast, setShowToast] = useState(false);
    const toggleShowToast = () => setShowToast(!showToast);
    const aRequest = props.request;
    const onLocalDeleteClicked = () => {
        props.onDeleteClicked(aRequest.instructorId);
    };

    return (
        <React.Fragment>
            <Card className="d-block lesson-card">
                <Card.Body>
                    <td className="px-4">
                        <h5 className="font-14 my-1">
                            <span>Request #</span>
                        </h5>
                        <h5 className="font-14 mt-1 fw-normal">{aRequest.instructorId}</h5>
                    </td>
                    <td className="px-4">
                        <h5 className="font-14 my-1">
                            <span>Status</span>
                        </h5>
                        <span className="badge badge-warning-lighten">Pending</span>
                    </td>
                    <p></p>
                    <td className="px-4">
                        <h5 className="font-14 my-1">
                            <span>Name</span>
                        </h5>
                        <h5 className="font-14 mt-1 fw-normal">{aRequest.name}</h5>
                    </td>
                    <p></p>
                    <td className="px-4">
                        <h5 className="font-14 my-1">
                            <span>Email</span>
                        </h5>
                        <h5 className="font-14 mt-1 fw-normal">{aRequest.email}</h5>
                    </td>
                    <p></p>
                    <td className="px-4">
                        <label>Topic</label>
                        <h5 className="font-14 mt-1 fw-normal">{aRequest.topic}</h5>
                    </td>
                    <p></p>
                    <td className="px-4">
                        <h5 className="font-14 my-1">
                            <span>Short Description</span>
                        </h5>
                        <h5 className="font-14 mt-1 fw-normal">{aRequest.shortDescription}</h5>
                    </td>
                    <p></p>

                    <Dropdown.Item onClick={toggleShowToast}>
                        <i className="bi bi-trash3-fill"></i>Delete
                    </Dropdown.Item>
                </Card.Body>

                <ToastContainer position="middle-end">
                    <Toast show={showToast} className="toast-display">
                        <Toast.Body>
                            <i className="bi bi-exclamation-triangle-fill"></i>
                            <h6 className="toast-h">
                                Are you sure you want to delete this Request? <br /> You will not be able to recover it
                                later.
                            </h6>
                            <button className="btn btn-yes" onClick={onLocalDeleteClicked}>
                                <p className="btn-p">Delete Request.</p>
                            </button>
                            <button className="btn btn-no" onClick={toggleShowToast}>
                                <p className="btn-p">No, keep it.</p>
                            </button>
                        </Toast.Body>
                    </Toast>
                </ToastContainer>
            </Card>
        </React.Fragment>
    );
};

FormTemplate.propTypes = {
    request: PropTypes.shape({
        instructorId: PropTypes.number,
        name: PropTypes.string,
        email: PropTypes.string,
        topic: PropTypes.string,
        shortDescription: PropTypes.string,
        status: PropTypes.shape({
            instructorId: PropTypes.number,
        }),
    }),
    isCurrent: PropTypes.bool,
    delBtn: PropTypes.func,
    onDeleteClicked: PropTypes.func,
};

export default React.memo(FormTemplate);

// import { Card, Table } from 'react-bootstrap';
// import debug from 'sabio-debug';
// import React, { useEffect, useState } from 'react';
// import { useParams, Link } from 'react-router-dom';
// import PropTypes from 'prop-types';

// const _loggerBasic = debug.extend('WorkShopRequestCards');

// const FormTemplate = (props) => {
//     const buttonTwo = {
//         padding: '10px 20px',
//         border: 'none',
//         borderRadius: '4px',
//         background: '#800',
//         color: '#fff',
//         fontSize: '14px',
//         cursor: 'pointer',
//         transition: '.3s background',
//         '&:hover': {
//             background: '#40a9ff',
//         },
//     };

//     const { instructorId } = useParams();
//     const aRequest = props.request;
//     const [currentId, setId] = useState(instructorId);
//     _loggerBasic([currentId, setId]);

//     useEffect(() => {
//         setId(instructorId);
//         _loggerBasic(setId);
//     }, [instructorId]);

//     const onDelClick = (eObj) => {
//         props.delBtn(aRequest.instructorId, eObj);
//     };

//     return (
//         <Card className="d-block card">
//             <Card.Body>
//                 <div className="workshoptable">
//                     <Table responsive hover className="table-centered table-nowrap mb-0">
//                         <tbody>
//                             <tr>
//                                 <td>
//                                     <h5 className="font-14 my-1">
//                                         <Link to="#" className="text-body">
//                                             FullName
//                                         </Link>
//                                     </h5>
//                                     <span className="text-muted font-13">{aRequest.name}</span>
//                                 </td>

//                                 <td>
//                                     <span className="text-muted font-13">Email</span>
//                                     <h5 className="font-14 mt-1 fw-normal">{aRequest.email}</h5>
//                                 </td>
//                                 <td>
//                                     <span className="text-muted font-13">Topic</span>
//                                     <h5 className="font-14 mt-1 fw-normal">{aRequest.topic}</h5>
//                                 </td>
//                                 <td>
//                                     <span className="text-muted font-13">Brief Description</span>
//                                     <h5 className="font-14 mt-1 fw-normal">{aRequest.briefDescription}</h5>
//                                 </td>

//                                 <td>
//                                     <span className="text-muted font-13">Status</span> <br />
//                                     <span className="badge badge-warning-lighten">Pending</span> <br />
//                                 </td>
//                             </tr>
//                         </tbody>
//                     </Table>

//                     <div className="card-body">
//                         <div className="row">
//                             <button onClick={onDelClick} className="btn btn-danger" style={buttonTwo}>
//                                 Delete
//                             </button>
//                         </div>
//                     </div>
//                 </div>
//             </Card.Body>
//         </Card>
//     );
// };

// FormTemplate.propTypes = {
//     request: PropTypes.shape({
//         instructorId: PropTypes.number,
//         name: PropTypes.string,
//         email: PropTypes.string,
//         topic: PropTypes.string,
//         briefDescription: PropTypes.string,
//         status: PropTypes.shape({
//             instructorId: PropTypes.number,
//         }),
//     }),

//     delBtn: PropTypes.func,
// };

// export default React.memo(FormTemplate);
