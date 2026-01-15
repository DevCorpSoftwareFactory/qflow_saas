FROM node:18-alpine AS base

# Setup pnpm
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN npm install -g pnpm@9.15.4

# =============================================================================
# Stage 1: Install dependencies
# =============================================================================
FROM base AS deps
WORKDIR /app

# Copy package files for dependency installation
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY apps/api/package.json ./apps/api/
COPY packages/database/package.json ./packages/database/
COPY packages/shared/package.json ./packages/shared/

RUN pnpm install --frozen-lockfile

# =============================================================================
# Stage 2: Build
# =============================================================================
FROM base AS builder
WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Build API and its dependencies
RUN pnpm turbo run build --filter=api...

# =============================================================================
# Stage 3: Production dependencies only
# =============================================================================
FROM base AS prod-deps
WORKDIR /app

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY apps/api/package.json ./apps/api/
COPY packages/database/package.json ./packages/database/
COPY packages/shared/package.json ./packages/shared/

# Install production dependencies only
RUN pnpm install --frozen-lockfile --prod

# =============================================================================
# Stage 4: Runner
# =============================================================================
FROM node:18-alpine AS runner
WORKDIR /app

# Create non-root user
RUN addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 nestjs

# Copy production dependencies
COPY --from=prod-deps --chown=nestjs:nodejs /app/node_modules ./node_modules

# Copy built artifacts
COPY --from=builder --chown=nestjs:nodejs /app/apps/api/dist ./apps/api/dist
COPY --from=builder --chown=nestjs:nodejs /app/packages/database/dist ./packages/database/dist
COPY --from=builder --chown=nestjs:nodejs /app/packages/shared/dist ./packages/shared/dist

# Copy package.json for runtime
COPY --from=builder --chown=nestjs:nodejs /app/package.json ./package.json
COPY --from=builder --chown=nestjs:nodejs /app/apps/api/package.json ./apps/api/package.json

USER nestjs
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD wget --spider -q http://localhost:3000/health || exit 1

CMD ["node", "apps/api/dist/main"]
