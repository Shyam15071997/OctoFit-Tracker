import axios from 'axios';

const apiClient = axios.create({
    baseURL: process.env.REACT_APP_API_URL || 'http://localhost:8000/api/',
    timeout: 10000,
    headers: {
        'Content-Type': 'application/json',
    },
});

export const getItems = async () => {
    const response = await apiClient.get('items/');
    return response.data;
};

export const getItemById = async (id) => {
    const response = await apiClient.get(`items/${id}/`);
    return response.data;
};

export const createItem = async (itemData) => {
    const response = await apiClient.post('items/', itemData);
    return response.data;
};

export const updateItem = async (id, itemData) => {
    const response = await apiClient.put(`items/${id}/`, itemData);
    return response.data;
};

export const deleteItem = async (id) => {
    await apiClient.delete(`items/${id}/`);
};