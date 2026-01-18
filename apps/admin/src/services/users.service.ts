import { ChangePasswordDto, UpdateProfileDto, UserResponseDto } from '@qflow/shared';
import api from '@/lib/api';
import { logger } from '@/services/logger.service';

export const UsersService = {
  getProfile: async (): Promise<UserResponseDto> => {
    logger.logApiRequest('GET', '/users/profile');
    try {
      const response = await api.get<UserResponseDto>('/users/profile');
      logger.logApiResponse(200, '/users/profile', response.data);
      return response.data;
    } catch (error) {
      logger.logApiError(0, '/users/profile', error);
      throw error;
    }
  },

  updateProfile: async (dto: UpdateProfileDto): Promise<UserResponseDto> => {
    logger.logApiRequest('PATCH', '/users/profile', dto);
    try {
      const response = await api.patch<UserResponseDto>('/users/profile', dto);
      logger.logApiResponse(200, '/users/profile', response.data);
      return response.data;
    } catch (error) {
      logger.logApiError(0, '/users/profile', error);
      throw error;
    }
  },

  changePassword: async (dto: ChangePasswordDto): Promise<{ success: boolean }> => {
    logger.logApiRequest('PATCH', '/users/change-password', {
      hasCurrentPassword: true,
      hasNewPassword: true,
      hasConfirmPassword: true,
    });
    try {
      const response = await api.patch<{ success: boolean }>('/users/change-password', dto);
      logger.logApiResponse(200, '/users/change-password', response.data);
      return response.data;
    } catch (error) {
      logger.logApiError(0, '/users/change-password', error);
      throw error;
    }
  },
};
