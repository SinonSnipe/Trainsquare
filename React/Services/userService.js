import axios from 'axios';
import { API_HOST_PREFIX } from './serviceHelpers';

const confirmRegisterToken = (token) => {
    const config = {
        method: 'PUT',
        url: `${API_HOST_PREFIX}/api/users/${token}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

const confirmPasswordResetToken = (token, payload) => {
    const config = {
        method: 'PUT',
        url: `${API_HOST_PREFIX}/api/users/resetpassword/${token}`,
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

const forgotPassword = (payload) => {
    const config = {
        method: 'PUT',
        url: `${API_HOST_PREFIX}/api/users/forgotpassword`,
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

const changePassword = (payload) => {
    const adjustPayloadNames = {
        oldPassword: payload.oldPassword,
        password: payload.newPassword,
        passwordConfirm: payload.newPasswordConfirm,
    };

    const config = {
        method: 'PUT',
        url: `${API_HOST_PREFIX}/api/users/changepassword`,
        data: adjustPayloadNames,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

export { confirmRegisterToken, confirmPasswordResetToken, forgotPassword, changePassword };
