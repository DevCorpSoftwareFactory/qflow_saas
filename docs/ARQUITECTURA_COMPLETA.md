# QFLOW PRO - DISEÑO ARQUITECTÓNICO COMPLETO

## Sistema ERP SaaS Multi-Tenant para Negocios Alimentarios

**Versión del Documento**: 1.1  
**Fecha**: Enero 2026  
**Arquitecto**: Tech Lead Backend  
**Clasificación**: Confidencial - Uso Interno

---

## 1. VISIÓN GENERAL DE LA ARQUITECTURA

### 1.1 Contexto del Sistema

QFlow Pro es un ERP SaaS multi-tenant diseñado específicamente para negocios alimentarios en Colombia, con soporte offline-first mediante Flutter + Hive para operación en puntos de venta con conectividad intermitente. El sistema opera bajo un modelo de base de datos compartida con Row Level Security (RLS), garantizando aislamiento criptográfico absoluto entre tenants mediante PostgreSQL 15+.

La arquitectura se fundamenta en tres pilares no negociables que definen los límites de cada bounded context y las reglas de comunicación entre dominios. Estos pilares no son sugerencias ni guías de estilo, sino constraints arquitectónicos verificados mediante RLS en base de datos, pruebas de integración automatizadas y revisión de código obligatoria.

**Primer pilar: Aislamiento de datos por tenant mediante RLS**. Cada tenant (empresa cliente) opera en un espacio de datos completamente aislado. El tenant_id es el selector primario de todas las queries, verificado automáticamente por políticas RLS a nivel de motor de base de datos. Incluso si un atacante o bug intenta acceder a datos de otro tenant, la query retorna cero filas sin posibilidad de bypass.

**Segundo pilar: Trazabilidad completa de inventario mediante lotes FIFO**. El stock nunca se almacena como número único en la tabla products. Cada unidad en inventario pertenece a un lote específico con fecha de vencimiento, precio de compra y proveedor documentados. La salida de inventario sigue estrictamente FIFO (First In, First Out), y el kardex (inventory_movements) es append-only, sin UPDATE ni DELETE, garantizando trazabilidad inmutable para auditorías y regulaciones de trazabilidad alimentaria.

**Tercer pilar: Consistencia contable mediante partida doble automatizada**. Cada transacción financiera genera automáticamente los asientos contables correspondientes según el PUC colombiano y normativa NIIF PYMES. La validación de partida doble (sum(débitos) = sum(créditos)) se ejecuta mediante triggers PostgreSQL, garantizando que ninguna transacción puede dejar la contabilidad en estado inconsistente.

### 1.2 Arquitectura de Referencia

El sistema implementa una arquitectura hexagonal adaptada (Puertos y Adaptadores) con NestJS como framework de integración. La comunicación entre capas sigue el flujo unidireccional: Controladores → Servicios de Aplicación → Servicios de Dominio → Repositories → Base de Datos. Cada capa conoce únicamente a la capa inmediata inferior, garantizando inversibilidad de dependencias y facilitando testing mediante mocks.

La estrategia de multi-tenancy emplea RLS como control primario, complementado por tenant context propagation a nivel de sesión PostgreSQL. Esta combinación garantiza que ninguna query, incluso maliciosa intencionalmente, pueda acceder a datos de otro tenant. El tenant context se establece mediante la función `utilities.current_tenant_id()` que lee de la configuración de sesión `app.current_tenant_id`, setteada por el middleware de autenticación.

### 1.3 Principios de Diseño

**Single Responsibility aplicado a dominios**: Cada bounded context es autocontenido, con entidades propias, reglas de negocio específicas y persistencia independiente. Los dominios no comparten tablas; cuando existe relación, esta se gestiona mediante identificadores externos y consultas explícitas, nunca mediante foreign keys que crucen límites de tenant.

**Inmutabilidad del kardex**: La tabla `inventory_movements` es append-only. No existe operación UPDATE ni DELETE sobre movimientos de inventario. Cualquier corrección requiere un movimiento de ajuste nuevo con tipo `adjustment` y justificación documentada en campo notes. Esto garantiza trazabilidad completa para auditorías y regulaciones de trazabilidad alimentaria.

**Offline-first mediante UUIDs**: El modelo de datos está diseñado para operación desconectada. Todas las entidades transaccionales usan UUID como primary key, generado localmente en el cliente Flutter antes de sincronizar con el servidor. Esto elimina colisiones de IDs y permite merge determinístico cuando múltiples dispositivos offline crean registros simultáneamente.

**Contratismo primero (Contract-First)**: La API REST se diseña mediante especificación OpenAPI antes de escribir código. Los DTOs se generan automáticamente desde el contrato, garantizando que la documentación siempre está sincronizada con la implementación.

---

## 2. ESTRUCTURA DEL MONOREPO

### 2.1 Organización de Workspaces

El monorepo utiliza pnpm workspaces como gestor de paquetes, permitiendo compartir código entre aplicaciones mientras mantiene límites claros de dependencia. Esta estructura soporta escalamiento del equipo: múltiples desarrolladores pueden trabajar en dominios diferentes sin conflictos de merge, y los pipelines de CI/CD pueden compilar y testar solo los paquetes afectados por un cambio.

```
/home/devin/Projects/qflow-pro/
├── apps/                              # Aplicaciones ejecutables
│   ├── api/                           # NestJS REST API principal
│   │   ├── src/
│   │   │   ├── auth/                  # Módulo de autenticación y autorización
│   │   │   ├── tenants/               # Gestión de tenants (Admin SaaS)
│   │   │   ├── licensing/             # Gestión de licencias SaaS
│   │   │   ├── billing/               # Facturación SaaS
│   │   │   ├── catalog/               # Catálogo de productos y precios
│   │   │   ├── inventory/             # Inventario y lotes (FIFO)
│   │   │   ├── sales/                 # Ventas y POS
│   │   │   ├── orders/                # Pedidos del portal web
│   │   │   ├── purchases/             # Órdenes de compra y proveedores
│   │   │   ├── cash/                  # Control de caja y cuadre ciego
│   │   │   ├── accounting/            # Contabilidad automatizada NIIF
│   │   │   ├── credits/               # Créditos y cartera de clientes
│   │   │   ├── hr/                    # Recursos humanos y nómina
│   │   │   ├── reports/               # Reportes y dashboards ejecutivos
│   │   │   ├── integrations/          # Hardware y servicios externos
│   │   │   ├── common/                # Guards, interceptors, filters compartidos
│   │   │   └── config/                # Configuración de aplicación
│   │   └── test/                      # Tests E2E
│   │
│   ├── admin/                         # Panel Admin QFlow Pro (Next.js 14)
│   │   ├── src/
│   │   │   ├── app/                   # Páginas y layouts
│   │   │   ├── components/            # Componentes UI reutilizables
│   │   │   ├── lib/                   # Utilidades y clientes API
│   │   │   └── styles/                # Estilos globales
│   │   └── public/                    # Assets estáticos
│   │
│   └── portal/                        # Portal empresarial (Next.js 14)
│       ├── src/
│       │   ├── app/                   # Páginas y layouts
│       │   ├── components/            # Componentes UI reutilizables
│       │   ├── lib/                   # Utilidades y clientes API
│       │   └── styles/                # Estilos globales
│       └── public/                    # Assets estáticos
│
├── packages/                          # Paquetes compartidos
│   ├── shared/                        # Código compartido entre apps
│   │   ├── constants/                 # Constantes globales
│   │   ├── types/                     # TypeScript types globales
│   │   ├── interfaces/                # Interfaces compartidas
│   │   ├── enums/                     # Enums compartidos
│   │   ├── exceptions/                # Excepciones personalizadas
│   │   ├── utils/                     # Utilidades puras
│   │   └── decorators/                # Decoradores compartidos
│   │
│   ├── typeorm-client/                # Cliente TypeORM generado
│   │   ├── entities/                  # Entity definitions
│   │   ├── repositories/              # Repository implementations
│   │   ├── datasource.ts              # TypeORM DataSource
│   │   └── index.ts                   # Exports
│   │
│   ├── api-contracts/                 # Contratos OpenAPI
│   │   ├── schemas/                   # Esquemas JSON Schema
│   │   ├── dto/                       # DTOs base
│   │   └── openapi.yaml               # Especificación OpenAPI completa
│   │
│   └── testing/                       # Utilidades de testing
│       ├── fixtures/
│       ├── mocks/
│       └── test-helpers.ts
│
├── supabase/                          # Configuración Supabase
│   ├── init.sql                       # DDL completo (fuente de verdad)
│   ├── migrations/                    # Migraciones incrementales
│   └── seed/                          # Datos iniciales
│
├── docs/                              # Documentación arquitectónica
├── scripts/                           # Scripts de utilidad
├── pnpm-workspace.yaml                # Configuración pnpm
└── package.json                       # Scripts globales
```

### 2.2 Reglas de Dependencia entre Paquetes

El monorepo implementa un grafo de dependencias estricto que previene acoplamiento accidental. Cada paquete tiene una lista explícita de qué otros paquetes puede importar, verificada mediante ESLint rules personalizadas durante el proceso de CI/CD.

**apps/api** puede importar únicamente los siguientes paquetes:
- `packages/shared/**` (constantes, tipos, utilidades puras)
- `packages/typeorm-client` (entidades y DataSource tipados)
- `packages/api-contracts` (esquemas y DTOs base)

**packages/shared** es completamente autónomo y no puede importar nada de apps ni de otros packages. Contiene únicamente código que no depende de ninguna implementación específica, frameworks ni librerías con efectos secundarios. Es el único paquete que puede ser importado por cualquier otro sin crear ciclos de dependencia.

**packages/typeorm-client** puede importar únicamente `packages/shared/types` y `packages/shared/enums` para definición de tipos derivados de las entidades TypeORM. No contiene lógica de negocio, solo acceso tipado a la base de datos mediante EntityManager y Repositories.

**packages/api-contracts** es completamente autónomo, define únicamente estructuras de datos (esquemas JSON Schema, DTOs base) sin lógica ni dependencias. Se genera automáticamente desde la especificación OpenAPI.

**Dominios NO cruzan**: El módulo `sales` nunca importa `accounting`, `inventory` nunca importa `purchases`. Esta regla es absoluta y se verifica mediante análisis estático. La comunicación cross-domain se realiza exclusivamente mediante eventos asíncronos (Message Queue) o servicios de aplicación que orquestan flujos sin crear dependencias circulares.

### 2.3 packages/shared: Contenido Exacto

El paquete shared contiene exclusivamente código que no depende de ninguna implementación específica, frameworks ni librerías con efectos secundarios. Su propósito es proporcionar tipos, constantes y utilidades que pueden ser compartidas entre backend (NestJS), frontend (Next.js) y móvil (Flutter).

