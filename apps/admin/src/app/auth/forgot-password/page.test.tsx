import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import ForgotPasswordPage from './page';
import { useAuth } from '@/hooks/use-auth';

// Mock the useAuth hook
jest.mock('@/hooks/use-auth', () => ({
    useAuth: jest.fn(),
}));

describe('ForgotPasswordPage', () => {
    const mockForgotPassword = jest.fn();

    beforeEach(() => {
        jest.clearAllMocks();
        (useAuth as jest.Mock).mockReturnValue({
            forgotPassword: mockForgotPassword,
            isLoading: false,
            error: null,
        });
    });

    it('renders input form correctly', () => {
        render(<ForgotPasswordPage />);

        expect(screen.getByText('Recuperar Contraseña')).toBeInTheDocument();
        expect(screen.getByLabelText('Correo Electrónico')).toBeInTheDocument();
        expect(screen.getByRole('button', { name: /enviar enlace/i })).toBeInTheDocument();
    });

    it('handles successful submission', async () => {
        render(<ForgotPasswordPage />);

        fireEvent.change(screen.getByLabelText('Correo Electrónico'), {
            target: { value: 'test@example.com' },
        });

        fireEvent.click(screen.getByRole('button', { name: /enviar enlace/i }));

        await waitFor(() => {
            expect(mockForgotPassword).toHaveBeenCalledWith('test@example.com');
        });

        expect(screen.getByText('¡Correo Enviado!')).toBeInTheDocument();
    });

    it('handles errors', async () => {
        (useAuth as jest.Mock).mockReturnValue({
            forgotPassword: mockForgotPassword,
            isLoading: false,
            error: 'Failed to send email',
        });

        render(<ForgotPasswordPage />);

        expect(screen.getByText('Failed to send email')).toBeInTheDocument();
    });
});
