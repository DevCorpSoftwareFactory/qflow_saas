# QFlow Pro - Matriz de Reglas de Negocio Global (VERSION MEJORADA)
## Quesera D&G - Plataforma Tecnológica ERP Multi-Sucursal SaaS

---

**Versión del Documento:** 2.0  
**Fecha de Creación:** 13 de Enero de 2026  
**Última Actualización:** 13 de Enero de 2026  
**Arquitecto:** Sistema de Generación Automática + Revisión Senior  
**Clasificación:** Confidencial - Uso Interno  

---

## PARTE 1: FUNDAMENTOS ARQUITECTÓNICOS

### 1.1 Principios Fundacionales del Sistema

El sistema QFlow Pro opera bajo principios axiomáticos que NUNCA pueden ser violados. Estos principios son la base sobre la cual se construye toda la lógica de negocio.

**RF-001: Principio de Aislamiento de Sucursales (Hard Constraint)**  
Cada sucursal opera como una entidad contable, de inventario y de caja completamente independiente. El campo `tenant_id` en PostgreSQL, combinado con Row Level Security, garantiza mediante políticas RLS que ninguna operación realizada en una sucursal pueda afectar los datos de otra. La única excepción permitida es la transferencia de suministros desde Corporativo hacia la sucursal, la cual debe quedar documentada en ambas partes mediante las tablas `corporate_transfers` y `corporate_accounts_payable`. El contexto de tenant se establece mediante la función `set_tenant_context(tenant_id)` que setea la configuración de sesión `app.current_tenant_id`, y todas las queries subsecuentes filtran automáticamente por este valor. Los usuarios con rol Dueño o Administrador Corporativo pueden ver datos consolidados de todas las sucursales, pero cada operación individual se ejecuta dentro del contexto de la sucursal destino.

**RF-002: Principio de Dualidad de Suministros (Hard Constraint)**  
El sistema debe distinguir radicalmente entre dos tipos de entradas de inventario que tienen implicaciones contables y financieras completamente diferentes. El primer tipo son las Compras a Proveedores Externos, que se registran en `suppliers`, `purchase_orders` y `purchase_invoices`, generan cuentas por pagar al proveedor mediante `accounts_payable`, y afectan el flujo de caja real de la sucursal. El segundo tipo son los Suministros del Dueño (Corporativo), que se registran en `corporate_purchases` y `corporate_transfers`, generan cuentas por pagar de la sucursal hacia Corporativo mediante `corporate_accounts_payable`, y NO afectan el flujo de caja real externo porque es un movimiento interno entre entidades del mismo grupo empresarial. Esta distinción es CRÍTICA para la contabilidad y debe reflejarse en cada transacción sin excepción. Las reglas RF-CORP-001 a RF-CORP-025 regulan este principio en detalle.

**RF-003: Principio de Trazabilidad de Lotes (Hard Constraint)**  
TODO movimiento de inventario debe estar vinculado a un lote específico mediante `lot_id` en `inventory_movements`. NUNCA se permite actualizar `current_quantity` directamente en `inventory_lotes` mediante UPDATE. Cada salida debe consumir el lote más antiguo primero siguiendo el algoritmo FIFO (First In, First Out) basado en `created_at` del lote, y cada entrada debe crear un nuevo lote o incrementar uno existente con trazabilidad completa hacia la factura de origen mediante `purchase_invoice_id`. Los lotes tienen un ciclo de vida definido: `active` → `depleted`/`expired`/`waste`/`returned`, y el sistema debe rechazar cualquier operación que intente modificar un lote en estado `depleted`. El kardex en `inventory_movements` es inmutable (sin UPDATE ni DELETE), y cualquier ajuste requiere un movimiento correctivo nuevo.

**RF-004: Principio de Cuadre Ciego (Hard Constraint)**  
El sistema DEBE mantener separación estricta y criptográfica entre `system_amount` (lo que el sistema calcula como efectivo esperado basado en todas las transacciones) y `declared_amount` (lo que el cajero cuenta físicamente al cierre). Esta separación es OBLIGATORIA para prevenir fraudes, errores de conteo y discrepancias operativas. El cálculo de `system_amount` incluye: `initial_amount` + `total_cash_in` + `total_credit_payments` - `total_cash_out` - `total_sales_cash_estimada`. La diferencia se calcula como `declared_amount - system_amount` y si excede el umbral configurable (default $50,000 COP), el sistema debe requerir justificación documentada antes de permitir el cierre. Las diferencias recurrentes del mismo cajero deben generar alertas automáticas para auditoría.

**RF-005: Principio de Offline-First (Hard Constraint)**  
Todas las operaciones de escritura deben funcionar sin conexión a internet en dispositivos móviles. El sistema debe almacenar transacciones localmente en Hive (Flutter) con la estructura `sync_queue` que incluye: `local_id`, `entity_type`, `entity_data`, `timestamp`, `retry_count` y `status`. La sincronización debe ser automática cuando se recupere conectividad, procesando la cola FIFO (First In, First Out). Los conflictos de sincronización deben resolverse mediante timestamp `updated_at` con estrategia Last-Write-Wins, excepto para transacciones financieras críticas (`inventory_movements`, `cash_movements`, `accounting_entries`) que requieren resolución manual mediante el panel `sync_conflicts`. Cada registro offline debe tener un `local_id` único generado por el dispositivo para permitir trazabilidad y resolución de duplicados.

**RF-006: Principio de Consistencia Contable (Hard Constraint)**  
Toda transacción financiera debe generar un asiento contable automático en `accounting_entries` con validación de partida doble. La suma de débitos debe ser IGUAL a la suma de créditos en cada asiento. Las cuentas contables en `chart_of_accounts` tienen tipos validados (`asset`, `liability`, `equity`, `income`, `expense`) y el sistema debe rechazar movimientos que violen la naturaleza de la cuenta (por ejemplo, acreditar una cuenta de activo). Los períodos contables en `accounting_periods` son mensuales y una vez marcados como `is_closed = true`, NO permiten modificaciones ni creación de nuevos asientos. Las únicas excepciones son ajustes de inventario físico con aprobación de supervisor y reversos de cierre con auditoría completa.

**RF-007: Principio de Multi-Tenancy con RLS (Hard Constraint)**  
Cada empresa cliente (tenant) tiene sus datos completamente aislados. La arquitectura usa Shared Database + Shared Schema con Row Level Security habilitado en TODAS las tablas de negocio. Cada tabla tiene una política RLS que filtra por `tenant_id = current_setting('app.current_tenant_id', true)::UUID`. Las tablas globales del SaaS (`subscription_plans`, `licenses`, `tenants`) NO tienen `tenant_id`. Las tablas transaccionales SIEMPRE tienen `tenant_id` como primer componente de índices compuestos para optimizar queries multi-tenant. El tenant context se establece al autenticarse y permanece vigente durante toda la sesión.

**RF-008: Principio de Soft Delete con Retención (Hard Constraint)**  
El sistema implementa soft delete en lugar de hard delete para todas las tablas de negocio. Cada tabla tiene campos `deleted_at TIMESTAMP WITH TIME ZONE` y `is_active BOOLEAN`. Las queries por defecto deben filtrar `WHERE deleted_at IS NULL`. Los registros eliminados se retienen por 90 días (configurable por tenant) para auditoría y posible recuperación. Después del período de retención, un proceso CRON puede archivar o eliminar físicamente los registros. Las vistas del sistema (`v_lote_stock`, `v_daily_sales_summary`) filtran automáticamente registros eliminados.

**RF-009: Principio de Auditoría Inmutable (Hard Constraint)**  
Todas las acciones relevantes del sistema se registran en `audit_logs` sin posibilidad de modificación o eliminación. Cada registro incluye: `user_id`, `tenant_id`, `action` (create, read, update, delete, login, logout, approve, reject), `entity_type`, `entity_id`, `old_value` (JSONB), `new_value` (JSONB), `ip_address`, `user_agent`, `device_id`, `location` (JSONB con lat/lng), `description` y `created_at`. Las acciones de lectura (SELECT) NO generan logs excepto para datos sensibles. Los logs se retienen por 1 año mínimo y son accesibles solo para usuarios con rol Dueño o Administrador Corporativo. Cualquier intento de manipulación de logs debe generar alertas de seguridad.

---

### 1.2 Stack Tecnológico y Restricciones de Implementación

El sistema se construye sobre las siguientes tecnologías, las cuales imponen restricciones específicas que deben respetarse en todas las reglas de negocio.

**Backend y Base de Datos:**
PostgreSQL 15+ con extensiones `uuid-ossp` (generación de UUIDs v4) y `pgcrypto` (funciones criptográficas para hashes de contraseñas). La zona horaria está fijada en `SET timezone = 'America/Bogota'` y TODAS las marcas temporales deben respetar este setting usando `TIMESTAMP WITH TIME ZONE`. El campo `tenant_id` es UUID y debe ser referenciado mediante Foreign Keys en todas las tablas de negocio. Los índices deben incluir `tenant_id` como primer componente para optimizar queries multi-tenant. Las funciones de utilidad como `current_tenant_id()` y `set_tenant_context(tenant_id)` son SECURITY DEFINER y permiten establecer el contexto de sesión.

**Frontend Móvil (Flutter):**
Flutter 3+ con Hive para caché local offline. Cada registro debe tener `local_id VARCHAR(50)` para identificar el origen de la sincronización cuando viene de múltiples dispositivos. El campo `synced BOOLEAN` indica si la transacción ha sido propagada al servidor. Los datos frecuentes (catálogo de productos, precios, inventario) se cachean automáticamente cada 5 minutos o cuando hay cambios. El estado de conexión se monitorea constantemente y las operaciones de escritura van directamente a la cola de sincronización cuando está offline.

**Seguridad y Autenticación:**
Autenticación mediante Supabase Auth con contraseñas hasheadas en bcrypt (cost factor 12). Las sesiones incluyen `current_setting('app.current_tenant_id')` para aislamiento multi-tenant. Los precios de compra y márgenes de utilidad SOLO son visibles para roles Dueño y Administrador mediante políticas RLS adicionales. Las políticas de contraseñas requieren: mínimo 8 caracteres, al menos una mayúscula, una minúscula, un número, no reuse las últimas 5 contraseñas. El bloqueo por intentos fallidos ocurre después de 5 intentos fallidos por 15 minutos.

**Cumplimiento Fiscal Colombia:**
El Plan de Cuentas (PUC) sigue la estructura NIIF PYMES colombiana: 1xxx Activos, 2xxx Pasivos, 3xxx Patrimonio, 4xxx Ingresos, 5xxx Gastos. Los períodos contables son mensuales y una vez marcados como `is_closed=true`, NO permiten modificaciones. Las retenciones en la fuente se calculan según tarifas DIAN (2.5%, 3.5%, 11% según el concepto). Los libros contables (ventas, compras, diario) se generan en formato estructurado para exportación a medios magnéticos DIAN.

**Integraciones:**
Las integraciones con hardware (impresoras térmicas ESC/POS, lectores de código de barras, balanzas electrónicas) se gestionan mediante la configuración en `cash_registers.printer_config` y `settings` JSONB. Las integraciones de mensajería (WhatsApp, SMS) usan APIs con templates configurables. La sincronización con servicios externos (bancos, transportadoras) se hace mediante webhooks y jobs asíncronos con reintentos configurables.

---

### 1.3 Matriz de Integración entre Componentes

La siguiente matriz muestra las integraciones críticas entre los componentes de la plataforma y las tablas involucradas.

| De \ Hacia | Web Admin | Backend API | POS | Móvil Offline | Portal Clientes |
|------------|-----------|-------------|-----|---------------|-----------------|
| **Compras** | Crear OC | Valida stock | - | Sync OC creada | - |
| **Inventario** | Ver kardex | Update lotes | Consume FIFO | Cache stock | Ver disponibilidad |
| **Caja** | Reportes | Asientos auto | Cuadre ciego | Registro offline | - |
| **Portal Pedidos** | Gestionar | Crea reserva | - | Sync estado | Crear pedido |
| **Contabilidad** | Reportes | Genera asientos | - | - | - |
| **Créditos** | Gestionar límite | Valida límite | - | Ver saldo | Consultar saldo |

---

## PARTE 2: MÓDULO DE GESTIÓN DE LICENCIAS Y SAAS

### 2.1 Objetivo del Módulo

Gestionar el ciclo de vida completo de las licencias SaaS, incluyendo creación, activación, renovación, suspensión, cancelación y gestión de planes y límites. Este módulo es crítico para el modelo de negocio SaaS y debe garantizar que cada tenant opere dentro de los límites de su suscripción.

### 2.2 Reglas de Negocio

**RN-LIC-001: Validación de Licencia al Inicio de Sesión**
*SI* un usuario intenta iniciar sesión en cualquier componente de la plataforma (Web, POS, Móvil),
*ENTONCES* el sistema debe:
- Validar que el tenant asociado tenga una licencia activa mediante `SELECT * FROM licenses WHERE tenant_id = ? AND status = 'active' AND current_period_end >= NOW()`
- Verificar que la cantidad de usuarios activos no exceda `max_users` del plan
- Verificar que la cantidad de sucursales activas no exceda `max_branches` del plan
- Verificar que el almacenamiento usado no exceda `max_storage_gb`
- Verificar que las transacciones del mes no excedan `max_transactions_monthly`

*EXCEPCIÓN:* Si la licencia está en estado `trial`, permitir acceso pero mostrar banner de días restantes. Si la licencia está `expired` o `suspended`, bloquear acceso y mostrar pantalla de renovación con opción de contacto. Si los límites están cerca de alcanzarse (80%), mostrar warnings pero permitir acceso.

*INTEGRACIÓN CRUZADA:* Esta validación ocurre en la capa de autenticación de Supabase Auth antes de permitir acceso a cualquier recurso. Los límites se verifican contra la tabla `licenses` y las métricas actuales contra `tenant_metrics`.

*TECNOLOGÍA:* Supabase Auth hook + PostgreSQL function `validate_license(tenant_id)`. Cachear resultado por sesión para evitar queries excesivas.

**RN-LIC-002: Creación de Licencia para Nuevo Cliente**
*SI* un administrador de QFlow Pro crea una nueva licencia desde el Panel Admin,
*ENTONCES* el sistema debe:
- Generar UUID único para la licencia
- Generar clave de activación legible con formato `QFLOW-XXXX-XXXX-XXXX-XXXX` usando caracteres alfanuméricos sin ambigüedad (0, O, I, 1 excluidos)
- Insertar registro en `licenses` con estado `pending`, `current_period_start = hoy`, `current_period_end = hoy + duración`
- Si es trial, setear `trial_ends_at = hoy + trial_days`
- Generar token de API único si el plan incluye `api_access`
- Enviar email automático con credenciales al contacto principal del tenant

*EXCEPCIÓN:* Si el tenant no existe, rechazar la creación. Si el plan seleccionado no está activo, rechazar. Si se intenta crear más sucursales de las permitidas, rechazar con mensaje explicativo.

*INTEGRACIÓN CRUZADA:* Al crear la licencia, se crea automáticamente el registro en `tenants` si no existe. Se inicializan los contadores de métricas en `tenant_metrics`. Se activan los módulos habilitados en `subscription_plans.enabled_modules`.

*TECNOLOGÍA:* PostgreSQL function `generate_activation_key()` + Supabase Edge Function para envío de email transactional.

**RN-LIC-003: Activación de Licencia por Cliente**
*SI* un cliente ingresa la clave de activación en el sistema,
*ENTONCES* el sistema debe:
- Validar que la clave exista, no esté usada y no esté expirada (`activation_expires_at > NOW()`)
- Vincular la licencia con el tenant que está activando
- Cambiar estado de `pending` a `active`
- Setear `activated_at = NOW()`
- Habilitar los módulos del plan en `tenant_settings.enabled_modules`
- Ejecutar el wizard de onboarding inicial
- Enviar email de confirmación de activación

*EXCEPCIÓN:* Si la clave ya fue usada, mostrar mensaje "Clave ya activada". Si está expirada, sugerir contacting soporte. Si el tenant ya tiene otra licencia activa, preguntar si desea reemplazar o mantener ambas.

