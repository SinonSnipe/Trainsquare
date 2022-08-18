import axios from 'axios';
import { API_HOST_PREFIX } from './serviceHelpers';
import debug from 'sabio-debug';

const _logger = debug.extend("contactUsService");

const contactUsForm = (payload) => {
    _logger(payload);
    const config = {
        method: 'POST',
        data: payload,
        url: `${API_HOST_PREFIX}/api/emails/contactus`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config);
};

export {contactUsForm};