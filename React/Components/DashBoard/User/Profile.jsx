import React, { useState, useEffect } from 'react';
import { Card, Button, Modal } from 'react-bootstrap';
import { Formik, Form, Field, ErrorMessage } from 'formik';
import propTypes from 'prop-types';
import debug from 'sabio-debug';
import userProfileSchema from '../../../../schema/userDashBoardSchema';
import * as userDashBoardService from '../../../../services/userDashBoardServices';
import toastr from '../../../../utils/toastr';
import * as externalLinksService from '../../../../services/externalLinksService.js';
import { Link } from 'react-router-dom';

const _logger = debug.extend('Profile'); //sabio:Profile

const Profile = (props) => {
    const { currentUser } = props;
    // _logger(currentUser.id);
    const [userProfile, setUserProfile] = useState({
        firstName: '',
        middleName: '',
        lastName: '',
        avatarUrl: '',
    });
    const [editUserProfile, setEditUserProfile] = useState({
        id: currentUser.id,
        data: {
            editFirstName: '',
            editLastName: '',
            editMiddleName: '',
            editAvatarUrl: '',
        },
    });
    const [editModalProfile, setModalEditProfile] = useState(false);
    const [addModalFriend, setAddModalFriend] = useState(false);

    const [currentUserUrls, setCurrentUserUrls] = useState([]);

    const handleEditProfileClose = () => {
        setModalEditProfile(false);
    };
    const handleEditProfileShow = () => {
        setEditUserProfile({
            id: currentUser.id,
            data: {
                editFirstName: userProfile.firstName,
                editLastName: userProfile.lastName,
                editMiddleName: userProfile.middleName,
                editAvatarUrl: userProfile.avatarUrl,
            },
        });
        setModalEditProfile(true);
    };

    const handleAddFriendClose = () => {
        setAddModalFriend(false);
    };
    const handleAddFriendShow = () => {
        setAddModalFriend(true);
    };

    useEffect(() => {
        getUserProfile();
        getUserUrls();
    }, [currentUser]);

    const getUserProfile = () => {
        _logger('getUserProfile', currentUser);
        if (currentUser) {
            userDashBoardService
                .getUserProfile(currentUser.id)
                .then(onGetUserProfileSuccess)
                .catch(onGetUserProfileError);
        }
    };

    const onGetUserProfileSuccess = (response) => {
        _logger('onGetUserProfileSuccess', response);
        const { firstName, middleName, lastName, avatarUrl } = response.data.item;

        setUserProfile({ firstName, middleName, lastName, avatarUrl });
    };
    const onGetUserProfileError = () => {};

    const onFormChange = (e) => {
        const { name, value } = e.target;
        setEditUserProfile((prevState) => {
            const newUserObj = { ...prevState };
            newUserObj.data[name] = value;
            return newUserObj;
        });
    };

    const getUserUrls = () => {
        if (currentUser.id) {
            externalLinksService
                .PaginateCreatedBy(0, 12, currentUser.id)
                .then(onPaginateByUserSuccess)
                .catch(onPaginateByUserError);
        }
    };
    const onPaginateByUserSuccess = (response) => {
        const receivedArray = response.data.item.pagedItems;
        setCurrentUserUrls((prevState) => {
            let newUrlsList = {
                ...prevState,
            };
            newUrlsList = receivedArray;
            return newUrlsList;
        });
    };
    const onPaginateByUserError = (error) => {
        _logger(error, 'just had: onPaginateByUserError');
        const errorData = error.data;
        toastr.error(`Retrieval Request Error: ${errorData}`);
    };

    const onUpdateClicked = (e) => {
        e.preventDefault();
        userDashBoardService
            .updateUserProfile({
                id: currentUser.id,
                data: {
                    firstName: editUserProfile.data.editFirstName,
                    lastName: editUserProfile.data.editLastName,
                    middleName: editUserProfile.data.editMiddleName,
                    avatarUrl: editUserProfile.data.editAvatarUrl,
                },
            })
            .then(onUpdateUserProfileSuccess)
            .catch(onUpdateUserProfileError);
    };

    const onUpdateUserProfileSuccess = () => {
        setModalEditProfile(false);
        getUserProfile();
        toastr.success('Your Profile has been updated');
    };
    const onUpdateUserProfileError = () => {
        toastr.error('Oops something is wrong');
    };

    _logger(userProfile);

    const UserLinksMapper = (anExternalLink) => {
        return (
            <p className="mt-3 mb-1" key={'ListA' + anExternalLink.id}>
                <strong>
                    <a href={anExternalLink.url} target="_blank" rel="noreferrer noopener">
                        {anExternalLink.url}
                    </a>
                </strong>
            </p>
        );
    };

    return (
        <>
            <Card>
                <Card.Body>
                    <div className="mt-3 mb-4 text-center">
                        <img src={userProfile.avatarUrl} alt="" className="img-thumbnail avatar-xl rounded-circle" />
                        <h4>{currentUser.email}</h4>
                        <Button onClick={handleEditProfileShow} className="btn-sm mt-1" variant="primary">
                            Edit Profile
                        </Button>
                        <Button onClick={handleAddFriendShow} className="btn-sm mt-1" variant="success">
                            Invite
                        </Button>
                    </div>

                    <div className="mt-3 text-center">
                        <p className="mt-3 mb-1 font-11 fw-bold">
                            <span className="font-13 fw-normal">{currentUser.email}</span>
                        </p>

                        <p className="mt-3 mb-1 font-11 fw-bold">
                            <span className="font-13 fw-normal">
                                {userProfile.firstName} {userProfile.middleName} {userProfile.lastName}
                            </span>
                        </p>
                        <br></br>
                        <p className="mt-3 mb-1">{currentUserUrls.map(UserLinksMapper)}</p>
                        <br></br>
                        <div className="text-center">
                            <button type="submit" href="#" className="btn btn-info btn-sm">
                                <Link to="/externallinks/externallinksmain" className="text-light">
                                    Edit Links
                                </Link>
                            </button>
                        </div>
                    </div>
                </Card.Body>
            </Card>
            <Modal
                show={editModalProfile}
                onHide={handleEditProfileClose}
                aria-labelledby="contained-modal-title-vcenter"
                centered>
                <Modal.Header closeButton>
                    <Modal.Title>Edit Profile</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <Formik
                        enableReinitialize={true}
                        initialValues={editUserProfile}
                        validationSchema={userProfileSchema}>
                        <Form>
                            <div className="form-group">
                                <label htmlFor="editFirstName">First Name</label>
                                <Field
                                    className="form-control mb-3"
                                    type="text"
                                    name="editFirstName"
                                    value={editUserProfile.data.editFirstName}
                                    onChange={onFormChange}></Field>
                                <ErrorMessage name="content" component="div" className="has-error" />
                            </div>
                            <div className="form-group">
                                <label htmlFor="editLastName">Last Name</label>
                                <Field
                                    className="form-control mb-3"
                                    type="text"
                                    name="editLastName"
                                    value={editUserProfile.data.editLastName}
                                    onChange={onFormChange}></Field>
                                <ErrorMessage name="content" component="div" className="has-error" />
                            </div>
                            <div className="form-group">
                                <label htmlFor="editMiddleName">Middle Name</label>
                                <Field
                                    className="form-control mb-3"
                                    type="text"
                                    name="editMiddleName"
                                    value={editUserProfile.data.editMiddleName}
                                    onChange={onFormChange}></Field>
                                <ErrorMessage name="content" component="div" className="has-error" />
                            </div>
                            <div className="form-group">
                                <label htmlFor="editAvatarUrl">Avatar Url</label>
                                <Field
                                    className="form-control mb-3"
                                    type="text"
                                    name="editAvatarUrl"
                                    value={editUserProfile.data.editAvatarUrl}
                                    onChange={onFormChange}></Field>
                                <ErrorMessage name="content" component="div" className="has-error" />
                            </div>
                        </Form>
                    </Formik>
                </Modal.Body>
                <Modal.Footer>
                    <Button variant="secondary" onClick={handleEditProfileClose}>
                        Close
                    </Button>
                    <Button variant="primary" onClick={onUpdateClicked}>
                        Update
                    </Button>
                </Modal.Footer>
            </Modal>

            <Modal
                show={addModalFriend}
                onHide={handleAddFriendClose}
                aria-labelledby="contained-modal-title-vcenter"
                centered>
                <Modal.Header closeButton>
                    <Modal.Title>Add Friend</Modal.Title>
                </Modal.Header>
                <Modal.Body></Modal.Body>
                <Modal.Footer>
                    <Button variant="secondary" onClick={handleAddFriendClose}>
                        Close
                    </Button>
                    <Button variant="primary" onClick={handleAddFriendClose}>
                        Invite
                    </Button>
                </Modal.Footer>
            </Modal>
        </>
    );
};

Profile.propTypes = {
    currentUser: propTypes.shape({
        email: propTypes.string.isRequired,
        profilePic: propTypes.string.isRequired,
        id: propTypes.number.isRequired,
    }),
};

export default Profile;
