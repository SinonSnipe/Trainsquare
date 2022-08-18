import axios from 'axios';
import { API_HOST_PREFIX, onGlobalSuccess, onGlobalError } from './serviceHelpers';
import debug from 'sabio-debug';

const _logger = debug.extend('ratingService');

const addRating = (payload) => {
    const config = {
        method: 'POST',
        url: `${API_HOST_PREFIX}/api/ratings`,
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const CreatedByPaginate = (pageIndex, pageSize) => {
    _logger(pageIndex, pageSize);
    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/ratings/CreatedBy?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };    

    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const updateRatingByCreatedBy = (payload) => {
    _logger(payload);
    const ratingId = payload.createdBy;
    const config = {
        method: 'PUT',
        url: `${API_HOST_PREFIX}/api/ratings/${ratingId}`,
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    _logger(payload);
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const getByCreatedByV2 = (CreatedBy) => {

    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/ratings/CreatedBy/?${CreatedBy}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const getRatingById = (id) => {
    _logger(id);
    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/rating/${id}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const getByEntityId = (entityId, entityTypeId, pageIndex, pageSize) => {
    _logger(entityId, entityTypeId);
    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/ratings/${entityId}/${entityTypeId}/?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const getAllRatingsPaginate = (pageIndex, pageSize) => {
    _logger(pageIndex, pageSize);
    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/ratings/paginate?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const ratingService = {
    addRating,
    CreatedByPaginate,
    updateRatingByCreatedBy,
    getByCreatedByV2,
    getRatingById,
    getByEntityId,
    getAllRatingsPaginate,
};

export default ratingService;
