import axios from 'axios';
import { API_HOST_PREFIX } from './serviceHelpers';

const endpoint = `${API_HOST_PREFIX}/api/users`

const login = (payload) => {
    const config = {
        method: 'POST',
        url: `${endpoint}/login`,
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

const register = (payload) => {
    const config = {
        method: 'POST',
        url: `${endpoint}/register`,
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

const currentUser = () => {
    const config = {
        method: 'GET',
        url: `${endpoint}/current`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

const logOut = () => {
    const config = {
        method: 'GET',
        url: `${endpoint}/logout`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

export { login, register, currentUser, logOut };
