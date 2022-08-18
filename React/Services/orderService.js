import axios from 'axios';
import * as helper from './serviceHelpers';
const endpoint = 'api/orders';
const url = `${helper.API_HOST_PREFIX}/${endpoint}`;

const getAll = () => {
    const config = {
        method: 'GET',
        url: `${url}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(helper.onGlobalSuccess).catch(helper.onGlobalError);
};

const getById = (id) => {
    const config = {
        method: 'GET',
        url: `${url}/${id}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(helper.onGlobalSuccess).catch(helper.onGlobalError);
};

const update = (sessionId) => {
    const config = {
        method: 'PUT',
        url: `${url}/${sessionId}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(helper.onGlobalSuccess).catch(helper.onGlobalError);
};

export { getAll, update, getById };
