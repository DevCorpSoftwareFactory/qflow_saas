import { UsersService } from './users.service';
import api from '@/lib/api';
import { ChangePasswordDto, UpdateProfileDto } from '@qflow/shared';

jest.mock('@/lib/api', () => ({
    get: jest.fn(),
    patch: jest.fn(),
    interceptors: {
        request: { use: jest.fn() },
        response: { use: jest.fn() },
    },
}));

describe('UsersService', () => {
    beforeEach(() => {
        jest.clearAllMocks();
    });

    describe('getProfile', () => {
        it('should fetch user profile successfully', async () => {
            const mockProfile = {
                id: '123',
                email: 'test@example.com',
                fullName: 'Test User',
                roles: [],
                permissions: [],
            };
            (api.get as jest.Mock).mockResolvedValue({ data: mockProfile });

            const result = await UsersService.getProfile();

            expect(api.get).toHaveBeenCalledWith('/users/profile');
            expect(result).toEqual(mockProfile);
        });

        it('should propagate errors from api', async () => {
            const error = new Error('Network Error');
            (api.get as jest.Mock).mockRejectedValue(error);

            await expect(UsersService.getProfile()).rejects.toThrow(error);
        });
    });

    describe('updateProfile', () => {
        it('should update user profile successfully', async () => {
            const dto: UpdateProfileDto = { fullName: 'Updated Name', language: 'es' };
            const mockResponse = {
                id: '123',
                email: 'test@example.com',
                fullName: 'Updated Name',
                language: 'es',
            };
            (api.patch as jest.Mock).mockResolvedValue({ data: mockResponse });

            const result = await UsersService.updateProfile(dto);

            expect(api.patch).toHaveBeenCalledWith('/users/profile', dto);
            expect(result).toEqual(mockResponse);
        });
    });

    describe('changePassword', () => {
        it('should change password successfully', async () => {
            const dto: ChangePasswordDto = {
                currentPassword: 'oldPass',
                newPassword: 'newPass',
                confirmPassword: 'newPass',
            };
            const mockResponse = { success: true };
            (api.patch as jest.Mock).mockResolvedValue({ data: mockResponse });

            const result = await UsersService.changePassword(dto);

            expect(api.patch).toHaveBeenCalledWith('/users/change-password', dto);
            expect(result).toEqual(mockResponse);
        });
    });
});
