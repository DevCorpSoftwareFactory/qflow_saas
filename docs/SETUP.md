# Guía de Configuración para Desarrolladores - QFlow Pro

## Requisitos Previos

### Software Requerido
- **Node.js** >= 20.x
- **pnpm** >= 9.x (`npm install -g pnpm`)
- **Flutter** >= 3.38.x
- **Docker** y **Docker Compose**
- **Git**

### Credenciales Necesarias
- Acceso al repositorio Git
- Credenciales de Supabase (solicitar al Tech Lead)

---

## 1. Clonar el Repositorio

```bash
git clone <repo-url>
cd qflow-pro
```

---

## 2. Instalar Dependencias

### Backend y Web Apps (Node.js)
```bash
pnpm install
```

### POS Mobile (Flutter)
```bash
cd apps/pos
flutter pub get
dart run build_runner build --delete-conflicting-outputs
cd ../..
```

---

## 3. Configurar Variables de Entorno

```bash
cp .env.example .env
```

Editar `.env` con los valores proporcionados por el Tech Lead:
- `DB_HOST`, `DB_PORT`, `DB_USERNAME`, `DB_PASSWORD`, `DB_NAME`
- `SUPABASE_URL`, `SUPABASE_ANON_KEY`
- `JWT_SECRET`

---

## 4. Levantar Base de Datos Local

```bash
docker-compose up -d
```

Esto inicia:
- PostgreSQL en `localhost:5432`
- pgAdmin en `localhost:5050`

---

## 5. Ejecutar Migraciones

```bash
pnpm migration:run
```

---

## 6. Iniciar Aplicaciones

### API Backend (NestJS)
```bash
cd apps/api
pnpm start:dev
```
Disponible en: `http://localhost:3000`

### Admin Portal (Next.js)
```bash
pnpm dev:admin
```
Disponible en: `http://localhost:3001`

### B2B Portal (Next.js)
```bash
pnpm dev:portal
```
Disponible en: `http://localhost:3002`

### POS Mobile (Flutter)
```bash
cd apps/pos
flutter run
```

---

## 7. Estructura del Proyecto

```
qflow-pro/
├── apps/
│   ├── admin/        # Portal de administración (Next.js)
│   ├── api/          # Backend API (NestJS)
│   ├── portal/       # Portal B2B (Next.js)
│   └── pos/          # App móvil POS (Flutter)
├── packages/
│   └── database/     # Entidades TypeORM compartidas
├── supabase/         # DDL y configuración Supabase
├── docs/             # Documentación del proyecto
└── docker-compose.yml
```

---

## 8. Comandos Útiles

| Comando | Descripción |
|---------|-------------|
| `pnpm lint` | Ejecutar linter en todo el proyecto |
| `pnpm build` | Build de producción |
| `pnpm test` | Ejecutar tests |
| `pnpm migration:generate` | Generar nueva migración |

---

## 9. Recursos

- **Supabase Dashboard**: https://supabase.com/dashboard
- **Documentación TypeORM**: https://typeorm.io/
- **Documentación Drift (Flutter)**: https://drift.simonbinder.eu/

---

## 10. Contacto

Para dudas técnicas, contactar al Tech Lead o abrir un issue en el repositorio.
