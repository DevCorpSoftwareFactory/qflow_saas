import { IsString, IsNumber, IsArray, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';

export class DashboardRecentSaleDto {
    @IsString()
    id!: string;

    @IsString()
    orderId!: string;

    @IsString()
    time!: string;

    @IsNumber()
    amount!: number;
}

export class DashboardMetricsDto {
    @IsNumber()
    totalRevenue!: number;

    @IsNumber()
    revenueGrowth!: number;

    @IsNumber()
    salesCount!: number;

    @IsNumber()
    salesGrowth!: number;

    @IsNumber()
    averageTicket!: number;

    @IsNumber()
    ticketGrowth!: number;

    @IsNumber()
    activeSessions!: number;

    @IsArray()
    @ValidateNested({ each: true })
    @Type(() => DashboardRecentSaleDto)
    recentSales!: DashboardRecentSaleDto[];
}
