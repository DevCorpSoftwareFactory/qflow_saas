import api from '@/lib/api';
import { AuthResponse } from '@/types/auth';
import { UserResponseDto } from '@qflow/shared';
import { logger } from '@/services/logger.service';

export interface LoginDto {
  email: string;
  password: string;
}

export interface RegisterDto {
  fullName: string;
  email: string;
  password: string;
  tenantId: string;
  roleId?: string;
}

export class AuthService {
  private static instance: AuthService;

  private constructor() {}

  public static getInstance(): AuthService {
    if (!AuthService.instance) {
      AuthService.instance = new AuthService();
    }
    return AuthService.instance;
  }

  async login(credentials: LoginDto): Promise<AuthResponse> {
    logger.logApiRequest('POST', '/auth/login', { email: credentials.email });
    try {
      const { data } = await api.post<AuthResponse>('/auth/login', credentials);
      logger.logApiResponse(200, '/auth/login', data);
      return data;
    } catch (error) {
      logger.logApiError(0, '/auth/login', error);
      throw error;
    }
  }

  async register(data: RegisterDto): Promise<void> {
    logger.logApiRequest('POST', '/auth/register', { email: data.email, fullName: data.fullName });
    try {
      await api.post('/auth/register', data);
      logger.logApiResponse(201, '/auth/register');
    } catch (error) {
      logger.logApiError(0, '/auth/register', error);
      throw error;
    }
  }

  async forgotPassword(email: string): Promise<void> {
    logger.logApiRequest('POST', '/auth/forgot-password', { email });
    try {
      await api.post('/auth/forgot-password', { email });
      logger.logApiResponse(200, '/auth/forgot-password');
    } catch (error) {
      logger.logApiError(0, '/auth/forgot-password', error);
      throw error;
    }
  }

  async getProfile(): Promise<UserResponseDto> {
    logger.logApiRequest('GET', '/users/profile');
    try {
      const { data } = await api.get<UserResponseDto>('/users/profile');
      logger.logApiResponse(200, '/users/profile', data);
      return data;
    } catch (error) {
      logger.logApiError(0, '/users/profile', error);
      throw error;
    }
  }

  async logout(): Promise<void> {
    try {
      await api.post('/auth/logout');
      logger.logApiResponse(200, '/auth/logout');
    } catch (error) {
      logger.logApiError(0, '/auth/logout', error);
    }
  }
}

export const authService = AuthService.getInstance();
