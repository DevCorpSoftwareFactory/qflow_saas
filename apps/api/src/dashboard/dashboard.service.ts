import { Injectable, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Between } from 'typeorm';
import { Sale, CashSession } from '@qflow/database';
import { DashboardMetricsDto } from '@qflow/shared';
import {
  startOfMonth,
  endOfMonth,
  subMonths,
  subDays,
  startOfWeek,
  endOfWeek,
  formatDistanceToNow,
} from 'date-fns';

// No global config needed for date-fns

@Injectable()
export class DashboardService {
  private readonly logger = new Logger(DashboardService.name);

  constructor(
    @InjectRepository(Sale)
    private readonly saleRepository: Repository<Sale>,
    @InjectRepository(CashSession)
    private readonly sessionRepository: Repository<CashSession>,
  ) {}

  async getSummary(tenantId: string): Promise<DashboardMetricsDto> {
    try {
      const now = new Date();

      // Month ranges
      const currentMonthStart = startOfMonth(now);
      const currentMonthEnd = endOfMonth(now);

      const prevMonthDate = subMonths(now, 1);
      const prevMonthStart = startOfMonth(prevMonthDate);
      const prevMonthEnd = endOfMonth(prevMonthDate);

      // Week ranges (Last 7 days vs Previous 7 days window)
      // Note: Keeping the "window" approach as per original code logic, not calendar week
      const currentWeekStart = subDays(now, 7);
      const prevWeekStart = subDays(now, 14);
      const prevWeekEnd = subDays(now, 7);

      // 1. Total Revenue (Current vs Previous Month)
      const currentMonthRevenue = await this.calculateRevenue(
        tenantId,
        currentMonthStart,
        currentMonthEnd,
      );
      const prevMonthRevenue = await this.calculateRevenue(
        tenantId,
        prevMonthStart,
        prevMonthEnd,
      );
      const revenueGrowth = this.calculateGrowth(
        currentMonthRevenue,
        prevMonthRevenue,
      );

      // 2. Sales Count (Last 7 Days vs Previous 7 Days)
      const currentWeekSales = await this.countSales(
        tenantId,
        currentWeekStart,
        now,
      );
      const prevWeekSales = await this.countSales(
        tenantId,
        prevWeekStart,
        prevWeekEnd,
      );
      const salesGrowth = this.calculateGrowth(currentWeekSales, prevWeekSales);

      // 3. Average Ticket (Current Month vs Previous Month)
      const currentMonthSalesCount = await this.countSales(
        tenantId,
        currentMonthStart,
        currentMonthEnd,
      );
      const prevMonthSalesCount = await this.countSales(
        tenantId,
        prevMonthStart,
        prevMonthEnd,
      );

      const currentAvgTicket =
        currentMonthSalesCount > 0
          ? Number(currentMonthRevenue) / currentMonthSalesCount
          : 0;
      const prevAvgTicket =
        prevMonthSalesCount > 0
          ? Number(prevMonthRevenue) / prevMonthSalesCount
          : 0;
      const ticketGrowth = this.calculateGrowth(
        currentAvgTicket,
        prevAvgTicket,
      );

      // 4. Active Cash Sessions
      const activeSessions = await this.sessionRepository.count({
        where: {
          tenantId,
          status: 'open',
        },
      });

      // 5. Recent Sales (Top 5)
      const recentSalesRaw = await this.saleRepository.find({
        where: {
          tenantId,
          status: 'completed',
        },
        order: {
          saleDate: 'DESC',
        },
        take: 5,
      });

      const recentSales = recentSalesRaw.map((sale) => ({
        id: sale.id,
        orderId: sale.saleNumber || 'N/A',
        time: formatDistanceToNow(new Date(sale.saleDate), { addSuffix: true }), // "5 minutes ago"
        amount: Number(sale.totalAmount),
      }));

      return {
        totalRevenue: Number(currentMonthRevenue),
        revenueGrowth,
        salesCount: currentWeekSales,
        salesGrowth,
        averageTicket: Number(currentAvgTicket.toFixed(2)),
        ticketGrowth,
        activeSessions,
        recentSales,
      };
    } catch (error: any) {
      this.logger.error(
        `Error calculating dashboard summary for tenant ${tenantId}: ${error.message}`,
        error.stack,
      );
      throw error;
    }
  }

  private async calculateRevenue(
    tenantId: string,
    start: Date,
    end: Date,
  ): Promise<number> {
    const result = await this.saleRepository
      .createQueryBuilder('sale')
      .select('SUM(sale.totalAmount)', 'total')
      .where('sale.tenantId = :tenantId', { tenantId })
      .andWhere('sale.saleDate BETWEEN :start AND :end', { start, end })
      .andWhere('sale.status = :status', { status: 'completed' })
      .getRawOne();

    return result && result.total ? parseFloat(result.total) : 0;
  }

  private async countSales(
    tenantId: string,
    start: Date,
    end: Date,
  ): Promise<number> {
    return this.saleRepository.count({
      where: {
        tenantId,
        saleDate: Between(start, end),
        status: 'completed',
      },
    });
  }

  private calculateGrowth(current: number, previous: number): number {
    if (previous === 0) return current > 0 ? 100 : 0;
    const growth = ((current - previous) / previous) * 100;
    return Number(growth.toFixed(1));
  }
}
