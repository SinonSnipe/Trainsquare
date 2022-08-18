import axios from 'axios';
import * as helper from './serviceHelpers';

let endpoint = helper.API_HOST_PREFIX;

const create = () => {
    const config = {
        method: 'POST',
        url: endpoint + `/api/payments/create-session`,
        withCredentials: false,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(helper.onGlobalSuccess).catch(helper.onGlobalError);
};

const getSession = (sessionId) => {
    const config = {
        method: 'GET',
        url: endpoint + `/api/payments/session/` + sessionId,
        withCredentials: false,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(helper.onGlobalSuccess).catch(helper.onGlobalError);
};

const createIntent = (payload) => {
    const config = {
        method: 'POST',
        url: endpoint + `/api/payments/intent`,
        data: payload,
        withCredentials: false,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(helper.onGlobalSuccess).catch(helper.onGlobalError);
};

const createCheckoutSession = () => {
    const config = {
        method: 'POST',
        url: endpoint + `/api/payments/session`,
        withCredentials: false,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(helper.onGlobalSuccess).catch(helper.onGlobalError);
};

export { create, getSession, createIntent, createCheckoutSession };
