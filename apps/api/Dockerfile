FROM node:18-alpine AS base

# Setup pnpm
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

FROM base AS builder
WORKDIR /app
# Copy full monorepo source (simplest approach for now)
COPY . .
RUN pnpm install --frozen-lockfile
# Build API and dependencies (database, shared)
RUN pnpm turbo run build --filter=api...

FROM base AS runner
WORKDIR /app

# create non-root user
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nestjs

# Copy built artifacts and node_modules from builder
# Note: For production, we should prune devDependencies but typically NestJS needs dependencies at runtime.
# Optimization: Copy from builder only what's needed.
COPY --from=builder --chown=nestjs:nodejs /app/node_modules ./node_modules
COPY --from=builder --chown=nestjs:nodejs /app/apps/api/dist ./apps/api/dist
COPY --from=builder --chown=nestjs:nodejs /app/packages ./packages
COPY --from=builder --chown=nestjs:nodejs /app/package.json ./package.json

USER nestjs
EXPOSE 3000

CMD ["node", "apps/api/dist/main"]
