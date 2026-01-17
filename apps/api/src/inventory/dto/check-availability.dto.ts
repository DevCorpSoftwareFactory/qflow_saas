import { IsInt, IsNotEmpty, IsNumber, IsUUID, Min } from 'class-validator';

export class CheckAvailabilityDto {
  @IsUUID()
  @IsNotEmpty()
  variantId: string;

  @IsUUID()
  @IsNotEmpty()
  branchId: string;

  @IsNumber()
  @Min(0.0001)
  quantity: number;
}
