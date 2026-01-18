import { IsString, IsOptional, IsUrl } from 'class-validator';
import { Transform } from 'class-transformer';

export class UpdateProfileDto {
    @IsOptional()
    @IsString()
    fullName?: string;

    @IsOptional()
    @IsString()
    phone?: string;

    @IsOptional()
    @Transform(({ value }) => value === '' ? null : value)
    @IsUrl()
    avatarUrl?: string;

    @IsOptional()
    @IsString()
    language?: string;

    @IsOptional()
    @IsString()
    timezone?: string;
}
