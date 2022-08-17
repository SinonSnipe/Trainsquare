import { useContext, useEffect } from 'react';
import * as auth from '../../services/authService';
import { useNavigate } from 'react-router-dom';
import { LoginContext } from '../../constants/loginContext';
import toastr from 'toastr';

import logger from 'sabio-debug';
const _logger = logger.extend('Logout');

export const Logout = () => {
    const navigate = useNavigate();
    const { setCurrentUser } = useContext(LoginContext);

    const onSuccessfulLogout = (response) => {
        _logger('Logout success', response);
        setCurrentUser((prevState) => {
            return {
                ...prevState,
                id: 0,
                email: '',
                roles: [],
                isLoggedIn: false,
            };
        });
    };

    const onUnsuccessfulLogout = (err) => {
        _logger('Logout error', err);
        toastr.error('Logout Error. Please try again or contact site administrator.', 'Error');
    };

    const navigateToLanding = () => {
        navigate('/');
    };

    useEffect(() => {
        auth.logOut().then(onSuccessfulLogout).then(navigateToLanding).catch(onUnsuccessfulLogout);
    }, []);

    return null;
};