```
packages/shared/
├── constants/
│   ├── http-status.constants.ts      # Códigos HTTP como constantes
│   ├── date-format.constants.ts      # Formatos de fecha estándar
│   └── currency.constants.ts         # Códigos de moneda ISO
├── types/
│   ├── tenant.types.ts               # Tipos relacionados con tenants
│   ├── user.types.ts                 # Tipos de usuario y roles
│   ├── pagination.types.ts           # Tipos de paginación genérica
│   └── common.types.ts               # Tipos comunes reutilizables
├── interfaces/
│   ├── entity.interface.ts           # Interface base para entidades
│   ├── repository.interface.ts       # Interface genérica de repository
│   └── service.interface.ts          # Interface genérica de servicio
├── enums/
│   ├── movement-type.enum.ts         # Tipos de movimiento de inventario
│   ├── order-status.enum.ts          # Estados de pedido
│   ├── payment-method.enum.ts        # Métodos de pago
│   ├── license-status.enum.ts        # Estados de licencia SaaS
│   ├── sale-status.enum.ts           # Estados de venta
│   └── customer-type.enum.ts         # Tipos de cliente
├── exceptions/
│   ├── domain.exception.ts           # Excepción base de dominio
│   ├── validation.exception.ts       # Errores de validación
│   └── not-found.exception.ts        # Recurso no encontrado
├── decorators/
│   ├── current-user.decorator.ts     # Extrae usuario del request
│   ├── current-tenant.decorator.ts   # Extrae tenant del request
│   └── public.decorator.ts           # Marca endpoint como público
├── utils/
│   ├── uuid.util.ts                  # Utilidades UUID
│   ├── date.util.ts                  # Utilidades de fecha puras
│   └── money.util.ts                 # Utilidades monetarias puras
└── index.ts                          # Exports públicos
```

**Lo que NO va en shared bajo ninguna circunstancia**:
- DTOs con decoradores de validación (class-validator, class-transformer) porque atan a NestJS
- Servicios con lógica de negocio porque atan a la implementación
- Repositories con TypeORM porque atan a la capa de datos
- Guards y Auth porque atan al framework HTTP
- Decoradores con ExecutionContext porque atan a NestJS

### 2.4 Estructura Interna de Dominio

Cada dominio NestJS implementa la siguiente estructura interna estandarizada. Esta estructura garantiza consistencia entre dominios, facilita onboarding de nuevos desarrolladores y permite tooling automatizado para generación de código y validación de arquitectura.

```
dominio/
├── dto/                                    # Data Transfer Objects
│   ├── create-*.dto.ts                     # Input para operaciones de creación
│   ├── update-*.dto.ts                     # Input para operaciones de actualización
│   ├── query-*.dto.ts                      # Parámetros de query y filtros
│   └── response-*.dto.ts                   # Respuestas tipadas normalizadas
├── entities/                               # Entidades de dominio (clases TypeORM)
│   ├── *.entity.ts                         # Entity con decoradores TypeORM
│   └── *.repository.ts                     # Custom repository si aplica
├── repositories/                           # Abstracción de persistencia
│   ├── *.repository.interface.ts           # Interface del repository
│   └── *.repository.ts                     # Implementación con TypeORM
├── services/                               # Servicios de dominio
│   ├── *.service.ts                        # Lógica de negocio
│   └── *.service.spec.ts                   # Tests unitarios
├── controllers/                            # Controladores HTTP
│   ├── *.controller.ts                     # Endpoints REST
│   └── *.controller.spec.ts                # Tests de controller
├── events/                                 # Eventos de dominio
│   ├── handlers/                           # Handlers de eventos
│   └── subscribers/                        # Subscribers a eventos
├── exceptions/                             # Excepciones específicas del dominio
│   └── *.exception.ts                      # Excepciones tipadas
├── domain/                                 # Reglas de negocio puras
│   ├── rules/                              # Reglas de negocio como clases
│   └── invariants/                         # Invariants del agregado
├── module.ts                               # Module exports
└── index.ts                                # Public API del dominio
```

---

## 3. CAPAS Y RESPONSABILIDADES

### 3.1 Arquitectura de Capas por Dominio

Cada dominio implementa una arquitectura de capas con responsabilidades claramente definidas. El flujo de control sigue el patrón de aplicación de caso de uso: un request HTTP llega al controlador, delega al servicio de aplicación, este orquesta servicios de dominio y repositories, y la respuesta fluye en sentido inverso. Cada capa conoce únicamente a la capa inmediata inferior, nunca a la superior ni a capas saltadas.

**Capa de Controladores (Presentation)**:
Los controladores son thin adapters que traducen HTTP a llamadas a servicios. Su responsabilidad se limita a validación de formato de request mediante DTOs con class-validator, parsing de query parameters para filtros y paginación, transformación de respuesta mediante class-transformer, delegación pura a servicios de aplicación, manejo de errores de presentación (404 not-found, 400 validation-error, 409 conflict), y documentación OpenAPI automática mediante decorators Swagger.

Los controladores NO deben contener lógica de negocio, validación de reglas de dominio ni acceso directo a repositorios. Si un controlador tiene más de 50 líneas, está violando Single Responsibility y debe refactorizarse.

**Capa de Servicios de Aplicación (Use Cases)**:
Los servicios de aplicación orquestan operaciones de dominio, representan casos de uso completos del sistema. Sus responsabilidades incluyen: transacciones de base de datos (TypeORM con DataSource y QueryRunner), validación de precondiciones de negocio antes de ejecutar operaciones, autorización basada en permisos y roles del usuario, emisión de eventos de dominio cuando se completan operaciones exitosas, logging estructurado para auditoría, y manejo de errores con traducción a excepciones del dominio.

Los servicios de aplicación NO deben contener lógica de negocio pura; esta debe delegarse a entidades de dominio. Tampoco deben conocer detalles de HTTP, JWT ni infraestructura.

**Capa de Servicios de Dominio (Domain Services)**:
Los servicios de dominio contienen reglas de negocio puras que no requieren infraestructura. Sus responsabilidades incluyen cálculos (precios con descuentos, márgenes, impuestos, intérêts), validación de invariantes de entidades, decisiones que no requieren acceso a base de datos, y lógica de negocio que aplica a múltiples entidades del mismo bounded context.

Los servicios de dominio son completamente testables sin mocks de infraestructura porque no conocen HTTP, TypeORM ni JWT.

**Capa de Repositories (Infraestructura)**:
Los repositories abstraen la persistencia, exponiendo métodos de acceso a datos independientemente de la implementación subyacente. Sus responsabilidades incluyen operaciones CRUD sobre entidades, queries complejos con filtros y paginación, consultas cross-entity para lectura (reports), y transacciones explícitas cuando se requiere atomicidad.

La implementación usa TypeORM con EntityManager y QueryRunner para transacciones, pero las interfaces están definidas sin dependencias de TypeORM, permitiendo swap de ORM si fuera necesario.

**Capa de Entidades (Dominio)**:
Las entidades son el corazón del dominio, conteniendo estado y comportamiento. Sus responsabilidades incluyen mantener estado inmutable dentro de una transacción, implementar métodos de comportamiento (validate, calculate), ejecutar checks de invariantes en setters, y encapsular reglas de negocio que aplican al objeto.

Las entidades son clases TypeORM decoradas con @Entity, @Column, @PrimaryColumn, etc. Son testables pero requieren mocking del EntityManager para tests unitarios puros.

### 3.2 Capa de Infraestructura Compartida

La capa common contiene componentes de infraestructura reutilizables entre todos los dominios. Estos componentes implementan aspectos transversales como autenticación, logging, manejo de errores y configuración.

```
apps/api/src/common/
├── guards/
│   ├── jwt-auth.guard.ts              # Validación JWT + tenant context
│   ├── permissions.guard.ts           # Autorización basada en roles
│   └── throttle.guard.ts              # Rate limiting por endpoint
├── interceptors/
│   ├── audit.interceptor.ts           # Logging automático de requests
│   ├── transform.interceptor.ts       # Normalización de respuestas
│   ├── tenant-context.interceptor.ts  # Inyección de tenant context
│   └── timing.interceptor.ts          # Métricas de performance
├── filters/
│   ├── http-exception.filter.ts       # Manejo de excepciones HTTP
│   └── typeorm-exception.filter.ts    # Traducción de errores TypeORM
├── pipes/
│   ├── validation.pipe.ts             # Pipe global de validación
│   └── parse-uuid.pipe.ts             # Conversión y validación UUID
├── decorators/
│   ├── current-user.decorator.ts      # Extrae usuario autenticado
│   ├── roles.decorator.ts             # Declara roles requeridos
│   └── branches.decorator.ts          # Declara sucursales permitidas
└── middlewares/
    ├── tenant.middleware.ts           # Establece tenant context
    └── correlation-id.middleware.ts   # Agrega correlation ID
```

### 3.3 Flujo de Request Típico

El flujo completo de un request HTTP a través de las capas ilustra cómo se separan responsabilidades:

1. Request llega al servidor con JWT token en Authorization header
2. JwtAuthGuard valida token, extrae user_id y tenant_id, establece sesión PostgreSQL con app.current_tenant_id
3. TenantContextInterceptor inyecta tenant en request para uso en controladores
4. PermissionsGuard verifica que el usuario tenga rol requerido para el endpoint
5. ValidationPipe valida DTO de input
6. Controlador recibe request ya validado, extrae user y tenant del request
7. Controlador delega a servicio de aplicación
8. Servicio de aplicación obtiene tenant context desde request, inicia transacción TypeORM (QueryRunner)
9. Servicio de aplicación llama a servicios de dominio para reglas de negocio
10. Servicios de dominio validan reglas, calculan valores, devuelven resultados
11. Servicio de aplicación llama a repositories para persistir cambios
12. Si todo éxito, commit de transacción, emite eventos de dominio
13. Si error, rollback de transacción, traduce excepción a HTTP
14. TransformInterceptor normaliza respuesta
15. Response retorna al cliente con código HTTP apropiado

---

## 4. MÓDULOS NESTJS (POR DOMINIO)

### 4.1 Módulo: Tenants (Gestión de Clientes SaaS)

**Responsabilidad del Dominio**: Administrar el ciclo de vida completo de tenants (empresas clientes del SaaS), incluyendo información comercial, contactos, configuración regional, límites de uso y métricas de actividad.

**Entidades Principales**:
- Tenant: Información corporativa principal (razón social, NIT, contacto)
- TenantSettings: Configuraciones específicas del tenant (zona horaria, moneda, idioma)
- TenantMetrics: Contadores de uso para enforcement de límites (sucursales, usuarios, almacenamiento)

**Dependencias Externas**: Ninguna. Este módulo es autonomous y no depende de ningún otro dominio.

**Componentes del Módulo**:

