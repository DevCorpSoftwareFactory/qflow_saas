# Deployment & Infrastructure Guide

## 1. CI/CD Pipeline (GitHub Actions)

The project includes a comprehensive CI pipeline defined in `.github/workflows/ci.yml`.

### Triggers
- **Push** to `main` or `develop`.
- **Pull Request** to `main` or `develop`.

### Jobs
1.  **Web & API CI (`web-ci`)**:
    - Runs on Ubuntu Latest.
    - Uses `pnpm` and `turbo`.
    - Steps:
        - Install Dependencies.
        - Build All Apps (API, Admin, Portal).
        - Lint All.
        - Run Unit Tests (`pnpm turbo run test`).

2.  **Mobile App CI (`mobile-ci`)**:
    - Runs on Ubuntu Latest.
    - Uses Flutter action.
    - Steps:
        - `flutter analyze`: Static analysis.
        - `flutter test`: Run widget/unit tests in `apps/pos`.

---

## 2. Staging Environment

We use Docker Compose to spin up a production-like replica of the system.

### Configuration
- **File**: `docker-compose.staging.yml`
- **Services**:
    - `api` (Port 8080) - Node.js NestJS Optimized Build
    - `admin` (Port 8081) - Next.js
    - `portal` (Port 8082) - Next.js
    - `postgres` (Internal Port 5432)
    - `redis` (Internal Port 6379)

### Usage
To start the staging environment:
```bash
docker-compose -f docker-compose.staging.yml up -d --build
```

To stop:
```bash
docker-compose -f docker-compose.staging.yml down
```

---

## 3. Monitoring Infrastructure

A complete monitoring stack is available (`Prometheus` + `Grafana`).

### Configuration
- **File**: `docker-compose.monitoring.yml`
- **Config**: `monitoring/` directory.

### Usage
**Prerequisite**: Staging environment must be running (to share the network).

Start monitoring:
```bash
docker-compose -f docker-compose.monitoring.yml up -d
```

### Accessing Dashboards
- **Grafana**: http://localhost:3003
    - **User**: `admin`
    - **Password**: `admin`
- **Prometheus**: http://localhost:9090

### Available Dashboards
- **QFlow System Health**: Service status, HTTP request rates, response latency, status codes, authentication requests.

### Configured Alerts
| Alert | Severity | Trigger |
|-------|----------|---------|
| InstanceDown | Critical | Service down > 1min |
| HighErrorRate | Warning | 5xx errors > 1/sec for 2min |
| DatabaseConnectionDown | Critical | PostgreSQL unreachable > 30s |
| APITargetDown | Critical | API service down > 1min |
| AuthenticationErrorsHigh | Warning | Auth failures > 0.5/sec for 2min |
| HighResponseLatency | Warning | p95 latency > 2s for 3min |

---

## 4. Rollback Procedures

### API Rollback
```bash
# Stop current deployment
docker-compose -f docker-compose.staging.yml stop api

# Pull previous image version
docker-compose -f docker-compose.staging.yml pull api

# Restart with previous version
docker-compose -f docker-compose.staging.yml up -d api
```

### Database Rollback
**Warning**: Database rollbacks require careful consideration.

1. Identify the migration to rollback:
```bash
pnpm --filter @qflow/database migration:show
```

2. Revert the last migration:
```bash
pnpm --filter @qflow/database migration:revert
```

### Full System Rollback
```bash
# Stop all services
docker-compose -f docker-compose.staging.yml down

# Restore from backup (if available)
# pg_restore -h localhost -U postgres -d qflow_pro_staging backup.dump

# Restart with previous images
docker-compose -f docker-compose.staging.yml up -d
```

---

## 5. Troubleshooting

### Service Health Checks

#### API Not Responding
```bash
# Check container status
docker-compose -f docker-compose.staging.yml ps

# View API logs
docker-compose -f docker-compose.staging.yml logs api --tail=100

# Restart API
docker-compose -f docker-compose.staging.yml restart api
```

#### Database Connection Issues
```bash
# Check PostgreSQL status
docker-compose -f docker-compose.staging.yml exec postgres pg_isready

# View PostgreSQL logs
docker-compose -f docker-compose.staging.yml logs postgres --tail=50

# Test connection manually
docker-compose -f docker-compose.staging.yml exec postgres psql -U postgres -c "SELECT 1"
```

#### Redis Connection Issues
```bash
# Check Redis status
docker-compose -f docker-compose.staging.yml exec redis redis-cli ping

# View Redis logs
docker-compose -f docker-compose.staging.yml logs redis --tail=50
```

### Monitoring Issues

#### Prometheus Not Scraping
```bash
# Check Prometheus targets
curl http://localhost:9090/api/v1/targets

# Verify API metrics endpoint
curl http://localhost:8080/metrics
```

#### Grafana Dashboard Empty
1. Verify Prometheus is running: http://localhost:9090
2. Check data source connection in Grafana: Settings → Data Sources → Prometheus
3. Verify time range is correct in dashboard

### Common Issues

| Problem | Possible Cause | Solution |
|---------|----------------|----------|
| API returns 500 | Database not ready | Wait for postgres healthcheck |
| No metrics in Prometheus | API metrics not enabled | Verify MetricsModule in app.module.ts |
| Grafana shows no data | Wrong time range | Adjust time picker to "Last 1 hour" |
| Container keeps restarting | Missing env vars | Check .env file and docker-compose |

---

## 6. Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `DB_USER` | PostgreSQL username | `postgres` |
| `DB_PASSWORD` | PostgreSQL password | `postgres` |
| `DB_NAME` | Database name | `qflow_pro_staging` |
| `JWT_SECRET` | JWT signing secret | `staging-secret` |
| `REDIS_HOST` | Redis hostname | `redis` |
| `REDIS_PORT` | Redis port | `6379` |
