// @flow
import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { Dropdown } from 'react-bootstrap';
import classNames from 'classnames';
import PropTypes from 'prop-types';

import logger from 'sabio-debug';
const _logger = logger.extend('ProfileDropdown');

const ProfileDropdown = (props) => {
    const profilePic = props.profilePic || null;
    const [dropdownOpen, setDropdownOpen] = useState(false);

    const toggleDropdown = () => {
        setDropdownOpen(!dropdownOpen);
    };

    const inputTheme = props.inputTheme;

    _logger('ProfileDropdown', props.menuItems);

    return (
        <Dropdown show={dropdownOpen} onToggle={toggleDropdown}>
            <Dropdown.Toggle
                variant="link"
                id="dropdown-profile"
                as={Link}
                to="#"
                onClick={toggleDropdown}
                className={classNames(
                    'nav-link',
                    'dropdown-toggle',
                    'nav-user',
                    'arrow-none',
                    'me-0',
                    'bg-' + inputTheme
                )}>
                <span className="account-user-avatar">
                    <img src={profilePic} className="rounded-circle" alt="user" />
                </span>
                <span>
                    <span className="account-user-name">{props.username}</span>
                    <span className="account-position">{props.userTitle}</span>
                </span>
            </Dropdown.Toggle>

            <Dropdown.Menu className="dropdown-menu dropdown-menu-end topbar-dropdown-menu profile-dropdown">
                <div onClick={toggleDropdown}>
                    {props.menuItems.map((item, i) => {
                        return (
                            <Link to={item.redirectTo} className="dropdown-item notify-item" key={i + '-profile-menu'}>
                                <i className={classNames(item.icon, 'me-1')}></i>
                                <span>{item.label}</span>
                            </Link>
                        );
                    })}
                </div>
            </Dropdown.Menu>
        </Dropdown>
    );
};

ProfileDropdown.propTypes = {
    profilePic: PropTypes.string.isRequired,
    username: PropTypes.string.isRequired,
    userTitle: PropTypes.string,
    inputTheme: PropTypes.string.isRequired,
    menuItems: PropTypes.arrayOf(
        PropTypes.shape({
            icon: PropTypes.string.isRequired,
            label: PropTypes.string.isRequired,
            redirectTo: PropTypes.string.isRequired,
        })
    ),
};
export default ProfileDropdown;