*INTEGRACIÓN CRUZADA:* La activación completa el registro en `tenants` con `status = 'active'` y `onboarded_at`. Inicializa datos base: categorías por defecto, roles del sistema, primer usuario admin.

**RN-LIC-004: Renovación Automática de Licencia**
*SI* el job CRON diario detecta licencias con `auto_renew = true` y `current_period_end = hoy`,
*ENTONCES* el sistema debe:
- Calcular el monto a cobrar: `plan.monthly_price` o `plan.annual_price` según `billing_cycle` + sum(`addons.monthly_price`) + impuestos
- Generar factura en `invoices_saas` con período `current_period_end + 1` a `current_period_end + 1 mes/año`
- Intentar cobro con el método de pago registrado del tenant
- Si el cobro es exitoso:
  - Marcar factura como `paid`
  - Extender `current_period_end` en 1 mes o 1 año
  - Mantener `status = 'active'`
  - Enviar recibo por email
- Si el cobro falla:
  - Marcar factura como `pending`
  - Programar reintentos para día +3, +5, +7
  - Enviar notificación de pago fallido
  - Mantener licencia activa durante período de gracia

*EXCEPCIÓN:* Si el tenant no tiene método de pago registrado, saltar el intento de cobro y enviar notificación urgente. Si después de 3 reintentos falla, cambiar estado a `suspended`.

*INTEGRACIÓN CRUZADA:* La renovación afecta `invoices_saas`, `saas_payments`, y los reportes financieros del SaaS. El cambio de período se refleja en `tenant_metrics` para métricas de MRR.

**RN-LIC-005: Suspensión de Licencia por Falta de Pago**
*SI* después de 3 intentos de cobro fallidos la factura sigue pendiente,
*ENTONCES* el sistema debe:
- Cambiar estado de la licencia a `suspended`
- Bloquear acceso a todos los módulos de la plataforma para usuarios del tenant
- Enviar notificación urgente al cliente: "Su suscripción ha sido suspendida por falta de pago. Tiene 7 días para regularizar antes de pérdida de datos."
- Deshabilitar tokens de API asociados
- Mantener los datos intactos (no eliminar)
- Registrar el evento en `audit_logs` con acción `suspend`

*EXCEPCIÓN:* Si el cliente paga dentro del período de gracia (7 días), la licencia se reactiva automáticamente sin pérdida de datos. Si pasa el período de gracia, el cliente puede solicitar reactivación pero requiere proceso de onboarding parcial.

*INTEGRACIÓN CRUZADA:* La suspensión deshabilita todas las políticas RLS que permiten acceso a datos del tenant. Los dashboards de QFlow Pro muestran métricas de licencias suspendidas.

**RN-LIC-006: Upgrade de Plan**
*SI* un cliente solicita cambiar de plan (ej: Basic → Pro),
*ENTONCES* el sistema debe:
- Calcular prorrateo: `(precio_nuevo - precio_actual) × (días_restantes / días_del_més)`
- Cobrar la diferencia inmediatamente si es upgrade, o aplicar crédito si es downgrade
- Actualizar `license.plan_id` al nuevo plan
- Ajustar límites: `max_branches`, `max_users`, `max_storage_gb`, `max_transactions_monthly`
- Habilitar/deshabilitar módulos según el nuevo plan
- Generar factura de ajuste
- Notificar al cliente con detalle de cambios

*EXCEPCIÓN:* Si el downgrade reduce límites por debajo del uso actual (ej: tiene 6 sucursales y baja a plan de 5), alertar al cliente y dar plazo de 30 días para ajustar. Bloquear nuevas creaciones hasta que cumpla los límites.

*INTEGRACIÓN CRUZADA:* El cambio de plan se refleja en `tenant_settings` y afecta inmediatamente lo que el usuario puede ver y hacer en la plataforma.

**RN-LIC-007: Renovación Manual desde Portal Cliente**
*SI* un cliente inicia renovación manual desde su portal (sin auto-renovación),
*ENTONCES* el sistema debe:
- Mostrar resumen de la licencia actual y período nuevo
- Solicitar confirmación de período (mensual/anual)
- Solicitar método de pago si no tiene ninguno registrado
- Procesar pago mediante pasarela integrada
- Si es exitoso:
  - Extender período de licencia
  - Generar factura
  - Enviar confirmación
- Si falla:
  - Mostrar error específico
  - Sugerir actualizar método de pago

*EXCEPCIÓN:* Si el cliente tiene facturas vencidas, bloquear la renovación hasta que pague las facturas pendientes. Mostrar lista de facturas pendientes con montos.

*TECNOLOGÍA:* Integración con pasarela de pagos (Wompi, PayU) mediante API REST. Tokenización de tarjetas segura.

**RN-LIC-008: Cancelación de Licencia**
*SI* un cliente solicita cancelar su suscripción,
*ENTONCES* el sistema debe:
- Ofrecer opciones: "Cancelar al final del período" o "Cancelar inmediatamente"
- Si cancela al final del período:
  - Setear `auto_renew = false`
  - Mantener licencia activa hasta `current_period_end`
  - Generar encuesta de salida: "¿Por qué cancelas?"
- Si cancela inmediatamente:
  - Setear `cancelled_at = NOW()`
  - Ofrecer reembolso prorrateado si aplica según política
  - Bloquear acceso inmediatamente
  - Programar eliminación de datos para 90 días después
- Enviar confirmación de cancelación
- Ofrecer exportación completa de datos del cliente

*EXCEPCIÓN:* Los clientes con contratos Enterprise pueden tener cláusulas diferentes de cancelación. Los clientes con saldo pendiente deben pagar antes de poder cancelar.

*INTEGRACIÓN CRUZADA:* La cancelación genera entradas en `churn_analysis` para métricas de negocio. La exportación de datos usa la función `export_tenant_data(tenant_id)`.

**RN-LIC-009: Control de Límites en Tiempo Real**
*SI* cualquier usuario intenta crear un recurso que cuenta contra un límite del plan,
*ENTONCES* el sistema debe:
- Verificar límite actual vs límite del plan:
  - Sucursales: `SELECT COUNT(*) FROM branches WHERE tenant_id = ? AND is_active = true`
  - Usuarios: `SELECT COUNT(*) FROM users WHERE tenant_id = ? AND is_active = true`
  - Almacenamiento: `SELECT SUM(storage_used) FROM tenant_metrics WHERE tenant_id = ?`
  - Transacciones mensuales: `SELECT COUNT(*) FROM transactions WHERE tenant_id = ? AND created_at >= month_start`
- Si el límite está alcanzado:
  - Bloquear la operación
  - Mostrar mensaje: "Has alcanzado el límite de X de tu plan [Nombre Plan]. Upgrade tu plan para continuar."
  - Ofrecer link directo a página de upgrade
- Si el límite está cerca (80%):
  - Permitir la operación
  - Mostrar warning: "Estás cerca del límite (85%). Considera hacer upgrade."

*EXCEPCIÓN:* Los usuarios con rol Dueño pueden ignorar warnings pero no pueden superar límites hard. Las transacciones siempre se permiten (se cuentan para el límite pero no se bloquean).

*TECNOLOGÍA:* PostgreSQL functions `check_branch_limit(tenant_id)`, `check_user_limit(tenant_id)`, `check_storage_limit(tenant_id)`, `check_transaction_limit(tenant_id)`.

**RN-LIC-010: Generación de Clave de Activación**
*SI* se necesita generar una nueva clave de activación (por pérdida o por seguridad),
*ENTONCES* el sistema debe:
- Generar clave en formato `QFLOW-XXXX-XXXX-XXXX-XXXX` donde X es alfanumérico mayúsculas sin caracteres ambiguos (0, O, I, 1)
- La clave debe ser única y nunca reutilizada
- La clave tiene validez de 30 días para activación
- La clave se vincula a una licencia específica
- Se registra en `license_activation_keys` con `used_at NULL` inicialmente
- Al usarse, se setea `used_at = NOW()` y `activated_by_tenant_id`

*EXCEPCIÓN:* Si la clave expira sin usarse, se puede generar una nueva. Si se genera más de 3 claves para la misma licencia, generar alerta de seguridad.

*TECNOLOGÍA:* PostgreSQL function `generate_qflow_key()` usando随机字符生成 con excluir caracteres problemáticos.

---

## PARTE 3: MÓDULO DE ARQUITECTURA MULTI-TENANT Y CONTEXTO

### 3.1 Objetivo del Módulo

Garantizar el aislamiento correcto de datos entre tenants, la aplicación de políticas Row Level Security, y la gestión del contexto de tenant en todas las operaciones. Este módulo es fundamental para la seguridad y privacidad de los datos de cada cliente.

### 3.2 Reglas de Negocio

**RN-TEN-001: Establecimiento de Contexto de Tenant**
*SI* un usuario se autentica exitosamente en el sistema,
*ENTONCES* el sistema debe:
- Obtener el `tenant_id` del usuario desde `users.tenant_id`
- Ejecutar la función `set_tenant_context(tenant_id)` que setea `app.current_tenant_id`
- Todas las queries subsecuentes heredan este contexto automáticamente
- El contexto permanece vigente durante toda la sesión
- Al hacer logout o expirar sesión, el contexto se limpia

*EXCEPCIÓN:* Si el usuario tiene acceso a múltiples tenants (admin corporativo), debe seleccionar el tenant activo en cada sesión. El cambio de tenant activa `set_tenant_context(nuevo_tenant_id)`.

*INTEGRACIÓN CRUZADA:* Todas las tablas de negocio filtran por el tenant context via RLS. Las tablas globales (tenants, licenses) son accesibles sin contexto.

*TECNOLOGÍA:* PostgreSQL session variable `app.current_tenant_id` + RLS policies. La función es SECURITY DEFINER para poder setear la variable.

**RN-TEN-002: Row Level Security en Tablas de Negocio**
*SI* se ejecuta cualquier query en una tabla con RLS habilitado,
*ENTONCES* PostgreSQL aplica automáticamente la política:
- `tenant_id = current_setting('app.current_tenant_id', true)::UUID`
- Si el setting no existe o es NULL, la query retorna vacío (sin acceso)
- Esto aplica para SELECT, INSERT, UPDATE, DELETE

*EXCEPCIÓN:* Las tablas `audit_logs` y `tenants` tienen políticas especiales. `audit_logs` permite NULL tenant_id para acciones globales. `tenants` no tiene tenant_id.

*TECNOLOGÍA:* PostgreSQL RLS con políticas como:
```sql
CREATE POLICY tenant_isolation ON products
  FOR ALL USING (tenant_id = current_setting('app.current_tenant_id', true)::UUID);
```

**RN-TEN-003: Aislamiento de Datos por Sucursal**
*SI* un usuario con rol Administrador de Sucursal opera en el sistema,
*ENTONCES* el sistema debe:
- Filtrar automáticamente por `branch_id` en `users.branch_ids`
- Mostrar solo opciones de sucursales asignadas en dropdowns
- Bloquear acceso a datos de otras sucursales con error 403
- Para usuarios con acceso múltiple (Dueño, Admin Corporativo), permitir selector de sucursal activa
- Los reportes consolidan todas las sucursales accesibles

*EXCEPCIÓN:* El rol Dueño y Administrador Corporativo pueden ver todas las sucursales. El rol Contador puede ver datos de todas las sucursales para efectos contables.

*INTEGRACIÓN CRUZADA:* Las tablas `branches`, `inventory_lotes`, `cash_sessions`, `sales`, `orders` filtran por branch además de tenant.

**RN-TEN-004: Validación de Acceso a Recurso Específico**
*SI* un usuario intenta acceder a un recurso específico (por ID),
*ENTONCES* el sistema debe:
- Verificar que el `tenant_id` del recurso coincida con el contexto actual
- Verificar que el `branch_id` del recurso esté en `users.branch_ids` (si aplica)
- Si no coincide, retornar error 403 Forbidden con mensaje genérico ("No tienes acceso a este recurso")
- Registrar el intento fallido en `audit_logs`

*EXCEPCIÓN:* Los intentos de acceso a recursos inexistentes retornan 404 Not Found (no revelar si existe o no por seguridad).

*TECNOLOGÍA:* Middleware de API que verifica tenant context antes de procesar requests.

**RN-TEN-005: Exportación de Datos por Tenant (GDPR)**
*SI* un cliente solicita exportación de sus datos (derecho al olvido o portabilidad),
*ENTONCES* el sistema debe:
- Exportar TODAS las tablas del tenant en formato JSON estructurado
- Incluir: productos, clientes, ventas, inventario, transacciones, usuarios, configuraciones
- Excluir: logs de auditoría detallados y datos de otros tenants
- Generar archivo descargable en máximo 30 días
- El proceso se ejecuta como job background con notificación al completar
- Registrar la solicitud en `data_export_requests`

*EXCEPCIÓN:* Si la licencia está suspendida por falta de pago, la exportación puede estar restringida hasta regularizar. Si es solicitud de eliminación ("derecho al olvido"), ejecutar proceso de anonimización.

*TECNOLOGÍA:* PostgreSQL function `export_tenant_data(tenant_id)` + Supabase Storage para archivo generado + Background job.

**RN-TEN-006: Cambio de Plan con Reducción de Límites**
*SI* un cliente hace downgrade de plan y el nuevo plan tiene límites menores al uso actual,
*ENTONCES* el sistema debe:
- Calcular excedentes: usuarios_activos - max_users, sucursales_activas - max_branches
- Alertar al cliente con detalle de excedentes
- Dar plazo de 30 días para reducir uso:
  - Desactivar usuarios excedentes (no eliminar)
  - Desactivar sucursales excedentes (no eliminar)
  - Bloquear nuevas creaciones
- Si no cumple en 30 días:
  - Mantener downgrade pero con excedentes visibles
  - Sugerir снова hacer upgrade
  - No penalizar financieramente pero warn continuamente

*EXCEPCIÓN:* Los excedentes de almacenamiento pueden manejarse con archivo automático de datos antiguos.

**RN-TEN-007: Soft Delete de Tenant**
*SI* una licencia se cancela o expires sin renovación,
*ENTONCES* el sistema debe:
- Cambiar `tenants.status` a `deleted` (soft delete)
- Conservar TODOS los datos por 90 días (período de gracia)
- Durante este período:
  - El cliente puede reactivar con proceso simplificado
  - Los datos permanecen intactos
  - Se muestra pantalla de "Cuenta en pausa" con opción de renovar
- Después de 90 días:
  - Proceso automático de archivado o eliminación
  - El cliente puede solicitar exportación antes de eliminación
  - Después de eliminación, los datos no son recuperables

*EXCEPCIÓN:* Los clientes Enterprise pueden tener períodos de retención personalizados en su contrato.

---

## PARTE 4: MÓDULO DE CATÁLOGO DE PRODUCTOS

### 4.1 Objetivo del Módulo

Gestionar el catálogo completo de productos incluyendo categorías jerárquicas, marcas, unidades de medida, productos base y variantes (SKUs), con precios dinámicos según tipo de cliente y lista de precios.

### 4.2 Reglas de Negocio

**RN-CAT-001: Estructura Jerárquica de Categorías**
*SI* se crea o modifica una categoría de productos,
*ENTONCES* el sistema debe:
- Validar que `parent_id` pertenezca a la misma categoría padre o sea NULL (categoría raíz)
- Mantener la jerarquía con autorreferencia en `product_categories.parent_id`
- Calcular `level` automáticamente: 1 para raíces, 2 para subcategorías, etc.
- No permitir más de 5 niveles de profundidad
- Generar `path` para consultas rápidas: "Lácteos/Quesos/Frescos"
- Validar unicidad de nombre dentro del mismo padre

*EXCEPCIÓN:* Las categorías con productos asociados NO pueden eliminarse (soft delete solo). Las categorías raíz no pueden tener `parent_id`.

*TECNOLOGÍA:* PostgreSQL recursive query para hierarchical paths + trigger para actualizar `level` y `path`.

