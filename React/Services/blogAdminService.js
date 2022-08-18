import axios from "axios";
import { API_HOST_PREFIX , onGlobalError, onGlobalSuccess} from "./serviceHelpers";
import debug from "sabio-debug";
const _logger = debug.extend("BlogAdmin Service");

const blogAdminService = { 
    endpoint: `${API_HOST_PREFIX}/api/blogs`}

const add = (payload) => {
    _logger(payload);

    const config = {
        method: "POST",
        url: `${blogAdminService.endpoint}/admin`,
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { "Content-Type": "application/json" }
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const update = (payload) => {
    const config = {
        method: "PUT",
        url: `${blogAdminService.endpoint}/admin/${payload.id}`,
        withCredentials: true,
        data: payload,
        crossdomain: true,
        headers: { "Content-Type": "application/json" }
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const getAll = (pageIndex, pageSize) => {
    const config = {
        method: "GET",        
        url:`${blogAdminService.endpoint}/admin/paginateAuthor?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        withCredentials: true,
        data:(pageSize, pageSize),
        crossdomain: true,
        headers: { "Content-Type": "application/json" }
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);   
};

const getByAuthor = (pageIndex, pageSize, query) => {
    const config = {
        method: "GET",        
        url:`${blogAdminService.endpoint}/admin/paginateAuthorQuery?pageIndex=${pageIndex}&pageSize=${pageSize}&query=${query}`,
        withCredentials: true,
        crossdomain: true,
        headers: { "Content-Type": "application/json" }
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);   
};


export {add, update, getAll, getByAuthor};