```
Module: TenantsModule

├── Controllers: TenantsController
│   Endpoints expostos:
│   ├── GET /tenants/:id
│   │   └── Responsabilidad: Obtener tenant por ID
│   │   └── Permisos: Admin SaaS únicamente
│   ├── PUT /tenants/:id
│   │   └── Responsabilidad: Actualizar información de tenant
│   │   └── Permisos: Admin SaaS o propietario del tenant
│   ├── GET /tenants
│   │   └── Responsabilidad: Listar tenants con filtros y paginación
│   │   └── Permisos: Admin SaaS únicamente
│   ├── POST /tenants
│   │   └── Responsabilidad: Crear nuevo tenant (onboarding)
│   │   └── Permisos: Público (con clave de activación) o Admin SaaS
│   ├── DELETE /tenants/:id
│   │   └── Responsabilidad: Soft delete de tenant
│   │   └── Permisos: Admin SaaS únicamente
│   └── GET /tenants/:id/metrics
│       └── Responsabilidad: Obtener métricas de uso del tenant
│       └── Permisos: Admin SaaS o propietario del tenant
│
├── Services: TenantService
│   Métodos públicos:
│   ├── create(data: CreateTenantDTO): Promise<Tenant>
│   │   └── Descripción: Crea nuevo tenant con settings por defecto
│   │   └── Reglas: tax_id único globalmente, slug URL-safe único
│   ├── update(id: UUID, data: UpdateTenantDTO): Promise<Tenant>
│   │   └── Descripción: Actualiza información del tenant
│   │   └── Reglas: No permite cambio de status si tiene license activa
│   ├── findById(id: UUID): Promise<Tenant | null>
│   ├── findBySlug(slug: string): Promise<Tenant | null>
│   ├── findAll(query: TenantQueryDTO): Promise<PaginatedResult<Tenant>>
│   ├── validateLimits(tenantId: UUID): Promise<LimitValidationResult>
│   │   └── Descripción: Verifica que tenant no exceda límites del plan
│   │   └── Reglas: Si excede, retorna lista de violaciones
│   ├── deactivate(id: UUID, reason: string): Promise<void>
│   └── reactivate(id: UUID): Promise<void>
│
├── Services: TenantDomainService
│   Métodos de dominio (lógica pura):
│   ├── validateTaxId(taxId: string): boolean
│   │   └── Descripción: Valida formato de NIT colombiano
│   ├── calculateLimits(plan: PlanType): TenantLimits
│   │   └── Descripción: Calcula límites según plan de suscripción
│   └── checkSlugAvailability(slug: string): Promise<boolean>
│
├── Repository: TenantRepository
│   Métodos de persistencia:
│   ├── findById(id: UUID): Promise<Tenant | null>
│   ├── findByTaxId(taxId: string): Promise<Tenant | null>
│   ├── findBySlug(slug: string): Promise<Tenant | null>
│   ├── countByPlan(plan: string): Promise<number>
│   ├── update(id: UUID, data: UpdateTenantDTO): Promise<Tenant>
│   └── incrementMetric(tenantId: UUID, metric: string): Promise<void>
│
└── Domain Events:
    ├── TenantCreatedEvent
    │   └── Handler: LicensingService → Crea license trial
    ├── TenantDeactivatedEvent
    │   └── Handler: LicensingService → Suspende license
    └── TenantLimitsExceededEvent
        └── Handler: BillingService → Notifica admin
```

**Reglas de Dominio Específicas**:
- tax_id debe ser único globalmente, no solo por tenant (verificación en repository)
- slug debe ser URL-safe (regex /^[a-z0-9-]+$/) y único globalmente
- Si tenant está en estado suspended, no puede crear recursos (ventas, pedidos)
- El cambio de status a cancelled requiere que no tenga invoices pendientes
- Métricas de uso se actualizan en tiempo real, no en batch

### 4.2 Módulo: Licensing (Licencias SaaS)

**Responsabilidad del Dominio**: Gestionar el ciclo de vida de licencias de suscripción, períodos de facturación, renovación automática, cambios de plan y enforcement de límites de uso.

**Entidades Principales**:
- License: Licencia activa del tenant con período de facturación
- SubscriptionPlan: Planes predefinidos con límites y características
- LicenseActivationKey: Claves de activación para onboarding

**Dependencias Externas**: TenantsModule (para validación de tenant existente y límites).

**Componentes del Módulo**:

```
Module: LicensingModule

├── Controllers: LicensingController
│   Endpoints expostos:
│   ├── GET /licensing/plans
│   │   └── Responsabilidad: Listar planes disponibles públicamente
│   │   └── Permisos: Público
│   ├── POST /licensing/trial
│   │   └── Responsabilidad: Crear licencia trial para tenant nuevo
│   │   └── Permisos: Admin SaaS o activación con clave trial
│   ├── POST /licensing/activate
│   │   └── Responsabilidad: Activar licencia con clave de activación
│   │   └── Permisos: Admin SaaS
│   ├── GET /licensing/status
│   │   └── Responsabilidad: Obtener estado de licencia del tenant
│   │   └── Permisos: Admin del tenant
│   ├── POST /licensing/renew
│   │   └── Responsabilidad: Renovar manualmente antes de vencimiento
│   │   └── Permisos: Admin del tenant
│   ├── PUT /licensing/plan
│   │   └── Responsabilidad: Cambiar de plan (upgrade/downgrade)
│   │   └── Permisos: Admin del tenant
│   └── POST /licensing/cancel
│       └── Responsabilidad: Cancelar licencia al final del período
│       └── Permisos: Admin del tenant
│
├── Services: LicensingService
│   Métodos públicos:
│   ├── createTrial(tenantId: UUID, planId: UUID): Promise<License>
│   │   └── Descripción: Crea licencia trial por días configurados
│   │   └── Reglas: Solo un trial por tenant, duración según plan
│   ├── activate(tenantId: UUID, key: string): Promise<License>
│   │   └── Descripción: Activa licencia comercial con clave
│   │   └── Reglas: Clave debe estar activa y no usada
│   ├── getStatus(tenantId: UUID): Promise<LicenseStatusDTO>
│   │   └── Descripción: Retorna estado completo incluyendo límites
│   ├── renew(licenseId: UUID): Promise<License>
│   │   └── Descripción: Extiende período de facturación
│   │   └── Reglas: Solo licencias activas pueden renovarse
│   ├── changePlan(licenseId: UUID, newPlanId: UUID): Promise<ChangePlanResult>
│   │   └── Descripción: Cambia plan calculando prorrata
│   │   └── Reglas: Upgrade cobra diferencia, downgrade genera crédito
│   ├── suspend(licenseId: UUID, reason: string): Promise<void>
│   │   └── Descripción: Suspende licencia (falta de pago)
│   │   └── Reglas: Envía notificación al tenant
│   ├── reactivate(licenseId: UUID): Promise<void>
│   │   └── Descripción: Reactiva licencia suspendida
│   │   └── Reglas: Requiere pago de facturas pendientes
│   └── validateAccess(tenantId: UUID): Promise<AccessValidation>
│       └── Descripción: Verifica acceso en cada request
│       └── Reglas: Retorna allow/deny con razón
│
├── Services: PlanService
│   Métodos públicos:
│   ├── findAll(): Promise<SubscriptionPlan[]>
│   │   └── Descripción: Lista planes activos y públicos
│   ├── findBySlug(slug: string): Promise<SubscriptionPlan | null>
│   ├── getDefaultPlan(): Promise<SubscriptionPlan>
│   └── validatePlanLimits(planId: UUID, usage: UsageMetrics): Promise<LimitValidation>
│
├── Repository: LicenseRepository
│   Métodos:
│   ├── findByTenantId(tenantId: UUID): Promise<License | null>
│   ├── findByLicenseKey(key: string): Promise<License | null>
│   ├── findActive(tenantId: UUID): Promise<License | null>
│   ├── findExpiring(daysThreshold: number): Promise<License[]>
│   └── update(id: UUID, data: UpdateLicenseDTO): Promise<License>
│
└── Domain Events:
    ├── LicenseActivatedEvent
    │   └── Handler: BillingService → Genera primera factura
    ├── LicenseExpiredEvent
    │   └── Handler: TenantService → Cambia tenant a modo lectura
    ├── LicenseSuspendedEvent
    │   └── Handler: NotificationService → Notifica al tenant
    └── PlanChangedEvent
        └── Handler: BillingService → Calcula ajuste financiero
```

**Reglas de Dominio Específicas**:
- Solo puede existir una licencia activa por tenant (enforced en service)
- Trial no puede reactivarse después de expirar (estado final es expired)
- Upgrade cobra prorrata del différence de precio; downgrade genera crédito para siguientes períodos
- Límites se verifican en tiempo real en cada operación crítica (crear usuario, sucursal)
- Si uso excede límite hard, operación se rechaza; si excede soft (90%), solo warning

### 4.3 Módulo: Billing (Facturación SaaS)

**Responsabilidad del Dominio**: Generar facturas a tenants, gestionar cobros, trackear morosidad, generar reportes financieros y calcular prorratas para cambios de plan.

**Entidades Principales**:
- SaaSInvoice: Factura emitida a tenant
- SaaSPayment: Pago recibido de tenant
- SaaSCreditNote: Notas de crédito por ajustes

**Dependencias Externas**: LicensingModule (para período de facturación), TenantsModule (para datos de facturación).

**Componentes del Módulo**:

```
Module: BillingModule

├── Controllers: BillingController
│   Endpoints expostos:
│   ├── GET /billing/invoices
│   │   └── Responsabilidad: Listar facturas del tenant con filtros
│   │   └── Permisos: Admin del tenant
│   ├── GET /billing/invoices/:id
│   │   └── Responsabilidad: Obtener detalle de factura
│   │   └── Permisos: Admin del tenant
│   ├── GET /billing/invoices/:id/pdf
│   │   └── Responsabilidad: Descargar PDF de factura
│   │   └── Permisos: Admin del tenant
│   ├── GET /billing/payments
│   │   └── Responsabilidad: Historial de pagos
│   │   └── Permisos: Admin del tenant
│   ├── GET /billing/due
│   │   └── Responsabilidad: Listar facturas pendientes
│   │   └── Permisos: Admin del tenant
│   ├── POST /billing/pay
│   │   └── Responsabilidad: Registrar pago manual (Admin SaaS)
│   │   └── Permisos: Admin SaaS
│   └── GET /billing/aging
│       └── Responsabilidad: Reporte de antigüedad de cartera
│       └── Permisos: Admin SaaS
│
├── Services: BillingService
│   Métodos públicos:
│   ├── generateInvoice(licenseId: UUID): Promise<SaaSInvoice>
│   │   └── Descripción: Genera factura al inicio del período
│   │   └── Reglas: Una factura por período por license
│   ├── getInvoices(tenantId: UUID, query: InvoiceQueryDTO): Promise<PaginatedResult>
│   ├── getInvoicePdf(invoiceId: UUID): Promise<Buffer>
│   │   └── Descripción: Genera PDF según formato DIAN
│   ├── markAsPaid(invoiceId: UUID, paymentData: PaymentDataDTO): Promise<void>
│   ├── calculateProrate(license: License, newPlan: Plan): Promise<ProrateResult>
│   │   └── Descripción: Calcula ajuste por cambio de plan
│   ├── getAgingReport(tenantId: UUID): Promise<AgingReport>
│   └── generateMonthlyReport(year: number, month: number): Promise<BillingReport>
│
├── Services: PaymentService
│   Métodos públicos:
│   ├── processPayment(invoiceId: UUID, method: PaymentMethod): Promise<PaymentResult>
│   │   └── Descripción: Procesa pago a través de gateway
│   ├── recordPayment(invoiceId: UUID, data: RecordPaymentDTO): Promise<SaaSPayment>
│   │   └── Descripción: Registra pago manual
│   ├── refund(paymentId: UUID, reason: string): Promise<void>
│   │   └── Descripción: Procesa reembolso
│   └── getPaymentMethods(): Promise<PaymentMethod[]>
│
├── Repository: BillingRepository
│   Métodos:
│   ├── findByTenant(tenantId: UUID): Promise<SaaSInvoice[]>
│   ├── findByStatus(status: InvoiceStatus): Promise<SaaSInvoice[]>
│   ├── findDue(tenantId: UUID): Promise<SaaSInvoice[]>
│   ├── findOverdue(): Promise<SaaSInvoice[]>
│   └── updateStatus(id: UUID, status: InvoiceStatus): Promise<void>
│
└── Domain Events:
    ├── InvoiceGeneratedEvent
    │   └── Handler: NotificationService → Envía email al tenant
    └── PaymentReceivedEvent
        └── Handler: LicensingService → reactiva license si estaba suspendida
```