**RN-CAT-002: Creación de Producto Base**
*SI* se crea un producto en `products`,
*ENTONCES* el sistema debe:
- Generar `code` único dentro del tenant: formato configurable (ej: PROD-{000000})
- Validar `has_expiry` según tipo de producto (lácteos y cárnicos deben ser true)
- Setear `is_active = true` por defecto
- No incluir precios ni stock (van en variantes y lotes)
- Permitir asociación con categoría y marca existentes
- Registrar creación en `audit_logs`

*EXCEPCIÓN:* Código duplicado dentro del tenant debe rechazarse. El código no puede cambiar después de creado.

**RN-CAT-003: Creación de Variante (SKU)**
*SI* se crea una variante de producto en `product_variants`,
*ENTONCES* el sistema debe:
- Generar `sku` único dentro del tenant: combina código de producto + atributos (ej: QF-001-500G)
- Generar `barcode` si se proporciona (debe ser único dentro del tenant)
- Validar que `product_id` exista y esté activo
- Setear `is_active = true` por defecto
- Si es la primera variante, marcarla como `is_default = true`
- Si hay variante default existente, permitir solo una default
- Los atributos específicos (presentación, formato, peso) van en JSONB

*EXCEPCIÓN:* El barcode debe ser único para escaneo correcto en POS. SKU vacío o duplicado debe rechazarse.

*INTEGRACIÓN CRUZADA:* La variante es la entidad que aparece en POS, pedidos e inventario. NO se vende el producto base, se vende la variante.

**RN-CAT-004: Gestión de Unidades de Medida**
*SI* se crea o modifica una unidad de medida,
*ENTONCES* el sistema debe:
- Validar tipo de unidad: weight, volume, count, length, area, other
- Definir unidad base del tipo: para peso es kg, para volumen es L
- El `conversion_factor` es respecto a la unidad base (libra = 0.453592, gramo = 0.001)
- Validar que la abreviatura sea única dentro del tenant
- Las unidades del sistema (kg, L, unidad) no pueden eliminarse

*EXCEPCIÓN:* Las conversiones deben ser precisas para cálculos de inventario y facturación.

**RN-CAT-005: Búsqueda de Productos en POS**
*SI* el cajero busca un producto en el POS,
*ENTONCES* el sistema debe:
- Buscar por múltiples criterios simultáneamente:
  - `product_variants.sku` (código interno)
  - `product_variants.barcode` (código de barras, soporta EAN-13, UPC, Code 128, QR)
  - `products.name` (búsqueda fuzzy con trigramas)
  - `product_categories.name` (por categoría)
- Excluir productos con `is_active = false`
- Excluir productos agotados: `current_quantity = 0` en todos los lotes de la sucursal
- Ordenar resultados por relevancia: barcode exacto primero, luego sku, luego nombre
- Retornar foto, nombre, precio según lista de precios del cliente, stock disponible

*EXCEPCIÓN:* Productos agotados pueden mostrarse si el cajero busca explícitamente por código (para devoluciones o consultas). La búsqueda soporta tipeo parcial con debounce de 300ms.

*INTEGRACIÓN CRUZADA:* La búsqueda consulta `product_variants` JOIN `products` JOIN `inventory_lotes` para obtener stock.

**RN-CAT-006: Asociación de Marca**
*SI* se asocia una marca a un producto,
*ENTONCES* el sistema debe:
- Validar que la marca exista y esté activa
- Permitir marca NULL (producto sin marca)
- Si la marca tiene logo, incluirlo en búsquedas y listados
- Las marcas se pueden crear/administrar independientemente de los productos

*EXCEPCIÓN:* Las marcas inactivas no aparecen en filtros de búsqueda pero los productos asociados siguen visibles.

---

## PARTE 5: MÓDULO DE PRECIOS DINÁMICOS

### 5.1 Objetivo del Módulo

Gestionar múltiples listas de precios según tipo de cliente (minorista, mayorista, VIP), aplicar descuentos por volumen, promociones temporales, y garantizar que el precio correcto se aplique según el contexto de la transacción.

### 5.2 Reglas de Negocio

**RN-PRE-001: Estructura de Listas de Precios**
*SI* se crea una lista de precios en `price_lists`,
*ENTONCES* el sistema debe:
- Definir `customer_type` objetivo: retail, wholesale, vip, special, all
- Si `customer_type = all`, la lista aplica a todos los tipos
- Setear `is_default = true` solo si es la primera lista para ese tipo
- Si `is_default = true`, usada automáticamente para nuevos clientes de ese tipo
- Definir vigencia: `valid_from` y `valid_to` (pueden ser NULL para vigencia indefinida)
- Si `branch_id` es NULL, la lista aplica a todas las sucursales
- Si `branch_id` tiene valor, la lista es específica para esa sucursal

*EXCEPCIÓN:* No puede haber dos listas default para el mismo `customer_type` y `branch_id`. Las listas vencidas no se aplican automáticamente.

**RN-PRE-002: Determinación de Precio por Transacción**
*SI* se necesita obtener el precio de un producto para una transacción,
*ENTONCES* el sistema debe ejecutar el siguiente algoritmo de resolución:
1. Identificar lista de precios aplicable:
   - Si cliente tiene lista asignada: usar esa
   - Sino usar lista default para `customer_type`
   - Si hay lista específica para la sucursal, tiene prioridad sobre lista general
2. Buscar precio en `price_list_items`:
   - `price_list_id = lista_identificada`
   - `variant_id = producto`
   - `min_quantity <= cantidad` (para descuentos por volumen)
   - Ordenar por `min_quantity DESC` para obtener el precio de mayor volumen
3. Si no hay precio específico, usar precio base del producto (deprecated, no debería ocurrir)
4. Aplicar descuentos automáticos si aplica: `discount_percent` de la lista

*EXCEPCIÓN:* Si no hay ninguna lista de precios configurada, el sistema debe rechazar la transacción con mensaje "No hay lista de precios configurada para este cliente".

*INTEGRACIÓN CRUZADA:* Este cálculo ocurre en POS y Portal al agregar producto al carrito, y en el backend al confirmar venta/pedido.

**RN-PRE-003: Descuento por Volumen**
*SI* un cliente compra una cantidad mayor al `min_quantity` de un precio por volumen,
*ENTONCES* el sistema debe:
- Aplicar automáticamente el precio de volumen correspondiente
- El `min_quantity` mayor tiene prioridad sobre el menor
- Si hay múltiples filas con mismo `min_quantity`, usar la primera
- El precio con volumen puede ser:
  - `volume_price`: precio unitario especial (ej: $9.500 en vez de $10.000)
  - `discount_percent`: porcentaje de descuento sobre precio base
- El descuento por volumen NO se acumula con otros descuentos salvo configuración explícita

*EXCEPCIÓN:* Los descuentos por volumen aplican solo a productos de la misma variante. No se puede mezclar para alcanzar cantidad.

**RN-PRE-004: Promociones Temporales**
*SI* existe una promoción activa y un producto aplica,
*ENTONCES* el sistema debe:
- La promoción puede definir:
  - `discount_percent`: porcentaje de descuento
  - `discount_amount`: monto fijo de descuento
  - `special_price`: precio especial fijo
- Verificar vigencia: `valid_from <= NOW() <= valid_to`
- Verificar condiciones:
  - `min_purchase_amount`: monto mínimo de compra
  - `customer_types`: tipos de cliente que aplican
  - `max_uses_per_customer`: límite por cliente
  - `total_max_uses`: límite global
- Si múltiples promociones aplican, usar la de mayor descuento para el cliente
- Si no son acumulables (regla general), aplicar solo la mejor

*EXCEPCIÓN:* Las promociones excluyen productos específicos definidos en `promotion_exclusions`. Las promociones con `max_uses` agotadas no aplican.

**RN-PRE-005: Cálculo de Margen de Utilidad**
*SI* se registra una venta con precio y se conoce el costo,
*ENTONCES* el sistema debe:
- Calcular `cost_price` desde los lotes consumidos (FIFO)
- Para cada ítem: `line_cost = quantity * cost_price` del lote
- `total_cost = SUM(line_cost)` de todos los ítems
- `profit_margin = total - total_cost`
- `margin_percent = (profit_margin / total) * 100`
- Registrar estos valores en `sales` y `sales_details`
- Los precios de compra y márgenes SOLO son visibles para roles Dueño y Administrador

*EXCEPCIÓN:* Si el producto no tiene lotes (venta de inventario manual), usar `cost_price` promedio o el último conocido.

**RN-PRE-006: Visibilidad de Precios por Rol**
*SI* un usuario consulta precios,
*ENTONCES* el sistema debe:
- Roles Dueño y Administrador: ven precio de costo (`cost_price`) y precio de venta
- Roles Cajero y Vendedor: ven solo precio de venta y margen si es necesario para operaciones
- Roles Cliente (Portal): ven solo precio según su lista de precios
- Los precios de compra NUNCA son visibles fuera de roles administrativos

*EXCEPCIÓN:* El cálculo de margen en reportes puede mostrarse a supervisores pero sin valores absolutos de costo.

---

## PARTE 6: MÓDULO DE GESTIÓN DE COMPRAS Y PROVEEDORES

### 6.1 Objetivo del Módulo

Gestionar el ciclo completo de compras desde la creación de órdenes de compra hasta la recepción de mercancía, incluyendo verificación de cantidades, gestión de diferencias, creación automática de lotes de inventario con trazabilidad completa hacia la factura del proveedor.

### 6.2 Reglas de Negocio

**RN-CMP-001: Creación de Orden de Compra**
*SI* un usuario con rol Administrador, Comprador o Supervisor crea una orden de compra,
*ENTONCES* el sistema debe:
- Generar `order_number` único secuencial dentro del tenant: `OC-{branch_code}-{YYYY}-{000000}`
- Validar que el proveedor exista (`suppliers.id`) y tenga `is_active = true` y `is_blocked = false`
- Validar que la sucursal destino exista y esté activa
- Validar capacidad de la sucursal para recibir más productos (límite configurable en `branches.settings.max_products`)
- Calcular totales sumando `quantity * unit_price` de cada ítem
- Registrar `created_by` con el UUID del usuario autenticado
- Setear `status = 'draft'` inicialmente
- Crear registro en `audit_logs` con acción `create` y `entity_type = 'purchase_orders'`

*EXCEPCIÓN:* Si el proveedor está bloqueado (`is_blocked = true`), rechazar con mensaje "El proveedor se encuentra bloqueado. Contacte al administrador." Si la sucursal está inactiva, rechazar.

*INTEGRACIÓN CRUZADA:* La creación de OC NO afecta inventario. El inventario se modifica SOLO al recibir mercancía.

**RN-CMP-002: Estados de Orden de Compra**
*SI* ocurre cualquier transición de estado en una orden de compra,
*ENTONCES* el sistema debe validar y ejecutar según la siguiente máquina de estados:

```
draft ──[enviar]──→ sent ──[confirmar]──→ confirmed
    ↓                              ↓
    └──────── [cancelar] ─────────┴─── [cancelar]
                                         ↓
                                      cancelled
sent ──[recibir parcial]──→ partial_received ──[recibir resto]──→ received
    ↓                                    ↓
    └──────── [recibir todo] ───────────┴─── [diferencias] ──────→ received_with_differences
```

*EXCEPCIÓN:* Una orden en estado `received` o `cancelled` NO puede cambiar de estado. Los estados `partial_received` pueden recibir múltiples recepciones hasta completar.

**RN-CMP-003: Envío de Orden a Proveedor**
*SI* una orden en estado `draft` es marcada como `sent`,
*ENTONCES* el sistema debe:
- Cambiar `status` a `sent`
- Registrar `sent_at` con timestamp actual
- Generar documento imprimible/enviable al proveedor (PDF con formato configurable)
- Enviar notificación al email del proveedor si está configurado
- Bloquear modificaciones a los ítems de la orden (solo Admins pueden editar)
- Registrar en `audit_logs`

*EXCEPCIÓN:* Si la orden tiene items con `quantity = 0`, mostrar warning y requerir confirmación antes de enviar. El cambio de estado NO afecta contabilidad.

**RN-CMP-004: Recepción de Mercancía con Verificación**
*SI* un usuario inicia el proceso de recepción seleccionando una orden de compra,
*ENTONCES* el sistema debe:
- Cargar todos los items de la orden en pantalla de verificación
- Por cada item, permitir seleccionar estado:
  - `recibido`: cantidad recibida = cantidad ordenada
  - `parcial`: cantidad recibida < cantidad ordenada (requiere ingresar `received_quantity`)
  - `no_recibido`: cantidad recibida = 0 (requiere motivo opcional)
  - `pendiente`: aún no se ha verificado
- Calcular dinámicamente `total_a_pagar = Σ(received_quantity * unit_price)`
- Si `received_quantity > ordered_quantity`, mostrar warning de "Sobrante" con justificación obligatoria

*EXCEPCIÓN:* Los items marcados como `no_recibido` se registran como backorder en `purchase_order_items.received_quantity = 0`. Se permiten hasta 10 recepciones parciales por orden.

**RN-CMP-005: Generación de Factura de Compra Ajustada**
*SI* el proceso de recepción es completado y confirmado,
*ENTONCES* el sistema debe:
- Crear registro en `purchase_invoices` con `invoice_number` único: `FC-{branch_code}-{YYYY}-{000000}`
- Asignar `purchase_order_id` de la orden origen
- Establecer `subtotal`, `tax`, `total` basados en cantidades REALMENTE recibidas (no las ordenadas)
- Marcar la orden de compra:
  - Si todas recibidas: `status = 'received'`
  - Si parcial: `status = 'partial_received'`
  - Si con diferencias: `status = 'received_with_differences'`
- Generar cuenta por pagar en `accounts_payable` al proveedor por el monto real
- Si hay diferencia entre OC y factura, crear registro de discrepancia para auditoría
- Crear registro en `audit_logs`

*EXCEPCIÓN:* Si la factura del proveedor difiere del monto calculado en más del 5%, crear `purchase_invoice.status = 'pending_review'` y alertar al administrador.

*INTEGRACIÓN CRUZADA:* La factura debe quedar vinculada al lote mediante `inventory_lotes.purchase_invoice_id`.

**RN-CMP-006: Creación de Lotes de Inventario**
*SI* la recepción de mercancía es confirmada y la factura es creada,
*ENTONCES* el sistema debe:
- Por cada item recibido con `received_quantity > 0`, crear registro en `inventory_lotes`:
  - `lot_number`: Generated as `{variant_code}-{YYYYMMDD}-{seq}` (ej: QF-001-20260113-001)
  - `purchase_invoice_id`: ID de la factura creada
  - `branch_id`: Sucursal destino
  - `initial_quantity`: Cantidad recibida
  - `current_quantity`: Igual a initial_quantity
  - `purchase_price`: Precio unitario de la factura
  - `expiry_date`: Requerido si `products.has_expiry = true`, opcional sino
  - `status = 'active'`
- Crear movimiento en `inventory_movements`:
  - `movement_type = 'purchase'`
  - `quantity = received_quantity` (positivo = entrada)
  - `reference_type = 'purchase_invoice'`
  - `reference_id = invoice_id`

*EXCEPCIÓN:* Si el producto no tiene variante creada (`product_variants`), bloquear la recepción hasta que se cree el SKU. El lote queda disponible INMEDIATAMENTE para ventas.

*TECNOLOGÍA:* Usar transacción PostgreSQL atómica para garantizar consistencia entre factura, lote y movimiento.

**RN-CMP-007: Seguimiento de Recepciones Parciales**
*SI* una orden de compra tiene items pendientes (`status = 'partial_received'`),
*ENTONCES* el sistema debe:
- Mantener la orden activa para recepciones adicionales
- Permitir crear nueva recepción seleccionando la misma orden
- Actualizar `received_quantity` cumulativamente en `purchase_order_items`
- Cuando `received_quantity == ordered_quantity`, cambiar `purchase_orders.status` a `received`
- Permitir hasta 10 recepciones parciales por orden (configurable)
- Si pasan más de 30 días sin recibir la totalidad, alertar al administrador para decisión

*EXCEPCIÓN:* Las alertas de 30 días se envían por email y aparecen en dashboard como notificaciones pendientes.

