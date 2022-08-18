import axios from 'axios';
import { API_HOST_PREFIX } from './serviceHelpers';

const getTotalUsers = (pageIndex, pageSize) => {
    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/users/?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        data: (pageIndex, pageSize),
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

const getTotalSessions = (pageIndex, pageSize) => {
    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/sessions/?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        data: (pageIndex, pageSize),
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

const getTotalWorkShops = (pageIndex, pageSize) => {
    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/workshops/paginate/?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        data: (pageIndex, pageSize),
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

const getUserProfile = (id) => {
    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/userprofiles/${id}`,
        data: id,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

const updateUserProfile = (payload) => {
    const config = {
        method: 'PUT',
        url: `${API_HOST_PREFIX}/api/userprofiles/${payload.id}`,
        data: payload.data,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};
export { getTotalUsers, getTotalSessions, getTotalWorkShops, getUserProfile, updateUserProfile };