**Reglas de Dominio Específicas**:
- Factura se genera automáticamente al inicio del período de facturación
- Si cobro falla 3 veces consecutivas, license pasa a suspended
- Período de gracia de 7 días antes de suspensión por falta de pago
- IVA se calcula según configuración fiscal del tenant (Colombia: 19% standard)
- Prorrata se calcula por día restante del período actual

### 4.4 Módulo: Catalog (Catálogo de Productos)

**Responsabilidad del Dominio**: Gestionar el catálogo maestro de productos, categorías, marcas, unidades de medida, variantes (SKUs), y sistema de precios dinámicos por lista de precios.

**Entidades Principales**:
- Product: Producto base (concepto genérico)
- ProductVariant: SKU individual (presentación específica)
- ProductCategory: Jerarquía de categorías
- Brand: Fabricante o marca
- UnitOfMeasure: Unidades de medida
- PriceList: Lista de precios por tipo de cliente
- PriceListItem: Precio específico de variante en lista

**Dependencias Externas**: Ninguna. Módulo autonomous.

**Componentes del Módulo**:

```
Module: CatalogModule

├── Controllers: CatalogController
│   Endpoints expostos:
│   ├── GET /catalog/products
│   │   └── Responsabilidad: Listar productos con filtros
│   │   └── Permisos: Usuario autenticado
│   ├── POST /catalog/products
│   │   └── Responsabilidad: Crear nuevo producto
│   │   └── Permisos: Admin o Inventory Manager
│   ├── GET /catalog/products/:id
│   │   └── Responsabilidad: Obtener producto con todas sus variantes
│   │   └── Permisos: Usuario autenticado
│   ├── PUT /catalog/products/:id
│   │   └── Responsabilidad: Actualizar producto base
│   │   └── Permisos: Admin o Inventory Manager
│   ├── DELETE /catalog/products/:id
│   │   └── Responsabilidad: Soft delete de producto
│   │   └── Permisos: Admin únicamente
│   ├── GET /catalog/categories
│   │   └── Responsabilidad: Listar categorías (jerarquía)
│   │   └── Permisos: Usuario autenticado
│   ├── POST /catalog/categories
│   │   └── Responsabilidad: Crear categoría
│   │   └── Permisos: Admin o Inventory Manager
│   ├── GET /catalog/brands
│   │   └── Responsabilidad: Listar marcas
│   │   └── Permisos: Usuario autenticado
│   ├── GET /catalog/variants/:id
│   │   └── Responsabilidad: Obtener variante por ID o código de barras
│   │   └── Permisos: Usuario autenticado
│   ├── GET /catalog/price-lists
│   │   └── Responsabilidad: Listar listas de precios
│   │   └── Permisos: Admin o Pricing Manager
│   ├── GET /catalog/price-lists/:id
│   │   └── Responsabilidad: Detalle de lista con items
│   │   └── Permisos: Admin o Pricing Manager
│   └── GET /catalog/price-lists/:id/export
│       └── Responsabilidad: Exportar lista a Excel
│       └── Permisos: Admin o Pricing Manager
│
├── Services: ProductService
│   Métodos públicos:
│   ├── create(data: CreateProductDTO): Promise<Product>
│   │   └── Descripción: Crea producto con código automático
│   ├── update(id: UUID, data: UpdateProductDTO): Promise<Product>
│   ├── findById(id: UUID): Promise<Product | null>
│   ├── findWithFilters(query: ProductQueryDTO): Promise<PaginatedResult<Product>>
│   ├── generateCode(categoryId: UUID): Promise<string>
│   └── delete(id: UUID): Promise<void>
│
├── Services: VariantService
│   Métodos públicos:
│   ├── create(productId: UUID, data: CreateVariantDTO): Promise<ProductVariant>
│   ├── update(id: UUID, data: UpdateVariantDTO): Promise<ProductVariant>
│   ├── generateSKU(productCode: string, attributes: Record<string, string>): Promise<string>
│   ├── generateBarcode(): Promise<string>
│   │   └── Descripción: Genera código EAN-13 único
│   ├── findByBarcode(barcode: string): Promise<ProductVariant | null>
│   │   └── Descripción: Búsqueda rápida para POS
│   └── findById(id: UUID): Promise<ProductVariant | null>
│
├── Services: CategoryService
│   Métodos públicos:
│   ├── create(data: CreateCategoryDTO): Promise<ProductCategory>
│   ├── update(id: UUID, data: UpdateCategoryDTO): Promise<ProductCategory>
│   ├── findTree(): Promise<ProductCategoryTree>
│   │   └── Descripción: Retorna árbol jerárquico completo
│   └── validateParent(parentId: UUID): Promise<boolean>
│
├── Services: PricingService
│   Métodos públicos:
│   ├── createPriceList(data: CreatePriceListDTO): Promise<PriceList>
│   ├── updatePriceList(id: UUID, data: UpdatePriceListDTO): Promise<PriceList>
│   ├── setVariantPrice(listId: UUID, variantId: UUID, price: number): Promise<PriceListItem>
│   ├── getVariantPrice(variantId: UUID, customerType: CustomerType, branchId: UUID): Promise<PriceResult>
│   │   └── Descripción: Obtiene precio según tipo de cliente y sucursal
│   ├── applyVolumeDiscount(variantId: UUID, quantity: number, priceListId: UUID): Promise<number>
│   │   └── Descripción: Calcula precio con descuento por volumen
│   └── validatePriceListItems(listId: UUID): Promise<ValidationResult>
│
├── Repositories:
│   ├── ProductRepository
│   ├── VariantRepository
│   ├── CategoryRepository
│   └── PriceListRepository
│
└── Domain Events:
    ├── ProductCreatedEvent
    │   └── Handler: InventoryService → Crea lotes iniciales
    └── PriceListUpdatedEvent
        └── Handler: SalesService → Limpia caché de precios
```

**Reglas de Dominio Específicas**:
- Código de producto es único por tenant, generado automáticamente si no se proporciona
- SKU es único por tenant, generado según formato: CATEGORIA-MARCA-CODIGO
- Código de barras (EAN-13) es único globalmente en el sistema
- Categoría no puede tener más de 5 niveles de profundidad (prevención de jerarquías infinitas)
- Precio por volumen: mayor cantidad = precio unitario más bajo (descuentos incrementales)
- Lista de precios tiene vigencia (from_date, to_date), precios fuera de vigencia no aplican
- Producto no puede eliminarse si tiene inventario o ventas asociadas (soft delete con verificación)

### 4.5 Módulo: Inventory (Inventario y Lotes)

**Responsabilidad del Dominio**: Gestionar stock por lote con trazabilidad FIFO completa, fechas de vencimiento, transferencias entre sucursales, ajustes de inventario y control de mermas.

**Entidades Principales**:
- InventoryLot: Lote individual con fecha de vencimiento
- InventoryMovement: Movimientos inmutables (kardex)
- InventoryReservation: Reservas para pedidos del portal
- InventoryAdjustment: Ajustes de inventario

**Dependencias Externas**: CatalogModule (para variantes), SalesModule (para consumo en ventas).

**Componentes del Módulo**:

```
Module: InventoryModule

├── Controllers: InventoryController
│   Endpoints expostos:
│   ├── GET /inventory/stock
│   │   └── Responsabilidad: Consultar stock disponible consolidado
│   │   └── Permisos: Usuario autenticado
│   ├── GET /inventory/stock/:variantId
│   │   └── Responsabilidad: Stock por variante (por sucursal o consolidado)
│   │   └── Permisos: Usuario autenticado
│   ├── GET /inventory/lots
│   │   └── Responsabilidad: Listar lotes con filtros
│   │   └── Permisos: Usuario autenticado
│   ├── GET /inventory/lots/:id
│   │   └── Responsabilidad: Detalle completo de lote
│   │   └── Permisos: Usuario autenticado
│   ├── GET /inventory/expiring
│   │   └── Responsabilidad: Lotes próximos a vencer
│   │   └── Permisos: Usuario autenticado
│   ├── GET /inventory/low-stock
│   │   └── Responsabilidad: Stock bajo umbral configurado
│   │   └── Permisos: Usuario autenticado
│   ├── POST /inventory/adjustments
│   │   └── Responsabilidad: Crear ajuste de inventario
│   │   └── Permisos: Admin o Inventory Manager
│   ├── GET /inventory/adjustments/:id
│   │   └── Responsabilidad: Detalle de ajuste
│   │   └── Permisos: Admin o Inventory Manager
│   ├── POST /inventory/transfers
│   │   └── Responsabilidad: Transferir entre sucursales
│   │   └── Permisos: Admin o Inventory Manager
│   └── GET /inventory/kardex/:variantId
│       └── Responsabilidad: Reporte kardex por variante
│       └── Permisos: Admin o Inventory Manager
│
├── Services: StockService
│   Métodos públicos:
│   ├── getAvailableStock(branchId: UUID, variantId: UUID): Promise<StockInfo>
│   │   └── Descripción: Stock disponible (no reservado)
│   ├── getStockByBranch(branchId: UUID, query: StockQueryDTO): Promise<PaginatedResult>
│   ├── getStockByProduct(productId: UUID, branchId: UUID): Promise<StockInfo[]>
│   ├── getLowStockAlerts(branchId: UUID): Promise<StockAlert[]>
│   │   └── Descripción: Productos bajo umbral mínimo
│   └── getConsolidatedStock(variantId: UUID): Promise<ConsolidatedStock>
│       └── Descripción: Stock en todas las sucursales
│
├── Services: LotService
│   Métodos públicos:
│   ├── createLot(data: CreateLotDTO): Promise<InventoryLot>
│   │   └── Descripción: Crea lote en recepción de compra
│   ├── findById(id: UUID): Promise<InventoryLot | null>
│   ├── findByNumber(lotNumber: string): Promise<InventoryLot | null>
│   ├── findByVariant(branchId: UUID, variantId: UUID): Promise<InventoryLot[]>
│   │   └── Descripción: Lotes disponibles de variante
│   ├── markAsDepleted(lotId: UUID): Promise<void>
│   └── markAsExpired(lotId: UUID): Promise<void>
│
├── Services: MovementService
│   Métodos públicos:
│   ├── registerEntry(lotId: UUID, quantity: number, reference: MovementReference): Promise<InventoryMovement>
│   ├── registerExit(lotId: UUID, quantity: number, reference: MovementReference): Promise<InventoryMovement>
│   ├── registerTransfer(fromBranch: UUID, toBranch: UUID, items: TransferItem[]): Promise<TransferResult>
│   ├── getMovements(query: MovementQueryDTO): Promise<PaginatedResult>
│   └── getFIFOConsumption(branchId: UUID, variantId: UUID, quantity: number): Promise<FIFOAllocation[]>
│       └── Descripción: Calcula qué lotes se consumen (FIFO)
│
├── Services: AdjustmentService
│   Métodos públicos:
│   ├── create(data: CreateAdjustmentDTO): Promise<InventoryAdjustment>
│   │   └── Descripción: Crea ajuste pendiente de aprobación
│   ├── approve(adjustmentId: UUID, approverId: UUID): Promise<void>
│   │   └── Descripción: Aprueba y aplica ajuste
│   ├── reject(adjustmentId: UUID, reason: string): Promise<void>
│   └── findById(id: UUID): Promise<InventoryAdjustment | null>
│
├── Services: ExpiryService
│   Métodos públicos:
│   ├── getExpiringLots(branchId: UUID, daysThreshold: number): Promise<ExpiringLot[]>
│   ├── processExpiredLots(): Promise<ProcessedLots>
│   │   └── Descripción: Job diario que procesa lotes vencidos
│   ├── getExpiryAlerts(branchId: UUID): Promise<ExpiryAlert[]>
│   └── createWasteRecord(lotId: UUID, cause: WasteCause, quantity: number): Promise<WasteRecord>
│
├── Services: ReservationService
│   Métodos públicos:
│   ├── createReservation(orderId: UUID, items: ReserveItem[]): Promise<ReservationResult>
│   ├── releaseReservation(reservationId: UUID): Promise<void>
│   ├── consumeReservation(reservationId: UUID): Promise<void>
│   ├── expireOldReservations(): Promise<ExpiredCount>
│   └── getActiveReservations(branchId: UUID): Promise<Reservation[]>
│
├── Repositories:
│   ├── LotRepository
│   ├── MovementRepository
│   ├── AdjustmentRepository
│   └── ReservationRepository
│
└── Domain Events:
    ├── StockLowAlertEvent
    │   └── Handler: NotificationService → Notifica al admin
    ├── LotExpiredEvent
    │   └── Handler: WasteService → Crea registro de merma
    └── TransferCompletedEvent
        └── Handler: AccountingService → Genera asiento contable
```

