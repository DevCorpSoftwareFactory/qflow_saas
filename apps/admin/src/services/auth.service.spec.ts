import { AuthService } from './auth.service';
import api from '../lib/api';

jest.mock('../lib/api', () => ({
    post: jest.fn(),
    get: jest.fn(),
    interceptors: {
        request: { use: jest.fn() },
        response: { use: jest.fn() },
    },
}));

describe('AuthService', () => {
    let authService: AuthService;

    beforeEach(() => {
        authService = AuthService.getInstance();
        jest.clearAllMocks();
        Storage.prototype.removeItem = jest.fn();
    });

    describe('login', () => {
        it('should call login api and return user data', async () => {
            const mockCredentials = { email: 'test@example.com', password: 'password' };
            const mockResponse = { user: { id: '1', email: 'test@example.com' }, accessToken: 'token' };
            (api.post as jest.Mock).mockResolvedValue({ data: mockResponse });

            const result = await authService.login(mockCredentials);

            expect(api.post).toHaveBeenCalledWith('/auth/login', mockCredentials);
            expect(result).toEqual(mockResponse);
        });
    });

    describe('logout', () => {
        it('should call logout api and remove tokens from local storage', async () => {
            (api.post as jest.Mock).mockResolvedValue({});

            await authService.logout();

            expect(api.post).toHaveBeenCalledWith('/auth/logout');
            expect(localStorage.removeItem).toHaveBeenCalledWith('accessToken');
            expect(localStorage.removeItem).toHaveBeenCalledWith('refreshToken');
        });
    });
});
