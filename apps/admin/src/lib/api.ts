import axios from 'axios';
import { logger } from '@/services/logger.service';
import { cacheService } from '@/services/cache.service';

const api = axios.create({
  baseURL: process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3001',
  headers: {
    'Content-Type': 'application/json',
  },
  withCredentials: true,
});

api.interceptors.request.use((config) => {
  const token = typeof window !== 'undefined' ? localStorage.getItem('accessToken') : null;
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }

  const existingRequestId = config.headers['x-request-id'] as string;
  const requestId = existingRequestId || `req_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
  config.headers['x-request-id'] = requestId;

  logger.logApiRequest(config.method?.toUpperCase() || 'UNKNOWN', config.url || 'UNKNOWN', config.data, requestId);

  return config;
});

api.interceptors.response.use(
  (response) => {
    const requestId = response.config.headers['x-request-id'] as string;

    logger.logApiResponse(response.status, response.config.url || 'UNKNOWN', response.data, requestId);

    return response;
  },
  async (error) => {
    const status = error.response?.status;
    const url = error.config?.url;
    const requestId = error.config?.headers?.['x-request-id'] as string;

    logger.logApiError(status || 0, url || 'UNKNOWN', error, requestId);

    if (status === 401) {
      if (typeof window !== 'undefined') {
        localStorage.removeItem('accessToken');
        localStorage.removeItem('refreshToken');
        cacheService.remove('user:profile');
        window.location.href = '/auth/login';
      }
    }
    return Promise.reject(error);
  },
);

export default api;
