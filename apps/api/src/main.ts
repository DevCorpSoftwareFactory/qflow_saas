import { NestFactory } from '@nestjs/core';
import { ValidationPipe, VersioningType } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import helmet from 'helmet';
import { AppModule } from './app.module';
import { API_PREFIX, APP_NAME, APP_DESCRIPTION } from './constants';
import { AllExceptionsFilter } from './common/filters/all-exceptions.filter';
import { Logger } from 'nestjs-pino';

async function bootstrap() {
  // Create NestJS application with buffer logs until Pino is ready
  const app = await NestFactory.create(AppModule, { bufferLogs: true });

  // Use Pino as the system logger
  const logger = app.get(Logger);
  app.useLogger(logger);

  // Security Headers (Helmet)
  app.use(helmet());

  // Global Exception Filter (descriptive error messages)
  app.useGlobalFilters(new AllExceptionsFilter());

  // Get config service
  const configService = app.get(ConfigService);
  const port = configService.get<number>('app.port', 3000);
  const environment = configService.get<string>(
    'app.environment',
    'development',
  );

  // Global prefix
  app.setGlobalPrefix(API_PREFIX);

  // API Versioning
  app.enableVersioning({
    type: VersioningType.URI,
    defaultVersion: '1',
  });

  // Global validation pipe
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true,
      transform: true,
      transformOptions: {
        enableImplicitConversion: true,
      },
    }),
  );

  // CORS Configuration
  const corsOrigins = configService.get<string[]>('app.cors.origins', [
    'http://localhost:3000',
  ]);
  app.enableCors({
    origin: corsOrigins,
    credentials: true,
    methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],
    allowedHeaders: [
      'Content-Type',
      'Authorization',
      'X-Tenant-ID',
      'X-Request-ID',
    ],
  });

  // Swagger Documentation
  const swaggerEnabled = configService.get<boolean>(
    'app.swagger.enabled',
    true,
  );
  if (swaggerEnabled && environment !== 'production') {
    const swaggerConfig = new DocumentBuilder()
      .setTitle(configService.get<string>('app.swagger.title', APP_NAME))
      .setDescription(
        configService.get<string>('app.swagger.description', APP_DESCRIPTION),
      )
      .setVersion(configService.get<string>('app.swagger.version', '1.0.0'))
      .addBearerAuth(
        {
          type: 'http',
          scheme: 'bearer',
          bearerFormat: 'JWT',
          name: 'Authorization',
          description: 'Enter JWT token',
          in: 'header',
        },
        'JWT-auth',
      )
      .addApiKey(
        {
          type: 'apiKey',
          name: 'X-Tenant-ID',
          in: 'header',
          description: 'Tenant ID for multi-tenant operations',
        },
        'tenant-id',
      )
      .addTag('Auth', 'Authentication and authorization endpoints')
      .addTag('Users', 'User management endpoints')
      .addTag('Products', 'Product catalog endpoints')
      .addTag('Inventory', 'Inventory management endpoints')
      .addTag('Sales', 'Sales and POS endpoints')
      .addTag('Cash Sessions', 'Cash session management endpoints')
      .addTag('Reports', 'Reporting and analytics endpoints')
      .build();

    const document = SwaggerModule.createDocument(app, swaggerConfig);
    const swaggerPath = configService.get<string>('app.swagger.path', 'docs');
    SwaggerModule.setup(swaggerPath, app, document, {
      swaggerOptions: {
        persistAuthorization: true,
        docExpansion: 'none',
        filter: true,
        showRequestDuration: true,
      },
    });

    logger.log(
      `📚 Swagger documentation available at: http://localhost:${port}/${swaggerPath}`,
    );
  }

  // Graceful shutdown
  const signals: NodeJS.Signals[] = ['SIGTERM', 'SIGINT'];
  signals.forEach((signal) => {
    process.on(signal, async () => {
      logger.log(`Received ${signal}, starting graceful shutdown...`);
      await app.close();
      logger.log('Application closed successfully');
      process.exit(0);
    });
  });

  // Start server
  await app.listen(port);

  logger.log(
    `🚀 ${APP_NAME} is running on: http://localhost:${port}/${API_PREFIX}`,
  );
  logger.log(`📍 Environment: ${environment}`);
}

bootstrap().catch((error) => {
  console.error('Failed to start application:', error);
  process.exit(1);
});
