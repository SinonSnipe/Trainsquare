import axios from 'axios';
import { API_HOST_PREFIX, onGlobalSuccess, onGlobalError } from './serviceHelpers';
import debug from 'sabio-debug';

const _logger = debug.extend('workShopService');

const add = (payload) => {
    const config = {
        method: 'POST',
        url: `${API_HOST_PREFIX}/api/workshops`,
        data: payload,
        withCrendentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const paginate = (pageIndex, pageSize) => {
    _logger(pageIndex, pageSize);
    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/workshops/paginate?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        withCrendentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const search = (pageIndex, pageSize, query) => {
    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/workshops/search?pageIndex=${pageIndex}&pageSize=${pageSize}&query=${query}`,
        crossdomain: true,
        withCredentials: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(onGlobalSuccess);
};

const random = () => {
    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/workshops/random`,
        withCrendentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const update = (payload, id) => {
    _logger(payload);
    const config = {
        method: 'PUT',
        url: `${API_HOST_PREFIX}/api/workshops/${id}`,
        data: payload,
        withCrendentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const deleteById = (id) => {
    const config = {
        method: 'DELETE',
        url: `${API_HOST_PREFIX}/api/workshops/${id}`,
        withCrendentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const getById = (id) => {
    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/workshops/${id}`,
        withCrendentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const searchGeo = (radius, latitude, longitude) => {
    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/workshops/geo?radius=${radius}&latitude=${latitude}&longitude=${longitude}`,
        crossdomain: true,
        withCredentials: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(onGlobalSuccess);
};

const registerAdd = (id, payload) => {
    const adjustedAddPayload = {
        WorkShopId: id,
        StatusId: payload,
    };

    const config = {
        method: 'POST',
        url: `${API_HOST_PREFIX}/api/workshops/registration`,
        data: adjustedAddPayload,
        withCrendentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then((response) => {
        _logger('SignUpAdd', response);
        return { id };
    });
};

const unregisterUpdate = (id, payload) => {
    const adjustedUpdatePayload = {
        WorkShopId: id,
        StatusId: payload,
    };

    const config = {
        method: 'PUT',
        url: `${API_HOST_PREFIX}/api/workshops/registration`,
        data: adjustedUpdatePayload,
        withCrendentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const getWorkshopIdByUser = () => {
    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/workshops/workshopstatus`,
        withCrendentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

export {
    getById,
    deleteById,
    paginate,
    update,
    add,
    random,
    search,
    searchGeo,
    registerAdd,
    unregisterUpdate,
    getWorkshopIdByUser,
};
