import { IsInt, IsNotEmpty, IsUUID, Min } from 'class-validator';

export class CheckAvailabilityDto {
  @IsUUID()
  @IsNotEmpty()
  variantId: string;

  @IsUUID()
  @IsNotEmpty()
  branchId: string;

  @IsInt()
  @Min(1)
  quantity: number;
}
