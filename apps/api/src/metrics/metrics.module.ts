import { Module } from '@nestjs/common';
import {
  PrometheusModule,
  makeCounterProvider,
  makeHistogramProvider,
} from '@willsoto/nestjs-prometheus';

/**
 * MetricsModule configures Prometheus metrics for the API.
 * Exposes /metrics endpoint for Prometheus scraping.
 */
@Module({
  imports: [
    PrometheusModule.register({
      path: '/metrics',
      defaultMetrics: {
        enabled: true,
      },
    }),
  ],
  providers: [
    // HTTP request counter
    makeCounterProvider({
      name: 'http_requests_total',
      help: 'Total number of HTTP requests',
      labelNames: ['method', 'path', 'status'],
    }),
    // HTTP request duration histogram
    makeHistogramProvider({
      name: 'http_request_duration_seconds',
      help: 'HTTP request duration in seconds',
      labelNames: ['method', 'path', 'status'],
      buckets: [0.01, 0.05, 0.1, 0.5, 1, 2, 5],
    }),
    // Auth-specific counter for monitoring auth errors
    makeCounterProvider({
      name: 'auth_requests_total',
      help: 'Total authentication requests',
      labelNames: ['type', 'status'],
    }),
  ],
  exports: [PrometheusModule],
})
export class MetricsModule {}
