import axios from 'axios';
import * as helper from './serviceHelpers';

const privateBookingService = {
    endpoint: 'https://localhost:50001/api/privateBooking',
};

const userIdBookingService = {
    endpoint: 'https://localhost:50001/api/WorkshopRequests',
};

const getById = (id) => {
    const config = {
        method: 'GET',
        url: `${privateBookingService.endpoint}/${id}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then((id) => {
        return id;
    });
};

const getByUserId = (id) => {
    const config = {
        method: 'GET',
        url: `${userIdBookingService}/${id}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then((id) => {
        return id;
    });
};

const paginateBooking = (pageIndex, pageSize) => {
    const config = {
        method: 'GET',
        url: `https://localhost:50001/api/privateBooking/paginate?pageIndex=${pageIndex}&pageSize=${pageSize}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(helper.onGlobalSuccess).catch(helper.onGlobalError);
};

const getBookingSearch = (pageIndex, pageSize, query) => {
    const config = {
        method: 'GET',
        url: `https://localhost:50001/api/privateBooking/search?pageIndex=${pageIndex}&pageSize=${pageSize}&query=${query}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then(helper.onGlobalSuccess).catch(helper.onGlobalError);
};

const createBooking = (payload) => {
    const config = {
        method: 'POST',
        url: 'https://localhost:50001/api/privateBooking',
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then((response) => {
        return { id: response.data.item, ...payload };
    });
};

const updateBooking = (id, payload) => {
    const config = {
        method: 'PUT',
        url: `${privateBookingService.endpoint}/${id}`,
        data: payload,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then((response) => {
        return { id: response.data.item, payload };
    });
};

const deleteBooking = (id) => {
    const config = {
        method: 'DELETE',
        url: `${privateBookingService.endpoint}/${id}`,
        withCredentials: true,
        crossdomain: true,
        headers: { 'Content-Type': 'application/json' },
    };

    return axios(config).then((id) => {
        return id;
    });
};

export { getById, getByUserId, paginateBooking, getBookingSearch, createBooking, updateBooking, deleteBooking };