**RN-CMP-008: Bloqueo de Proveedor**
*SI* un Administrador marca un proveedor como bloqueado,
*ENTONCES* el sistema debe:
- Setear `suppliers.is_blocked = true`
- Solicitar `blocked_reason` obligatorio (texto libre)
- El proveedor bloqueado NO aparece en selección de órdenes de compra
- Órdenes existentes con el proveedor pueden continuar o cancelarse según decisión del admin
- Registrar en `supplier_blocking_history` con timestamp y usuario
- Crear registro en `audit_logs`

*EXCEPCIÓN:* Proveedores bloqueados por calidad (rating < 2.0) requieren plan de mejora documentado para desbloqueo.

**RN-CMP-009: Evaluación de Proveedor Post-Recepción**
*SI* una recepción de mercancía es completada,
*ENTONCES* el sistema debe:
- Solicitar calificación del proveedor:
  - `quality_score`: 1-5 estrellas (estado del producto)
  - `punctuality_score`: 1-5 estrellas (a tiempo vs esperado)
  - `price_score`: 1-5 estrellas (precios competitivos)
  - `service_score`: 1-5 estrellas (atención)
  - `compliance_score`: 1-5 estrellas (cumplimiento de órdenes)
- Registrar `evaluation_notes` opcionales
- Calcular métricas agregadas:
  - `rating`: Promedio de todas las evaluaciones
  - `on_time_delivery_rate`: % de recepciones a tiempo
  - Actualizar en `suppliers`

*EXCEPCIÓN:* Proveedores nuevos start con rating 0 hasta tener mínimo 3 evaluaciones.

---

## PARTE 7: MÓDULO DE SUMINISTROS CORPORATIVOS DEL DUEÑO

### 7.1 Objetivo del Módulo

Gestionar el flujo de productos desde el inventario corporativo (del Dueño) hacia las sucursales, creando transacciones internas que generan cuentas por pagar de la sucursal hacia el corporativo sin afectar el flujo de caja real externo. Este módulo es DISTINTO de las compras a proveedores externos.

### 7.2 Reglas de Negocio

**RN-CORP-001: Registro de Compra Corporativa del Dueño**
*SI* el Dueño registra una compra realizada con su dinero personal para distribuir a sucursales,
*ENTONCES* el sistema debe:
- Crear registro en `corporate_purchases`:
  - `supplier_id`: Proveedor original de la compra
  - `total_amount`: Costo real pagado por el Dueño
  - `products_detail`: JSONB con items comprados [{variant_id, quantity, unit_price}]
  - `status = 'pending_distribution'`
  - `purchase_date`: Fecha de la compra
  - `invoice_number`: Número de factura del proveedor
- NO crear cuenta por pagar (el Dueño YA pagò)
- Mantener el producto en "Inventario Corporativo" pendiente de distribuir
- Registrar en `audit_logs`

*EXCEPCIÓN:* Si la compra es para uso directo de una sucursal (no distribución), tratar como compra normal de la sucursal. Esta tabla NO tiene `branch_id` porque es corporativa.

**RN-CORP-002: Creación de Orden de Suministro**
*SI* el Dueño inicia una distribución desde `/corporativo/suministros/nueva`,
*ENTONCES* el sistema debe:
- Mostrar inventario corporativo disponible (productos en `corporate_purchases` con status 'pending_distribution' o 'partially_distributed')
- Permitir seleccionar sucursal(es) destino
- Permitir seleccionar productos y cantidades a distribuir
- Definir `transfer_price`: precio al que la sucursal "compra" al corporativo:
  - Puede ser igual al costo (sin margen)
  - Puede ser costo + margen (para utilidad del Dueño)
  - Puede ser precio especial (para estrategias comerciales)
- Calcular `total_debt = Σ(cantidad * transfer_price)` para cada sucursal
- Generar documento de transferencia interna
- Crear cuenta por cobrar al corporativo (en la sucursal) en `corporate_accounts_payable`

*EXCEPCIÓN:* Si no hay inventario corporativo suficiente, rechazar o sugerir cantidad máxima disponible. El `transfer_price` debe ser ≥ costo (no puede ser negativo el margen).

*INTEGRACIÓN CRUZADA:* **CRÍTICO** - Esto afecta `corporate_accounts_payable` de la sucursal hacia `corporate_accounts_receivable` del corporativo.

**RN-CORP-003: Confirmación de Recepción en Sucursal**
*SI* el Administrador de Sucursal confirma la recepción de suministros,
*ENTONCES* el sistema debe:
- Crear lotes en `inventory_lotes` de la sucursal:
  - `lot_number` incluye identificador "CORP-{date}" para distinguir de compras externas
  - `purchase_invoice_id = NULL` (no hay factura externa)
  - `purchase_price = transfer_price` (para cálculo de margen en la sucursal)
- Incrementar `current_quantity` del inventario de la sucursal
- Crear movimiento `inventory_movements` con `movement_type = 'corporate_transfer_in'`
- Marcar cuenta por pagar de la sucursal como "pendiente de pago a corporativo"
- Actualizar status de la transferencia a 'received'

*EXCEPCIÓN:* Si las cantidades recibidas difieren de las enviadas, crear registro de diferencia para conciliación y ajustar la deuda.

*INTEGRACIÓN CRUZADA:* El inventario está disponible para venta INMEDIATAMENTE tras confirmar recepción.

**RN-CORP-004: Pago de Deuda de Sucursal a Corporativo**
*SI* la sucursal registra un pago hacia el corporativo,
*ENTONCES* el sistema debe:
- Crear registro en `corporate_payments`:
  - `branch_id`: Sucursal que paga
  - `amount`: Monto del pago
  - `payment_method`: Efectivo, transferencia, Nequi, etc.
  - `reference`: Número de transacción bancaria (si aplica)
- Actualizar saldo de cuenta por pagar: `balance -= amount`
- Registrar en `cash_movements` de la sucursal como egreso hacia corporativo
- Si es pago en efectivo, disminuir `cash_sessions.system_amount`
- Crear entrada correspondiente en `corporate_accounts_receivable` del corporativo

*EXCEPCIÓN:* El pago hacia corporativo NO va a un proveedor real, es cuenta interna. NO afectar `suppliers` ni `purchase_invoices`.

*INTEGRACIÓN CRUZADA:* Genera asiento contable automático en la sucursal y en corporativo.

**RN-CORP-005: Estados de Cuentas Corporativas**
*SI* el sistema procesa cualquier transacción de suministro corporativo,
*ENTONCES* debe mantener los siguientes estados:

| Entity | Estados | Descripción |
|--------|---------|-------------|
| `corporate_purchases` | pending_distribution, partially_distributed, distributed | Control de inventario corporativo |
| `corporate_transfers` | pending, in_transit, received, cancelled | Flujo de distribución |
| `corporate_accounts_payable` | pending, partial, paid, overdue | Deuda de sucursal a corporativo |
| `corporate_accounts_receivable` | pending, partial, paid, overdue | Crédito del corporativo a sucursal |

*EXCEPCIÓN:* Estados `overdue` generan alerta automática al administrador de la sucursal y al Dueño.

**RN-CORP-006: Reportes de Suministros Corporativos**
*SI* se solicita reporte de suministros corporativos,
*ENTONCES* el sistema debe generar:
- Inversión total del Dueño en suministros por período
- Suministros distribuidos por sucursal
- Cuentas por cobrar del Dueño a sucursales
- Rentabilidad del Dueño en suministros: `(precio_transfer - costo) × cantidad`
- Comparativa de precios corporativos vs precios de mercado
- Estado de deuda de cada sucursal

*EXCEPCIÓN:* Los reportes de corporativa son visibles solo para roles Dueño y Administrador Corporativo.

---

## PARTE 8: MÓDULO DE CONTROL DE CAJA DIARIO

### 8.1 Objetivo del Módulo

Gestionar el cuadre diario de caja en un modelo OPERATIVO donde NO se registran ventas individuales ticket a ticket en el POS físico. El sistema se basa en apertura de caja, registro de créditos otorgados, salidas de dinero, cobros de créditos y cierre con cuadre ciego entre el cálculo del sistema y el conteo físico del cajero.

### 8.2 Reglas de Negocio

**RN-CAJ-001: Apertura de Caja Diaria**
*SI* un usuario inicia una sesión de caja en `/caja/apertura`,
*ENTONCES* el sistema debe:
- Validar que no exista `cash_sessions` abierta para hoy en la sucursal (`status = 'open'`)
- Crear registro con:
  - `user_id`: Cajero responsable (logueado)
  - `cash_register_id`: Caja seleccionada
  - `opening_date`: Timestamp actual
  - `initial_amount`: Monto declarado de apertura
  - `status = 'open'`
  - `total_cash_in = 0`, `total_cash_out = 0`, `total_sales_cash = 0`, `total_credit_payments = 0`
- Iniciar cálculo de `system_amount = initial_amount`
- Registrar en `audit_logs`

*EXCEPCIÓN:* Si ya existe caja abierta, mostrar opción de "Continuar sesión" (si es el mismo cajero) o forzar cierre (si es otro cajero).

*INTEGRACIÓN CRUZADA:* La apertura de caja habilita el POS y todas las operaciones de efectivo en la sucursal.

**RN-CAJ-002: Registro de Crédito Otorgado (Venta a Crédito sin Factura Individual)**
*SI* un cajero registra una venta a crédito durante el día,
*ENTONCES* el sistema debe:
- Crear registro en `day_credits`:
  - `customer_id`: Cliente (nombre rápido si es nuevo)
  - `amount`: Monto del crédito
  - `credit_date`: Fecha actual
  - `status = 'pending'`
  - `notes`: Productos vendidos (general, no detallado)
- Generar número de comprobante único: `CRE-{branch}-{YYYYMMDD}-{0000}`
- NO incrementar `cash_sessions.total_cash_in` (no entra efectivo aún)
- Crear cuenta por cobrar en `credit_accounts` del cliente:
  - `transaction_type = 'charge'`
  - `balance_after += amount`
- Registrar en `audit_logs`

*EXCEPCIÓN:* Si el cliente tiene crédito vencido o excede su `credit_limit`, rechazar operación con mensaje explicativo.

*INTEGRACIÓN CRUZADA:* El crédito aparece en "Cuentas por Cobrar" inmediatamente y afecta el límite disponible del cliente.

**RN-CAJ-003: Registro de Cobro de Crédito en Efectivo**
*SI* un cajero registra el pago de un crédito anterior EN EFECTIVO,
*ENTONCES* el sistema debe:
- Actualizar `day_credits.status` a 'paid'
- Crear `cash_movements`:
  - `movement_type = 'income'`
  - `category = 'credit_payment'`
  - `amount = payment_amount`
  - `reference_type = 'credit'`
  - `reference_id = credit_id`
- Incrementar `cash_sessions.total_cash_in += amount`
- Incrementar `cash_sessions.total_credit_payments += amount` (para tracking)
- Crear `credit_transactions` con `transaction_type = 'payment'`
- Actualizar `credit_accounts.balance -= amount`
- Registrar en `audit_logs`

*EXCEPCIÓN:* Si el monto del pago difiere del crédito, permitir pago parcial y mantener saldo pendiente. Actualizar `balance_after` соответственно.

*INTEGRACIÓN CRUZADA:* El efectivo entra a caja y suma al `system_amount`.

**RN-CAJ-004: Registro de Salida de Dinero (Egresos)**
*SI* un cajero o administrador registra cualquier egreso de efectivo,
*ENTONCES* el sistema debe:
- Crear `cash_movements` con `movement_type = 'expense'` o `withdrawal`
- Clasificar según categoría:
  - `supplier_payment`: Pago a proveedor
  - `expense`: Gasto operativo
  - `owner_withdrawal`: Retiro del dueño
  - `other`: Otro egreso
- Requerir: `concept`, `amount`, `beneficiary`
- Opcional: `evidence_url` (foto de recibo)
- Incrementar `cash_sessions.total_cash_out += amount`
- Si es pago a proveedor, actualizar `purchase_invoices.paid_amount` y `balance`
- Registrar en `audit_logs`

*EXCEPCIÓN:* Si es pago a proveedor, debe vincularse a factura específica (`reference_type = 'purchase_invoice'`, `reference_id = invoice_id`) para afectar cuentas por pagar.

*INTEGRACIÓN CRUZADA:* El egreso disminuye el `system_amount` de la caja.

**RN-CAJ-005: Registro de Movimientos Online (Nequi, Transferencias)**
*SI* se registra un ingreso o egreso por canales online,
*ENTONCES* el sistema debe:
- NO afectar `cash_sessions` (es caja diferente)
- Crear `online_account_movements`:
  - `account_type`: Nequi, Bancolombia, Davivienda, etc.
  - `movement_type`: income/expense
  - `reference`: Número de transacción
  - `amount`: Monto
  - `balance_after`: Saldo actualizado de la cuenta
- Mantener `online_accounts.balance` calculado como suma de movimientos
- Registrar en `audit_logs`

*EXCEPCIÓN:* Si el balance calculado difiere del saldo real en la app del banco (conciliación), crear alerta de discrepancia para investigar.

*INTEGRACIÓN CRUZADA:* Reporte de cierre debe incluir resumen de movimientos online para conciliación.

**RN-CAJ-006: Cierre de Caja - Cuadre Ciego**
*SI* un usuario inicia el proceso de cierre de caja,
*ENTONCES* el sistema debe:
- Calcular `system_amount = initial_amount + total_cash_in + total_credit_payments - total_cash_out`
- Mostrar en pantalla SOLO el `system_amount` (monto esperado)
- Solicitar al cajero que ingrese `declared_amount` (contado físico, SIN mostrar el cálculo)
- Calcular `difference = declared_amount - system_amount`
- Si `|difference| > 50000` (threshold configurable), requerir `difference_justification` obligatoria
- Validar que los `cash_movements` del día estén completos
- Setear `cash_sessions.status = 'pending_approval'` si hay diferencia significativa

*EXCEPCIÓN:* Si la justificación no se proporciona o es insuficiente, bloquear cierre hasta aprobación de supervisor.

*INTEGRACIÓN CRUZADA:* El cuadre ciego es OBLIGATORIO para cerrar sesión de caja. Genera asientos contables automáticos.

**RN-CAJ-007: Aprobación de Diferencias de Cuadre**
*SI* existe diferencia de cuadre mayor al umbral,
*ENTONCES* el sistema debe:
- Crear solicitud de aprobación en `cash_session_differences`
- Notificar al Supervisor/Administrador
- El aprobador puede:
  - Aprobar con comentario: registra `difference_approved_by` y `difference_approved_at`
  - Rechazar: requiere reconteo por parte del cajero
  - Asignar a otro usuario para investigación
- Si es aprobada, permitir cerrar la caja
- Registrar en `audit_logs`

*EXCEPCIÓN:* Diferencias recurrentes del mismo cajero (más de 3 en 30 días) deben generar alerta de auditoría para revisión.

**RN-CAJ-008: Generación de Reporte de Cierre**
*SI* el cierre de caja es completado exitosamente,
*ENTONCES* el sistema debe generar documento con:
- `initial_amount`: Apertura
- `total_cash_in`: Entradas de efectivo (ventas contado + cobros créditos)
- `total_cash_out`: Salidas (gastos, pagos, retiros)
- `total_sales_cash`: Ventas en efectivo estimadas (input manual del cajero)
- `total_credit_payments`: Cobros en efectivo de créditos
- `system_amount`: Efectivo esperado (calculado)
- `declared_amount`: Efectivo contado
- `difference`: Diferencia (sobrante/faltante)
- `online_incomes`: Ingresos por canales online
- `online_expenses`: Egresos por canales online
- Listado de `cash_movements` del día
- Firmas: Cajero y supervisor (si aplica)

*EXCEPCIÓN:* El reporte debe ser exportable en PDF para archivo físico. Generar asiento contable automático.

---

## PARTE 9: MÓDULO DE CONTABILIDAD SIMPLIFICADA NIIF PYMES

### 9.1 Objetivo del Módulo

