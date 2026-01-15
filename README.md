# QFlow Pro

Sistema ERP SaaS Multi-Tenant para Negocios Alimentarios en Colombia.

## Stack Tecnológico

- **Backend**: Supabase (PostgreSQL 15+) + Edge Functions
- **Web Admin**: Next.js 14 + Tailwind CSS
- **Web Portal**: Next.js 14 + Tailwind CSS
- **App POS**: Flutter + Hive (offline-first)
- **Monorepo**: pnpm workspaces

## Estructura del Proyecto

```
qflow-pro/
├── apps/
│   ├── admin/           # Backoffice SaaS
│   ├── portal/          # Portal Empresarial
│   └── pos/             # Flutter POS
├── packages/
│   └── shared/          # Tipos y utilidades compartidas
└── supabase/            # DDL y migraciones
```

## Desarrollo Local

### Prerequisitos

- Docker y Docker Compose
- Node.js 18+
- pnpm 8+
- Flutter 3.x (para POS)

### Iniciar Base de Datos

```bash
# Levantar PostgreSQL + pgAdmin
docker compose up -d

# Verificar estado
docker compose ps

# Ver logs
docker compose logs -f postgres
```

### Conexiones

| Servicio   | URL                        | Credenciales          |
|------------|----------------------------|-----------------------|
| PostgreSQL | localhost:5432             | postgres / postgres   |
| pgAdmin    | http://localhost:5050      | admin@qflow.local / admin |

### Ejecutar DDL Manualmente

```bash
docker exec -i qflow-pro-postgres psql -U postgres -d qflow_pro < supabase/qflow_pro_ddl_complete.sql
```

## Migraciones (TypeORM)

Las migraciones se gestionan desde el paquete `packages/database`:

```bash
# Ver migraciones pendientes
pnpm run migration:show

# Ejecutar migraciones pendientes
pnpm run migration:run

# Revertir última migración
pnpm run migration:revert

# Crear nueva migración (vacía)
pnpm --filter @qflow/database typeorm migration:create ./src/migrations/NombreMigracion

# Generar migración desde cambios de entidades
pnpm --filter @qflow/database migration:generate ./src/migrations/NombreMigracion
```

> **Nota**: El DDL inicial se ejecutó directamente. Las migraciones TypeORM son para cambios incrementales futuros.

## Comandos Útiles

```bash
# Detener contenedores
docker compose down

# Detener y eliminar volúmenes (¡borra datos!)
docker compose down -v

# Ver tablas creadas
docker exec qflow-pro-postgres psql -U postgres -d qflow_pro -c "\dt"

# Conectar a la base de datos
docker exec -it qflow-pro-postgres psql -U postgres -d qflow_pro
```

## Licencia

Privado - Todos los derechos reservados.
