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

### Setup
1. Login to Grafana.
2. Go to **Dashboards**.
3. Create new dashboard or import existing ones.
4. Prometheus data source is pre-configured.

---

## 4. Alerting
Prometheus is configured to scrape `/metrics` from the API.
Ensure `WEB_API` has `nestjs-prometheus` enabled (Task 1.4.5 requirements).
*Note: If metrics endpoint is missing, install `npm install @willsoto/nestjs-prometheus prom-client` in `apps/api`.*
