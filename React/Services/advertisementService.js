import axios from 'axios';
import * as helper from './serviceHelpers';
import debug from 'sabio-debug';

const _logger = debug.extend('advertisementService');

const adService = { endpoint: `${helper.API_HOST_PREFIX}/api/advertisements` };

const get = (pageIndex, pageSize) => {
    const config = {
        method: 'GET',
        url: `${adService.endpoint}/paginate?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(helper.onGlobalSuccess);
};

const post = (payload) => {
    _logger(payload);
    const config = {
        method: 'POST',
        url: `${adService.endpoint}`,
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(helper.onGlobalSuccess);
};

const update = (payload, adId) => {
    _logger(payload, adId);
    const config = {
        method: 'PUT',
        url: `${adService.endpoint}/${adId}`,
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(helper.onGlobalSuccess);
};
const deleteAd = (adId) => {
    _logger(adId);
    const config = {
        method: 'DELETE',
        url: `${adService.endpoint}/${adId}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    _logger(`${adId} was returned`);
    return axios(config).then(() => {
        return adId;
    });
};

export { post, get, update, deleteAd };
