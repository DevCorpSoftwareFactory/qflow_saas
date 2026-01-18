import axios from 'axios';
import { logger } from '@/services/logger.service';
import { cacheService } from '@/services/cache.service';
import { authService } from '@/services/auth.service';

const api = axios.create({
  baseURL: process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3001',
  headers: {
    'Content-Type': 'application/json',
  },
  withCredentials: true,
});

let isRefreshing = false;
let failedRequestsQueue: Array<{
  resolve: (token: string) => void;
  reject: (error: Error) => void;
}> = [];

const processQueue = (token: string | null, error: Error | null) => {
  failedRequestsQueue.forEach((prom) => {
    if (error) {
      prom.reject(error);
    } else {
      prom.resolve(token!);
    }
  });
  failedRequestsQueue = [];
};

api.interceptors.request.use((config) => {
  const token = typeof window !== 'undefined' ? localStorage.getItem('accessToken') : null;
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }

  const tenantId = typeof window !== 'undefined' ? localStorage.getItem('tenantId') : null;
  if (tenantId) {
    config.headers['x-tenant-id'] = tenantId;
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
    const originalRequest = error.config;
    const url = originalRequest?.url;
    const requestId = originalRequest?.headers?.['x-request-id'] as string;

    logger.logApiError(status || 0, url || 'UNKNOWN', error, requestId);

    if (status === 401 && !originalRequest._retry) {
      if (typeof window === 'undefined') {
        return Promise.reject(error);
      }

      originalRequest._retry = true;

      if (!isRefreshing) {
        isRefreshing = true;

        try {
          const refreshToken = localStorage.getItem('refreshToken');
          if (!refreshToken) {
            throw new Error('No refresh token available');
          }

          const response = await authService.refreshToken();
          const { accessToken, refreshToken: newRefreshToken } = response;

          localStorage.setItem('accessToken', accessToken);
          localStorage.setItem('refreshToken', newRefreshToken);

          api.defaults.headers.common['Authorization'] = `Bearer ${accessToken}`;
          processQueue(accessToken, null);
          isRefreshing = false;

          return api(originalRequest);
        } catch (refreshError) {
          isRefreshing = false;
          processQueue(null, refreshError as Error);

          localStorage.removeItem('accessToken');
          localStorage.removeItem('refreshToken');
          localStorage.removeItem('tenantId');
          cacheService.remove('user:profile');
          window.location.href = '/auth/login';

          return Promise.reject(refreshError);
        }
      }

      return new Promise((resolve, reject) => {
        failedRequestsQueue.push({
          resolve: (token: string) => {
            originalRequest.headers['Authorization'] = `Bearer ${token}`;
            resolve(api(originalRequest));
          },
          reject: (err: Error) => {
            reject(err);
          },
        });
      });
    }

    return Promise.reject(error);
  },
);

export default api;
