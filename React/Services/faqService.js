import axios from 'axios';
import { API_HOST_PREFIX, onGlobalSuccess, onGlobalError } from './serviceHelpers';
import debug from 'sabio-debug';

const _logger = debug.extend('faqService');

const addFaq = (payload) => {
    _logger(payload);
    const config = {
        method: 'POST',
        url: `${API_HOST_PREFIX}/api/faqs`,
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const getAllFaq = (pageIndex, pageSize) => {
    _logger(pageIndex, pageSize);
    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/faqs/paginate?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const getFaqById = (id) => {
    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/faqs/${id}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const getFaqByCreator = (pageIndex, pageSize) => {
    _logger(pageIndex, pageSize);
    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/faqs/creator/paginate?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const updateFaq = (payload) => {
    _logger(payload);
    const faqId = payload.id;
    const config = {
        method: 'PUT',
        url: `${API_HOST_PREFIX}/api/faqs/${faqId}`,
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    _logger(payload);
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const removeFaq = (payload) => {
    const config = {
        method: 'DELETE',
        url: `${API_HOST_PREFIX}/api/faqs/${payload}`,
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    _logger(payload);
    return axios(config);
};

const faqService = {
    addFaq,
    getAllFaq,
    updateFaq,
    removeFaq,
    getFaqById,
    getFaqByCreator,
};

export default faqService;
