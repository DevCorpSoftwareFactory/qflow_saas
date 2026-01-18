import api from '@/lib/api';
import { DashboardMetricsDto } from '@qflow/shared';
import { logger } from '@/services/logger.service';

export class DashboardService {
  private static instance: DashboardService;

  private constructor() {}

  public static getInstance(): DashboardService {
    if (!DashboardService.instance) {
      DashboardService.instance = new DashboardService();
    }
    return DashboardService.instance;
  }

  async getSummary(): Promise<DashboardMetricsDto> {
    logger.logApiRequest('GET', '/dashboard/summary');
    try {
      const { data } = await api.get<DashboardMetricsDto>('/dashboard/summary');
      logger.logApiResponse(200, '/dashboard/summary', data);
      return data;
    } catch (error) {
      logger.logApiError(0, '/dashboard/summary', error);
      throw error;
    }
  }
}

export const dashboardService = DashboardService.getInstance();
