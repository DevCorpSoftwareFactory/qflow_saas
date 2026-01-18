import { IsString, IsNotEmpty, IsOptional, IsEmail, IsUrl } from 'class-validator';

export class UpdateCompanyDto {
    /* Company Info */
    @IsString()
    @IsNotEmpty()
    name!: string;

    @IsString()
    @IsNotEmpty()
    nit!: string; // Tax ID

    @IsString()
    @IsOptional()
    address?: string;

    @IsString()
    @IsOptional()
    phone?: string;

    @IsEmail()
    @IsOptional()
    email?: string;

    @IsString()
    @IsOptional()
    website?: string;

    /* Branding (Module 45 / 57) */
    @IsUrl()
    @IsOptional()
    logoUrl?: string;

    @IsString()
    @IsOptional()
    primaryColor?: string;

    /* Regional (Module 25.1) */
    @IsString()
    @IsOptional()
    currency?: string; // Default COP

    @IsString()
    @IsOptional()
    timezone?: string; // Default America/Bogota

    @IsString()
    @IsOptional()
    dateFormat?: string;
}