**Reglas de Dominio (Hard Constraints - RF-003)**:
- stock NUNCA se actualiza directamente en tabla; siempre mediante inventory_movement
- movement_type determina dirección: entrada (+) o salida (-)
- Salida siempre consume el lote más antiguo (FIFO por created_at asc)
- Lotes con current_quantity = 0 pasan automáticamente a status 'depleted'
- expiry_date es obligatorio para productos con has_expiry = true
- inventory_movements es append-only (sin UPDATE ni DELETE; corrección requiere adjustment)
- Ajuste de inventario (inventory_movements.type = 'adjustment') requiere justificación documentada

### 4.6 Módulo: Sales (Ventas y POS)

**Responsabilidad del Dominio**: Procesar ventas en mostrador, aplicar precios según lista del cliente, registrar pagos, calcular costo mediante FIFO para trazabilidad de margen, y generar tickets.

**Entidades Principales**:
- Sale: Venta completa con totales
- SaleDetail: Ítem individual de venta
- SalePayment: Pago de venta

**Dependencias Externas**: CatalogModule (para variantes y precios), InventoryModule (para consumo de stock).

**Componentes del Módulo**:

```
Module: SalesModule

├── Controllers: SalesController
│   Endpoints expostos:
│   ├── POST /sales
│   │   └── Responsabilidad: Crear nueva venta
│   │   └── Permisos: Cajero, Supervisor, Admin
│   ├── GET /sales/:id
│   │   └── Responsabilidad: Obtener venta con detalles
│   │   └── Permisos: Cajero de la venta, Supervisor, Admin
│   ├── GET /sales
│   │   └── Responsabilidad: Listar ventas con filtros
│   │   └── Permisos: Cajero (solo propias), Supervisor, Admin
│   ├── GET /sales/today
│   │   └── Responsabilidad: Ventas del día actual
│   │   └── Permisos: Cajero, Supervisor, Admin
│   ├── POST /sales/:id/annul
│   │   └── Responsabilidad: Anular venta (hard delete con justificación)
│   │   └── Permisos: Supervisor, Admin
│   ├── POST /sales/:id/refund
│   │   └── Responsabilidad: Procesar devolución parcial
│   │   └── Permisos: Cajero, Supervisor, Admin
│   ├── GET /sales/:id/ticket
│   │   └── Responsabilidad: Generar ticket para impresión
│   │   └── Permisos: Cajero de la venta
│   └── POST /sales/:id/print
│       └── Responsabilidad: Enviar a imprimir en thermal printer
│       └── Permisos: Cajero, Supervisor
│
├── Services: SaleService
│   Métodos públicos:
│   ├── create(data: CreateSaleDTO): Promise<SaleResult>
│   │   └── Descripción: Procesa venta completa
│   │   └── Reglas: Valida stock, calcula precios, consume inventario
│   ├── findById(id: UUID): Promise<Sale | null>
│   ├── findByDateRange(branchId: UUID, start: Date, end: Date): Promise<Sale[]>
│   ├── annul(id: UUID, reason: string, userId: UUID): Promise<void>
│   │   └── Descripción: Anula venta, retorna inventario
│   ├── refund(saleId: UUID, items: RefundItemDTO[], userId: UUID): Promise<RefundResult>
│   │   └── Descripción: Procesa devolución parcial
│   └── getDailySummary(branchId: UUID, date: Date): Promise<DailySalesSummary>
│
├── Services: SalePricingService
│   Métodos públicos:
│   ├── calculateTotals(items: PricingItemDTO[], customerType: CustomerType): Promise<PricingResult>
│   │   └── Descripción: Calcula subtotal, descuentos, IVA, total
│   ├── applyPromotions(items: PricingItemDTO[], customerType: CustomerType): Promise<PricingItemDTO[]>
│   │   └── Descripción: Aplica promociones automáticamente
│   ├── validateCredit(customerId: UUID, amount: number): Promise<CreditValidation>
│   │   └── Descripción: Valida límite de crédito disponible
│   └── calculateChange(paymentAmount: number, total: number): Promise<number>
│
├── Services: SalePaymentService
│   Métodos públicos:
│   ├── registerPayment(saleId: UUID, payment: PaymentDTO): Promise<SalePayment>
│   ├── processCashPayment(saleId: UUID, amount: number): Promise<SalePayment>
│   ├── processCardPayment(saleId: UUID, cardData: CardPaymentDTO): Promise<SalePayment>
│   ├── processCreditPayment(saleId: UUID): Promise<SalePayment>
│   └── refundPayment(paymentId: UUID, amount: number): Promise<void>
│
├── Services: SaleInventoryService
│   Métodos públicos:
│   ├── consumeInventory(saleId: UUID, items: SaleItemDTO[]): Promise<FIFOResult>
│   │   └── Descripción: Consume inventario por FIFO
│   ├── restoreInventory(saleId: UUID): Promise<void>
│   │   └── Descripción: Restaura inventario por anulación
│   └── getCostOfSale(saleId: UUID): Promise<number>
│       └── Descripción: Calcula costo total para margen
│
├── Services: TicketService
│   Métodos públicos:
│   ├── generateTicket(saleId: UUID): Promise<TicketData>
│   │   └── Descripción: Genera datos para ticket
│   ├── sendTicketByWhatsApp(saleId: UUID, phone: string): Promise<void>
│   └── sendTicketByEmail(saleId: UUID, email: string): Promise<void>
│
├── Repositories:
│   ├── SaleRepository
│   ├── SaleDetailRepository
│   └── SalePaymentRepository
│
└── Domain Events:
    ├── SaleCreatedEvent
    │   └── Handler: AccountingService → Genera asiento contable
    └── SaleRefundedEvent
        └── Handler: AccountingService → Genera nota de crédito
```

**Reglas de Dominio Específicas**:
- Venta requiere caja abierta en la sucursal (cash_sessions.status = 'open')
- Stock se verifica en tiempo real antes de confirmar venta
- Si venta es a crédito, se valida límite disponible del cliente
- Descuento requiere autorización si excede límite del rol
-IVA se calcula según tarifa del producto (19%, 5%, 0%)
- Ticket incluye: número de venta, items con precios, descuentos, IVA, total, método de pago

### 4.7 Módulo: Cash (Control de Caja y Cuadre Ciego)

**Responsabilidad del Dominio**: Gestionar sesiones de caja, cuadre diario con sistema ciego (system_amount vs declared_amount), movimientos de efectivo, y conciliación.

**Entidades Principales**:
- CashSession: Sesión de caja diaria
- CashMovement: Movimiento de entrada/salida de efectivo
- CashDenomination: Denominaciones de efectivo (conteo físico)

**Dependencias Externas**: SalesModule (para ventas en efectivo).

**Componentes del Módulo**:

