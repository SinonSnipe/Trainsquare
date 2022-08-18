import axios from 'axios';
import { API_HOST_PREFIX, onGlobalSuccess, onGlobalError } from './serviceHelpers';

const createMeeting = (payload) => {
    const config = {
        method: 'POST',
        url: `${API_HOST_PREFIX}/api/zoom/request`,
        crossdomain: true,
        withCredentials: true,
        data: payload,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const getSdkToken = (payload) => {
    const config = {
        method: 'POST',
        url: `${API_HOST_PREFIX}/api/zoom/token`,
        crossdomain: true,
        withCredentials: true,
        data: payload,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

export { createMeeting, getSdkToken };
