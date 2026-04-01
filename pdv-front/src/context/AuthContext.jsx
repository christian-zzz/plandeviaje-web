import React, { createContext, useState, useEffect, useContext } from 'react';
import api from '../api/axios';

const AuthContext = createContext();

export const AuthProvider = ({ children }) => {
    const [user, setUser] = useState(null);
    const [token, setToken] = useState(localStorage.getItem('token') || null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        if (token) {
            fetchUser();
        } else {
            setLoading(false);
        }
    }, [token]);

    const fetchUser = async () => {
        try {
            const response = await api.get('/user');
            const userData = response.data;
            if (userData && userData.role) {
                userData.role = parseInt(userData.role);
            }
            setUser(userData);
        } catch (error) {
            console.error('Error fetching user', error);
            localStorage.removeItem('token');
            setToken(null);
            setUser(null);
        } finally {
            setLoading(false);
        }
    };

    const login = async (email, password) => {
        try {
            const response = await api.post('/login', { email, password });
            const { access_token, user: userData } = response.data;

            if (userData && userData.role) {
                userData.role = parseInt(userData.role);
            }

            localStorage.setItem('token', access_token);
            setToken(access_token);
            setUser(userData);
            return { success: true };
        } catch (error) {
            console.error('Login error', error);
            return {
                success: false,
                message: error.response?.data?.message || 'Login failed. Please check your credentials.'
            };
        }
    };

    const logout = async () => {
        try {
            await api.post('/logout');
        } catch (error) {
            console.error('Logout error', error);
        } finally {
            localStorage.removeItem('token');
            setToken(null);
            setUser(null);
        }
    };

    return (
        <AuthContext.Provider value={{ user, token, loading, login, logout }}>
            {children}
        </AuthContext.Provider>
    );
};

export const useAuth = () => {
    return useContext(AuthContext);
};