Generar automáticamente asientos contables basados en las transacciones operativas (compras, ventas, caja, créditos), respetando el Plan de Cuentas PUC colombiano y la normativa NIIF PYMES. El módulo debe trabajar con el modelo híbrido donde las ventas POS no generan asientos individuales sino consolidados del cuadre.

### 9.2 Reglas de Negocio

**RN-CON-001: Validación de Período Contable**
*SI* cualquier transacción que genera asiento contable es ejecutada,
*ENTONCES* el sistema debe:
- Verificar que el `accounting_period` exista para el mes/año de la transacción
- Si no existe, crearlo con `is_closed = false`
- Validar que `is_closed = false`
- Si `is_closed = true`, rechazar la transacción con mensaje "El período contable está cerrado. No se pueden registrar movimientos."
- Registrar el intento fallido en `audit_logs`

*EXCEPCIÓN:* Los ajustes de inventario físico pueden permitir excepciones con aprobación explícita de Administrador y registro de justificación.

**RN-CON-002: Asiento Automático por Compra a Proveedor**
*SI* una factura de compra es creada y confirmada,
*ENTONCES* el sistema debe generar automáticamente el siguiente asiento:

```
Débito: 5xxx - Compras (subtotal de la factura)
Débito: 2xxx - IVA Descontable (impuesto de la factura)
Crédito: 21xx - Proveedores (total de la factura)
```

- Crear registro en `accounting_entries`:
  - `entry_number`: `ASI-{branch}-{YYYY}-{000000}`
  - `entry_date`: Fecha de la factura
  - `reference_type = 'purchase_invoice'`
  - `reference_id = invoice_id`
  - `description`: "Compra a [proveedor] - Factura [número]"
  - `is_auto_generated = true`
- Crear líneas en `accounting_entry_lines` con las cuentas del PUC

*EXCEPCIÓN:* Si el proveedor tiene retención configurada, generar asiento adicional de retención en fuente (débito adicional a 2360, crédito a 2365).

**RN-CON-003: Asiento Automático por Cierre de Caja (Ventas Consolidadas)**
*SI* un cierre de caja es completado,
*ENTONCES* el sistema debe generar asientos basados en el cuadre:

```
-- Si hubo ventas de contado (estimadas)
Débito: 11xx - Caja General (efectivo contado)
Débito: 12xx - Bancos/Cuentas Online (pagos online)
Crédito: 41xx - Ventas (subtotal de ventas)
Crédito: 24xx - IVA Generado (impuesto)

-- Cobros de créditos del día
Débito: 11xx - Caja General
Crédito: 13xx - Clientes (por el monto cobrado)

-- Costos de venta (calculado desde lotes consumidos del día)
Débito: 61xx - Costo de Ventas
Crédito: 14xx - Inventario
```

*EXCEPCIÓN:* En modelo simplificado sin ventas individuales, el asiento de ventas usa el total estimado del cuadre (`total_sales_cash` input manual). El costo de venta se calcula desde `inventory_movements` del día con `movement_type = 'sale'`.

**RN-CON-004: Asiento Automático por Pago a Proveedor**
*SI* un pago a proveedor es registrado,
*ENTONCES* el sistema debe generar:

```
Débito: 21xx - Proveedores (monto del pago)
Crédito: 11xx - Caja General (si efectivo)
Crédito: 12xx - Bancos (si transferencia)
```

*EXCEPCIÓN:* Si el pago incluye retención, ajustar los montos correspondientemente. El asiento reduce el balance de la factura en `purchase_invoices`.

**RN-CON-005: Asiento Automático por Suministro Corporativo (Entrada a Sucursal)**
*SI* una sucursal recibe suministros del corporativo,
*ENTONCES* el sistema debe generar en la sucursal:

```
-- Por el valor del suministro
Débito: 14xx - Inventario (transfer_price × cantidad)
Crédito: 21xx - Cuentas por Pagar a Corporativo
```

*EXCEPCIÓN:* El asiento NO incluye IVA (es movimiento interno entre entidades del mismo grupo). En corporativo, generar asiento inverso en cuentas por cobrar.

**RN-CON-006: Asiento Automático por Pago de Deuda Corporativa**
*SI* una sucursal paga su deuda hacia el corporativo,
*ENTONCES* generar en la sucursal:

```
Débito: 21xx - Cuentas por Pagar a Corporativo
Crédito: 11xx - Caja General
```

*EXCEPCIÓN:* El corporativo registra simultáneamente el cobro en su contabilidad separada.

**RN-CON-007: Validación de Partida Doble**
*SI* cualquier asiento contable es creado,
*ENTONCES* el sistema debe:
- Validar que `SUM(debit) = SUM(credit)` con tolerancia de 0.01
- Validar que cada línea tenga exactamente débito O crédito (no ambos, no ninguno)
- Validar que las cuentas sean del tipo correcto:
  - Activos (1xxx): saldo deudor normal
  - Pasivos (2xxx): saldo acreedor normal
  - Patrimonio (3xxx): saldo acreedor normal
  - Ingresos (4xxx): saldo acreedor normal
  - Gastos (5xxx): saldo deudor normal
- Si la validación falla, rechazar el asiento y registrar error en logs

*EXCEPCIÓN:* Los asientos rechazados deben poder editareintentarse. Los errores de validación se notifican al administrator.

*TECNOLOGÍA:* Trigger PostgreSQL `validate_double_entry()` que corre antes de INSERT en `accounting_entry_lines`.

**RN-CON-008: Cierre de Período Contable**
*SI* un Administrador solicita cerrar un período contable,
*ENTONCES* el sistema debe:
- Verificar que no hayan transacciones pendientes de registrar
- Validar que el cuadre de caja de todos los días del mes esté completado
- Generar asiento de cierre mensual si aplica (depende de política contable)
- Setear `accounting_periods.is_closed = true`
- Setear `closed_at = NOW()` y `closed_by = user_id`
- Bloquear modificaciones retroactivas al período
- Generar libro diario del período para archivo

*EXCEPCIÓN:* Una vez cerrado, el período NO puede abrirse sin intervención de soporte (auditoría completa requerida).

**RN-CON-009: Generación de Libros Contables**
*SI* se solicita generar libro de ventas, compras o diario,
*ENTONCES* el sistema debe:
- Filtrar `accounting_entries` por período contable
- Agrupar por cuenta o por documento según tipo de libro
- Calcular subtotales y totales
- Formatear según normativa DIAN
- Generar archivo en Excel/PDF estructurado
- Permitir exportación a formato medios magnéticos (XML/texto)

*EXCEPCIÓN:* Períodos cerrados generan libros inmutables. Los libros se usan para declaraciones tributarias y auditoría.

**RN-CON-010: Cálculo de IVA**
*SI* se procesa una transacción con productos gravados,
*ENTONCES* el sistema debe:
- Identificar tarifa de IVA del producto (19%, 5%, 0%)
- Calcular IVA: `subtotal × (tarifa / 100)`
- En compras: registrar como IVA Descontable (2370)
- En ventas: registrar como IVA Generado (2408)
- Al cierre de período: calcular `IVA a Pagar = IVA Generado - IVA Descontable`
- Generar reporte de IVA por tarifa para declaraciones

*EXCEPCIÓN:* Productos exentos (tarifa 0%) no generan IVA. La configuración de tarifas está en `products.iva_rate`.

---

## PARTE 10: MÓDULO DE VENTAS Y PUNTO DE VENTA (POS)

### 10.1 Objetivo del Módulo

Proporcionar interfaz rápida de venta para operación en mostrador. En el modelo de Quesera D&G, el POS opera de forma simplificada: no registra ventas individuales detalladas ticket a ticket para el cuadre, pero SÍ registra cada venta para trazabilidad de inventario (consumo FIFO por lote).

### 10.2 Reglas de Negocio

**RN-POS-001: Búsqueda de Productos en POS**
*SI* el cajero busca un producto en el POS,
*ENTONCES* el sistema debe:
- Buscar por: código SKU, código de barras (EAN-13, UPC, Code 128, QR), nombre (búsqueda fuzzy)
- Excluir productos con `is_active = false`
- Excluir productos agotados (`current_quantity = 0` en todos los lotes de la sucursal)
- Mostrar foto, nombre, precio (según lista de precios del cliente) y stock disponible
- Ordenar resultados por relevancia

*EXCEPCIÓN:* Productos agotados pueden mostrarse con indicador "Agotado" si se busca explícitamente por código.

**RN-POS-002: Consumo de Inventario por Venta (FIFO)**
*SI* una venta es confirmada en POS,
*ENTONCES* el sistema debe:
- Para cada producto vendido:
  1. Identificar lotes disponibles: `SELECT * FROM inventory_lotes WHERE variant_id = ? AND branch_id = ? AND status = 'active' AND current_quantity > 0 ORDER BY created_at ASC`
  2. Ordenar por `created_at` (FIFO - primero el más antiguo)
  3. Consumir del lote más antiguo primero
  4. Si el lote no alcanza, continuar con el siguiente
  5. Crear `inventory_movements` por cada lote consumido:
     - `movement_type = 'sale'`
     - `quantity = -cantidad_consumida` (negativo = salida)
  6. Cerrar lotes que llegan a `current_quantity = 0` (status = 'depleted')
- Calcular `total_cost` desde precios de los lotes consumidos
- Registrar en `sales` y `sales_details` con trazabilidad completa

*EXCEPCIÓN:* Si no hay stock suficiente, rechazar la venta o permitir venta parcial. La venta NO puede proceeder si no hay inventario.

*INTEGRACIÓN CRUZADA:* **CRÍTICO** - El kardex debe reflejar cada salida por lote. El costo de venta se calcula para margen.

**RN-POS-003: Registro de Venta Simplificada (Modelo Quesera D&G)**
*SI* el cajero confirma una venta en POS,
*ENTONCES* el sistema debe:
- Crear registro en `sales`:
  - `sale_type`: 'retail' (venta mostrador)
  - `status`: 'completed'
  - `subtotal`, `discount_amount`, `tax`, `total`
  - `total_cost`: Desde lotes consumidos (para margen)
  - `profit_margin = total - total_cost`
- Registrar en `cash_movements` si es efectivo:
  - `movement_type = 'income'`
  - `category = 'sale'`
- Si es crédito, crear cuenta por cobrar en `credit_accounts`:
  - `transaction_type = 'charge'`
  - `balance_after += total`
- Generar movimiento de inventario (ver RN-POS-002)

*EXCEPCIÓN:* El modelo simplificado permite que las ventas no se registren ticket a ticket para efectos de cuadre, pero SÍ se registran para efectos de inventario y trazabilidad.

**RN-POS-004: Descuentos en POS con Autorización**
*SI* el cajero aplica descuento a una venta,
*ENTONCES* el sistema debe:
- Validar que el descuento no exceda el límite del rol del cajero:
  - Cajero: hasta 5%
  - Supervisor: hasta 15%
  - Administrador: sin límite
- Si el descuento requiere aprobación:
  - Solicitar código PIN de supervisor
  - Validar contra `users.role_id` y `pin_security`
- Registrar `discount_percent` y `discount_amount` en `sales`
- Recalcular totales y margen

*EXCEPCIÓN:* Descuentos mayores al 20% requieren justificación obligatoria. El margen de utilidad se recalcula con el descuento aplicado.

**RN-POS-005: Devolución desde POS**
*SI* un cliente solicita devolución de producto vendido en POS,
*ENTONCES* el sistema debe:
- Buscar la venta original por número o fecha
- Si la venta existe:
  - Crear `sales` con `sale_type = 'return'`
  - Los items devueltos retornan al inventario:
    - Crear lote nuevo o incrementar existente
    - `inventory_movement` tipo `sale_return` (cantidad positiva)
  - Generar nota de crédito
  - Si es efectivo, crear egreso de caja para reembolso

*EXCEPCIÓN:* Devoluciones solo dentro de los 30 días posteriores a la venta. Productos perecederos no se devuelven si están abiertos.

**RN-POS-006: Impresión de Comprobante**
*SI* el cajero solicita comprobante de venta,
*ENTONCES* el sistema debe:
- Generar documento según configuración de la sucursal:
  - Ticket simplificado (modelo D&G)
  - Factura completa (si aplica)
- Enviar a impresora térmica configurada (`cash_registers.printer_config`)
- Opcional: enviar por email/WhatsApp al cliente

*EXCEPCIÓN:* Si la impresora no está disponible, ofrecer "Sin impresión" como opción.

**RN-POS-007: Ventas a Crédito desde POS**
*SI* el cajero selecciona "Crédito" como método de pago,
*ENTONCES* el sistema debe:
- Validar que el cliente tenga límite disponible: `credit_accounts.balance + sale_total <= credit_accounts.credit_limit`
- Validar que el cliente no tenga facturas vencidas (configurable)
- Si es válido:
  - Crear cargo en `credit_accounts`
  - Setear fecha de vencimiento según `credit_days` del cliente
  - Crear registro en `day_credits` para tracking diario
- Si no es válido:
  - Bloquear venta a crédito
  - Mostrar mensaje: "Cliente excedió límite de crédito" o "Cliente tiene factura vencida"

---

## PARTE 11: MÓDULO DE PEDIDOS Y PORTAL DEL CLIENTE

### 11.1 Objetivo del Módulo

Proporcionar portal/web para que clientes mayoristas/minoristas de Quesera D&G puedan: registrarse, ver catálogo de productos según su tipo, realizar pedidos, seguir estados de entrega, gestionar créditos y registrar pagos. Este módulo SÍ registra pedidos individuales (a diferencia del POS físico).

### 11.2 Reglas de Negocio

**RN-CLI-001: Registro de Cliente en Portal**
*SI* un prospecto completa el formulario de registro en `/portal/registro`,
*ENTONCES* el sistema debe:
- Validar email único dentro del tenant: `NOT EXISTS (SELECT 1 FROM customers WHERE email = ?)`
- Crear registro en `customers` con `status = 'pending_approval'`
- Generar `code` único: `CLI-{branch}-{00000}` (o global si es multi-sucursal)
- Asignar `customer_type` solicitado (retail/wholesale)
- Crear usuario en `users` con rol 'cliente' y `app_user_id` vinculado
- Crear `credit_account` con límites default (`credit_limit = 0`, `credit_days = 0`)
- Enviar notificación al email del administrador de la empresa
- NO permitir login hasta aprobación

*EXCEPCIÓN:* Email duplicado dentro del tenant debe rechazar registro. El password se setea temporal o enviado por email.

**RN-CLI-002: Aprobación de Cliente por Administrador**
*SI* el administrador aprueba o rechaza una solicitud de registro,
*ENTONCES* el sistema debe:
- Si APRUEBA:
  - Cambiar `status` a 'active'
  - Asignar `customer_type` definitivo (puede diferir del solicitado)
  - Configurar `credit_limit` y `credit_days` según política
  - Crear `credit_account` con límites asignados
  - Notificar al cliente por email con credenciales
  - Habilitar login en portal
- Si RECHAZA:
  - Cambiar `status` a 'rejected'
  - Solicitar `rejection_reason` obligatorio
  - Notificar al cliente con la razón

*EXCEPCIÓN:* Clientes mayoristas requieren verificación de documentos de negocio (NIT, Cámara de Comercio).

**RN-CLI-003: Cambio de Tipo de Cliente**
*SI* un cliente solicita cambio de tipo (ej: retail → wholesale),
*ENTONCES* el sistema debe:
- Crear solicitud en `customer_type_change_requests`
- Solicitar justificación y documentación de soporte
- Notificar al administrador
- El administrador puede aprobar o rechazar:
  - Si aprueba: actualizar `customer_type`
  - El cliente recibe notificación del resultado
- Registrar en `audit_logs`

*EXCEPCIÓN:* El cliente NO puede cambiar su tipo unilateralmente. Siempre requiere aprobación administrativa.

**RN-CLI-004: Visualización de Catálogo por Tipo de Cliente**
*SI* un cliente logueado navega el catálogo,
*ENTONCES* el sistema debe:
- Filtrar productos según `customer_type` del cliente
- Mostrar precios de la `price_list` correspondiente:
  - retail → precios minoristas
  - wholesale → precios mayoristas
  - VIP → precios especiales
