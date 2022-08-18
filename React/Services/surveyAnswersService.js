import axios from 'axios';
import { API_HOST_PREFIX } from './serviceHelpers';

const answerService = `${API_HOST_PREFIX}/api/survey/answer`;

let get = (id) => {
    const getConfig = {
        method: 'GET',
        url: `${answerService}/${id}`,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(getConfig);
};

let getAll = (pageIndex, pageSize) => {
    const getAllConfig = {
        method: 'GET',
        url: `${answerService}/?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(getAllConfig);
};

let getCreatedBy = (pageIndex, pageSize, id) => {
    const getCreatedByConfig = {
        method: 'GET',
        url: `${answerService}/user/${id}?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(getCreatedByConfig);
};

let add = (payload) => {
    const addConfig = {
        method: 'POST',
        url: answerService,
        data: payload,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(addConfig);
};

let update = (payload, id) => {
    const updateConfig = {
        method: 'PUT',
        url: `${answerService}/${id}`,
        data: payload,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(updateConfig);
};

let remove = (id) => {
    const removeConfig = {
        method: 'DELETE',
        url: `${answerService}/${id}`,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(removeConfig).then(() => {
        return id;
    });
};

export { get, getAll, getCreatedBy, add, update, remove };
