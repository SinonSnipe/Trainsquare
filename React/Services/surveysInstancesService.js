import axios from 'axios';
import { API_HOST_PREFIX, onGlobalError, onGlobalSuccess } from '../serviceHelpers';

const surveysInstancesService = `${API_HOST_PREFIX}/api/surveys/instances`;

let get = (id) => {
    const getConfig = {
        method: 'GET',
        url: `${surveysInstancesService}/${id}`,
        crossdomain: true,
        withCredentials: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(getConfig).then(onGlobalSuccess).catch(onGlobalError);
};

let getAll = () => {
    const getAllConfig = {
        method: 'GET',
        url: surveysInstancesService,
        crossdomain: true,
        withCredentials: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(getAllConfig);
};

let pagination = (pageIndex, pageSize) => {
    const paginationConfig = {
        method: 'GET',
        url: `${surveysInstancesService}/paginate?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(paginationConfig);
};

let getCreatedBy = (pageIndex, pageSize, userId) => {
    const getCreatedByConfig = {
        method: 'GET',
        url: `${surveysInstancesService}/createdby/${userId}?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(getCreatedByConfig);
};

let add = (id) => {
    const addConfig = {
        method: 'POST',
        url: `${surveysInstancesService}/${id}`,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(addConfig);
};

let update = (payload, id) => {
    const updateConfig = {
        method: 'PUT',
        url: `${surveysInstancesService}/${id}`,
        data: payload,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(updateConfig);
};

let Delete = (id) => {
    const removeConfig = {
        method: 'DELETE',
        url: `${surveysInstancesService}/${id}`,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(removeConfig).then(() => {
        return id;
    });
};

export { get, getAll, pagination, getCreatedBy, add, update, Delete };
