import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import LoginPage from './page';
import { useAuth } from '@/hooks/use-auth';

// Mock the useAuth hook
jest.mock('@/hooks/use-auth', () => ({
    useAuth: jest.fn(),
}));

// Mock useRouter
jest.mock('next/navigation', () => ({
    useRouter: () => ({
        push: jest.fn(),
    }),
}));

describe('LoginPage', () => {
    const mockLogin = jest.fn();

    beforeEach(() => {
        jest.clearAllMocks();
        (useAuth as jest.Mock).mockReturnValue({
            login: mockLogin,
            isLoading: false,
            error: null,
        });
    });

    it('renders login form correctly', () => {
        render(<LoginPage />);

        expect(screen.getByText('Bienvenido a QFlow Pro')).toBeInTheDocument();
        expect(screen.getByLabelText('Correo Electrónico')).toBeInTheDocument();
        expect(screen.getByLabelText('Contraseña')).toBeInTheDocument();
        expect(screen.getByRole('button', { name: /iniciar sesión/i })).toBeInTheDocument();
    });

    it('handles form submission successfully', async () => {
        render(<LoginPage />);

        fireEvent.change(screen.getByLabelText('Correo Electrónico'), {
            target: { value: 'test@example.com' },
        });
        fireEvent.change(screen.getByLabelText('Contraseña'), {
            target: { value: 'password123' },
        });

        fireEvent.click(screen.getByRole('button', { name: /iniciar sesión/i }));

        await waitFor(() => {
            expect(mockLogin).toHaveBeenCalledWith('test@example.com', 'password123');
        });
    });

    it('displays error message when login fails', () => {
        (useAuth as jest.Mock).mockReturnValue({
            login: mockLogin,
            isLoading: false,
            error: 'Invalid credentials',
        });

        render(<LoginPage />);

        expect(screen.getByText('Invalid credentials')).toBeInTheDocument();
    });

    it('disables button when loading', () => {
        (useAuth as jest.Mock).mockReturnValue({
            login: mockLogin,
            isLoading: true,
            error: null,
        });

        render(<LoginPage />);

        expect(screen.getByRole('button', { name: /iniciar sesión/i })).toBeDisabled();
    });
});
