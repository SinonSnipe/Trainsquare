import axios from 'axios';
import * as helper from './serviceHelpers';


let RequestService = {
    endpoint: `${helper.API_HOST_PREFIX}/api/venuerequests`,
};

const getAll = (pageIndex, pageSize) => {

    const config = {
        method: "GET",
        url: RequestService.endpoint + "/paginate/?pageIndex=0&pageSize=10",
        data: (pageIndex, pageSize),
        crossdomain: true,
        headers: { "Content-Type": "application/json" }
    };
    return axios(config);
}

const getById = (id) => {
    const config = {
        method: 'GET',
        url: `${RequestService.endpoint}/byvenue/${id}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then((response) => {
        return response.data.item;
    });
};

const deleteById = (id) => {
    const config = {
        method: 'DELETE',
        url: `${RequestService.endpoint}/${id}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

const create = (payload) => {
    const config = {
        method: 'POST',
        url: RequestService.endpoint,
        withCredentials: true,
        data: payload,
        crossdomain: true,
        headers: { 'Content-type': 'application/json' },
    };
    return axios(config)
    .then(() => {
        return {
            ...payload,
        };
    })
    .catch(helper.onGlobalError);
};

const update = (id, payload) => {
    const config = {
        method: 'PUT',
        url: `${RequestService.endpoint}/${id}`,
        data: payload,
        crossdomain: true,
        withCredentials: true,
        headers: { 'Content-type': 'application/json' },
    };
    return axios(config)
        .then(() => {
            return { ...payload, id };
        })
        .catch(helper.onGlobalError);
};

export { create, getAll, getById, deleteById, update };