- Ocultar productos no disponibles para su tipo
- Aplicar descuentos automáticos según configuración de la lista de precios
- Mostrar disponibilidad de stock en tiempo real

*EXCEPCIÓN:* Si el cliente no tiene `price_list` asignada, usar lista default para su tipo.

**RN-CLI-005: Creación de Pedido desde Portal**
*SI* un cliente confirma un pedido en el portal,
*ENTONCES* el sistema debe:
- Crear registro en `orders`:
  - `order_number`: `PED-{branch}-{YYYY}-{000000}`
  - `customer_id`: Cliente actual
  - `branch_id`: Sucursal destino
  - `status`: 'requested'
  - `subtotal`, `shipping_cost`, `tax`, `total`: Calculados desde items
- Crear items en `order_items` por cada producto
- Crear factura proforma en `invoices` con `status = 'pending_payment'`
- **CRÍTICO:** Reservar inventario en la sucursal destino
- Enviar notificación a la sucursal destino
- Notificar al cliente con número de pedido

*EXCEPCIÓN:* Si algún producto no tiene stock suficiente, mostrar warning y permitir continuar sin él o con cantidad disponible.

*INTEGRACIÓN CRUZADA:* **CRÍTICO** - El pedido debe RESERVAR stock en la sucursal. Ver RN-CLI-006.

**RN-CLI-006: Reserva de Inventario por Pedido de Portal**
*SI* un pedido es creado en el portal,
*ENTONCES* el sistema debe:
- Para cada item del pedido:
  - Consultar `inventory_lotes` disponibles (status='active', current_quantity > 0)
  - Reservar cantidad en lotes FIFO:
    - Crear `inventory_reservations`:
      - `lot_id`, `quantity`, `order_id`, `expires_at`
    - Reducir `current_quantity` disponible (lógico, no físico): usar columna `reserved_quantity`
- Si no hay stock suficiente:
  - El pedido se crea con estado 'partial_reserved'
  - Notificar al administrador
- El POS de la sucursal debe mostrar "reservado" y no permitir venderlo
- La reserva expira en 24 horas (configurable): pasado el plazo, liberar y notificar

*EXCEPCIÓN:* Cuando el pedido cambia a 'confirmed' o 'preparing', convertir reserva en consumo real del inventario.

**RN-CLI-007: Estados de Pedido y Transiciones**
*SI* cualquier cambio de estado ocurre en un pedido,
*ENTONCES* el sistema debe validar y ejecutar:

```
requested → [confirmar] → confirmed
          → [cancelar] → cancelled

confirmed → [preparar] → preparing
          → [cancelar] → cancelled

preparing → [listo] → ready
          → [enviar] → in_transit

ready → [enviar] → in_transit

in_transit → [entregar] → delivered
           → [problema] → issue (requiere resolución)

delivered → [confirmar_recepcion] → completed
```

*EXCEPCIÓN:* El cliente puede cancelar solo en estado 'requested'. Cada cambio de estado envía notificación al cliente.

**RN-CLI-008: Pago Registrado por Cliente**
*SI* un cliente registra un pago en el portal (para factura pendiente),
*ENTONCES* el sistema debe:
- Crear registro en `customer_payments`:
  - `status`: 'pending_verification'
  - `payment_method`, `reference`, `amount`
  - `proof_url`: Foto del comprobante (opcional)
- Cambiar estado de factura a 'payment_pending_verification'
- Notificar al vendedor de la empresa

*EXCEPCIÓN:* El pago registrado NO se considera confirmado hasta que el vendedor lo verifique manualmente.

**RN-CLI-009: Verificación de Pago por Vendedor**
*SI* un vendedor verifica un pago registrado por el cliente,
*ENTONCES* el sistema debe:
- Si APRUEBA:
  - Cambiar `customer_payments.status` a 'verified'
  - Actualizar `invoices.balance` y `status`
  - Crear `credit_transactions` con `transaction_type = 'payment'`
  - Si es efectivo: crear `cash_movements` con `movement_type = 'income'`
  - Si es online: crear `online_account_movements`
  - Notificar al cliente: "Pago confirmado"
- Si RECHAZA:
  - Cambiar `customer_payments.status` a 'rejected'
  - Solicitar `rejection_reason`
  - Notificar al cliente con el motivo
  - El cliente puede volver a registrar el pago

*EXCEPCIÓN:* Pagos rechazados múltiples veces (3+) generan alerta de posible fraude para revisión.

---

## PARTE 12: MÓDULO DE CONTROL DE INVENTARIO FÍSICO

### 12.1 Objetivo del Módulo

Gestionar el proceso de conteo físico de inventario, comparación con datos del sistema, cálculo de diferencias (faltantes/sobrantes), determinación de causas y ajustes con autorización apropiada.

### 12.2 Reglas de Negocio

**RN-INV-001: Programación de Inventario**
*SI* un administrador programa un control de inventario,
*ENTONCES* el sistema debe:
- Crear registro en `inventory_counts`:
  - `branch_id`, `count_date`, `type`: 'total' o 'partial'
  - `status`: 'scheduled', 'in_progress', 'completed', 'cancelled'
  - `responsible_users`: UUID[] de contadores asignados
  - `product_categories`: Si es parcial, categorías a contar
- Generar checklist de productos a contar
- Enviar recordatorios a responsables
- Un inventario total no puede tener más de 5000 productos por sesión (límite de rendimiento)

*EXCEPCIÓN:* Durante el inventario, el POS puede seguir operando pero con advertencias de que hay conteo en progreso.

**RN-INV-002: Ejecución del Conteo Físico**
*SI* un contador inicia sesión de inventario,
*ENTONCES* el sistema debe:
- Mostrar lista de productos asignados
- Por cada producto:
  - Mostrar `system_quantity`: Cantidad actual en sistema (snapshot al inicio)
  - Permitir escaneo de código de barras
  - Permitir ingresar `physical_quantity`
  - Registrar `notes` y opcionalmente `photo_url`
- Marcar producto como 'counted'
- Guardar progreso automáticamente (en caso de interrupciones)
- Permitir múltiples contadores simultáneos con resolución de conflictos por timestamp

*EXCEPCIÓN:* Si el escaneo no encuentra producto, permitir crear "producto no registrado" para investigación.

*INTEGRACIÓN CRUZADA:* Las cantidades del sistema son snapshots al inicio del inventario (no cambian durante el conteo).

**RN-INV-003: Cálculo Automático de Diferencias**
*SI* el inventario es completado y cerrado,
*ENTONCES* el sistema debe:
- Para cada producto:
  - `difference = physical_quantity - system_quantity`
  - Clasificar: 'ok' (diferencia 0), 'shortage' (negativo), 'surplus' (positivo)
  - `value_difference = difference * cost_price` (precio de costo promedio)
- Generar resumen:
  - Total productos contados
  - Productos con diferencias
  - Valor total de faltantes
  - Valor total de sobrantes
  - Diferencia neta (valor)

*EXCEPCIÓN:* Diferencias mayores al 5% del total requieren revisión de supervisor.

**RN-INV-004: Determinación de Causa de Diferencias**
*SI* se detectan diferencias de inventario,
*ENTONCES* el sistema debe:
- Para cada diferencia, solicitar clasificación de causa:
  - 'sale_unregistered': Venta no registrada en sistema
  - 'theft': Robo/pérdida
  - 'damage': Producto dañado
  - 'expiry': Producto vencido
  - 'counting_error': Error en conteo anterior
  - 'system_error': Error del sistema
  - 'other': Otro motivo
- Si es 'sale_unregistered':
  - Crear ajuste de caja como "venta en efectivo no registrada"
  - Generar asiento contable de venta
- Si es 'damage' o 'expiry':
  - Registrar en `waste_records` para control de mermas

*EXCEPCIÓN:* Causas 'theft' o 'damage' requieren foto de evidencia si el valor > umbral configurado.

**RN-INV-005: Ajuste de Inventario con Autorización**
*SI* las diferencias de inventario van a ser aplicadas al sistema,
*ENTONCES* el sistema debe:
- Si `|difference_value| <= 500000`: Autorización automática
- Si `|difference_value| > 500000`: Requiere aprobación de supervisor
- Para cada ajuste:
  - Crear `inventory_movements` con `movement_type = 'adjustment'`
  - Si diferencia negativa: `quantity = -|difference|` (salida)
  - Si diferencia positiva: `quantity = |difference|` (entrada)
  - Actualizar `current_quantity` en `inventory_lotes`
- Generar asiento contable de ajuste

*EXCEPCIÓN:* Ajustes rechazados por supervisor requieren reconteo.

---

## PARTE 13: MÓDULO DE MERMAS Y PÉRDIDAS

### 13.1 Objetivo del Módulo

Registrar y controlar las pérdidas de inventario por diversas causas (vencimiento, daño, robo, consumo interno), calcular su impacto económico, afectar la contabilidad y generar reportes para análisis de eficiencia operativa.

### 13.2 Reglas de Negocio

**RN-MER-001: Registro de Merma Manual**
*SI* un usuario registra una merma de producto,
*ENTONCES* el sistema debe:
- Solicitar: `variant_id`, `lot_id`, `quantity`, `cause`:
  - 'expiry': Producto vencido
  - 'damage': Producto dañado/roto
  - 'theft': Robo/pérdida
  - 'internal_consumption': Consumo por empleados/familia
  - 'deterioration': Deterioro general
- Requerir `notes` descriptiva
- Si valor > 100000, requerir `evidence_url` (foto)
- Calcular `loss_value = quantity * cost_price` del lote
- Crear `inventory_movements` con `movement_type = 'waste'`
- Reducir `current_quantity` del lote

*EXCEPCIÓN:* Mermas por 'theft' deben generar alerta de seguridad. El lote afectado reduce su `current_quantity`.

**RN-MER-002: Merma Automática por Vencimiento**
*SI* se ejecuta el proceso diario de detección de vencidos,
*ENTONCES* el sistema debe:
- Identificar lotes con `expiry_date < today` y `status = 'active'`
- Crear automáticamente registros de merma:
  - `cause = 'expiry'`
  - `quantity = current_quantity`
  - `loss_value = current_quantity * purchase_price`
  - `auto_generated = true`
- Cambiar `inventory_lotes.status` a 'expired'
- Generar `inventory_movements` tipo 'expired'

*EXCEPCIÓN:* Productos vencidos pueden mantenerse visibles pero marcados para atención. El costo de la merma va a gastos operativos.

**RN-MER-003: Afectación Contable de Mermas**
*SI* una merma es registrada y confirmada,
*ENTONCES* el sistema debe generar asiento contable:

```
Débito: 5xxx - Gastos por Mermas (cuenta específica según causa)
Crédito: 14xx - Inventario (loss_value)
```

*EXCEPCIÓN:* Si la merma es por 'internal_consumption' y el consumidor es el dueño, puede ir a "Retiros del Dueño" (cuenta 3115).

**RN-MER-004: Reporte de Mermas por Período**
*SI* se solicita reporte de mermas,
*ENTONCES* el sistema debe generar:
- Total de mermas en valor y cantidad
- Desglose por causa (expiry, damage, theft, etc.)
- Porcentaje de merma sobre inventario total
- Productos con mayor tasa de merma
- Comparativa con períodos anteriores

*EXCEPCIÓN:* Tasa de merma > 2% sobre ventas debe generar alerta de gestión.

---

## PARTE 14: MÓDULO DE CONTROL DE VENCIMIENTOS

### 14.1 Objetivo del Módulo

Gestionar productos perecederos con fechas de vencimiento, generar alertas automáticas antes del vencimiento, facilitar decisiones de descuento para venta rápida, registrar productos vencidos y mantener trazabilidad para auditoría.

### 14.2 Reglas de Negocio

**RN-VEN-001: Registro de Fecha de Vencimiento**
*SI* se recibe mercancía perecedera en compra,
*ENTONCES* el sistema debe:
- Requerir `expiry_date` como campo obligatorio (si `products.has_expiry = true`)
- Validar que `expiry_date > today` (con warning si es <= today)
- Crear lote con `expiry_date` registrado
- Calcular `days_until_expiry = expiry_date - today`
- Si `products.has_expiry = false`, el campo es opcional

*EXCEPCIÓN:* Si `expiry_date <= today`, permitir con warning explícito y marcar lote como "ya vencido".

**RN-VEN-002: Alertas de Vencimiento Escalonadas**
*SI* un lote tiene días restantes hasta vencimiento,
*ENTONCES* el sistema debe generar alertas en intervalos configurables:

| Días Restantes | Acción |
|----------------|--------|
| 30 | Alerta informativa en dashboard |
| 15 | Notificación a gerente |
| 10 | Descuento sugerido (pre-venta) |
| 7 | Alerta urgente |
| 3 | Requiere acción inmediata |
| 1 | Último día |
| 0 o menos | Vencido - Bloqueado para venta (configurable) |

*EXCEPCIÓN:* El sistema puede configurarse para NO bloquear venta de vencidos (cliente acepta bajo su responsabilidad).

**RN-VEN-003: Descuento Automático por Próximo Vencimiento**
*SI* el administrador aprueba descuento para producto próximo a vencer,
*ENTONCES* el sistema debe:
- Crear promoción temporal con:
  - `discount_percent`: Configurado (ej: 20%, 30%, 50%)
  - `valid_from`: Hoy
  - `valid_to`: Fecha de vencimiento
  - `applies_to`: Productos seleccionados o categorías
- El descuento se aplica automáticamente en POS y Portal
- El descuento NO puede exceder el margen de utilidad del producto

**RN-VEN-004: Venta de Producto Vencido con Confirmación**
*SI* un cajero intenta vender producto vencido en POS,
*ENTONCES* el sistema debe:
- Mostrar warning: "Producto vencido. ¿Desea continuar?"
- Solicitar confirmación del cliente (firma o aceptación verbal registrada)
- Si el sistema está configurado para bloquear:
  - Rechazar la venta directamente
- Registrar en auditoría: cliente, cajero, timestamp, justificación

*EXCEPCIÓN:* La venta de vencidos debe cumplir con regulaciones de invoconsumo. El lote marcado como 'expired' sigue disponible pero con advertencias.

**RN-VEN-005: Auditoría de Productos Vencidos**
*SI* un producto vence sin venderse,
*ENTONCES* el sistema debe:
- Registrar en `expired_products_audit`:
  - `lot_id`, `product_id`, `quantity`, `cost_value`
  - `expiry_date`, `disposition`: 'discarded', 'donated', 'sold_discounted'
  - `responsible`: Usuario que registró la disposición
  - `notes`: Justificación de la decisión
- Generar alerta para decisión de disposición
- Si es donación, generar certificado de donación para contabilidad

---

## PARTE 15: MÓDULO DE CRÉDITOS Y CUENTAS POR COBRAR

### 15.1 Objetivo del Módulo

Gestionar el otorgamiento de créditos a clientes, cálculo de límites dinámicos, scoring crediticio, gestión de cobranzas y control de morosidad.

### 15.2 Reglas de Negocio

**RN-CRE-001: Evaluación de Límite de Crédito**
*SI* se solicita evaluar o modificar el límite de crédito de un cliente,
*ENTONCES* el sistema debe:
- Calcular score crediticio automático basado en:
  - `payment_history_score`: % de pagos a tiempo (peso: 40%)
  - `antigüedad`: Meses como cliente (peso: 20%)
  - `volume_score`: Volumen de compras (peso: 15%)
  - `credit_utilization`: % del límite usado (peso: 15%)
  - `overdue_history`: Días promedio de retraso (peso: 10%)
- Generar `suggested_limit = min(credit_score * 10000, ticket_promedio * 3, current_limit * 1.2)`
- El administrador puede aprobar, aumentar o disminuir el sugerido
- Registrar `limit_change_history` con justificación

*EXCEPCIÓN:* Clientes nuevos start con score 50 (Regular) hasta acumular 3 meses de historial.

