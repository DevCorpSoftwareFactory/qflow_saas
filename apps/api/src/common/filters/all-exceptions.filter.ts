import {
    ExceptionFilter,
    Catch,
    ArgumentsHost,
    HttpException,
    HttpStatus,
    Logger,
} from '@nestjs/common';
import { Request, Response } from 'express';
import { QueryFailedError } from 'typeorm';

/**
 * Global Exception Filter
 * 
 * Catches all unhandled exceptions and returns a standardized error response.
 * Handles:
 * - HTTP exceptions (pass through with proper status)
 * - TypeORM/Database errors (500 with descriptive message)
 * - Unknown errors (500 with generic message)
 */
@Catch()
export class AllExceptionsFilter implements ExceptionFilter {
    private readonly logger = new Logger(AllExceptionsFilter.name);

    catch(exception: unknown, host: ArgumentsHost): void {
        const ctx = host.switchToHttp();
        const response = ctx.getResponse<Response>();
        const request = ctx.getRequest<Request>();

        let status = HttpStatus.INTERNAL_SERVER_ERROR;
        let message = 'Error interno del servidor';
        let error = 'Internal Server Error';

        // Handle known HTTP exceptions
        if (exception instanceof HttpException) {
            status = exception.getStatus();
            const exceptionResponse = exception.getResponse();

            if (typeof exceptionResponse === 'string') {
                message = exceptionResponse;
            } else if (typeof exceptionResponse === 'object' && exceptionResponse !== null) {
                const responseObj = exceptionResponse as Record<string, unknown>;
                const responseMessage = responseObj.message;
                if (Array.isArray(responseMessage)) {
                    message = responseMessage.join(', ');
                } else if (typeof responseMessage === 'string') {
                    message = responseMessage;
                }
                error = (responseObj.error as string) || error;
            }
        }
        // Handle TypeORM QueryFailedError
        else if (exception instanceof QueryFailedError) {
            const queryError = exception as QueryFailedError & { code?: string; detail?: string };

            this.logger.error(
                `Database Query Failed: ${queryError.message}`,
                queryError.stack,
            );

            // Check for specific PostgreSQL error codes
            switch (queryError.code) {
                case '42P01': // relation does not exist
                    message = 'Error de base de datos: una o más tablas no existen. Verifique que las migraciones estén aplicadas.';
                    error = 'Database Schema Error';
                    break;
                case '23505': // unique violation
                    message = 'El registro ya existe en la base de datos.';
                    error = 'Duplicate Entry';
                    status = HttpStatus.CONFLICT;
                    break;
                case '23503': // foreign key violation
                    message = 'Referencia a un registro que no existe.';
                    error = 'Foreign Key Violation';
                    status = HttpStatus.BAD_REQUEST;
                    break;
                case '42703': // undefined column
                    message = 'Error de esquema: columna no encontrada.';
                    error = 'Schema Error';
                    break;
                case '22P02': // invalid text representation (e.g., invalid UUID)
                    message = 'Formato de datos inválido.';
                    error = 'Invalid Data Format';
                    status = HttpStatus.BAD_REQUEST;
                    break;
                default:
                    message = 'Error de base de datos. Por favor, contacte al administrador.';
                    error = 'Database Error';
            }
        }
        // Handle generic errors
        else if (exception instanceof Error) {
            this.logger.error(
                `Unhandled Exception: ${exception.message}`,
                exception.stack,
            );

            // Check for common error patterns
            if (exception.message.includes("Cannot read properties of undefined")) {
                message = 'Error de procesamiento: datos incompletos o malformados.';
                error = 'Processing Error';
                status = HttpStatus.BAD_REQUEST;
            } else if (exception.message.includes("split")) {
                message = 'Error de formato: token o datos inválidos.';
                error = 'Format Error';
                status = HttpStatus.BAD_REQUEST;
            }
        }

        // Log the error details
        this.logger.error(
            `${request.method} ${request.url} - ${status} ${error}: ${typeof message === 'string' ? message : JSON.stringify(message)}`,
        );

        // Send standardized error response
        response.status(status).json({
            statusCode: status,
            error,
            message,
            timestamp: new Date().toISOString(),
            path: request.url,
        });
    }
}
