import { IsArray, IsBoolean, IsOptional, IsNumber, IsString } from 'class-validator';

export class TaxRateDto {
    @IsString()
    name!: string; // e.g. "IVA 19%"

    @IsNumber()
    rate!: number; // e.g. 19.0
}

export class UpdateTaxesDto {
    @IsString()
    @IsOptional()
    taxRegime?: string; // e.g., "Responsable de IVA", "Régimen Simple"

    @IsArray()
    @IsOptional()
    configuredRates?: TaxRateDto[];

    @IsBoolean()
    @IsOptional()
    pricesIncludeTax?: boolean;
}
