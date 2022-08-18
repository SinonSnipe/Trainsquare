import axios from 'axios';
import debug from "sabio-debug";
import { API_HOST_PREFIX, onGlobalSuccess, onGlobalError } from './serviceHelpers';

const news = `${API_HOST_PREFIX}/api/newsletter`


const _logger = debug.extend('NewslettersServices');


const paginated = (pageIndex, pageSize) => {
    const config = {
        method: 'GET',
        url: `${news}/paginate/?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError) 
  
};

const add = (payload) => {
    const config = {
        method: "POST",
        url: `${news}`,
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    _logger("add", payload);
    return axios(config).then(onGlobalSuccess).catch(onGlobalError) ;
}
const update = (payload, id) => {
    _logger('update ajax', payload, id);
    const config = {
        method: 'PUT',
        url:`${news}/${id}`,
        withCredentials: true,
        data: payload,
        crossdomain: true,
        headers: { 'Content-type': 'application/json' },
    };
    return axios(config)
        .then(() => {
            return {
                ...payload,
                id,
            };
        })
        .catch(onGlobalError);
};
const getById = (id) => {
    const config = {
        method: 'GET',
        url: `${news}/${id}`,
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
        url: `${news}/${id}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    _logger(id);
    return axios(config).then(onGlobalSuccess).catch(onGlobalError) ;
};




export{paginated, add, update, getById, deleteById} 
