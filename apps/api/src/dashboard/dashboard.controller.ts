import {
  Controller,
  Get,
  UseGuards,
  Req,
  UnauthorizedException,
} from '@nestjs/common';
import { DashboardService } from './dashboard.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { DashboardMetricsDto } from '@qflow/shared';
import { AuthenticatedRequest } from '../common/types';

@Controller('dashboard')
@UseGuards(JwtAuthGuard)
export class DashboardController {
  constructor(private readonly dashboardService: DashboardService) {}

  /**
   * Get executive dashboard summary metrics.
   * Returns revenue, sales, and active session data for the current tenant.
   */
  @Get('summary')
  async getSummary(
    @Req() req: AuthenticatedRequest,
  ): Promise<DashboardMetricsDto> {
    const tenantId = req.user?.tenantId;
    if (!tenantId) {
      throw new UnauthorizedException('Tenant ID not found in user context');
    }
    return this.dashboardService.getSummary(tenantId);
  }
}
