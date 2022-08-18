import axios from 'axios';
import { API_HOST_PREFIX, onGlobalSuccess, onGlobalError } from './serviceHelpers';

const favoriteWorkshop = {
    endpoint: `${API_HOST_PREFIX}/api/favoriteWorkshops`,
};

const addFavorite = (payload) => {
    const config = {
        method: 'POST',
        url: `${favoriteWorkshop.endpoint}`,
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const getUserFavoriteWorkshops = (pageIndex, pageSize) => {
    const config = {
        method: 'GET',
        url: `${favoriteWorkshop.endpoint}/current?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const getAllFavoriteWorkshops = (pageIndex, pageSize) => {
    const config = {
        method: 'GET',
        url: `${favoriteWorkshop.endpoint}/topFavorited?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const search = (pageIndex, pageSize, query) => {
    const config = {
        method: 'GET',
        url: `${favoriteWorkshop.endpoint}/search?pageIndex=${pageIndex}&pageSize=${pageSize}&query=${query}`,
        crossdomain: true,
        withCredentials: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(onGlobalSuccess);
};

const getFavoriteWorkshopIds = () => {
    const config = {
        method: 'GET',
        url: `${favoriteWorkshop.endpoint}/favoriteWorkShopIds`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

const deleteFavorite = (id) => {
    const config = {
        method: 'DELETE',
        url: `${favoriteWorkshop.endpoint}/${id}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };
    return axios(config).then(onGlobalSuccess).catch(onGlobalError);
};

export {
    addFavorite,
    getUserFavoriteWorkshops,
    getFavoriteWorkshopIds,
    deleteFavorite,
    getAllFavoriteWorkshops,
    search,
};
