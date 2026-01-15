import {
  IsArray,
  IsInt,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
  IsUUID,
  Min,
  ValidateNested,
} from 'class-validator';
import { Type } from 'class-transformer';

export class SaleItemDto {
  @IsUUID()
  @IsNotEmpty()
  variantId: string;

  @IsUUID()
  @IsOptional()
  lotId?: string;

  @IsInt()
  @Min(1)
  quantity: number;

  @IsNumber()
  @Min(0)
  unitPrice: number;

  @IsNumber()
  @IsOptional()
  @Min(0)
  discountPercent?: number;
}

export class CreateSaleDto {
  @IsUUID()
  @IsNotEmpty()
  branchId: string;

  @IsUUID()
  @IsOptional()
  customerId?: string;

  @IsUUID()
  @IsNotEmpty()
  cashierId: string;

  @IsUUID()
  @IsOptional()
  cashSessionId?: string;

  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => SaleItemDto)
  items: SaleItemDto[];

  @IsString()
  @IsNotEmpty()
  paymentMethod: string; // 'cash' | 'card' | 'transfer' | etc.

  @IsNumber()
  @IsOptional()
  @Min(0)
  discountAmount?: number;
}
