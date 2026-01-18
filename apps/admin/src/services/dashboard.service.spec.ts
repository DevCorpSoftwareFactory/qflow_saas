import { DashboardService } from './dashboard.service';
import api from '../lib/api';

jest.mock('../lib/api', () => ({
    get: jest.fn(),
    interceptors: {
        request: { use: jest.fn() },
        response: { use: jest.fn() },
    },
}));

describe('DashboardService', () => {
    let dashboardService: DashboardService;

    beforeEach(() => {
        dashboardService = DashboardService.getInstance();
        jest.clearAllMocks();
    });

    describe('getSummary', () => {
        it('should fetch dashboard metrics', async () => {
            const mockMetrics = {
                totalRevenue: 1000,
                revenueGrowth: 10,
                salesCount: 50,
                salesGrowth: 5,
                averageTicket: 20,
                ticketGrowth: 2,
                activeSessions: 1,
                recentSales: [],
            };
            (api.get as jest.Mock).mockResolvedValue({ data: mockMetrics });

            const result = await dashboardService.getSummary();

            expect(api.get).toHaveBeenCalledWith('/dashboard/summary');
            expect(result).toEqual(mockMetrics);
        });
    });
});