```
Module: CashModule

├── Controllers: CashController
│   Endpoints expostos:
│   ├── POST /cash/sessions/open
│   │   └── Responsabilidad: Apertura de caja
│   │   └── Permisos: Cajero, Supervisor, Admin
│   ├── POST /cash/sessions/close
│   │   └── Responsabilidad: Cierre de caja con cuadre ciego
│   │   └── Permisos: Cajero de la sesión, Supervisor, Admin
│   ├── GET /cash/sessions/current
│   │   └── Responsabilidad: Estado de caja actual
│   │   └── Permisos: Cajero de la sesión
│   ├── GET /cash/sessions/:id
│   │   └── Responsabilidad: Detalle de sesión
│   │   └── Permisos: Admin, Supervisor
│   ├── GET /cash/sessions
│   │   └── Responsabilidad: Historial de sesiones
│   │   └── Permisos: Admin, Supervisor
│   ├── POST /cash/movements
│   │   └── Responsabilidad: Registrar movimiento de efectivo
│   │   └── Permisos: Cajero, Supervisor, Admin
│   ├── GET /cash/movements
│   │   └── Responsabilidad: Listar movimientos del día
│   │   └── Permisos: Cajero, Supervisor, Admin
│   └── POST /cash/denominations
│       └── Responsabilidad: Registrar conteo físico de cierre
│       └── Permisos: Cajero
│
├── Services: CashSessionService
│   Métodos públicos:
│   ├── openSession(branchId: UUID, userId: UUID, initialAmount: number): Promise<CashSession>
│   │   └── Descripción: Abre caja para el día
│   │   └── Reglas: Solo una sesión abierta por caja por día
│   ├── closeSession(sessionId: UUID, declaredAmount: number): Promise<CloseResult>
│   │   └── Descripción: Cierra caja con cuadre ciego
│   │   └── Reglas: Muestra system_amount, solicita declared_amount
│   ├── getCurrentSession(branchId: UUID): Promise<CashSession | null>
│   ├── getSessionById(id: UUID): Promise<CashSession | null>
│   └── getSessionHistory(branchId: UUID, startDate: Date, endDate: Date): Promise<CashSession[]>
│
├── Services: CashMovementService
│   Métodos públicos:
│   ├── registerMovement(sessionId: UUID, data: CreateMovementDTO): Promise<CashMovement>
│   ├── registerIncome(sessionId: UUID, amount: number, category: string): Promise<CashMovement>
│   ├── registerExpense(sessionId: UUID, amount: number, category: string, concept: string): Promise<CashMovement>
│   └── getMovementsBySession(sessionId: UUID): Promise<CashMovement[]>
│
├── Services: CashDrawerService
│   Métodos públicos:
│   ├── countDenominations(sessionId: UUID, denominations: DenominationDTO[]): Promise<CountResult>
│   │   └── Descripción: Procesa conteo físico para cuadre
│   └── calculateSystemAmount(sessionId: UUID): Promise<number>
│       └── Descripción: Calcula amount esperado basado en movimientos
│
├── Services: CashReconciliationService
│   Métodos públicos:
│   ├── performReconciliation(sessionId: UUID, declaredAmount: number): Promise<ReconciliationResult>
│   │   └── Descripción: Compara system_amount vs declared_amount
│   ├── getDiscrepancyReport(sessionId: UUID): Promise<DiscrepancyReport>
│   └── approveDiscrepancy(sessionId: UUID, approverId: UUID, comment: string): Promise<void>
│
├── Repositories:
│   ├── CashSessionRepository
│   ├── CashMovementRepository
│   └── CashDenominationRepository
│
└── Domain Events:
    ├── CashSessionOpenedEvent
    │   └── Handler: SalesService → Habilita POS
    └── CashSessionClosedEvent
        └── Handler: AccountingService → Genera asiento de cierre
```

**Reglas de Dominio Específicas (Hard Constraint - RF-004 Cuadre Ciego)**:
- Solo puede haber una sesión abierta por caja por sucursal
- system_amount se calcula internamente, NO se muestra al cajero antes del conteo
- declared_amount es el conteo físico que ingresa el cajero
- Si |difference| > threshold configurable (default 50000 COP), requiere justificación
- Si justificación insuficiente, Supervisor debe aprobar para cerrar
- Diferencias recurrentes del mismo cajero (3+ en 30 días) generan alerta de auditoría

### 4.8 Módulo: Accounting (Contabilidad Automatizada NIIF PYMES)

**Responsabilidad del Dominio**: Generar asientos contables automáticamente según transacciones operativas, validar partida doble, gestionar períodos contables y PUC colombiano.

**Entidades Principales**:
- ChartOfAccount: Plan de cuentas PUC
- AccountingPeriod: Período contable
- AccountingEntry: Asiento contable
- AccountingEntryLine: Línea de asiento (débito/crédito)

**Dependencias Externas**: SalesModule, PurchasesModule, CashModule.

**Componentes del Módulo**:

```
Module: AccountingModule

├── Controllers: AccountingController
│   Endpoints expostos:
│   ├── GET /accounting/chart-of-accounts
│   │   └── Responsabilidad: Listar plan de cuentas
│   │   └── Permisos: Admin, Contador
│   ├── GET /accounting/periods
│   │   └── Responsabilidad: Listar períodos contables
│   │   └── Permisos: Admin, Contador
│   ├── POST /accounting/periods
│   │   └── Responsabilidad: Crear período (mensual)
│   │   └── Permisos: Admin únicamente
│   ├── POST /accounting/periods/:id/close
│   │   └── Responsabilidad: Cerrar período contable
│   │   └── Permisos: Admin únicamente
│   ├── GET /accounting/entries
│   │   └── Responsabilidad: Listar asientos
│   │   └── Permisos: Admin, Contador
│   ├── GET /accounting/entries/:id
│   │   └── Responsabilidad: Detalle de asiento
│   │   └── Permisos: Admin, Contador
│   ├── GET /accounting/entries/:id/pdf
│   │   └── Responsabilidad: Generar PDF de asiento
│   │   └── Permisos: Admin, Contador
│   └── GET /accounting/trial-balance
│       └── Responsabilidad: Balance de prueba
│       └── Permisos: Admin, Contador
│
├── Services: ChartOfAccountsService
│   Métodos públicos:
│   ├── initializePUC(tenantId: UUID): Promise<void>
│   │   └── Descripción: Crea PUC base colombiano
│   ├── findByCode(code: string): Promise<ChartOfAccount | null>
│   ├── findByLevel(level: number): Promise<ChartOfAccount[]>
│   └── getAccountType(code: string): Promise<AccountType>
│
├── Services: AccountingPeriodService
│   Métodos públicos:
│   ├── createPeriod(tenantId: UUID, year: number, month: number): Promise<AccountingPeriod>
│   ├── findByYearMonth(tenantId: UUID, year: number, month: number): Promise<AccountingPeriod | null>
│   ├── closePeriod(periodId: UUID, userId: UUID): Promise<void>
│   │   └── Descripción: Cierra período contable
│   │   └── Reglas: No permite transacciones posteriores
│   ├── reopenPeriod(periodId: UUID, userId: UUID): Promise<void>
│   │   └── Descripción: Reabre período (solo Admin)
│   └── getOpenPeriod(tenantId: UUID): Promise<AccountingPeriod | null>
│
├── Services: EntryService
│   Métodos públicos:
│   ├── createEntry(data: CreateEntryDTO): Promise<AccountingEntry>
│   ├── findById(id: UUID): Promise<AccountingEntry | null>
│   ├── findByReference(referenceType: string, referenceId: UUID): Promise<AccountingEntry[]>
│   ├── postEntry(entryId: UUID): Promise<void>
│   │   └── Descripción: Publica asiento (cambia status)
│   └── voidEntry(entryId: UUID, reason: string): Promise<void>
│
├── Services: DoubleEntryValidationService
│   Métodos públicos:
│   ├── validateEntry(entryId: UUID): Promise<ValidationResult>
│   │   └── Descripción: Verifica sum(débitos) = sum(créditos)
│   └── validateBalance(accountId: UUID): Promise<AccountBalance>
│
├── Services: AutomaticEntryService
│   Métodos públicos:
│   ├── generateSaleEntry(saleId: UUID): Promise<AccountingEntry>
│   │   └── Descripción: Asiento automático por venta
│   ├── generatePurchaseEntry(purchaseId: UUID): Promise<AccountingEntry>
│   ├── generateCashEntry(cashSessionId: UUID): Promise<AccountingEntry>
│   ├── generateCreditEntry(saleId: UUID): Promise<AccountingEntry>
│   └── generateAdjustmentEntry(adjustmentId: UUID): Promise<AccountingEntry>
│
├── Repositories:
│   ├── ChartOfAccountsRepository
│   ├── AccountingPeriodRepository
│   └── AccountingEntryRepository
│
└── Domain Events:
    └── EntryCreatedEvent
        └── Handler: AuditService → Registra en audit_logs
```

**Reglas de Dominio Específicas (Hard Constraint - RF-006 Consistencia Contable)**:
- SUM(débitos) debe equals SUM(créditos) con tolerancia 0.01 (validado por trigger PostgreSQL)
- Cada línea tiene exactly débito O crédito, no ambos, no ninguno
- Cuentas de activo (1xxx): saldo deudor normal
- Cuentas de pasivo (2xxx): saldo acreedor normal
- Cuentas de patrimonio (3xxx): saldo acreedor normal
- Cuentas de ingresos (4xxx): saldo acreedor normal
- Cuentas de gastos (5xxx): saldo deudor normal
- Período contable cerrado no acepta nuevas transacciones (excepto ajustes con aprobación)

### 4.9 Módulo: Purchases (Compras y Proveedores)

**Responsabilidad del Dominio**: Gestionar órdenes de compra, recepción de mercancía, facturas de proveedor y control de cuentas por pagar.

**Entidades Principales**:
- Supplier: Proveedor
- PurchaseOrder: Orden de compra
- PurchaseOrderItem: Item de orden
- PurchaseInvoice: Factura de proveedor
- PurchasePayment: Pago a proveedor

**Dependencias Externas**: CatalogModule (para variantes), InventoryModule (para recepción en lotes).

**Componentes del Módulo**:

```
Module: PurchasesModule

├── Controllers: PurchasesController
│   Endpoints expostos:
│   ├── GET /purchases/suppliers
│   │   └── Responsabilidad: Listar proveedores
│   │   └── Permisos: Admin, Compras, Almacenista
│   ├── POST /purchases/suppliers
│   │   └── Responsabilidad: Crear proveedor
│   │   └── Permisos: Admin, Compras
│   ├── GET /purchases/suppliers/:id
│   │   └── Responsabilidad: Detalle de proveedor
│   │   └── Permisos: Admin, Compras
│   ├── PUT /purchases/suppliers/:id
│   │   └── Responsabilidad: Actualizar proveedor
│   │   └── Permisos: Admin, Compras
│   ├── GET /purchases/orders
│   │   └── Responsabilidad: Listar órdenes de compra
│   │   └── Permisos: Admin, Compras
│   ├── POST /purchases/orders
│   │   └── Responsabilidad: Crear orden de compra
│   │   └── Permisos: Admin, Compras
│   ├── GET /purchases/orders/:id
│   │   └── Responsabilidad: Detalle de orden
│   │   └── Permisos: Admin, Compras
│   ├── POST /purchases/orders/:id/receive
│   │   └── Responsabilidad: Registrar recepción de mercancía
│   │   └── Permisos: Admin, Almacenista
│   ├── GET /purchases/invoices
│   │   └── Responsabilidad: Listar facturas de proveedor
│   │   └── Permisos: Admin, Contador
│   ├── POST /purchases/invoices
│   │   └── Responsabilidad: Registrar factura de proveedor
│   │   └── Permisos: Admin, Contador
│   ├── POST /purchases/payments
│   │   └── Responsabilidad: Registrar pago a proveedor
│   │   └── Permisos: Admin, Contador
│   └── GET /purchases/payables
│       └── Responsabilidad: Estado de cuentas por pagar
│       └── Permisos: Admin, Contador
│
├── Services: SupplierService
│   Métodos públicos:
│   ├── create(data: CreateSupplierDTO): Promise<Supplier>
│   ├── update(id: UUID, data: UpdateSupplierDTO): Promise<Supplier>
│   ├── findById(id: UUID): Promise<Supplier | null>
│   ├── findWithFilters(query: SupplierQueryDTO): Promise<PaginatedResult>
│   └── deactivate(id: UUID): Promise<void>
│
├── Services: PurchaseOrderService
│   Métodos públicos:
│   ├── create(data: CreatePurchaseOrderDTO): Promise<PurchaseOrder>
│   ├── update(id: UUID, data: UpdatePurchaseOrderDTO): Promise<PurchaseOrder>
│   ├── findById(id: UUID): Promise<PurchaseOrder | null>
│   ├── findByStatus(status: PurchaseOrderStatus): Promise<PurchaseOrder[]>
│   ├── cancel(id: UUID, reason: string): Promise<void>
│   └── receive(id: UUID, items: ReceiveItemDTO[], userId: UUID): Promise<ReceiveResult>
│       └── Descripción: Registra recepción y crea lotes
│
├── Services: PurchaseInvoiceService
│   Métodos públicos:
│   ├── create(data: CreateInvoiceDTO): Promise<PurchaseInvoice>
│   ├── findById(id: UUID): Promise<PurchaseInvoice | null>
│   ├── findBySupplier(supplierId: UUID): Promise<PurchaseInvoice[]>
│   ├── applyPayment(invoiceId: UUID, amount: number): Promise<void>
│   └── getAccountPayable(supplierId: UUID): Promise<PayableStatus>
│
├── Services: PurchasePaymentService
│   Métodos públicos:
│   ├── createPayment(data: CreatePaymentDTO): Promise<PurchasePayment>
│   ├── findBySupplier(supplierId: UUID): Promise<PurchasePayment[]>
│   └── getPaymentHistory(invoiceId: UUID): Promise<PurchasePayment[]>
│
├── Repositories:
│   ├── SupplierRepository
│   ├── PurchaseOrderRepository
│   ├── PurchaseInvoiceRepository
│   └── PurchasePaymentRepository
│
└── Domain Events:
    ├── PurchaseOrderCreatedEvent
    │   └── Handler: InventoryService → Notifica recepción pendiente
    └── InvoiceReceivedEvent
        └── Handler: AccountingService → Genera asiento de compra
```

