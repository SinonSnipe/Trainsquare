import axios from 'axios';
import * as helper from "./serviceHelpers"
import { API_HOST_PREFIX } from './serviceHelpers';

const endpoint = `${API_HOST_PREFIX}/api/sms`

const getTFA = () => {
    const config = {
        method: 'GET',
        url: `${endpoint}/current`,

        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(helper.onGlobalSuccess);
};

const generateTFA = (payload) => {
    const config = {
        method: 'POST',
        url: `${endpoint}/sending`,
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(helper.onGlobalSuccess);
};

export { getTFA, generateTFA };