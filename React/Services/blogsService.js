import axios from 'axios';
import * as helper from './serviceHelpers';
const endpoint = 'api/blogs';
const url = `${helper.API_HOST_PREFIX}/${endpoint}`;

const id = (id) => {
    const config = {
        method: 'GET',
        url: `${url}/${id}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(helper.onGlobalSuccess).catch(helper.onGlobalError);
};

const paginate = (pageindex, pagesize, query) => {
    const config = {
        method: 'GET',
        url: `${url}/paginate/?pageIndex=${pageindex}&pageSize=${pagesize}&query=${query}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(helper.onGlobalSuccess).catch(helper.onGlobalError);
};

const blogsByCategory = (pageindex, pagesize, query, type) => {
    const config = {
        method: 'GET',
        url: `${url}/paginateType/?pageIndex=${pageindex}&pageSize=${pagesize}&query=${query}&type=${type}`,

        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(helper.onGlobalSuccess).catch(helper.onGlobalError);
};

export { id, paginate, blogsByCategory };
