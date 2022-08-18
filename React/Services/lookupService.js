import axios from 'axios';
import { API_HOST_PREFIX, onGlobalSuccess, onGlobalError } from './serviceHelpers';

const lookup = (tableNames) => {
    const config = {
        method: 'POST',
        url: `${API_HOST_PREFIX}/api/lookup/`,
        data: tableNames,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    //in the .then(anything can go in here to return what you need response=>{})
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

export default lookup;
