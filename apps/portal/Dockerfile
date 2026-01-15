FROM node:18-alpine AS base

# Setup pnpm
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

FROM base AS builder
WORKDIR /app
COPY . .
RUN pnpm install --frozen-lockfile
# Build Portal
RUN pnpm turbo run build --filter=portal...

FROM base AS runner
WORKDIR /app

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder /app/apps/portal/package.json ./apps/portal/package.json
COPY --from=builder /app/apps/portal/.next ./apps/portal/.next
COPY --from=builder /app/apps/portal/public ./apps/portal/public
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/packages ./packages

USER nextjs
EXPOSE 3002
ENV PORT 3002
ENV HOSTNAME "0.0.0.0"

WORKDIR /app/apps/portal
CMD ["npm", "start"]
