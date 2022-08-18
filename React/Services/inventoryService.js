import axios from 'axios';
import * as helper from './serviceHelpers';

const inventory = {
    endpoint: `${helper.API_HOST_PREFIX}/api/inventory`,
};

const paginate = (pageIndex, pageSize) => {
    const config = {
        method: 'GET',
        url: `${inventory.endpoint}/paginate/?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        crossdomain: true,
        withCredentials: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

const paginateV2 = (pageIndex, pageSize) => {
    const config = {
        method: 'GET',
        url: `${inventory.endpoint}/paginateV2/?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        crossdomain: true,
        withCredentials: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(helper.onGlobalSuccess).catch(helper.onGlobalError);
};

const paginateV2Search = (pageIndex, pageSize, query) => {
    const config = {
        method: 'GET',
        url: `${inventory.endpoint}/paginateV2/search?pageIndex=${pageIndex}&pageSize=${pageSize}&query=${query}`,
        crossdomain: true,
        withCredentials: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(helper.onGlobalSuccess).catch(helper.onGlobalError);
};

const getByCreator = (pageIndex, pageSize, creatorId) => {
    const config = {
        method: 'GET',
        url: `${inventory.endpoint}?pageIndex=${pageIndex}&pageSize=${pageSize}&user=${creatorId}`,
        crossdomain: true,
        withCredentials: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

const getById = (id) => {
    const config = {
        method: 'GET',
        url: `${inventory.endpoint}/${id}`,
        crossdomain: true,
        withCredentials: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

const add = (payload) => {
    const config = {
        method: 'POST',
        url: `${inventory.endpoint}`,
        data: payload,
        crossdomain: true,
        withCredentials: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

const update = (payload, id) => {
    const config = {
        method: 'PUT',
        url: `${inventory.endpoint}/${id}`,
        data: payload,
        crossdomain: true,
        withCredentials: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config)
        .then(() => {
            return { ...payload, id };
        })
        .catch(helper.onGlobalError);
};

const deleteById = (id) => {
    const config = {
        method: 'DELETE',
        url: `${inventory.endpoint}/${id}`,
        crossdomain: true,
        withCredentials: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

export { deleteById, getByCreator, getById, paginate, add, update, paginateV2, paginateV2Search };
