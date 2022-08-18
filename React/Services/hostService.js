import axios from 'axios';
import { API_HOST_PREFIX, onGlobalSuccess, onGlobalError } from './serviceHelpers';

let GetWorkshops = (payload) => {
    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/HostDash/workshops`,
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

let GetSessions = (payload) => {
    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/HostDash/sessions/?pageIndex=0&pageSize=4`,
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

let GetProfile = (payload) => {
    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/HostDash`,
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

let GetWorkshopRequests = (payload) => {
    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/HostDash/requests`,
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};
export { GetWorkshops, GetProfile, GetWorkshopRequests, GetSessions };
