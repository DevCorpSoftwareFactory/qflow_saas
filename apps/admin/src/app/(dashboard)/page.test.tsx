import { render, screen, waitFor } from '@testing-library/react';
import DashboardPage from './page';
import { dashboardService } from '@/services/dashboard.service';

// Mock the dashboard service
jest.mock('@/services/dashboard.service', () => ({
    dashboardService: {
        getSummary: jest.fn(),
    },
}));

// Mock Lucide icons to avoid render issues/complexity
jest.mock('lucide-react', () => ({
    Activity: () => <div data-testid="icon-activity" />,
    CreditCard: () => <div data-testid="icon-credit-card" />,
    DollarSign: () => <div data-testid="icon-dollar-sign" />,
    Users: () => <div data-testid="icon-users" />,
    ArrowUpRight: () => <div data-testid="icon-arrow-up" />,
    ArrowDownRight: () => <div data-testid="icon-arrow-down" />,
}));

describe('DashboardPage', () => {
    beforeEach(() => {
        jest.clearAllMocks();
    });

    it('renders loading state initially', () => {
        // Return a pending promise to keep it in loading state
        (dashboardService.getSummary as jest.Mock).mockReturnValue(new Promise(() => { }));
        render(<DashboardPage />);
        expect(screen.getByText('Cargando tablero...')).toBeInTheDocument();
    });

    it('renders metrics after loading', async () => {
        const mockMetrics = {
            totalRevenue: 5000,
            revenueGrowth: 15,
            salesCount: 120,
            salesGrowth: 8,
            averageTicket: 45,
            ticketGrowth: -2,
            activeSessions: 3,
            recentSales: [
                { id: '1', orderId: '1001', time: '5 mins ago', amount: 150.00 }
            ]
        };
        (dashboardService.getSummary as jest.Mock).mockResolvedValue(mockMetrics);

        render(<DashboardPage />);

        // Wait for data to load
        await waitFor(() => {
            expect(screen.queryByText('Cargando tablero...')).not.toBeInTheDocument();
        });

        expect(screen.getByText('Tablero Ejecutivo')).toBeInTheDocument();

        // Check key metrics
        expect(screen.getByText('$5,000.00')).toBeInTheDocument();
        expect(screen.getByText('+15%')).toBeInTheDocument();
        expect(screen.getByText('+120')).toBeInTheDocument();
        expect(screen.getByText('+2 cajeros activos desde hace 1h')).toBeInTheDocument(); // Static test content

        // Check recent sales
        expect(screen.getByText('Orden #1001')).toBeInTheDocument();
        expect(screen.getByText('+$150.00')).toBeInTheDocument();
    });
});
