import axios from 'axios';
import debug from "sabio-debug";
import { API_HOST_PREFIX, onGlobalSuccess, onGlobalError } from './serviceHelpers';

const newsTemps = `${API_HOST_PREFIX}/api/newsletter/templates`


const _logger = debug.extend('NewsletterTemplatesServices');


const paginated = (pageIndex, pageSize) => {
    const config = {
        method: 'GET',
        url: `${newsTemps}/paginate/?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError) 
  
};

let search = (pageIndex,pageSize,query) => {
    const config = {
      method: "GET",
      url: `${newsTemps}/search/?pageIndex=${pageIndex}&pageSize=${pageSize}&query=${query}`,
      withCredentials: true,
      crossdomain: true,
      headers: { "Content-Type": "application/json" },
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError) // 
   };


const deleteById = (id) => {
    const config = {
        method: 'DELETE',
        url: `${newsTemps}/${id}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    _logger(id);
    return axios(config).then(onGlobalSuccess).catch(onGlobalError) ;
};

const add = (payload) => {
    const config = {
        method: "POST",
        url: `${newsTemps}`,
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
        url:`${newsTemps}/${id}`,
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
        url: `${newsTemps}/${id}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then((response) => {
        return response.data.item;
    });
};




export{ paginated, deleteById, search, add, update, getById} 
