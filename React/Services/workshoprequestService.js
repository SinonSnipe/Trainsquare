import axios from 'axios';
import * as helper from './serviceHelpers';
import debug from 'sabio-debug';
const _logger = debug.extend('WorkShopRequestSerive');
let RequestService = {
    endpoint: `${helper.API_HOST_PREFIX}/api/workshoprequestform`,
};




const create = (payload) => {
    _logger(payload);
    const config = {
        method: 'POST',
        url: RequestService.endpoint,
        withCredentials: true,
        data: payload,
        crossdomain: true,
        headers: { 'Content-type': 'application/json' },
    };
    return axios(config)
    .then(() => {
        return {
            ...payload,
        };
    })
    .catch(helper.onGlobalError);

};

const get = (pageIndex, pageSize) => {
    const config = {
        method: 'GET',
        url: `${RequestService.endpoint}/paginate/?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(helper.onGlobalSuccess).catch(helper.onGlobalError);
};

const getById = (id) => {
    const config = {
        method: 'GET',
        url: `${RequestService.endpoint}/${id}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then((response) => {
        return response.data.item;
    });
};
const remove = (id) => {
    const config = {
        method: 'DELETE',
        url: `${RequestService.endpoint}/${id}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

const getByCreatedBy = (pageIndex, pageSize) => {
    const config = {
        method: 'GET',
        url: `${RequestService.endpoint}/creator/paginate?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(helper.onGlobalSuccess).catch(helper.onGlobalError);
};

const getBySearch = (pageIndex, pageSize, searchString) => {
    const config = {
        method: 'GET',
        url: `${RequestService.endpoint}/search?pageIndex=${pageIndex}&pageSize=${pageSize}&q=${searchString}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-type': 'application/json' },
    };
    return axios(config).then(helper.onGlobalSuccess).catch(helper.onGlobalError);
};

export { create, get, getById, remove, getByCreatedBy, getBySearch };






