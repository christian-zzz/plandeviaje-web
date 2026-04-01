import api from './axios';

export const getSettings = async (group = '') => {
    const url = group ? `/settings?group=${group}` : '/settings';
    const response = await api.get(url);
    return response.data; // Assuming Laravel returns an object or array of settings
};

export const updateSettingsBulk = async (formData) => {
    // formData is used because we might be uploading images
    const response = await api.post('/settings/bulk', formData, {
        headers: {
            'Content-Type': 'multipart/form-data',
        },
    });
    return response.data;
};
