import axios from 'axios';
import * as helper from './serviceHelpers';

const endpoint = 'api/cart-items';
const url = `${helper.API_HOST_PREFIX}/${endpoint}`;

const updateCartItem = (cartItemId, payload) => {
    const config = {
        method: 'PUT',
        url: `${url}/${cartItemId}`,
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(helper.onGlobalSuccess).catch(helper.onGlobalError);
};

const deleteById = (id) => {
    const config = {
        method: 'DELETE',
        url: `${url}/${id}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(helper.onGlobalSuccess).catch(helper.onGlobalError);
};

const addToCart = (payload) => {
    const config = {
        method: 'POST',
        data: payload,
        url: `${url}/add`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(helper.onGlobalSuccess).catch(helper.onGlobalError);
};

export { updateCartItem, deleteById, addToCart };
