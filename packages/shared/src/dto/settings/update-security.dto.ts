import { IsNumber, IsOptional, Min, Max } from 'class-validator';

export class UpdateSecurityDto {
    @IsNumber()
    @IsOptional()
    @Min(5)
    @Max(240)
    sessionTimeoutMinutes?: number;

    @IsNumber()
    @IsOptional()
    @Min(8)
    @Max(32)
    minPasswordLength?: number;

    @IsNumber()
    @IsOptional()
    passwordExpiryDays?: number;

    @IsNumber()
    @IsOptional()
    maxLoginAttempts?: number;
}
