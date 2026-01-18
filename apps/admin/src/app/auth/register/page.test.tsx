import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import RegisterPage from './page';
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

describe('RegisterPage', () => {
    const mockRegister = jest.fn();

    beforeEach(() => {
        jest.clearAllMocks();
        (useAuth as jest.Mock).mockReturnValue({
            register: mockRegister,
            isLoading: false,
            error: null,
        });
    });

    it('renders register form correctly', () => {
        render(<RegisterPage />);

        expect(screen.getByText('Crear una cuenta')).toBeInTheDocument();
        expect(screen.getByLabelText('Nombre')).toBeInTheDocument();
        expect(screen.getByLabelText('Apellido')).toBeInTheDocument();
        expect(screen.getByLabelText('Correo Electrónico')).toBeInTheDocument();
        expect(screen.getByLabelText('Contraseña')).toBeInTheDocument();
        expect(screen.getByLabelText('Confirmar Contraseña')).toBeInTheDocument();
    });

    it('validates password mismatch', async () => {
        render(<RegisterPage />);

        fireEvent.change(screen.getByLabelText('Contraseña'), {
            target: { value: 'password123' },
        });
        fireEvent.change(screen.getByLabelText('Confirmar Contraseña'), {
            target: { value: 'password456' },
        });

        fireEvent.click(screen.getByRole('button', { name: /registrarse/i }));

        await waitFor(() => {
            expect(screen.getByText('Las contraseñas no coinciden')).toBeInTheDocument();
        });
    });

    it('handles successful registration', async () => {
        render(<RegisterPage />);

        fireEvent.change(screen.getByLabelText('Nombre'), { target: { value: 'John' } });
        fireEvent.change(screen.getByLabelText('Apellido'), { target: { value: 'Doe' } });
        fireEvent.change(screen.getByLabelText('Correo Electrónico'), { target: { value: 'john@example.com' } });
        fireEvent.change(screen.getByLabelText('Contraseña'), { target: { value: 'password123' } });
        fireEvent.change(screen.getByLabelText('Confirmar Contraseña'), { target: { value: 'password123' } });

        fireEvent.click(screen.getByRole('button', { name: /registrarse/i }));

        await waitFor(() => {
            expect(mockRegister).toHaveBeenCalledWith(expect.objectContaining({
                fullName: 'John Doe',
                email: 'john@example.com',
                password: 'password123',
            }));
        });
    });
});