**Reglas de Dominio Específicas**:
- Orden de compra no afecta inventario hasta recepción (receive)
- Recepción puede ser parcial (diferentes items o cantidades)
- Factura de proveedor puede linked a orden o independiente
- Pago a proveedor reduce cuenta por pagar (purchase_invoices.balance)
- Retención en fuente se calcula según tipo de compra (2.5%, 3.5%, 11%)

### 4.10 Módulo: Orders (Pedidos del Portal Web)

**Responsabilidad del Dominio**: Gestionar pedidos realizados por clientes a través del portal web, incluyendo reservación de inventario, estados de pedido y seguimiento de entrega.

**Entidades Principales**:
- Order: Pedido del portal
- OrderItem: Item de pedido
- OrderStatusHistory: Historial de cambios de estado

**Dependencias Externas**: CatalogModule (para variantes y precios), InventoryModule (para reservas).

**Componentes del Módulo**:

```
Module: OrdersModule

├── Controllers: OrdersController
│   Endpoints expostos:
│   ├── POST /orders
│   │   └── Responsabilidad: Crear pedido desde carrito
│   │   └── Permisos: Cliente autenticado
│   ├── GET /orders
│   │   └── Responsabilidad: Listar pedidos del cliente
│   │   └── Permisos: Cliente autenticado (solo propios)
│   ├── GET /orders/:id
│   │   └── Responsabilidad: Detalle de pedido
│   │   └── Permisos: Cliente (propietario), Admin, Ventas
│   ├── PUT /orders/:id/status
│   │   └── Responsabilidad: Cambiar estado de pedido
│   │   └── Permisos: Admin, Ventas
│   ├── POST /orders/:id/cancel
│   │   └── Responsabilidad: Cancelar pedido
│   │   └── Permisos: Cliente (solo estado requested), Admin
│   ├── GET /orders/:id/track
│   │   └── Responsabilidad: Seguimiento de entrega
│   │   └── Permisos: Cliente (propietario)
│   └── GET /orders/pending
│       └── Responsabilidad: Pedidos pendientes de preparación
│       └── Permisos: Admin, Ventas
│
├── Services: OrderService
│   Métodos públicos:
│   ├── createFromCart(customerId: UUID, cartId: UUID, deliveryAddress: string): Promise<Order>
│   │   └── Descripción: Convierte carrito en pedido
│   │   └── Reglas: Reserva inventario, genera número
│   ├── findById(id: UUID): Promise<Order | null>
│   ├── findByCustomer(customerId: UUID, query: OrderQueryDTO): Promise<PaginatedResult>
│   ├── updateStatus(orderId: UUID, newStatus: OrderStatus, userId: UUID): Promise<Order>
│   │   └── Descripción: Cambia estado con validación
│   ├── cancel(orderId: UUID, reason: string, userId: UUID): Promise<void>
│   └── getTrackingInfo(orderId: UUID): Promise<TrackingInfo>
│
├── Services: OrderItemService
│   Métodos públicos:
│   ├── createItems(orderId: UUID, items: CreateItemDTO[]): Promise<OrderItem[]>
│   ├── updateItem(orderItemId: UUID, quantity: number): Promise<OrderItem>
│   └── calculateItemTotals(variantId: UUID, quantity: number, priceListId: UUID): Promise<ItemTotals>
│
├── Services: OrderReservationService
│   Métodos públicos:
│   ├── reserveStock(orderId: UUID): Promise<ReservationResult>
│   │   └── Descripción: Reserva inventario en lotes FIFO
│   ├── releaseReservation(orderId: UUID): Promise<void>
│   │   └── Descripción: Libera reserva por cancelación
│   ├── consumeReservation(orderId: UUID): Promise<void>
│   │   └── Descripción: Convierte reserva en salida (preparing/ready)
│   └── extendReservation(orderId: UUID, hours: number): Promise<void>
│
├── Services: OrderDeliveryService
│   Métodos públicos:
│   ├── scheduleDelivery(orderId: UUID, scheduledDate: Date, timeWindow: string): Promise<void>
│   ├── assignDelivery(orderId: UUID, deliveryId: UUID): Promise<void>
│   ├── updateDeliveryStatus(orderId: UUID, status: DeliveryStatus, location?: GeoLocation): Promise<void>
│   └── confirmDelivery(orderId: UUID, signature?: string, photo?: string): Promise<void>
│
├── Repositories:
│   ├── OrderRepository
│   ├── OrderItemRepository
│   └── OrderStatusHistoryRepository
│
└── Domain Events:
    ├── OrderCreatedEvent
    │   └── Handler: InventoryService → Reserva inventario
    └── OrderDeliveredEvent
        └── Handler: BillingService → Confirma pago (si aplica)
```

**Reglas de Dominio Específicas**:
- Reserva de inventario expira en 24 horas configurable
- Solo se puede cancelar en estado 'requested'
- Cambios de estado validan transiciones válidas
- Cliente recibe notificación en cada cambio de estado
- Si pedido se entrega, reserva se convierte en consumo real

### 4.11 Módulo: Credits (Créditos y Cartera)

**Responsabilidad del Dominio**: Gestionar otorgamiento de créditos a clientes, cálculo de límites dinámicos, scoring crediticio, gestión de cobranzas y control de morosidad.

**Entidades Principales**:
- CreditAccount: Cuenta de crédito del cliente
- CreditTransaction: Transacción de crédito (cargo/pago)
- CustomerPayment: Pago registrado por cliente

**Dependencias Externas**: SalesModule (para ventas a crédito).

**Componentes del Módulo**:

```
Module: CreditsModule

├── Controllers: CreditsController
│   Endpoints expostos:
│   ├── GET /credits/accounts
│   │   └── Responsabilidad: Listar cuentas de crédito
│   │   └── Permisos: Admin, Ventas
│   ├── GET /credits/accounts/:id
│   │   └── Responsabilidad: Detalle de cuenta con aging
│   │   └── Permisos: Admin, Ventas
│   ├── PUT /credits/accounts/:id/limit
│   │   └── Responsabilidad: Actualizar límite de crédito
│   │   └── Permisos: Admin únicamente
│   ├── GET /credits/transactions
│   │   └── Responsabilidad: Listar transacciones
│   │   └── Permisos: Admin, Ventas
│   ├── GET /credits/payments/pending
│   │   └── Responsabilidad: Pagos pendientes de verificación
│   │   └── Permisos: Admin, Ventas
│   ├── POST /credits/payments/:id/verify
│   │   └── Responsabilidad: Verificar pago registrado por cliente
│   │   └── Permisos: Admin, Ventas
│   └── GET /credits/aging
│       └── Responsabilidad: Reporte de aging de cartera
│       └── Permisos: Admin, Contador
│
├── Services: CreditAccountService
│   Métodos públicos:
│   ├── createAccount(customerId: UUID, limit: number, days: number): Promise<CreditAccount>
│   ├── updateLimit(accountId: UUID, newLimit: number, reason: string): Promise<CreditAccount>
│   ├── getAccountByCustomer(customerId: UUID): Promise<CreditAccount | null>
│   ├── getAccountWithDetails(accountId: UUID): Promise<CreditAccountDetail>
│   ├── freezeAccount(accountId: UUID, reason: string): Promise<void>
│   └── unfreezeAccount(accountId: UUID): Promise<void>
│
├── Services: CreditLimitService
│   Métodos públicos:
│   ├── calculateSuggestedLimit(customerId: UUID): Promise<number>
│   │   └── Descripción: Calcula límite basado en scoring
│   ├── validateCredit(customerId: UUID, amount: number): Promise<CreditValidation>
│   │   └── Descripción: Verifica límite disponible
│   └── processCreditIncreaseRequest(customerId: UUID, requestedLimit: number): Promise<RequestResult>
│
├── Services: CreditTransactionService
│   Métodos públicos:
│   ├── registerCharge(accountId: UUID, amount: number, reference: string): Promise<CreditTransaction>
│   ├── registerPayment(accountId: UUID, amount: number, method: PaymentMethod): Promise<CreditTransaction>
│   ├── getTransactions(accountId: UUID, query: TransactionQueryDTO): Promise<PaginatedResult>
│   └── calculateInterest(accountId: UUID): Promise<number>
│       └── Descripción: Calcula intereses de mora
│
├── Services: CustomerPaymentService
│   Métodos públicos:
│   ├── registerPayment(customerId: UUID, data: RegisterPaymentDTO): Promise<CustomerPayment>
│   ├── verifyPayment(paymentId: UUID, verifiedBy: UUID, status: VerificationStatus): Promise<void>
│   ├── rejectPayment(paymentId: UUID, reason: string): Promise<void>
│   └── getPendingPayments(branchId: UUID): Promise<CustomerPayment[]>
│
├── Services: AgingService
│   Métodos públicos:
│   ├── calculateAging(customerId: UUID): Promise<AgingResult>
│   ├── getAgingReport(branchId: UUID, asOfDate: Date): Promise<AgingReport>
│   └── generateCollectionLetters(): Promise<LetterResult>
│
├── Repositories:
│   ├── CreditAccountRepository
│   ├── CreditTransactionRepository
│   └── CustomerPaymentRepository
│
└── Domain Events:
    ├── CreditLimitExceededEvent
    │   └── Handler: SalesService → Rechaza venta a crédito
    └── PaymentVerifiedEvent
        └── Handler: AccountingService → Genera conciliación
```