**RN-CRE-002: Validación de Crédito en Transacción**
*SI* un cliente intenta comprar a crédito,
*ENTONCES* el sistema debe:
- Verificar `credit_accounts.status = 'active'` (no bloqueado ni suspendido)
- Calcular crédito disponible: `credit_limit - current_credit`
- Verificar que la venta no exceda el límite: `current_credit + sale_total <= credit_limit`
- Verificar que no tenga facturas vencidas (si aplica política)
- Si todo OK: permitir la venta a crédito
- Si no cumple: rechazar con mensaje explicativo

**RN-CRE-003: Aging de Cartera**
*SI* se ejecuta el proceso diario de aging,
*ENTONCES* el sistema debe:
- Calcular antigüedad de cada deuda:
  - Por vencer (días < 0)
  - 1-30 días vencidos
  - 31-60 días vencidos
  - 61-90 días vencidos
  - >90 días vencidos
- Actualizar `credit_accounts.overdue_balance`
- Cambiar estado del cliente si tiene deuda vencida >30 días
- Generar alertas para cobros

*EXCEPCIÓN:* Clientes con >90 días vencidos pueden bloquearse automáticamente según política.

**RN-CRE-004: Cálculo de Intereses de Mora**
*SI* una factura supera la fecha de vencimiento,
*ENTONCES* el sistema debe:
- Calcular días de mora: `hoy - due_date`
- Si hay tasa de interés configurada: `interest = balance × (tasa_mora × días / 365)`
- Crear cargo en `credit_transactions` con `transaction_type = 'interest'`
- Notificar al cliente con detalle de intereses

*EXCEPCIÓN:* Los intereses pueden perdonarse manualmente por administrador con justificación.

---

## PARTE 16: MÓDULO DE NÓMINA Y RECURSOS HUMANOS

### 16.1 Objetivo del Módulo

Gestionar empleados, contratos, cálculo de nómina, deducciones, bonificaciones y generación de comprobantes de pago.

### 16.2 Reglas de Negocio

**RN-NOM-001: Registro de Empleado**
*SI* se crea un nuevo empleado en `employees`,
*ENTONCES* el sistema debe:
- Generar `employee_code` único: `EMP-{branch}-{00000}`
- Validar `tax_id` (cédula) único dentro del tenant
- Vincular con usuario del sistema si aplica (`user_id`)
- Registrar cargo, departamento, sucursal asignada
- Configurar salario y frecuencia de pago (semanal, quincenal, mensual)
- Setear `status = 'active'` por defecto

*EXCEPCIÓN:* El usuario vinculado debe tener el mismo `tenant_id` y `branch_id`.

**RN-NOM-002: Ejecución de Nómina**
*SI* se ejecuta un período de nómina,
*ENTONCES* el sistema debe:
- Crear registro en `payroll_runs`:
  - `payroll_number`: `NOM-{YYYY}-{MM}-{000}`
  - `period_start`, `period_end`, `payment_date`
- Para cada empleado activo:
  - Calcular `gross_salary` según frecuencia
  - Calcular deducciones: salud (4%), pensión (4%), retención fuente si aplica
  - Calcular bonificaciones: transporte, alimentación, horas extras
  - `net_salary = gross + bonificaciones - deducciones`
- Generar `payroll_details` por empleado
- Actualizar totales en `payroll_runs`

*EXCEPCIÓN:* Empleados con contrato por días o horas tienen cálculo proporcional.

**RN-NOM-003: Asiento Contable de Nómina**
*SI* la nómina es aprobada y pagada,
*ENTONCES* el sistema debe generar asientos:
```
Débito: 5xxx - Gastos de Personal (salarios)
Crédito: 21xx - Nómina por Pagar

Débito: 21xx - Nómina por Pagar
Crédito: 11xx - Caja / 12xx - Bancos

Débito: 2xxx - Aportes Seguridad Social
Crédito: 2xxx - Cuentas por Pagar
```

---

## PARTE 17: MÓDULO DE GASTOS OPERATIVOS

### 17.1 Objetivo del Módulo

Registrar y clasificar gastos operativos, gestionar presupuestos por categoría, y afectar la contabilidad automáticamente.

### 17.2 Reglas de Negocio

**RN-GAS-001: Registro de Gasto**
*SI* se registra un gasto operativo,
*ENTONCES* el sistema debe:
- Clasificar por categoría:
  - Servicios públicos (luz, agua, gas, internet, teléfono)
  - Alquiler
  - Mantenimiento
  - Publicidad
  - Gastos administrativos
  - Transporte
  - Otros
- Registrar datos: fecha, categoría, concepto, beneficiario, monto, método de pago
- Adjuntar factura/recibo si está disponible
- Generar `cash_movements` con `movement_type = 'expense'`
- Generar asiento contable automático

*EXCEPCIÓN:* Gastos mayores a umbral configurable requieren aprobación de supervisor.

**RN-GAS-002: Control Presupuestario**
*SI* se define presupuesto mensual por categoría,
*ENTONCES* el sistema debe:
- Alertas cuando el gasto real alcance 80% del presupuesto
- Alertas cuando alcance 100%
- Bloquear gastos adicionales si se excede el presupuesto (configurable)
- Generar reportes de cumplimiento presupuestario

---

## PARTE 18: MÓDULO DE DEVOLUCIONES A PROVEEDORES

### 18.1 Objetivo del Módulo

Gestionar devoluciones de mercancía a proveedores, generación de notas de crédito, y actualización de inventario y cuentas por pagar.

### 18.2 Reglas de Negocio

**RN-DEV-001: Registro de Devolución**
*SI* se crea una devolución a proveedor,
*ENTONCES* el sistema debe:
- Seleccionar factura de compra original
- Seleccionar productos y cantidades a devolver
- Identificar lote específico a devolver
- Clasificar motivo:
  - Producto defectuoso
  - Producto vencido
  - Entrega incorrecta
  - Cantidad incorrecta
- Adjuntar fotos de evidencia
- Generar nota de devolución al proveedor

**RN-DEV-002: Afectación de Inventario**
*SI* la devolución es confirmada,
*ENTONCES* el sistema debe:
- Disminuir del lote específico: `current_quantity -= quantity`
- Si lote queda en 0: `status = 'returned'`
- Crear `inventory_movements` con `movement_type = 'purchase_return'`
- Generar nota de crédito del proveedor

*EXCEPCIÓN:* Si el lote ya no existe (vendido completo), manejar como pérdida o ajuste.

**RN-DEV-003: Actualización Financiera**
*SI* se recibe nota de crédito del proveedor,
*ENTONCES* el sistema debe:
- Si la factura ya estaba pagada:
  - Crear cuenta por cobrar al proveedor (reembolso)
  - O aplicar como crédito en próxima compra
- Si la factura está pendiente:
  - Disminuir `purchase_invoices.balance`
  - Si balance = 0, marcar como `paid`

---

## PARTE 19: MÓDULO DE PRÉSTAMOS Y ANTICIPOS A EMPLEADOS

### 19.1 Objetivo del Módulo

Gestionar préstamos otorgados a empleados, descuentos por nómina, y control de saldos.

### 19.2 Reglas de Negocio

**RN-PRE-001: Otorgamiento de Préstamo**
*SI* se otorga un préstamo a un empleado,
*ENTONCES* el sistema debe:
- Crear registro en `employee_loans`:
  - `employee_id`, `amount`, `interest_rate`, `quota_count`
  - `start_date`, `status = 'active'`
- Calcular cuota mensual con interés si aplica
- Crear cronograma de pagos
- Generar asiento contable: Débito (Préstamos a Empleados) / Crédito (Caja)

**RN-PRE-002: Descuento por Nómina**
*SI* se ejecuta nómina con descuento de préstamo,
*ENTONCES* el sistema debe:
- Verificar cuota del mes en cronograma
- Crear `payroll_details.deductions` con cuota del préstamo
- Actualizar saldo pendiente del préstamo
- Marcar cuota como pagada

---

## PARTE 20: MÓDULO DE LOGÍSTICA Y ENTREGAS

### 20.1 Objetivo del Módulo

Gestionar la entrega de pedidos a clientes, rutas de distribución, seguimiento en tiempo real y confirmación de recepción.

### 20.2 Reglas de Negocio

**RN-LOG-001: Programación de Entrega**
*SI* un pedido está listo para envío,
*ENTONCES* el sistema debe:
- Asignar fecha y窗口 de entrega
- Asignar vehículo/ruta si aplica
- Asignar repartidor
- Cambiar estado a `in_transit`
- Enviar notificación al cliente con hora estimada
- Generar guía de remisión si aplica

**RN-LOG-002: Confirmación de Entrega**
*SI* el repartidor confirma entrega,
*ENTONCES* el sistema debe:
- Cambiar estado del pedido a `delivered`
- Solicitar firma del cliente o confirmación en app
- Registrar geolocalización y timestamp
- Notificar al cliente: "Tu pedido ha sido entregado"
- Si hay problema: registrar novedad y cambiar a estado `issue`

**RN-LOG-003: Reporte de Entregas**
*SI* se solicita reporte de entregas,
*ENTONCES* el sistema debe generar:
- Entregas a tiempo vs retrasadas
- Tiempo promedio de entrega por ruta
- Problemas más frecuentes
- Costo logístico por entrega
- Eficiencia de repartidores

---

## PARTE 21: MÓDULO DE RESERVAS DE INVENTARIO

### 21.1 Objetivo del Módulo

Gestionar reservas de inventario para pedidos del portal, preventas, y compromisos especiales, con control de expiración y liberación automática.

### 21.2 Reglas de Negocio

**RN-RES-001: Creación de Reserva**
*SI* se confirma un pedido en el portal o se crea una preventa,
*ENTONCES* el sistema debe:
- Crear `inventory_reservations`:
  - `lot_id`, `quantity`, `order_id`/`pre_sale_id`
  - `expires_at`: hoy + 24 horas (configurable)
  - `status = 'active'`
- Disminuir `available_quantity` del lote (cantidad total - reservada)
- Marcar el inventario como "reservado" en el POS

**RN-RES-002: Conversión de Reserva a Venta**
*SI* un pedido confirmado pasa a estado "preparing" o "ready",
*ENTONCES* el sistema debe:
- Convertir reserva en consumo real:
  - Crear `inventory_movements` tipo `sale` con `reference_type = 'order'`
  - Disminuir `current_quantity` del lote
  - Marcar reserva como `consumed`

**RN-RES-003: Expiración de Reservas**
*SI* una reserva alcanza su `expires_at` sin convertirse en venta,
*ENTONCES* el sistema debe:
- Liberar la reserva:
  - Aumentar `available_quantity` del lote
  - Marcar reserva como `expired`
- Notificar al administrador
- Si es preventa: notificar al cliente

---

## PARTE 22: MÓDULO DE KPIS Y DASHBOARDS EJECUTIVOS

### 22.1 Objetivo del Módulo

Proveer métricas en tiempo real, análisis de tendencias, y reportes ejecutivos para la toma de decisiones.

### 22.2 Reglas de Negocio

**RN-KPI-001: Dashboard de Ventas**
*SI* se visualiza el dashboard,
*ENTONCES* el sistema debe mostrar:
- Ventas del día actual (actualización en tiempo real)
- Comparativa: hoy vs ayer, vs misma día semana pasada
- Ticket promedio del día
- Número de transacciones
- Productos más vendidos (top 20)
- Ventas por método de pago

**RN-KPI-002: Dashboard de Inventario**
*SI* se visualiza dashboard de inventario,
*ENTONCES* el sistema debe mostrar:
- Valor total del inventario
- Productos con stock bajo (alertas)
- Productos próximos a vencer (alertas)
- Rotación de inventario por producto
- Mermas del período

**RN-KPI-003: Dashboard Financiero**
*SI* se visualiza dashboard financiero,
*ENTONCES* el sistema debe mostrar:
- Ingresos del día/mes
- Egresos del día/mes
- Flujo de caja (entradas - salidas)
- Cartera vencida (monto y %)
- Utilidad bruta estimada
- Margen de ganancia

**RN-KPI-004: Análisis de Tendencias**
*SI* se solicita análisis de tendencias,
*ENTONCES* el sistema debe:
- Comparar período actual vs anterior (día, semana, mes)
- Identificar productos en crecimiento y en declive
- Detectar patrones estacionales
- Proponer acciones basadas en datos

---

## PARTE 23: MÓDULO DE COMUNICACIÓN INTERNA

### 23.1 Objetivo del Módulo

Facilitar comunicación entre empleados de la misma sucursal, entre sucursales, por roles y anuncios corporativos.

### 23.2 Reglas de Negocio

**RN-COM-001: Chat entre Empleados**
*SI* un empleado envía mensaje,
*ENTONCES* el sistema debe:
- Crear mensaje en `internal_messages`
- Si destinatario está offline: almacenar y entregar al reconectar
- Generar notificación push si está habilitada
- Mantener historial de conversación

**RN-COM-002: Anuncios Corporativos**
*SI* un administrador publica un anuncio,
*ENTONCES* el sistema debe:
- Definir alcance: por rol, por sucursal, o global
- Establecer prioridad: normal, importante, urgente
- Si `requires_confirmation = true`: registrar confirmación por usuario
- Enviar notificación push
- Anuncios urgentes aparecen como modal obligatorio

**RN-COM-003: Tickets de Soporte Interno**
*SI* un empleado crea ticket interno,
*ENTONCES* el sistema debe:
- Crear registro en `support_tickets`:
  - `ticket_number`: `TKT-{YYYY}-{00000}`
  - `category`: Técnico, Inventario, Nómina, Otro
  - `priority`: Baja, Media, Alta, Crítica
  - `status`: 'open', 'in_progress', 'resolved', 'closed'
- Asignar según categoría (routing automático)
- Notificar al responsable

---

## PARTE 24: MÓDULO DE AUDITORÍA Y SEGURIDAD

### 24.1 Objetivo del Módulo

Registrar todas las acciones relevantes del sistema, gestionar intentos de acceso fallidos, políticas de contraseñas, sesiones y recuperación de credenciales.

### 24.2 Reglas de Negocio

**RN-AUD-001: Registro de Auditoría Automático**
*SI* cualquier acción relevante es ejecutada,
*ENTONCES* el sistema debe:
- Crear registro en `audit_logs`:
  - `user_id`, `tenant_id`
  - `action`: create, read, update, delete, login, logout, approve, reject, etc.
  - `entity_type`, `entity_id`
  - `old_value`, `new_value`: JSONB (para updates)
  - `ip_address`, `user_agent`, `device_id`
  - `description`, `created_at`
- Esta tabla es INMUTABLE (sin UPDATE ni DELETE)

*EXCEPCIÓN:* Acciones de lectura en listados NO generan log (solo operaciones críticas).

**RN-AUD-002: Bloqueo por Intentos Fallidos**
*SI* un usuario tiene 5 intentos de login fallidos consecutivos,
*ENTONCES* el sistema debe:
- Bloquear temporalmente la cuenta por 15 minutos
- Setear `users.is_blocked = true`
- Registrar `blocked_at`
- Enviar email de alerta al usuario
- Notificar administradores si es posible intento de intrusión

**RN-AUD-003: Políticas de Contraseñas**
*SI* un usuario crea o cambia contraseña,
*ENTONCES* el sistema debe validar:
- Longitud mínima: 8 caracteres
- Al menos una mayúscula, una minúscula, un número
- Un carácter especial (opcional, configurable)
- No reuse las últimas 5 contraseñas
- Si es primer login: forzar cambio de contraseña temporal

**RN-AUD-004: Recuperación de Contraseña**
*SI* un usuario solicita recuperación,
*ENTONCES* el sistema debe:
- Generar OTP de 6 dígitos enviado por email/SMS
- Generar Magic Link enviado por email
- Priorizar OTP con Magic Link como backup
- El código/link expira en 15-30 minutos
- Registrar el evento en `audit_logs`

**RN-AUD-005: Gestión de Sesiones**
*SI* un usuario inicia sesión,
*ENTONCES* el sistema debe:
- Crear registro de sesión con JWT token
- Setear timeout de inactividad configurable (default 30 minutos)
- Permitir listar sesiones activas del usuario
- Permitir cerrar sesión en dispositivo específico
- Permitir cerrar todas las sesiones excepto actual

