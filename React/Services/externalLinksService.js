import axios from 'axios';
import { API_HOST_PREFIX } from './serviceHelpers';
import debug from 'sabio-debug';

const _logger = debug.extend("externalLinksService");
const endpoint = `${API_HOST_PREFIX}/api/externallinks`;

const AddExternalLink = (payload) => {
    _logger(payload);
    const config = {
        method: 'POST',
        data: payload,
        url: endpoint,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

const UpdateExternalLink = (payload, id) => {
    _logger(payload);
    const config = {
        method: 'PUT',
        data: payload,
        url: `${endpoint}/${id}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

const DeleteExternalLink = (id) => {
    _logger('ran DeleteExternalLink');
    const config = {
        method: 'DELETE',
        url: `${endpoint}/${id}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config)
};

const GetOneExternalLink = (id) => {
    _logger('ran GetOneExternalLink');
    const config = {
        method: 'GET',
        url: `${endpoint}/${id}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

const PaginateSelectAll = (pageIndex, pageSize) => {
    _logger('ran PaginateSelectAll');
    const config = {
        method: 'GET',
        url: `${endpoint}/externallinksall?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

const PaginateCreatedBy = (pageIndex, pageSize, userId) => {
    _logger('ran PaginateCreatedBy');
    const config = {
        method: 'GET',
        url: `${endpoint}/userexternallinks?pageIndex=${pageIndex}&pageSize=${pageSize}&userId=${userId}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

export { AddExternalLink, UpdateExternalLink, DeleteExternalLink, GetOneExternalLink, PaginateSelectAll, PaginateCreatedBy };