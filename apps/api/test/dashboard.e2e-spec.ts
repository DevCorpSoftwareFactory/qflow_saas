import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import { AppModule } from '../src/app.module';
import {
  getTestServer,
  createAuthorizedUser,
  LoginResponseBody,
} from './utils';
import { DashboardMetricsDto } from '@qflow/shared';

/**
 * Dashboard E2E Tests
 */
describe('Dashboard (e2e)', () => {
  let app: INestApplication;

  let accessToken: string;

  beforeAll(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    app.useGlobalPipes(
      new ValidationPipe({ whitelist: true, transform: true }),
    );
    await app.init();

    // Register and login to get tokens using the helper
    try {
      const auth = await createAuthorizedUser(app);
      accessToken = auth.token;
    } catch (error) {
      console.error('Failed to create authorized user:', error);
      throw error;
    }
  });

  afterAll(async () => {
    await app.close();
  });

  describe('GET /dashboard/summary', () => {
    it('should return 401 if not authenticated', async () => {
      return getTestServer(app).get('/dashboard/summary').expect(401);
    });

    it('should return dashboard metrics when authenticated', async () => {
      const response = await getTestServer(app)
        .get('/dashboard/summary')
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(200);

      const body = response.body as DashboardMetricsDto;

      // Verify structure matches DTO
      expect(body).toHaveProperty('totalRevenue');
      expect(body).toHaveProperty('revenueGrowth');
      expect(body).toHaveProperty('salesCount');
      expect(body).toHaveProperty('salesGrowth');
      expect(body).toHaveProperty('averageTicket');
      expect(body).toHaveProperty('ticketGrowth');
      expect(body).toHaveProperty('activeSessions');
      expect(body).toHaveProperty('recentSales');

      expect(Array.isArray(body.recentSales)).toBe(true);
    });
  });
});
