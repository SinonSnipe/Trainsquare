import axios from 'axios';
import debug from "sabio-debug";
import { API_HOST_PREFIX, onGlobalSuccess, onGlobalError } from './serviceHelpers';

const newsTempsKeys = `${API_HOST_PREFIX}/api/newsletter/templatekeys`

const _logger = debug.extend('NewsletterTemplatesKeysService');

const add = (payload) => {
    const config = {
        method: "POST",
        url: `${newsTempsKeys}`,
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
        url:`${newsTempsKeys}/${id}`,
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

const getByTemplateId = (templateId) => {
    const config = {
        method: 'GET',
        url: `${newsTempsKeys}/${templateId}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    // return axios(config).then((response) => {
    //     _logger('get by template id service call', response);
    //     return response.data.item;
   // })
   return axios(config).then(onGlobalSuccess).catch(onGlobalError);

};

export{  add, update, getByTemplateId} 