import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
import { Card } from 'react-bootstrap';
import classnames from 'classnames';
import SimpleBar from 'simplebar-react';
import debug from 'sabio-debug';
import avatar11 from '../../assets/images/users/avatar-11.jpg';

const _logger = debug.extend('ChatUsers');

const ChatUsers = (props) => {
    const [user, setUser] = useState([...props.users]);
    const [selectedUser, setSelectedUser] = useState({});

    useEffect(() => {
        _logger('useEffect firing');
        setUser(props.users);
    }, [props.users, setUser]);

    /**
     * Search the user
     * @param {*} text
     */
    const search = (text) => {
        setUser(
            text
                ? [...props.users].filter((u) => u.firstName?.toLowerCase().indexOf(text?.toLowerCase()) >= 0)
                : [...props.users]
        );
    };

    /**
     * Activates the user
     * @param {*} user
     */
    const activateUser = (user) => {
        setSelectedUser(user);
        if (props.onUserSelect) {
            props.onUserSelect(user);
        }
    };

    return (
        <>
            <Card>
                <Card.Body className="p-0">
                    <div className="tab-content">
                        <div className="tab-pane show active">
                            <div className="app-search p-3">
                                <div className="form-group position-relative">
                                    <input
                                        type="text"
                                        className="form-control"
                                        placeholder="People, groups, messages..."
                                        onKeyUp={(e) => search(e.target.value)}
                                    />
                                    <span className="mdi mdi-magnify search-icon"></span>
                                </div>
                            </div>
                            <SimpleBar className="px-3" style={{ maxHeight: '550px', width: '100%' }}>
                                {user.map((user, index) => {
                                    return (
                                        <Link
                                            to="#"
                                            key={index}
                                            className="text-body"
                                            onClick={() => {
                                                activateUser(user);
                                            }}>
                                            <div
                                                className={classnames('d-flex align-items-start mt-1 p-2', {
                                                    'bg-light': user.id === selectedUser.id,
                                                })}>
                                                <img
                                                    src={user.avatar ? user.avatar : avatar11}
                                                    className="me-2 rounded-circle"
                                                    height="48"
                                                    alt=""
                                                />

                                                <div className="w-100 overflow-hidden">
                                                    <h5 className="mt-0 mb-0 font-14">
                                                        <span className="float-end text-muted font-12">
                                                            {user.lastMessageOn}
                                                        </span>
                                                        {user.firstName}
                                                    </h5>
                                                    <p className="mt-1 mb-0 text-muted font-14">
                                                        <span className="w-75">{user.lastMessage}</span>
                                                    </p>
                                                </div>
                                            </div>
                                        </Link>
                                    );
                                })}
                            </SimpleBar>
                        </div>
                    </div>
                </Card.Body>
            </Card>
        </>
    );
};

ChatUsers.propTypes = {
    users: PropTypes.arrayOf(
        PropTypes.shape({
            id: PropTypes.number.isRequired,
            firstName: PropTypes.string,
            lastName: PropTypes.string,
            avatarUrl: PropTypes.string,
            email: PropTypes.string,
            lastMessage: PropTypes.string.isRequired,
            lastMessageOn: PropTypes.string.isRequired,
        })
    ),
    onUserSelect: PropTypes.func,
};

export default ChatUsers;
