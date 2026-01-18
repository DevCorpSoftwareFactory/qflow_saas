import { IsString, IsNumber, IsOptional, IsDateString } from 'class-validator';

export class DocumentSequenceDto {
    @IsString()
    prefix!: string;

    @IsNumber()
    currentNumber!: number;

    @IsString()
    @IsOptional()
    resolutionText?: string;

    @IsDateString()
    @IsOptional()
    resolutionDate?: string;
}

export class UpdateDocumentsDto {
    @IsOptional()
    invoice?: DocumentSequenceDto;

    @IsOptional()
    posTicket?: DocumentSequenceDto;

    @IsOptional()
    creditNote?: DocumentSequenceDto;

    @IsOptional()
    debitNote?: DocumentSequenceDto;
}
