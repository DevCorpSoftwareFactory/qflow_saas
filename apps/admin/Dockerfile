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

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY apps/admin/package.json ./apps/admin/
COPY packages/shared/package.json ./packages/shared/

RUN pnpm install --frozen-lockfile

# =============================================================================
# Stage 2: Build
# =============================================================================
FROM base AS builder
WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Build Admin app
RUN pnpm turbo run build --filter=admin...

# =============================================================================
# Stage 3: Runner
# =============================================================================
FROM node:18-alpine AS runner
WORKDIR /app

# Create non-root user
RUN addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 nextjs

# Copy Next.js build
COPY --from=builder --chown=nextjs:nodejs /app/apps/admin/package.json ./apps/admin/package.json
COPY --from=builder --chown=nextjs:nodejs /app/apps/admin/.next ./apps/admin/.next
COPY --from=builder --chown=nextjs:nodejs /app/apps/admin/public ./apps/admin/public
COPY --from=builder --chown=nextjs:nodejs /app/apps/admin/node_modules ./apps/admin/node_modules

# Copy shared packages
COPY --from=builder --chown=nextjs:nodejs /app/packages ./packages
COPY --from=builder --chown=nextjs:nodejs /app/package.json ./package.json

USER nextjs

EXPOSE 3001
ENV PORT=3001
ENV HOSTNAME="0.0.0.0"
ENV NODE_ENV=production

WORKDIR /app/apps/admin

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD wget --spider -q http://localhost:3001 || exit 1

CMD ["npm", "start"]
