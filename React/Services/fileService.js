import axios from 'axios';
import { API_HOST_PREFIX } from './serviceHelpers';

const uploadService = `${API_HOST_PREFIX}/api/files`;

let get = (id) => {
    const getConfig = {
        method: 'GET',
        url: `${uploadService}/${id}`,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(getConfig);
};

let getAll = (pageIndex, pageSize) => {
    const getAllConfig = {
        method: 'GET',
        url: `${uploadService}/?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(getAllConfig);
};

let getCreatedBy = (pageIndex, pageSize, id) => {
    const getCreatedByConfig = {
        method: 'GET',
        url: `${uploadService}/user/${id}?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(getCreatedByConfig);
};

let add = (payload) => {
    const addConfig = {
        method: 'POST',
        url: uploadService,
        data: payload,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(addConfig);
};

let upload = (payload, uploadProgress) => {
    const uploadConfig = {
        method: 'POST',
        url: `${uploadService}/upload`,
        data: payload,
        crossdomain: true,
        headers: { 'Content-Type': 'multipart/form-data' },
        onUploadProgress: uploadProgress,
    };
    return axios(uploadConfig);
};

let update = (payload, id) => {
    const updateConfig = {
        method: 'PUT',
        url: `${uploadService}/${id}`,
        data: payload,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(updateConfig);
};

let remove = (id) => {
    const removeConfig = {
        method: 'DELETE',
        url: `${uploadService}/${id}`,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(removeConfig).then(() => {
        return id;
    });
};

export { get, getAll, getCreatedBy, add, upload, update, remove };
