import { render, screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import ProfilePage from './page';
import { useAuth } from '@/hooks/use-auth';
import { toast } from 'sonner';
import { UsersService } from '@/services/users.service';

jest.mock('@/hooks/use-auth');
jest.mock('@/services/users.service');
jest.mock('sonner');
jest.mock('next/navigation', () => ({
    useRouter: () => ({
        push: jest.fn(),
        refresh: jest.fn(),
    }),
}));

describe('ProfilePage Integration', () => {
    const mockUser = {
        id: 'user-123',
        fullName: 'Test User',
        email: 'test@example.com',
        phone: '1234567890',
        avatarUrl: 'https://example.com/avatar.png',
        language: 'en',
        timezone: 'UTC',
        isActive: true,
        isBlocked: false,
        roleId: 'role-1',
        tenantId: 'tenant-1',
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString(),
    };

    const mockFetchProfile = jest.fn();
    const mockUpdateProfile = jest.fn();

    beforeEach(() => {
        jest.clearAllMocks();
        (useAuth as jest.Mock).mockReturnValue({
            fetchProfile: mockFetchProfile,
            updateProfile: mockUpdateProfile,
            user: mockUser,
        });
    });

    it('renders the profile form with user data', async () => {
        render(<ProfilePage />);

        await waitFor(() => {
            expect(screen.queryByText('Loading profile...')).not.toBeInTheDocument();
        });

        expect(screen.getByDisplayValue('Test User')).toBeInTheDocument();
        expect(screen.getByDisplayValue('1234567890')).toBeInTheDocument();
        expect(screen.getByDisplayValue('https://example.com/avatar.png')).toBeInTheDocument();
        expect(screen.getByDisplayValue('en')).toBeInTheDocument();
        expect(screen.getByDisplayValue('UTC')).toBeInTheDocument();
    });

    it('updates profile successfully', async () => {
        mockUpdateProfile.mockResolvedValue({ ...mockUser, fullName: 'Updated Name' });
        const user = userEvent.setup();

        render(<ProfilePage />);

        await waitFor(() => {
            expect(screen.queryByText('Loading profile...')).not.toBeInTheDocument();
        });

        const nameInput = screen.getByLabelText('Full Name');
        await user.clear(nameInput);
        await user.type(nameInput, 'Updated Name');

        const submitButton = screen.getByRole('button', { name: /update profile/i });
        await user.click(submitButton);

        await waitFor(() => {
            expect(mockUpdateProfile).toHaveBeenCalledWith(expect.objectContaining({
                fullName: 'Updated Name',
            }));
            expect(mockFetchProfile).toHaveBeenCalled();
            expect(toast.success).toHaveBeenCalledWith('Profile updated successfully');
        });
    });

    it('handles profile update error', async () => {
        mockUpdateProfile.mockRejectedValue(new Error('Update failed'));
        const user = userEvent.setup();

        render(<ProfilePage />);

        await waitFor(() => {
            expect(screen.queryByText('Loading profile...')).not.toBeInTheDocument();
        });

        const submitButton = screen.getByRole('button', { name: /update profile/i });
        await user.click(submitButton);

        await waitFor(() => {
            expect(mockUpdateProfile).toHaveBeenCalled();
            expect(toast.error).toHaveBeenCalledWith('Update failed');
        });
    });

    it('changes password successfully', async () => {
        (UsersService.changePassword as jest.Mock).mockResolvedValue({ success: true });
        const user = userEvent.setup();

        render(<ProfilePage />);

        await waitFor(() => {
            expect(screen.queryByText('Loading profile...')).not.toBeInTheDocument();
        });

        await user.type(screen.getByLabelText('Current Password'), 'oldpass');
        await user.type(screen.getByLabelText('New Password'), 'newpass123');
        await user.type(screen.getByLabelText('Confirm Password'), 'newpass123');

        const changePassButton = screen.getByRole('button', { name: /change password/i });
        await user.click(changePassButton);

        await waitFor(() => {
            expect(UsersService.changePassword).toHaveBeenCalledWith({
                currentPassword: 'oldpass',
                newPassword: 'newpass123',
                confirmPassword: 'newpass123',
            });
            expect(toast.success).toHaveBeenCalledWith('Password changed successfully');
        });
    });
});
