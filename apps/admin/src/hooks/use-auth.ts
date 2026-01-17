import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import api from '@/lib/api';
import { User, AuthResponse } from '@/types/auth';

export function useAuth() {
    const router = useRouter();
    const [user, setUser] = useState<User | null>(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        // Check if user is logged in (e.g. check local storage for token)
        const token = localStorage.getItem('accessToken');
        if (token) {
            // Ideally verify token with backend or decode it
            // For now, we assume if token exists we are likely logged in, 
            // but we should fetch the profile
            fetchProfile();
        } else {
            setLoading(false);
        }
    }, []);

    const fetchProfile = async () => {
        try {
            const response = await api.get('/auth/profile'); // Assuming a profile endpoint exists
            setUser(response.data);
        } catch (error) {
            console.error("Failed to fetch profile", error);
            logout();
        } finally {
            setLoading(false);
        }
    };

    const login = async (email: string, password: string) => {
        try {
            const response = await api.post<AuthResponse>('/auth/login', { email, password });
            const { accessToken, user } = response.data;
            localStorage.setItem('accessToken', accessToken);
            // Store refreshToken if needed
            if (response.data.refreshToken) {
                localStorage.setItem('refreshToken', response.data.refreshToken);
            }
            setUser(user);
            router.push('/');
            return true;
        } catch (error) {
            console.error('Login failed', error);
            throw error;
        }
    };

    const logout = () => {
        localStorage.removeItem('accessToken');
        localStorage.removeItem('refreshToken');
        setUser(null);
        router.push('/auth/login');
    };

    return {
        user,
        loading,
        login,
        logout,
    };
}
