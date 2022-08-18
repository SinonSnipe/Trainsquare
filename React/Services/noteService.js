import axios from 'axios';
import { API_HOST_PREFIX, onGlobalSuccess, onGlobalError } from './serviceHelpers';
import debug from 'sabio-debug';

const endpoint = `api/notes`;
const url = `${API_HOST_PREFIX}/${endpoint}`;

const _logger = debug.extend('noteService');

 const add = (payload) => {
    const config = {
        method: 'POST',
        url: url,
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    }
    return axios (config).then((response) => {
        return response.data.item; 
      })
}

 const getById = (id) => {
    const config = {
        method:"GET",
        url:`${url}/${id}`,
        crossdomain:true,
        withCredentials:true,
        headers:{"Content-Type":"application/json"}
    }
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
}

 const getPaginate = (pageIndex, pageSize) => {
    _logger(pageIndex, pageSize);
    const config = {
        method: "GET",
        url: `${url}/paginate?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        data: (pageIndex, pageSize),
        withCredentials: true,
        crossdomain: true,
        headers: { "Content-Type": "application/json" }
    }
      return axios(config).then(onGlobalSuccess).catch(onGlobalError); 
}

 const getByCreated = (createdby, pageIndex, pageSize) => {
    const config = {
        method:"GET",
        url:`${url}/current/?pageIndex=${createdby}&pageSize=${pageIndex}&user=${pageSize}`,
        crossdomain:true,
        withCredentials:true,
        headers:{"Content-Type":"application/json"}
    }
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
}

 const update = (id, payload) => {
    const config = {
        method:"PUT",
        url:`${url}/${id}`,
        data:payload,
        crossdomain:true,
        withCredentials:true,
        headers:{"Content-Type":"application/json"}
    }
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
}

  const remove = (id) => {
    const config = {
        method:"DELETE",
        url:`${url}/${id}`,
        crossdomain:true,
        withCredentials:true,
        headers:{"Content-Type":"application/json"}
    }
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
}
const noteService = { add, getById, getPaginate, getByCreated, update, remove};
export default noteService;