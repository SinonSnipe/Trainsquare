import axios from 'axios';
import { API_HOST_PREFIX } from './serviceHelpers';

export const addLocation = (payload) => {
    const config = {
        method: 'POST',
        url: `${API_HOST_PREFIX}/api/locations`,
        data: payload,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config)
};

export const getAllLocationsByCreator = (id) => {
    const config = {
        method: 'GET',
        url: `${API_HOST_PREFIX}/api/locations/createdBy/?pageIndex=0&&pageSize=10&&creatorId=${id}`,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    
    return axios(config)
};

export const deleteLocationRequest = (id) => {
    const config = {
        method: 'DELETE',
        url: `${API_HOST_PREFIX}/api/locations/${id}`,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    
    return axios(config)
};

export const updateLocationRequest = (payload) => {
    const config = {
        method: 'PUT',
        url: `${API_HOST_PREFIX}/api/locations/${payload.id}`,
        data: payload,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    
    return axios(config)
};