**Reglas de Dominio Específicas**:
- Límite de crédito = balance máximo permitido (no usado)
- Scoring crediticio calcula: historial (40%), antigüedad (20%), volumen (15%), utilización (15%), mora (10%)
- Días de gracia configurables por cliente
- Interés de mora aplica después de due_date + grace_days
- Cliente con >90 días vencidos puede bloquearse automáticamente

### 4.12 Módulo: HR (Recursos Humanos y Nómina)

**Responsabilidad del Dominio**: Gestionar empleados, contratos, cálculo de nómina, deducciones legales y bonificaciones.

**Entidades Principales**:
- Employee: Empleado
- Contract: Contrato de trabajo
- PayrollRun: Ejecución de nómina
- PayrollDetail: Detalle de nómina por empleado

**Dependencias Externas**: Ninguna.

**Componentes del Módulo**:

```
Module: HRModule

├── Controllers: HRController
│   Endpoints expostos:
│   ├── GET /hr/employees
│   │   └── Responsabilidad: Listar empleados
│   │   └── Permisos: Admin, RRHH
│   ├── POST /hr/employees
│   │   └── Responsabilidad: Crear empleado
│   │   └── Permisos: Admin, RRHH
│   ├── GET /hr/employees/:id
│   │   └── Responsabilidad: Detalle de empleado
│   │   └── Permisos: Admin, RRHH
│   ├── PUT /hr/employees/:id
│   │   └── Responsabilidad: Actualizar empleado
│   │   └── Permisos: Admin, RRHH
│   ├── GET /hr/payrolls
│   │   └── Responsabilidad: Listar nóminas ejecutadas
│   │   └── Permisos: Admin, RRHH, Contador
│   ├── POST /hr/payrolls
│   │   └── Responsabilidad: Ejecutar nómina
│   │   └── Permisos: Admin únicamente
│   └── GET /hr/payrolls/:id
│       └── Responsabilidad: Detalle de nómina con breakdowns
│       └── Permisos: Admin, RRHH, Contador
│
├── Services: EmployeeService
│   Métodos públicos:
│   ├── create(data: CreateEmployeeDTO): Promise<Employee>
│   ├── update(id: UUID, data: UpdateEmployeeDTO): Promise<Employee>
│   ├── findById(id: UUID): Promise<Employee | null>
│   ├── findWithFilters(query: EmployeeQueryDTO): Promise<PaginatedResult>
│   ├── terminate(id: UUID, reason: string, date: Date): Promise<void>
│   └── reactivate(id: UUID): Promise<void>
│
├── Services: ContractService
│   Métodos públicos:
│   ├── createContract(employeeId: UUID, data: CreateContractDTO): Promise<Contract>
│   ├── activeContract(employeeId: UUID): Promise<Contract | null>
│   ├── endContract(contractId: UUID, reason: string): Promise<void>
│   └── calculateBenefits(contractId: UUID): Promise<BenefitSummary>
│
├── Services: PayrollService
│   Métodos públicos:
│   ├── runPayroll(periodStart: Date, periodEnd: Date): Promise<PayrollRun>
│   │   └── Descripción: Ejecuta nómina del período
│   │   └── Reglas: Calcula deducciones legales, bonificaciones
│   ├── calculateNetSalary(employeeId: UUID, periodStart: Date, periodEnd: Date): Promise<SalaryBreakdown>
│   ├── getPayrollById(id: UUID): Promise<PayrollRun | null>
│   └── approvePayroll(payrollId: UUID, approverId: UUID): Promise<void>
│
├── Repositories:
│   ├── EmployeeRepository
│   ├── ContractRepository
│   └── PayrollRepository
│
└── Domain Events:
    └── PayrollExecutedEvent
        └── Handler: AccountingService → Genera asientos de nómina
```

**Reglas de Dominio Específicas**:
- Salario mínimo colombiano como base para cálculos
- Deducciones legales: salud (4%), pensión (4%), retención fuente si aplica
- Prestaciones sociales según legislación colombiana
- Nómina liquidada no puede modificarse (crear payroll run nuevo para ajustes)

---

## 5. DISEÑO DE API REST

### 5.1 Principios de Diseño de API

La API REST sigue principios de contract-first, orientación a recursos y consistencia. Cada endpoint representa un recurso del dominio, no una operación. Los paths usan sustantivos en plural, kebab-case, y reflejan la jerarquía del modelo de datos.

**Contract-First**: La especificación OpenAPI es la fuente de verdad. Los DTOs se generan automáticamente desde el contrato, garantizando sincronización entre documentación e implementación. Los cambios de API requieren actualización del contrato primero.

**Orientación a Recursos**: Los endpoints representan entidades del dominio. La acción se determina por el verbo HTTP, no por el path. No existen endpoints como /doSomething; en su lugar, se usa el recurso apropiado con el verbo correcto.

**Consistencia**: Todos los endpoints siguen el mismo patrón de naming, versioning, respuesta y manejo de errores. Los errores siempre incluyen código, mensaje y detalles estructurados.

### 5.2 Estructura de Paths por Dominio

```
/api/v1/                          # Versión de API
  /tenants                        # Gestión de tenants (SaaS Admin)
  /licensing                      # Licencias SaaS
  /billing                        # Facturación SaaS
  /catalog                        # Catálogo de productos
    /products
    /categories
    /brands
    /variants
    /price-lists
  /inventory                      # Inventario y lotes
    /stock
    /lots
    /movements
    /adjustments
  /sales                          # Ventas y POS
  /cash                           # Control de caja
    /sessions
    /movements
  /orders                         # Pedidos del portal
  /purchases                      # Compras y proveedores
    /suppliers
    /orders
    /invoices
  /accounting                     # Contabilidad
    /chart-of-accounts
    /periods
    /entries
  /credits                        # Créditos y cartera
    /accounts
    /transactions
  /hr                             # Recursos humanos
    /employees
    /payrolls
```

### 5.3 Formato de Request y Response

**Formato Estándar de Response**:

```typescript
interface ApiResponse<T> {
  success: boolean;
  data: T;
  meta?: {
    pagination?: PaginationMeta;
    tenant_id?: UUID;
  };
  timestamp: string;
}

interface PaginationMeta {
  page: number;
  limit: number;
  total: number;
  totalPages: number;
}
```

**Formato Estándar de Error**:

```typescript
interface ApiError {
  success: false;
  error: {
    code: string;
    message: string;
    details?: Record<string, any>;
    path: string;
  };
  timestamp: string;
}
```

---

## 6. MULTI-TENANCY Y SEGURIDAD

### 6.1 Estrategia de Multi-Tenancy

QFlow Pro implementa multi-tenancy a nivel de base de datos compartida con Row Level Security (RLS) como control primario. Esta arquitectura permite que múltiples tenants compartir la misma instancia PostgreSQL mientras garantiza aislamiento criptográfico de datos.

### 6.2 Tenant Context Propagation

El tenant context se propaga desde el JWT token hasta la sesión PostgreSQL mediante un middleware que establece la configuración de sesión `app.current_tenant_id`.

### 6.3 Row Level Security (RLS)

Las políticas RLS son la última línea de defensa contra filtrado de datos. Incluso si el código tiene un bug y olvida filtrar por tenant_id, RLS bloquea el acceso.

### 6.4 Modelo de Autorización

La autorización opera en dos niveles: roles y permisos granulares.

**Roles**:
- Admin SaaS: Acceso total al sistema QFlow Pro (super-admin)
- Admin Tenant: Acceso total a su tenant
- Supervisor: Acceso a operaciones sensibles (cierre de caja, aprobaciones)
- Cajero: Acceso a POS y operaciones básicas
- Inventory Manager: Acceso a inventario y compras
- Contador: Acceso a reportes contables

---

## 7. COMUNICACIÓN ENTRE PAQUETES

### 7.1 Reglas de Dependencia

**Matriz de Dependencias Permitidas**:

| Desde \ Hacia | shared | typeorm-client | api-contracts | apps/api |
|---------------|--------|----------------|---------------|----------|
| shared        | -      | ✗              | ✗             | ✗        |
| typeorm-client| ✓      | -              | ✗             | ✗        |
| api-contracts | ✓      | ✗              | -             | ✗        |
| apps/api      | ✓      | ✓              | ✓             | -        |

### 7.2 Comunicación Cross-Domain

Cuando un dominio necesita información de otro, la comunicación se realiza mediante **eventos asíncronos** o **servicios de aplicación**.

---

## 8. DECISIONES ARQUITECTÓNICAS CLAVE

### 8.1 PostgreSQL con RLS vs Base de Datos por Tenant

**Decisión**: PostgreSQL con Row Level Security en base de datos compartida.

### 8.2 NestJS como Framework

**Decisión**: NestJS como framework backend principal.

### 8.3 TypeORM como ORM

**Decisión**: TypeORM como ORM principal.

**Justificación**:
- TypeScript-first: Entidades como clases decoradas con tipos completos
- Migrations integradas: Versioning de schema con history
- Transactions: QueryRunner para control granular de transacciones
- Repositories: Abstracción familiar para acceso a datos
- Active Record y Data Mapper: Flexibilidad para elegir patrón

**Alternativas descartadas**:
- Prisma: Diferente paradigma, menos familiar para algunos desarrolladores
- Kysely: Menor level de abstracción, más código manual
- TypeORM vs Prisma: Preferencia del equipo por patrones Repository

### 8.4 Offline-First con Flutter + Hive

**Decisión**: Flutter con Hive para clientes móviles offline-first.

### 8.5 API REST vs GraphQL

**Decisión**: API REST con OpenAPI/Swagger.

### 8.6 Monorepo con pnpm

**Decisión**: Monorepo con pnpm workspaces.

### 8.7 Contabilidad Automatizada

**Decisión**: Generación automática de asientos contables mediante triggers y eventos.

### 8.8 Inventario por Lotes FIFO

**Decisión**: Stock por lote con consumo FIFO obligatorio.

---

## 9. ANEXO: MATRIZ DE REFERENCIA CRUZADA

### 9.1 Tablas Principales y Dominios Asociados

| Tabla              | Dominio Principal |
|--------------------|-------------------|
| tenants            | Tenants           |
| licenses           | Licensing         |
| products           | Catalog           |
| product_variants   | Catalog           |
| price_lists        | Catalog           |
| inventory_lots     | Inventory         |
| inventory_movements| Inventory         |
| sales              | Sales             |
| cash_sessions      | Cash              |
| cash_movements     | Cash              |
| accounting_entries | Accounting        |
| credit_accounts    | Credits           |
| orders             | Orders            |
| audit_logs         | Common            |

---

**FIN DEL DOCUMENTO**

*Este documento representa la arquitectura de referencia para QFlow Pro. Cualquier desviación debe ser justificada y aprobada por el Arquitecto de Soluciones. Las reglas hard constraints (RF-001 a RF-009) son innegables y no pueden violarse bajo ninguna circunstancia.*
