import axios from 'axios';
import * as helper from './serviceHelpers';
const endpoint = 'api/carts';
const url = `${helper.API_HOST_PREFIX}/${endpoint}`;

const getCartByCustomer = () => {
    const config = {
        method: 'GET',
        url: `${url}/my-cart`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(helper.onGlobalSuccess).catch(helper.onGlobalError);
};

export { getCartByCustomer };
