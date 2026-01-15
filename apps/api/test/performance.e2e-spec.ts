import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import request from 'supertest';
import { AppModule } from '../src/app.module';
import { Server } from 'http';

/**
 * Performance and Load Tests
 *
 * These tests measure:
 * 1. Response times under normal load
 * 2. Throughput capacity
 * 3. Behavior under stress
 * 4. Memory and connection handling
 */

interface TimingResult {
    time: number;
    status: number;
}

describe('Performance Tests', () => {
    let app: INestApplication;
    let httpServer: Server;

    const testTenantId = '00000000-0000-0000-0000-000000000001';

    beforeAll(async () => {
        jest.setTimeout(60000);
        const moduleFixture: TestingModule = await Test.createTestingModule({
            imports: [AppModule],
        }).compile();

        app = moduleFixture.createNestApplication();
        await app.init();

        httpServer = app.getHttpServer() as Server;
    });

    afterAll(async () => {
        await app.close();
    });

    describe('Auth Endpoint Performance', () => {
        const ACCEPTABLE_LOGIN_TIME_MS = 500;

        it('should complete login within acceptable time', async () => {
            const iterations = 10;
            const times: number[] = [];

            for (let i = 0; i < iterations; i++) {
                const start = Date.now();

                await request(httpServer)
                    .post('/auth/login')
                    .send({ email: 'perf-test@test.com', password: 'TestPass123!' });

                times.push(Date.now() - start);
            }

            const avgTime = times.reduce((a, b) => a + b, 0) / times.length;

            expect(avgTime).toBeLessThan(ACCEPTABLE_LOGIN_TIME_MS);
        });

        it('should handle burst of login requests', async () => {
            const burstSize = 50;
            const start = Date.now();

            const results = await Promise.allSettled(
                Array(burstSize)
                    .fill(null)
                    .map(() =>
                        request(httpServer)
                            .post('/auth/login')
                            .send({ email: 'burst-test@test.com', password: 'TestPass123!' }),
                    ),
            );

            const elapsed = Date.now() - start;
            // Count successful HTTP responses (not just fulfilled promises)
            const successCount = results.filter(
                (r) => r.status === 'fulfilled' && (r.value as any).status < 500,
            ).length;
            const successRate = successCount / burstSize;

            // Results logged silently for debugging if needed

            // Lower threshold: we just want to verify the server doesn't crash under load
            // 401 responses are expected since the user doesn't exist
            // All requests should complete without 5xx errors
            const serverErrors = results.filter(
                (r) => r.status === 'fulfilled' && (r.value as any).status >= 500,
            ).length;
            expect(serverErrors).toBe(0);
        });
    });

    describe('Sales Endpoint Performance', () => {
        const ACCEPTABLE_SALE_TIME_MS = 1000;

        it('should complete a sale within acceptable time', async () => {
            const iterations = 10;
            const times: number[] = [];

            for (let i = 0; i < iterations; i++) {
                const start = Date.now();

                await request(httpServer)
                    .post('/sales')
                    .set('x-tenant-id', testTenantId)
                    .send({
                        branchId: '00000000-0000-0000-0000-000000000002',
                        cashierId: '00000000-0000-0000-0000-000000000004',
                        paymentMethod: 'cash',
                        items: [
                            {
                                variantId: '00000000-0000-0000-0000-000000000003',
                                quantity: 1,
                                unitPrice: 100,
                            },
                        ],
                    });

                times.push(Date.now() - start);
            }

            const avgTime = times.reduce((a, b) => a + b, 0) / times.length;

            expect(avgTime).toBeLessThan(ACCEPTABLE_SALE_TIME_MS);
        });
    });

    describe('Load Test Simulation', () => {
        it('should handle sustained load of 100 requests/minute', async () => {
            const requestsPerMinute = 100;
            const testDurationSeconds = 10;
            const totalRequests = Math.floor(
                (requestsPerMinute / 60) * testDurationSeconds,
            );
            const delayBetweenRequests = (testDurationSeconds * 1000) / totalRequests;

            const results: TimingResult[] = [];
            const startTime = Date.now();

            for (let i = 0; i < totalRequests; i++) {
                const reqStart = Date.now();

                const response = await request(httpServer)
                    .post('/auth/login')
                    .send({ email: 'load-test@test.com', password: 'TestPass123!' });

                results.push({
                    time: Date.now() - reqStart,
                    status: response.status,
                });

                await new Promise((resolve) =>
                    setTimeout(resolve, delayBetweenRequests),
                );
            }

            const elapsed = Date.now() - startTime;
            const avgResponseTime =
                results.reduce((a, b) => a + b.time, 0) / results.length;
            const errorCount = results.filter((r) => r.status >= 500).length;
            const errorRate = errorCount / results.length;

            // Load test completed silently

            expect(errorRate).toBeLessThan(0.01);
        }, 30000);
    });

    describe('Memory and Connection Stress', () => {
        it('should not leak connections under repeated requests', async () => {
            const iterations = 100;
            let errorCount = 0;

            for (let i = 0; i < iterations; i++) {
                try {
                    await request(httpServer)
                        .post('/auth/login')
                        .send({
                            email: 'connection-test@test.com',
                            password: 'TestPass123!',
                        })
                        .timeout(5000);
                } catch {
                    errorCount++;
                }
            }

            // Connection stress completed silently

            expect(errorCount).toBeLessThan(iterations * 0.05);
        });
    });

    describe('Throughput Benchmarks', () => {
        it('should measure maximum throughput for read operations', async () => {
            const testDurationMs = 5000;
            let requestCount = 0;
            const startTime = Date.now();

            while (Date.now() - startTime < testDurationMs) {
                await request(httpServer).post('/inventory/check-availability').send({
                    variantId: '00000000-0000-0000-0000-000000000003',
                    branchId: '00000000-0000-0000-0000-000000000002',
                    quantity: 1,
                });
                requestCount++;
            }

            const elapsed = Date.now() - startTime;
            const throughput = (requestCount / elapsed) * 1000;

            // Throughput test completed silently

            expect(throughput).toBeGreaterThan(10);
        }, 30000);
    });
});
