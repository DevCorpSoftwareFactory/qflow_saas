'use client';

import React, { createContext, useContext, useEffect, useState, useCallback, ReactNode } from 'react';
import { useRouter } from 'next/navigation';
import { AxiosError } from 'axios';
import { UserResponseDto, UpdateProfileDto } from '@qflow/shared';
import { authService } from '@/services/auth.service';
import { UsersService } from '@/services/users.service';
import { AuthErrorResponse } from '@/types/auth';
import { logger } from '@/services/logger.service';
import { cacheService } from '@/services/cache.service';

interface AuthContextType {
  user: UserResponseDto | null;
  loading: boolean;
  isLoading: boolean;
  error: string | null;
  login: (email: string, password: string) => Promise<boolean>;
  register: (data: {
    fullName: string;
    email: string;
    password: string;
    tenantId: string;
    roleId?: string;
  }) => Promise<boolean>;
  forgotPassword: (email: string) => Promise<boolean>;
  logout: () => Promise<void>;
  fetchProfile: () => Promise<void>;
  updateProfile: (dto: UpdateProfileDto) => Promise<UserResponseDto>;
  clearError: () => void;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: ReactNode }) {
  const router = useRouter();
  const [user, setUser] = useState<UserResponseDto | null>(null);
  const [loading, setLoading] = useState(true);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const clearError = useCallback(() => {
    setError(null);
  }, []);

  const logout = useCallback(async () => {
    try {
      await authService.logout();
    } catch (logoutError) {
      const errorMessage = logoutError instanceof Error ? logoutError.message : 'Unknown error';
      logger.error('Logout failed on server', { error: errorMessage });
    } finally {
      localStorage.removeItem('accessToken');
      localStorage.removeItem('refreshToken');
      setUser(null);
      cacheService.remove('user:profile');
      logger.info('User logged out');
      router.push('/auth/login');
    }
  }, [router]);

  const fetchProfile = useCallback(async () => {
    try {
      const cachedUser = cacheService.get<UserResponseDto>('user:profile');
      if (cachedUser) {
        logger.debug('Using cached user profile', { userId: cachedUser.id });
        setUser(cachedUser);
        setLoading(false);
        return;
      }

      logger.debug('Fetching user profile from API');
      const data = await authService.getProfile();
      setUser(data);
      cacheService.set('user:profile', data);
      logger.debug('Profile fetched successfully', { userId: data.id });
    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : 'Unknown error';
      logger.error('Failed to fetch profile', { error: errorMessage });
      logout();
    } finally {
      setLoading(false);
    }
  }, [logout]);

  useEffect(() => {
    const token = localStorage.getItem('accessToken');
    if (token) {
      fetchProfile();
    } else {
      setLoading(false);
    }
  }, [fetchProfile]);

  const login = async (email: string, password: string): Promise<boolean> => {
    setIsLoading(true);
    setError(null);
    try {
      const response = await authService.login({ email, password });
      const { accessToken, refreshToken, user: userData } = response;
      localStorage.setItem('accessToken', accessToken);
      if (refreshToken) {
        localStorage.setItem('refreshToken', refreshToken);
      }
      setUser(userData);
      cacheService.set('user:profile', userData);
      logger.info('User logged in successfully', { userId: userData.id, email: userData.email });
      router.push('/');
      return true;
    } catch (err) {
      const errorMessage = err instanceof Error ? err.message : 'Unknown error';
      logger.error('Login failed', { email, error: errorMessage });
      const axiosError = err as AxiosError<AuthErrorResponse>;
      setError(axiosError.response?.data?.message || 'Error al iniciar sesión');
      return false;
    } finally {
      setIsLoading(false);
    }
  };

  const register = async (data: {
    fullName: string;
    email: string;
    password: string;
    tenantId: string;
    roleId?: string;
  }): Promise<boolean> => {
    setIsLoading(true);
    setError(null);
    try {
      await authService.register(data);
      return true;
    } catch (err) {
      const errorMessage = err instanceof Error ? err.message : 'Unknown error';
      logger.error('Registration failed', { error: errorMessage });
      const axiosError = err as AxiosError<AuthErrorResponse>;
      setError(axiosError.response?.data?.message || 'Error al registrar cuenta');
      return false;
    } finally {
      setIsLoading(false);
    }
  };

  const forgotPassword = async (email: string): Promise<boolean> => {
    setIsLoading(true);
    setError(null);
    try {
      await authService.forgotPassword(email);
      return true;
    } catch (err) {
      const errorMessage = err instanceof Error ? err.message : 'Unknown error';
      logger.error('Forgot password failed', { error: errorMessage });
      const axiosError = err as AxiosError<AuthErrorResponse>;
      setError(axiosError.response?.data?.message || 'Error al solicitar recuperación');
      return false;
    } finally {
      setIsLoading(false);
    }
  };

  const updateProfile = async (dto: UpdateProfileDto): Promise<UserResponseDto> => {
    setIsLoading(true);
    setError(null);
    try {
      const updatedUser = await UsersService.updateProfile(dto);
      setUser(updatedUser);
      cacheService.set('user:profile', updatedUser);
      logger.info('Profile updated successfully', { userId: updatedUser.id });
      return updatedUser;
    } catch (err) {
      const errorMessage = err instanceof Error ? err.message : 'Unknown error';
      logger.error('Update profile failed', { error: errorMessage });
      const axiosError = err as AxiosError<AuthErrorResponse>;
      const errorMsg = axiosError.response?.data?.message || errorMessage;
      setError(errorMsg);
      throw new Error(errorMsg);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <AuthContext.Provider
      value={{
        user,
        loading,
        isLoading,
        error,
        login,
        register,
        forgotPassword,
        logout,
        fetchProfile,
        updateProfile,
        clearError,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth(): AuthContextType {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
}