---

## PARTE 25: MÓDULO DE MODO OFFLINE Y SINCRONIZACIÓN

### 25.1 Objetivo del Módulo

Garantizar operación continua sin conexión a internet, gestionar caché local con Hive, procesar transacciones offline y sincronizar cuando se recupere conectividad.

### 25.2 Reglas de Negocio

**RN-OFF-001: Operaciones Permitidas Offline**
*SI* el dispositivo pierde conectividad,
*ENTONCES* el sistema debe permitir:
- Consultar inventario local (Hive cache)
- Registrar ventas en POS
- Registrar créditos otorgados
- Registrar salidas de dinero
- Continuar operación de cuadre de caja
- Consultar clientes y precios (cache)

*EXCEPCIÓN:* NO permitir: validar límite de crédito actualizado, consultar inventario de otra sucursal, generar reportes consolidados.

**RN-OFF-002: Cola de Sincronización**
*SI* se ejecuta cualquier operación offline,
*ENTONCES* el sistema debe:
- Guardar transacción en `sync_queue` (Hive local):
  - `id`: UUID generado localmente
  - `local_id`: Identificador temporal del dispositivo
  - `operation_type`: create, update, delete
  - `entity_type`: Tabla afectada
  - `data`: JSON completo de la transacción
  - `timestamp`: Fecha/hora de creación
  - `status`: 'pending', 'synced', 'error', 'conflict'
  - `retry_count`: Número de intentos de sync
- Mantener orden FIFO
- Guardar hasta 1000 transacciones pendientes

**RN-OFF-003: Sincronización Automática**
*SI* el dispositivo detecta conectividad恢复,
*ENTONCES* el sistema debe:
- Iniciar proceso de sincronización automática
- Procesar cola FIFO secuencialmente
- Para cada transacción:
  - Enviar al servidor con `local_id`
  - Si éxito: marcar como 'synced'
  - Si error: incrementar `retry_count`, marcar 'error'
- Si `retry_count > 3`: marcar para revisión manual
- Notificar al usuario al completar sincronización

**RN-OFF-004: Resolución de Conflictos**
*SI* una transacción offline tiene conflicto con datos del servidor,
*ENTONCES* el sistema debe aplicar estrategia:
- `Last Write Wins`: Por defecto (el `updated_at` más reciente gana)
- `Server Wins`: Para datos maestros (productos, clientes)
- `Client Wins`: Para transacciones locales (cierre de caja)
- `Manual Resolution`: Para conflictos críticos (inventario, dinero)
- Si es manual: crear registro en `sync_conflicts` para revisión

*EXCEPCIÓN:* Conflictos en `inventory_movements` y `cash_movements` requieren revisión manual obligatoriamente.

**RN-OFF-005: Caché Local**
*SI* hay conectividad y se ejecutan operaciones,
*ENTONCES* el sistema debe:
- Sincronizar datos frecuentes a Hive:
  - Catálogo de productos (completo)
  - Precios por lista de precios
  - Clientes frecuentes
  - Inventario actual (sucursal)
  - Configuración de la sucursal
- Actualizar caché cada 5 minutos o cuando hay cambios
- Limpiar caché antiguo (más de 7 días) automáticamente

---

## PARTE 26: MÓDULO DE REPORTES FISCALES Y LEGALES (COLOMBIA)

### 26.1 Objetivo del Módulo

Generar libros contables, declaraciones de IVA, retenciones en la fuente y formatos exigidos por la DIAN.

### 26.2 Reglas de Negocio

**RN-FIS-001: Generación de Libro de Ventas**
*SI* se solicita libro de ventas por período,
*ENTONCES* el sistema debe:
- Filtrar `accounting_entries` con `reference_type = 'sale'` por fecha
- Para cada venta/factura:
  - Fecha, número de factura
  - Cliente (nombre y NIT)
  - Base gravable (sin IVA)
  - IVA generado
  - Total (con IVA)
- Calcular totales por tarifa de IVA (19%, 5%, 0%)
- Generar formato según normativa DIAN
- Exportar a Excel/PDF

**RN-FIS-002: Generación de Libro de Compras**
*SI* se solicita libro de compras por período,
*ENTONCES* el sistema debe:
- Filtrar `accounting_entries` con `reference_type = 'purchase'` por fecha
- Para cada factura de compra:
  - Fecha, número de factura
  - Proveedor (nombre y NIT)
  - Base gravable (sin IVA)
  - IVA descontable
  - Total (con IVA)
  - Retención en la fuente aplicada

**RN-FIS-003: Cálculo de IVA a Pagar**
*SI* se ejecuta cierre de período fiscal,
*ENTONCES* el sistema debe:
- `IVA Generado`: Sumatoria de IVA en ventas del período
- `IVA Descontable`: Sumatoria de IVA en compras del período
- `IVA a Pagar = IVA Generado - IVA Descontable`
- Si es positivo: pagar a la DIAN
- Si es negativo: solicitar devolución o cross-current

**RN-FIS-004: Retención en la Fuente**
*SI* se registra una compra o venta que requiere retención,
*ENTONCES* el sistema debe:
- Calcular retención según tarifas configuradas:
  - Compras: típicamente 2.5%, 3.5%, 11% según producto/servicio
  - Servicios: 11%
  - Compras con tarjeta: 1%
- Generar asiento de retención
- Acumular en `retention_accumulated` para certificado

**RN-FIS-005: Exportación de Medios Magnéticos**
*SI* se solicita exportación para medios magnéticos DIAN,
*ENTONCES* el sistema debe:
- Generar archivos en formato requerido (XML, texto estructurado)
- Para Formato 1001 (Pagos a terceros): incluir todas las retenciones practicadas
- Para Formato 1005 (Ingresos): incluir todas las ventas con IVA
- Validar datos antes de exportar (NIT válidos, montos cuadrar)
- Generar archivo firmable digitalmente

---

## PARTE 27: MÓDULO DE INTEGRACIONES

### 27.1 Objetivo del Módulo

Gestionar integraciones con hardware (impresoras, lectores, balanzas), servicios de mensajería (WhatsApp, SMS) y APIs externas.

### 27.2 Reglas de Negocio

**RN-INT-001: Impresión de Tickets**
*SI* se envía documento a impresión,
*ENTONCES* el sistema debe:
- Detectar impresoras térmicas disponibles
- Enviar a impresora configurada por defecto
- Si falla, intentar impresoras alternativas
- Si todas fallan, ofrecer "impresión diferida"
- Los caracteres deben ser UTF-8 soportados por ESC/POS

**RN-INT-002: Lectura de Códigos de Barras**
*SI* el lector escanea un código,
*ENTONCES* el sistema debe:
- Capturar entrada del teclado virtual o USB
- Buscar en `product_variants.barcode` o `sku`
- Si encuentra producto: agregarlo al carrito automáticamente
- Si no encuentra: mostrar error y permitir búsqueda manual

**RN-INT-003: Integración con Balanza**
*SI* se conecta balanza electrónica,
*ENTONCES* el sistema debe:
- Capturar peso desde puerto serial/USB
- Si el producto es vendible por peso: usar peso capturado
- Permitir tara manual para envases
- Calcular precio: `peso × precio_por_kg`
- Si la balanza no responde en 5 segundos: solicitar peso manual

**RN-INT-004: Envío de WhatsApp**
*SI* el sistema debe enviar mensaje por WhatsApp,
*ENTONCES* debe usar integración con API disponible:
- WhatsApp Business API (oficial, costos por mensaje)
- WhatsApp Web via librerías (no oficiales, gratis)
- Twilio API (versión gratuita limitada)
- El mensaje puede incluir: texto, PDF (factura), imagen
- Los templates de mensaje están en `notification_templates`

**RN-INT-005: Envío de SMS**
*SI* el sistema debe enviar SMS,
*ENTONCES* debe usar integración con proveedor:
- Twilio, Infobip u otro configurado
- SMS solo para emergencias y verificación 2FA (no para notificaciones rutinarias)
- Costo por SMS enviado
- Los códigos OTP se generan con expiración de 5-10 minutos

---

## PARTE 28: MÓDULO DE BACKUP Y RECUPERACIÓN

### 28.1 Objetivo del Módulo

Gestionar respaldos automáticos de datos, restauración de bases de datos, recuperación ante desastres y exportación de datos por tenant.

### 28.2 Reglas de Negocio

**RN-BCK-001: Backup Automático**
*SI* se ejecuta el proceso de backup programado,
*ENTONCES* el sistema debe:
- Crear backup completo de PostgreSQL
- Incluir todas las tablas del tenant
- Encriptar backup con clave del tenant
- Subir a almacenamiento redundante (S3 + disco local)
- Mantener historial de backups: últimos 30 diarios, 12 mensuales
- Generar hash SHA-256 para verificación de integridad

**RN-BCK-002: Restauración de Tenant**
*SI* un administrador solicita restaurar datos,
*ENTONCES* el sistema debe:
- Mostrar lista de backups disponibles con fecha/hora
- Permitir selección de tenant específico
- Crear backup manual ANTES de restaurar (por seguridad)
- Restaurar tablas filtradas por `tenant_id`
- Validar integridad post-restauración

**RN-BCK-003: Exportación de Datos por Tenant (GDPR)**
*SI* un cliente solicita exportación de sus datos,
*ENTONCES* el sistema debe:
- Exportar todas las tablas del tenant en formato JSON/CSV
- Incluir: productos, clientes, ventas, inventario, transacciones
- Excluir: logs de auditoría detallados (por privacidad)
- Generar archivo descargable
- Plazo máximo: 30 días según normativa

---

## PARTE 29: MÓDULO DE PROMOCIONES Y DESCUENTOS

### 29.1 Objetivo del Módulo

Gestionar promociones automáticas y manuales, cupones de descuento, precios especiales por volumen y aplicación inteligente de la mejor promoción disponible.

### 29.2 Reglas de Negocio

**RN-PROM-001: Creación de Promoción**
*SI* un administrador crea una promoción,
*ENTONCES* el sistema debe:
- Validar campos requeridos:
  - `name`, `type`: percentage, fixed, bogo, free_product, special_price
  - `discount_value`: Porcentaje o monto fijo
  - `valid_from`, `valid_to`: Período de vigencia
- Definir productos/categorías participantes
- Configurar condiciones:
  - `min_quantity`: Cantidad mínima para aplicar
  - `min_purchase_amount`: Monto mínimo de compra
  - `customer_types`: ['retail', 'wholesale', 'vip']
  - `max_uses_per_customer`: Límite por cliente
  - `total_max_uses`: Límite global

**RN-PROM-002: Aplicación Automática de Promociones**
*SI* un producto es agregado al carrito (POS o Portal),
*ENTONCES* el sistema debe:
- Identificar todas las promociones aplicables al producto
- Si múltiples promociones: seleccionar la mejor para el cliente (mayor descuento)
- Aplicar automáticamente si `auto_apply = true`
- Mostrar al usuario la promoción aplicada
- Recalcular totales del carrito

**RN-PROM-003: Validación de Cupones**
*SI* un cliente ingresa un código de cupón,
*ENTONCES* el sistema debe:
- Verificar que el cupón exista y esté activo
- Validar vigencia: `valid_from <= today <= valid_to`
- Validar límites de uso: `current_uses < max_uses`
- Validar condiciones del cliente: tipo, monto mínimo, productos
- Si es válido: aplicar descuento y `current_uses += 1`
- Si es inválido: mostrar razón específica del rechazo

**RN-PROM-004: Acumulación de Promociones**
*SI* hay múltiples promociones aplicables,
*ENTONCES* el sistema debe:
- Aplicar la promoción con mayor descuento primero
- Determinar si las promociones son acumulables según configuración
- Si son acumulables: aplicar en orden de prioridad
- Calcular precio final paso a paso
- Regla general: promociones de porcentaje NO se acumulan con otras de porcentaje

---

## ANEXO A: MATRIZ DE REFERENCIA CRUZADA

### Tablas Principales y Módulos Asociados

| Tabla | Módulo Principal | Reglas Asociadas |
|-------|------------------|------------------|
| `tenants` | Multi-Tenant | RF-007, RN-TEN-001 a RN-TEN-007 |
| `licenses` | Licencias SaaS | RN-LIC-001 a RN-LIC-010 |
| `branches` | Multi-Sucursal | RF-001, RN-CMP-001, RN-CAJ-001 |
| `products` | Catálogo | RN-CAT-001 a RN-CAT-003 |
| `product_variants` | Catálogo | RN-CAT-003 a RN-CAT-005 |
| `price_lists` | Precios | RN-PRE-001 a RN-PRE-006 |
| `suppliers` | Compras | RN-CMP-008, RN-CMP-009 |
| `purchase_orders` | Compras | RN-CMP-001 a RN-CMP-004 |
| `inventory_lotes` | Inventario | RF-003, RN-CMP-006 |
| `inventory_movements` | Inventario | RF-003, RN-POS-002 |
| `sales` | Ventas | RN-POS-003, RN-POS-004 |
| `orders` | Portal Cliente | RN-CLI-005 a RN-CLI-007 |
| `cash_sessions` | Caja | RN-CAJ-001 a RN-CAJ-008 |
| `cash_movements` | Caja | RN-CAJ-003 a RN-CAJ-005 |
| `customers` | Clientes | RN-CLI-001 a RN-CLI-004 |
| `credit_accounts` | Créditos | RN-CRE-001 a RN-CRE-004 |
| `accounting_entries` | Contabilidad | RN-CON-001 a RN-CON-010 |
| `employees` | Nómina | RN-NOM-001 a RN-NOM-003 |
| `audit_logs` | Auditoría | RF-009, RN-AUD-001 a RN-AUD-005 |
| `sync_queue` | Offline | RN-OFF-001 a RN-OFF-005 |

---

## ANEXO B: ÍNDICE DE REGLAS POR CATEGORÍA

### Reglas Fundacionales (Hard Constraints)
RF-001 a RF-009

### Licencias y SaaS
RN-LIC-001 a RN-LIC-010

### Multi-Tenant y Contexto
RN-TEN-001 a RN-TEN-007

### Catálogo de Productos
RN-CAT-001 a RN-CAT-006

### Precios Dinámicos
RN-PRE-001 a RN-PRE-006

### Compras y Proveedores
RN-CMP-001 a RN-CMP-009

### Suministros Corporativos
RN-CORP-001 a RN-CORP-006

### Control de Caja
RN-CAJ-001 a RN-CAJ-008

### Contabilidad
RN-CON-001 a RN-CON-010

### Ventas y POS
RN-POS-001 a RN-POS-007

### Portal Cliente
RN-CLI-001 a RN-CLI-009

### Inventario Físico
RN-INV-001 a RN-INV-005

### Mermas
RN-MER-001 a RN-MER-004

### Vencimientos
RN-VEN-001 a RN-VEN-005

### Créditos
RN-CRE-001 a RN-CRE-004

### Nómina
RN-NOM-001 a RN-NOM-003

### Gastos Operativos
RN-GAS-001 a RN-GAS-002

### Devoluciones
RN-DEV-001 a RN-DEV-003

### Préstamos
RN-PRE-001 a RN-PRE-002 (repetido)

### Logística
RN-LOG-001 a RN-LOG-003

### Reservas
RN-RES-001 a RN-RES-003

### KPIs y Dashboards
RN-KPI-001 a RN-KPI-004

### Comunicación Interna
RN-COM-001 a RN-COM-003

### Auditoría y Seguridad
RN-AUD-001 a RN-AUD-005

### Offline y Sync
RN-OFF-001 a RN-OFF-005

### Reportes Fiscales
RN-FIS-001 a RN-FIS-005

### Integraciones
RN-INT-001 a RN-INT-005

### Backup y Recuperación
RN-BCK-001 a RN-BCK-003

### Promociones
RN-PROM-001 a RN-PROM-004

---

**FIN DEL DOCUMENTO**

*Este documento es la fuente de verdad para todas las reglas de negocio del sistema QFlow Pro. Cualquier implementación debe respetar estas reglas. Para dudas o excepciones, consultar al Arquitecto de Soluciones.*
