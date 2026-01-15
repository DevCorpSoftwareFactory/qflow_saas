# QFlow Pro - Matriz de Roles y Permisos (RBAC)
## Arquitectura de Seguridad Multi-Tenant para Quesera D&G

---

**Versión del Documento:** 1.0  
**Fecha de Creación:** 13 de Enero de 2026  
**Arquitecto:** Arquitecto de Seguridad de la Información (IAM Expert)  
**Clasificación:** Confidencial - Uso Interno  

---

# PARTE 1: FUNDAMENTOS DE SEGURIDAD

## 1.1 Principios Rectores del RBAC

El sistema de control de acceso basado en roles (RBAC) de QFlow Pro se fundamenta en tres principios arquitectónicos que NUNCA pueden ser violados, independientemente del rol o nivel jerárquico del usuario.

**Principio de Menor Privilegio (Least Privilege):** Cada usuario recibe únicamente los permisos mínimos indispensables para desempeñar sus funciones laborales. Este principio se traduce en que ninguna persona tiene acceso por defecto a información o funcionalidades que no utilice directamente en su día a día. Los permisos adicionales solo se otorgan mediante solicitud explícita y justificación documentada, pasando por un proceso de aprobación que evalúa la necesidad real del acceso. La denegación es la configuración por defecto: si un permiso no está explícitamente listado para un rol, ese rol NO lo tiene.

**Principio de Aislación de Datos (Data Isolation):** La información de una Sucursal A es completamente inaccesible para usuarios de Sucursal B, a menos que exista una autorización corporativa explícita. Esta aislación se implementa a nivel de base de datos mediante Row Level Security (RLS), donde cada query incluye filtros automáticos por tenant_id y branch_id. Los únicos roles con visión consolidada de todas las Sucursales son aquellos con alcance corporativo (Dueño, Administrador Corporativo, Contador Corporativo). Ningún usuario operativo puede ver datos de Sucursales distintas a la(s) asignada(s).

**Principio de Separación de Funciones (Separation of Duties):** Las funciones de creación, aprobación y auditoría están distribuidas en roles distintos para prevenir fraudes y errores. Por ejemplo, quien registra una compra NO puede approve el pago de esa misma compra. Quien cierra la caja NO puede approve su propio cuadre. Quien registra una devolución NO puede approve el reintegro de dinero. Esta separación garantiza que al menos dos personas participen en cada transacción financiera crítica.

## 1.2 Matriz de Sensibilidad de Datos

Antes de definir los roles, establecemos la clasificación de sensibilidad de los datos del sistema para determinar qué información requiere protección reforzada.

**Datos Muy Sensibles (Solo roles corporativos):** El precio de costo de los productos y los márgenes de utilidad pertenecen a esta categoría. El conocimiento de estos datos por parte de personal operativo podría facilitar fraudes, fugas de información a competidores o prácticas desleales. Solo el Dueño, Administrador Corporativo, Contador Corporativo y el Contador de Sucursal pueden ver estos datos. Los Cajeros, Vendedores y personal operativo ven ÚNICAMENTE el precio de venta.

**Datos Sensibles (Solo roles administrativos):** La información financiera detallada, las nóminas de empleados, los estados de cuenta de clientes y las métricas de rendimiento pertenecen a esta categoría. Su acceso se limita a roles con responsabilidad administrativa directa.

**Datos Operativos (Roles operativos):** La información necesaria para el día a día de las operaciones: inventario disponible, catálogo de productos, pedidos activos, historial de transacciones propias. Accesible para todo el personal autorizado con las restricciones de Sucursal correspondientes.

**Datos Públicos (Sin restricción):** Información que puede ser conocida por cualquier persona: catálogo de productos con precios (para clientes), políticas generales, información de contacto de la empresa.

---

# PARTE 2: ROLES DE LA PLATAFORMA 1 - ADMIN QFLOW PRO (SaaS)

Esta sección define los roles para los usuarios internos del equipo QFlow Pro que administran la plataforma SaaS y dan servicio a los clientes empresariales.

---

## [ROL: SUPER ADMINISTRADOR QFLOW PRO]

**Descripción y Alcance:** Usuario con acceso TOTAL al sistema de administración de QFlow Pro. Tiene visibilidad y control sobre todos los tenants, licencias, configuraciones globales y operaciones del SaaS. Este rol está reservado para los fundadores o socios del negocio y para personal de confianza absoluta. No existe límite de permisos dentro de la plataforma Admin.

**ALCANCE DE DATOS (Visibility):**

**Ver:** Todos los datos de todos los tenants (empresas clientes), incluyendo datos financieros, métricas de uso, tickets de soporte, historial de licencias, información de tarjetas de crédito tokenizadas (últimos 4 dígitos únicamente), logs de auditoría globales, configuraciones del sistema, métricas de negocio (MRR, churn, CAC, LTV) de todos los clientes.

**Ocultar:** Contraseñas de usuarios (hash only), datos completos de tarjetas de crédito (solo últimos 4 dígitos visibles), contenido de tickets con información sensible marcada como confidencial por el cliente.

---

**PERMISOS POR ACCIÓN (CRUD + ESPECIALES):**

**Módulo: Gestión de Tenants**
- Tenants (Todos): Ver, Crear, Editar, Eliminar, Aprobar -> Control total sobre todas las empresas clientes del SaaS.
- Configuración de Tenant: Ver, Editar -> Modificar parámetros de cualquier tenant.
- Métricas de Tenant: Ver -> Acceso a todas las métricas de uso y negocio.

**Módulo: Gestión de Licencias**
- Licencias: Ver, Crear, Editar, Eliminar, Aprobar -> Administración completa del ciclo de vida de licencias.
- Planes: Ver, Crear, Editar, Eliminar -> Gestión de planes de suscripción.
- Addons: Ver, Crear, Editar, Eliminar -> Gestión de complementos adicionales.
- Claves de Activación: Ver, Crear, Revocar -> Generación y revocación de claves.

**Módulo: Facturación SaaS**
- Facturas: Ver, Crear, Editar, Eliminar, Aprobar -> Gestión completa de facturación.
- Pagos: Ver, Aprobar, Rechazar -> Procesamiento de pagos y cobros.
- Métodos de Pago: Ver (solo últimos 4 dígitos) -> Solo visualización de datos tokenizados.
- Reportes Financieros: Ver, Exportar -> Acceso a reportes financieros consolidados.

**Módulo: Soporte Técnico**
- Tickets: Ver, Asignar, Editar, Aprobar, Cerrar -> Gestión completa del sistema de soporte.
- Base de Conocimientos: Ver, Crear, Editar, Eliminar -> Gestión de artículos de ayuda.
- Satisfacción: Ver, Exportar -> Acceso a métricas de CSAT.

**Módulo: Métricas y Analytics**
- Dashboard Ejecutivo: Ver, Exportar -> Acceso a todas las métricas del SaaS.
- MRR/ARR: Ver, Exportar -> Métricas de ingresos recurrentes.
- Churn Analysis: Ver, Exportar -> Análisis de cancelaciones.
- CAC/LTV: Ver, Exportar -> Métricas de adquisición y valor.

**Módulo: Usuarios Internos**
- Usuarios QFlow Pro: Ver, Crear, Editar, Eliminar, Aprobar -> Gestión de usuarios internos.
- Roles Internos: Ver, Crear, Editar, Eliminar -> Definición de roles del equipo.

**Módulo: Auditoría**
- Logs de Auditoría: Ver, Exportar -> Acceso a logs inmutables de todas las operaciones.
- Seguridad: Ver, Alertas -> Monitoreo de eventos de seguridad.

**Módulo: Configuración del Sistema**
- Configuración Global: Ver, Editar -> Parámetros que afectan a todos los tenants.
- Integraciones: Ver, Configurar -> Conexiones con servicios externos.
- Notificaciones: Ver, Editar -> Plantillas y configuración de notificaciones.

---

## [ROL: ADMINISTRADOR DE VENTAS QFLOW PRO]

**Descripción y Alcance:** Usuario responsable de la adquisición de nuevos clientes, la conversión de leads a clientes pagadores y la gestión de la relación comercial inicial. Tiene acceso a información de clientes potenciales y clientes activos, pero NO tiene acceso a datos financieros sensibles, configuraciones técnicas ni métricas internas del SaaS.

**ALCANCE DE DATOS (Visibility):**

**Ver:** Perfiles de leads y clientes empresariales, historial de interacciones comerciales, propuestas comerciales enviadas, estado de licencias (trial/active/suspended), planes contratados, métricas básicas de uso (usuarios, sucursales), tickets de soporte abiertos.

**Ocultar:** Datos financieros detallados de clientes, información de tarjetas de pago, logs de auditoría, métricas de MRR/ARR/Churn detalladas, configuraciones técnicas del sistema, información de empleados de clientes.

---

**PERMISOS POR ACCIÓN (CRUD + ESPECIALES):**

**Módulo: Gestión de Leads**
- Leads: Ver, Crear, Editar, Eliminar -> Gestión del pipeline comercial.
- Interacciones: Ver, Crear -> Registro de actividades comerciales.

**Módulo: Gestión de Clientes**
- Clientes: Ver, Crear, Editar -> Datos comerciales básicos.
- Licencias: Ver -> Solo estado y plan contratado, sin detalles financieros.
- Contactos: Ver, Crear, Editar -> Gestión de contactos empresariales.

**Módulo: Licencias**
- Licencias Trial: Ver, Crear, Asignar -> Otorgar trials a nuevos leads.
- Licencias Comerciales: Ver -> Solo estado y tipo, sin detalles de pago.

**Módulo: Comercial**
- Propuestas: Ver, Crear, Editar -> Elaboración de propuestas comerciales.
- Conversiones: Ver -> Seguimiento de leads convertidos.

**Módulo: Soporte (限ado)**
- Tickets: Ver, Asignar -> Solo tickets de sus clientes asignados.

---

## [ROL: ADMINISTRADOR DE SOPORTE QFLOW PRO]

**Descripción y Alcance:** Usuario responsable de la atención al cliente del SaaS, gestión de tickets técnicos y funcionales, y soporte en el uso de la plataforma. Tiene acceso a los datos necesarios para reproducir problemas y asistir a los clientes, pero NO tiene acceso a información financiera ni configuraciones críticas del sistema.

**ALCANCE DE DATOS (Visibility):**

**Ver:** Tickets de soporte de todos los clientes, bases de conocimientos, configuraciones de tenant visibles para soporte (sin parámetros sensibles), métricas de uso limitadas (para diagnóstico), logs de sesión de usuarios (para diagnóstico de problemas).

**Ocultar:** Información financiera de clientes, datos de tarjetas de pago, logs de auditoría completos, métricas de negocio (MRR, churn), configuraciones de seguridad, credenciales de acceso.

---

**PERMISOS POR ACCIÓN (CRUD + ESPECIALES):**

**Módulo: Tickets**
- Tickets: Ver, Asignar, Editar, Aprobar, Cerrar -> Gestión completa de soporte.
- Conversaciones: Ver, Crear -> Comunicación con clientes.

**Módulo: Base de Conocimientos**
- Artículos: Ver, Crear, Editar -> Gestión de contenido de ayuda.
- FAQs: Ver, Crear, Editar -> Preguntas frecuentes.

**Módulo: Clientes (限ado)**
- Configuración Visible: Ver -> Solo parámetros relevantes para soporte.

**Módulo: Métricas de Soporte**
- CSAT: Ver, Exportar -> Calificaciones de satisfacción.
- Tiempos de Respuesta: Ver -> Métricas de SLA.

---

## [ROL: ADMINISTRADOR FINANCIERO QFLOW PRO]

**Descripción y Alcance:** Usuario responsable de la gestión financiera del SaaS: facturación, cobros, gestión de cartera y reportes financieros. Tiene acceso a información financiera detallada, pero NO tiene acceso a configuraciones técnicas, datos operativos de clientes ni métricas de producto.

**ALCANCE DE DATOS (Visibility):**

**Ver:** Facturas de todos los clientes, historial de pagos, métodos de pago tokenizados (últimos 4 dígitos), reportes financieros, métricas de ingresos (MRR, ARR), cartera vencida, transacciones de pago, información fiscal de clientes.

**Ocultar:** Configuraciones técnicas del sistema, tickets de soporte (excepto los financieros), datos operativos de clientes, métricas de uso del producto.

---

**PERMISOS POR ACCIÓN (CRUD + ESPECIALES):**

**Módulo: Facturación**
- Facturas: Ver, Crear, Editar, Aprobar -> Gestión de facturación.
- Notas Crédito/Débito: Ver, Crear -> Ajuste de facturación.

**Módulo: Pagos**
- Pagos: Ver, Aprobar, Rechazar -> Procesamiento de cobros.
- Reembolsos: Ver, Crear, Aprobar -> Gestión de devoluciones.

**Módulo: Cartera**
- Cartera Vencida: Ver, Exportar -> Seguimiento de cobranza.
- Clientes en Mora: Ver, Notificar -> Gestión de cartera.

**Módulo: Reportes Financieros**
- Reportes MRR/ARR: Ver, Exportar -> Métricas de ingresos.
- Reportes de Cobranza: Ver, Exportar -> Análisis de cobros.
- Conciliación: Ver, Editar -> Conciliación bancaria.

---

## [ROL: ANALISTA DE MÉTRICAS QFLOW PRO]

**Descripción y Alcance:** Usuario responsable del análisis de métricas de negocio del SaaS, generación de reportes ejecutivos y forecasting. Tiene acceso a datos agregados y métricas, pero NO tiene acceso a datos granulares de clientes individuales, información financiera detallada ni configuraciones del sistema.

**ALCANCE DE DATOS (Visibility):**

**Ver:** Métricas agregadas de MRR, ARR, churn, CAC, LTV por tenant y globales, reportes ejecutivos, dashboards de métricas, análisis de tendencias, proyecciones, cohortes de clientes (datos anonimizados).

**Ocultar:** Datos individuales de clientes, información financiera detallada, transacciones específicas, datos de tarjetas, logs de auditoría, configuraciones del sistema.

---

**PERMISOS POR ACCIÓN (CRUD + ESPECIALES):**

**Módulo: Métricas de Ingresos**
- MRR/ARR: Ver, Exportar -> Métricas de ingresos.
- New/Expansion/Churn: Ver, Exportar -> Componentes de MRR.
- Proyecciones: Ver, Crear -> Forecasting de ingresos.

**Módulo: Métricas de Clientes**
- CAC/LTV: Ver, Exportar -> Métricas de adquisición.
- Churn: Ver, Exportar -> Análisis de cancelaciones.
- Cohortes: Ver, Exportar -> Análisis de retención.

**Módulo: Reportes**
- Dashboards: Ver, Crear -> Construcción de reportes.
- Exportaciones: Ver, Generar -> Generación de reportes.

---

# PARTE 3: ROLES DE LA PLATAFORMA 2 - PORTAL EMPRESARIAL (QUESERA D&G)

Esta sección define los roles para los usuarios internos de Quesera D&G que operan el negocio desde el backoffice corporativo y las sucursales.

---

## [ROL: DUEÑO / PROPIETARIO]

**Descripción y Alcance:** Máximo responsable del negocio con acceso TOTAL a toda la información de Quesera D&G. Puede ver y operar sobre todas las Sucursales, tiene acceso a información confidencial (márgenes, costos, nómina) y puede delegar permisos a otros usuarios. Este rol representa la autoridad ejecutiva del negocio.

**ALCANCE DE DATOS (Visibility):**

**Ver:** TODOS los datos de TODAS las Sucursales, incluyendo ventas, inventario, caja, clientes, proveedores, contabilidad, nóminas, precios de costo, márgenes de utilidad, información corporativa del Dueño (suministros), métricas consolidadas, reportes ejecutivos.

**Ocultar:** Contraseñas de usuarios (solo hash), datos personales sensibles de empleados (documentos de identidad completos), información de tarjetas de clientes.

---

**PERMISOS POR ACCIÓN (CRUD + ESPECIALES):**

**Módulo: Sucursales**
- Sucursales: Ver, Crear, Editar, Eliminar, Aprobar -> Gestión completa de Sucursales.
- Cajas: Ver, Crear, Editar, Eliminar -> Configuración de cajas.
- Configuración Sucursal: Ver, Editar -> Parámetros de cada Sucursal.

**Módulo: Usuarios y Roles**
- Usuarios: Ver, Crear, Editar, Eliminar, Aprobar -> Gestión de usuarios de todas las Sucursales.
- Roles: Ver, Crear, Editar, Eliminar -> Definición de roles del negocio.
- Empleados: Ver, Crear, Editar, Eliminar -> Gestión de personal.
- Nóminas: Ver, Crear, Editar, Eliminar, Aprobar -> Gestión de nómina completa.

**Módulo: Catálogo**
- Categorías: Ver, Crear, Editar, Eliminar -> Gestión de categorías.
- Marcas: Ver, Crear, Editar, Eliminar -> Gestión de marcas.
- Productos: Ver, Crear, Editar, Eliminar -> Gestión completa de productos.
- Variantes: Ver, Crear, Editar, Eliminar -> Gestión de SKUs.
- Listas Precios: Ver, Crear, Editar, Eliminar -> Gestión de precios.
- Precios: Ver, Crear, Editar, Eliminar -> Configuración de precios (incluye PRECIO DE COSTO).

**Módulo: Inventario**
- Lotes: Ver, Crear, Editar, Eliminar, Aprobar -> Gestión de lotes.
- Movimientos: Ver, Exportar -> Trazabilidad de inventario.
- Ajustes: Ver, Crear, Aprobar -> Correcciones de inventario.
- Transferencias: Ver, Crear, Editar, Aprobar -> Entre Sucursales.
- Mermas: Ver, Crear, Editar, Eliminar -> Control de pérdidas.
- Vencimientos: Ver, Editar -> Gestión de productos perecederos.

**Módulo: Compras (Proveedores Externos)**
- Proveedores: Ver, Crear, Editar, Eliminar, Bloquear -> Gestión de proveedores.
- Órdenes Compra: Ver, Crear, Editar, Eliminar, Aprobar -> Gestión de compras.
- Recepciones: Ver, Crear, Editar, Aprobar -> Recepción de mercancía.
- Facturas Compra: Ver, Crear, Editar, Eliminar, Aprobar -> Gestión de facturas.
- Pagos Proveedores: Ver, Crear, Editar, Aprobar -> Pagos a proveedores.
- Devoluciones: Ver, Crear, Editar, Aprobar -> Devoluciones a proveedores.

**Módulo: Suministros Corporativos**
- Compras Corporativas: Ver, Crear, Editar, Eliminar, Aprobar -> Compras del Dueño.
- Transferencias: Ver, Crear, Editar, Eliminar, Aprobar -> Distribución a Sucursales.
- Cuentas por Pagar Corp: Ver, Editar, Aprobar -> Deudas de Sucursales al Corporativo.
- Pagos Corporativos: Ver, Crear, Aprobar -> Pagos de Sucursales al Corporativo.

**Módulo: Ventas POS**
- Ventas: Ver, Crear, Editar (Anular), Aprobar -> Gestión de ventas.
- Devoluciones: Ver, Crear, Editar, Aprobar -> Gestión de devoluciones.
- Créditos: Ver, Crear, Editar, Aprobar -> Gestión de créditos.

**Módulo: Pedidos Portal**
- Pedidos: Ver, Editar, Aprobar, Cancelar -> Gestión de pedidos del portal.
- Reservas: Ver, Editar, Eliminar, Aprobar -> Control de reservas.
- Facturas: Ver, Crear, Editar, Eliminar, Aprobar -> Gestión de facturas.

**Módulo: Caja**
- Sesiones: Ver, Crear, Editar, Aprobar -> Gestión de cajas.
- Movimientos: Ver, Crear, Editar, Aprobar -> Movimientos de efectivo.
- Cuadres: Ver, Editar, Aprobar -> Cierre de caja y cuadres.
- Arqueos: Ver, Crear, Editar, Aprobar -> Arqueos de efectivo.

**Módulo: Clientes**
- Clientes: Ver, Crear, Editar, Eliminar, Bloquear -> Gestión de clientes.
- Créditos: Ver, Crear, Editar, Eliminar, Aprobar -> Gestión de líneas de crédito.
- Pagos: Ver, Crear, Editar, Aprobar -> Verificación de pagos.
- Estados Cuenta: Ver, Exportar -> Estados de cuenta de clientes.

**Módulo: Contabilidad**
- Asientos: Ver, Crear, Editar, Eliminar, Aprobar -> Gestión contable.
- Períodos: Ver, Crear, Editar, Cerrar -> Períodos contables.
- Plan Cuentas: Ver, Crear, Editar, Eliminar -> PUC colombiano.
- Reportes: Ver, Exportar -> Libros y reportes contables.
- Conciliación: Ver, Crear, Editar -> Conciliación bancaria.

**Módulo: Reportes**
- Ventas: Ver, Exportar -> Reportes de ventas.
- Inventario: Ver, Exportar -> Reportes de inventario.
- Financieros: Ver, Exportar -> Reportes financieros.
- Cartera: Ver, Exportar -> Reportes de cartera.
- Consolidados: Ver, Exportar -> Reportes consolidados de todas las Sucursales.

---

## [ROL: ADMINISTRADOR CORPORATIVO]

**Descripción y Alcance:** Usuario con privilegios administrativos a nivel corporativo, capaz de gestionar todas las Sucursales y usuarios del sistema. Tiene acceso a información confidencial de costos y márgenes, pero NO puede modificar configuraciones técnicas del SaaS ni acceder a información de otros tenants. Este rol辅助 al Dueño en la administración diaria.

**ALCANCE DE DATOS (Visibility):**

**Ver:** TODOS los datos de TODAS las Sucursales, incluyendo información de costos y márgenes, nóminas, información financiera consolidada, reportes de todas las Sucursales.

**Ocultar:** Contraseñas de usuarios (solo hash), información personal sensible de empleados (documentos completos), configuraciones técnicas del SaaS, información de otros tenants.

---

**PERMISOS POR ACCIÓN (CRUD + ESPECIALES):**

**Módulo: Sucursales**
- Sucursales: Ver, Crear, Editar, Aprobar -> Gestión de Sucursales (no eliminar).
- Cajas: Ver, Crear, Editar -> Configuración de cajas.

**Módulo: Usuarios y Roles**
- Usuarios: Ver, Crear, Editar, Aprobar -> Gestión de usuarios de todas las Sucursales.
- Roles: Ver -> Solo visualización de roles definidos.

**Módulo: Catálogo**
- Productos: Ver, Crear, Editar -> Gestión de productos.
- Variantes: Ver, Crear, Editar -> Gestión de SKUs.
- Precios: Ver, Crear, Editar -> Configuración de precios (incluye PRECIO DE COSTO).
- Listas Precios: Ver, Crear, Editar -> Gestión de listas.

**Módulo: Inventario**
- Lotes: Ver, Crear, Editar -> Gestión de lotes.
- Movimientos: Ver, Exportar -> Trazabilidad.
- Ajustes: Ver, Crear, Aprobar -> Correcciones.
- Transferencias: Ver, Crear, Aprobar -> Entre Sucursales.

**Módulo: Compras**
- Proveedores: Ver, Crear, Editar -> Gestión de proveedores.
- Órdenes Compra: Ver, Crear, Editar, Aprobar -> Gestión de compras.
- Recepciones: Ver, Crear, Aprobar -> Recepción.
- Pagos Proveedores: Ver, Crear, Aprobar -> Pagos.

**Módulo: Suministros Corporativos**
- Compras Corporativas: Ver, Crear, Editar, Aprobar -> Gestión de compras del Dueño.
- Transferencias: Ver, Crear, Aprobar -> Distribución.
- Cuentas por Pagar Corp: Ver, Aprobar -> Control de deudas.

**Módulo: Ventas**
- Ventas: Ver, Editar (Anular), Aprobar -> Gestión de ventas.
- Devoluciones: Ver, Crear, Aprobar -> Devoluciones.

**Módulo: Pedidos Portal**
- Pedidos: Ver, Editar, Aprobar, Cancelar -> Gestión de pedidos.
- Facturas: Ver, Crear, Editar, Aprobar -> Facturación.

**Módulo: Caja**
- Sesiones: Ver, Crear, Editar, Aprobar -> Gestión de cajas.
- Cuadres: Ver, Aprobar -> Cierre de caja.

**Módulo: Clientes**
- Clientes: Ver, Crear, Editar, Bloquear -> Gestión de clientes.
- Créditos: Ver, Crear, Editar, Aprobar -> Gestión de crédito.

**Módulo: Contabilidad**
- Asientos: Ver, Crear, Editar, Aprobar -> Gestión contable.
- Períodos: Ver, Cerrar -> Cierre de períodos.
- Reportes: Ver, Exportar -> Reportes contables.

**Módulo: Reportes**
- Todos los Reportes: Ver, Exportar -> Acceso a reportes consolidados.

---

## [ROL: ADMINISTRADOR DE SUCURSAL]

**Descripción y Alcance:** Usuario responsable de la operación diaria de una Sucursal específica. Tiene acceso completo a los datos y operaciones de SU Sucursal asignada, pero NO puede ver datos de otras Sucursales. Puede gestionar usuarios de su Sucursal y tiene acceso a información de precios de costo para su Sucursal.

**ALCANCE DE DATOS (Visibility):**

**Ver:** Todos los datos de la Sucursal ASIGNADA únicamente: ventas, inventario, caja, clientes de la Sucursal, proveedores (solo los que surten a su Sucursal), precios de costo del inventario de su Sucursal.

**Ocultar:** Datos de OTRAS Sucursales, nóminas de empleados (solo la suya si aplica), información corporativa del Dueño (suministros), métricas consolidadas de otras Sucursales, configuraciones corporativas globales.

---

**PERMISOS POR ACCIÓN (CRUD + ESPECIALES):**

**Módulo: Sucursal (Propia)**
- Configuración: Ver, Editar -> Parámetros de su Sucursal.
- Cajas: Ver, Crear, Editar -> Gestión de cajas de su Sucursal.

**Módulo: Usuarios (Sucursal Propia)**
- Usuarios: Ver, Crear, Editar -> Gestión de usuarios de su Sucursal (no puede crear Admin).
- Roles: Ver -> Solo visualización.

**Módulo: Catálogo**
- Productos: Ver -> Solo lectura del catálogo corporativo.
- Variantes: Ver -> Solo lectura.
- Precios: Ver, Editar -> Solo precios de venta de su Sucursal (NO precio de costo).

**Módulo: Inventario**
- Lotes: Ver, Crear, Editar -> Gestión de lotes de su Sucursal.
- Movimientos: Ver -> Trazabilidad de su Sucursal.
- Ajustes: Ver, Crear -> Correcciones de inventario (monto bajo requiere solo editar, alto requiere aprobación).
- Consultas Stock: Ver -> Inventario de su Sucursal.

**Módulo: Compras (Sucursal Propia)**
- Órdenes Compra: Ver, Crear, Editar, Aprobar -> Compras de su Sucursal.
- Recepciones: Ver, Crear, Aprobar -> Recepción en su Sucursal.
- Pagos Proveedores: Ver, Crear, Aprobar -> Pagos de su Sucursal.

**Módulo: Ventas POS**
- Ventas: Ver, Crear, Editar (Anular bajo monto) -> Ventas de su Sucursal.
- Devoluciones: Ver, Crear -> Devoluciones (monto bajo solo editar, alto requiere aprobación).

**Módulo: Pedidos Portal**
- Pedidos: Ver, Editar, Aprobar, Cancelar -> Pedidos de su Sucursal.
- Reservas: Ver, Editar, Cancelar -> Control de reservas.
- Facturas: Ver, Crear, Editar -> Facturación.

**Módulo: Caja**
- Sesiones: Ver, Crear, Abrir/Cerrar -> Gestión de caja de su Sucursal.
- Movimientos: Ver, Crear -> Movimientos de efectivo.
- Cuadres: Ver, Crear, Editar -> Cierre de caja (aprobar solo el propio).

**Módulo: Clientes (Sucursal Propia)**
- Clientes: Ver, Crear, Editar, Bloquear -> Gestión de clientes de su Sucursal.
- Créditos: Ver, Crear, Editar, Aprobar -> Otorgamiento de crédito.

**Módulo: Contabilidad (Sucursal Propia)**
- Asientos: Ver, Crear -> Asientos operativos de su Sucursal.
- Reportes: Ver, Exportar -> Reportes de su Sucursal.

**Módulo: Reportes**
- Reportes Sucursal: Ver, Exportar -> Reportes de su Sucursal.

---

## [ROL: CONTADOR CORPORATIVO]

**Descripción y Alcance:** Usuario responsable de la contabilidad consolidada de Quesera D&G, con acceso a los datos contables de todas las Sucursales para consolidación, cierre mensual y preparación de declaraciones tributarias. Tiene acceso a información financiera detallada, pero NO tiene acceso a información operativa de inventario detallado ni a permisos de modificación de datos.

**ALCANCE DE DATOS (Visibility):**

**Ver:** Todos los datos contables de TODAS las Sucursales: asientos contables, balances, reportes financieros, información fiscal, conciliaciones bancarias, métricas financieras consolidadas, información de costos y márgenes para análisis contable.

**Ocultar:** Datos operativos detallados de inventario (lotes individuales), información de clientes individuales (solo datos contables), información de empleados (solo datos de nómina), configuraciones del sistema.

---

**PERMISOS POR ACCIÓN (CRUD + ESPECIALES):**

**Módulo: Contabilidad (Todas las Sucursales)**
- Asientos: Ver, Crear, Editar (solo propios errores), Aprobar -> Gestión contable.
- Períodos: Ver, Cerrar -> Cierre de períodos contables.
- Plan Cuentas: Ver -> Solo lectura del PUC.
- Conciliación: Ver, Crear -> Conciliación bancaria.

**Módulo: Reportes Contables**
- Libro Diario: Ver, Exportar -> Libro diario consolidado.
- Libro Mayor: Ver, Exportar -> Libro mayor por cuenta.
- Balance: Ver, Exportar -> Balance de prueba.
- Estados Financieros: Ver, Exportar -> Estados financieros consolidados.

**Módulo: Impuestos**
- Declaraciones: Ver, Crear -> Preparación de declaraciones.
- Retenciones: Ver, Exportar -> Reporte de retenciones.
- IVA: Ver, Exportar -> Libro de IVA.

**Módulo: Costos y Márgenes**
- Costo Ventas: Ver -> Información de costos para análisis.
- Márgenes: Ver -> Márgenes por producto/Sucursal.

**Módulo: Nómina (Solo lectura)**
- Nóminas: Ver -> Visualización para contabilización.
- Provisiones: Ver -> Para provisiones contables.

**Módulo: Cierre**
- Cierre Mensual: Ver, Aprobar -> Proceso de cierre.
- Ajustes Cierre: Ver, Crear -> Ajustes de cierre.

---

## [ROL: CONTADOR DE SUCURSAL]

**Descripción y Alcance:** Usuario responsable de la contabilidad local de una Sucursal específica, con acceso a los datos contables de SU Sucursal para registro de operaciones locales y preparación de información para el Contador Corporativo. Tiene acceso a información de costos para la Sucursal.

**ALCANCE DE DATOS (Visibility):**

**Ver:** Datos contables de la Sucursal ASIGNADA únicamente: asientos contables locales, conciliaciones, reportes financieros de la Sucursal, información de costos del inventario de su Sucursal.

**Ocultar:** Datos de OTRAS Sucursales, nóminas de otras Sucursales, información corporativa del Dueño, configuraciones globales.

---

**PERMISOS POR ACCIÓN (CRUD + ESPECIALES):**

**Módulo: Contabilidad (Sucursal Propia)**
- Asientos: Ver, Crear, Editar (solo propios errores) -> Registro contable local.
- Períodos: Ver -> Solo lectura de períodos.
- Conciliación: Ver, Crear -> Conciliación bancaria local.

**Módulo: Reportes (Sucursal Propia)**
- Reportes Locales: Ver, Exportar -> Reportes de su Sucursal.
- Libro Diario: Ver, Exportar -> Libro diario local.

**Módulo: Costos**
- Costo Inventario: Ver -> Costos de su Sucursal.
- Costo Ventas: Ver -> Para análisis local.

**Módulo: Cierre**
- Cierre Local: Ver, Aprobar -> Cierre mensual de su Sucursal.
- Info Corporativo: Enviar -> Envío de información al Contador Corporativo.

---

## [ROL: SUPERVISOR DE SUCURSAL]

**Descripción y Alcance:** Usuario con capacidad de supervisión y aprobación de operaciones en una Sucursal específica. Puede aprobar transacciones que excedan los límites del personal operativo, gestionar excepciones y tiene acceso a información operativa del día a día. NO tiene acceso a información financiera detallada ni a precios de costo.

**ALCANCE DE DATOS (Visibility):**

**Ver:** Datos operativos de la Sucursal ASIGNADA: ventas del día, movimientos de caja, inventario disponible, pedidos en curso, clientes, reportes operativos, métricas de rendimiento de la Sucursal.

**Ocultar:** Precios de costo de productos, márgenes de utilidad, nóminas de empleados, información financiera detallada, datos de OTRAS Sucursales, información corporativa del Dueño.

---

**PERMISOS POR ACCIÓN (CRUD + ESPECIALES):**

**Módulo: Ventas**
- Ventas: Ver, Aprobar -> Aprobación de anulaciones que excedan límite cajero.
- Devoluciones: Ver, Aprobar -> Aprobación de devoluciones de alto monto.

**Módulo: Inventario**
- Ajustes: Ver, Aprobar -> Aprobación de ajustes de alto monto.
- Mermas: Ver, Aprobar -> Aprobación de mermas significativas.

**Módulo: Caja**
- Cuadres: Ver, Aprobar -> Aprobación de cuadres con diferencias.
- Arqueos: Ver, Aprobar -> Verificación de arqueos.

**Módulo: Pedidos**
- Pedidos: Ver, Aprobar -> Aprobación de pedidos especiales.
- Excepciones: Ver, Aprobar -> Manejo de excepciones.

**Módulo: Clientes**
- Créditos: Ver, Aprobar -> Aprobación de créditos de alto monto.
- Descuentos: Ver, Aprobar -> Aprobación de descuentos especiales.

**Módulo: Reportes**
- Reportes Operativos: Ver, Exportar -> Reportes del día.
- Rendimiento: Ver -> Métricas de rendimiento de la Sucursal.

---

## [ROL: CAJERO / VENDEDOR]

**Descripción y Alcance:** Usuario responsable de la atención al cliente en punto de venta, registro de ventas, manejo de caja y atención básica. Tiene acceso limitado a las operaciones necesarias para su función y NO puede ver precios de costo ni información confidencial. Este rol opera exclusivamente en la Sucursal asignada.

**ALCANCE DE DATOS (Visibility):**

**Ver:** Catálogo de productos con PRECIOS DE VENTA únicamente, inventario disponible de su Sucursal, clientes registrados (solo datos básicos), historial de sus propias ventas, movimientos de caja del día, reportes operativos básicos.

**Ocultar:** Precios de costo de productos, márgenes de utilidad, información de otros empleados, nóminas, información financiera detallada, datos de otras Sucursales, información corporativa del Dueño, costos de pedidos del portal, métricas de rendimiento.

---

**PERMISOS POR ACCIÓN (CRUD + ESPECIALES):**

**Módulo: POS**
- Productos: Ver -> Catálogo con precios de venta.
- Búsqueda: Ver -> Búsqueda de productos.
- Carrito: Crear, Editar -> Armado de venta.
- Venta: Crear -> Confirmar venta (con método de pago).
- Cobro: Crear -> Procesar cobro.

**Módulo: Caja**
- Apertura: Crear -> Apertura de caja (monto inicial).
- Movimientos: Crear -> Registrar ingresos/egresos menores (límite bajo).
- Cierre: Crear -> Iniciar cierre de caja.

**Módulo: Clientes (限ado)**
- Consulta: Ver -> Consultar cliente por código/nombre.
- Crédito: Ver -> Consultar saldo disponible de crédito.

**Módulo: Inventario (Solo consulta)**
- Stock: Ver -> Inventario disponible (sin detalles de lotes).
- Productos: Ver -> Catálogo de productos.

**Módulo: Pedidos Portal (限ado)**
- Preparación: Editar -> Marcar como preparado (si tiene permisos).
- Entrega: Editar -> Confirmar entrega.

---

## [ROL: ALMACENISTA / BODEGUERO]

**Descripción y Alcance:** Usuario responsable de la recepción de mercancía, control de inventario físico, organización de bodega y preparación de pedidos. Tiene acceso a información de inventario detallada, pero NO tiene acceso a información financiera, precios de costo ni operaciones de venta y caja.

**ALCANCE DE DATOS (Visibility):**

**Ver:** Inventario de la Sucursal ASIGNADA con detalles de lotes, movimientos de inventario, órdenes de compra para recepción, transferencias entrantes, productos próximos a vencer.

**Ocultar:** Precios de costo de productos, información financiera, ventas, caja, nóminas, datos de otras Sucursales, información corporativa del Dueño.

---

**PERMISOS POR ACCIÓN (CRUD + ESPECIALES):**

**Módulo: Inventario**
- Lotes: Ver, Crear -> Recepción de mercancía (crear lotes).
- Movimientos: Ver, Crear -> Registro de movimientos (entradas/salidas).
- Stock: Ver -> Consulta de inventario disponible.
- Consultas: Ver -> Consultas de stock por producto/lote.

**Módulo: Recepciones**
- Órdenes Compra: Ver -> Visualizar órdenes pendientes.
- Recepciones: Crear -> Registrar recepción de mercancía.
- Diferencias: Crear -> Registrar diferencias en recepción.

**Módulo: Transferencias**
- Transferencias Entrantes: Ver, Editar -> Recepción de transferencias.
- Transferencias Salientes: Ver, Crear -> Preparar transferencias salientes.

**Módulo: Control**
- Vencimientos: Ver -> Productos próximos a vencer.
- mermas: Crear -> Registrar mermas (límite bajo).
- Ajustes: Crear -> Ajustes menores de inventario.

**Módulo: Pedidos**
- Preparación: Ver, Editar -> Preparar pedidos para entrega.

---

## [ROL: AUXILIAR DE COMPRAS]

**Descripción y Alcance:** Usuario responsable de la gestión de órdenes de compra a proveedores, seguimiento de recepciones y registro de la documentación de compras. Tiene acceso a información de proveedores y compras, pero NO tiene acceso a información financiera detallada, precios de costo de productos ni operaciones de venta.

**ALCANCE DE DATOS (Visibility):**

**Ver:** Catálogo de productos con precios de VENTA (no costo), proveedores, órdenes de compra, recepciones pendientes, historial de compras con proveedores.

**Ocultar:** Precios de costo de productos, márgenes de utilidad, información financiera detallada, caja, ventas, nóminas, datos de otras Sucursales, información corporativa del Dueño.

---

**PERMISOS POR ACCIÓN (CRUD + ESPECIALES):**

**Módulo: Proveedores**
- Proveedores: Ver -> Lista de proveedores.
- Contactos: Ver -> Información de contacto.

**Módulo: Órdenes de Compra**
- Órdenes: Ver, Crear, Editar -> Gestión de órdenes de compra.
- Seguimiento: Ver -> Estado de órdenes.

**Módulo: Recepciones**
- Recepciones: Ver -> Visualizar recepciones pendientes.
- Documentación: Crear, Editar -> Registro de documentos.

**Módulo: Catálogo (限ado)**
- Productos: Ver -> Catálogo para referencia.

**Módulo: Inventario (Solo consulta)**
- Stock: Ver -> Consulta para decisiones de compra.

---

## [ROL: RECURSOS HUMANOS]

**Descripción y Alcance:** Usuario responsable de la gestión del personal: contratación, administración de nóminas, control de asistencia y desarrollo de talento. Tiene acceso a información de empleados y nóminas, pero NO tiene acceso a información operativa del negocio (ventas, inventario, caja) ni a configuraciones del sistema.

**ALCANCE DE DATOS (Visibility):**

**Ver:** Información de TODOS los empleados del tenant: datos personales, contratos, nóminas, historial laboral, desempeño, asistencia. Información de candidatos si aplica.

**Ocultar:** Información de clientes, proveedores, ventas, inventario, caja, precios de costo, información financiera, configuraciones del sistema, datos de otras Sucursales (excepto datos de personal).

---

**PERMISOS POR ACCIÓN (CRUD + ESPECIALES):**

**Módulo: Empleados**
- Empleados: Ver, Crear, Editar, Eliminar -> Gestión de personal.
- Contratos: Ver, Crear, Editar -> Administración de contratos.
- Datos Personales: Ver, Editar -> Información de empleados.

**Módulo: Nómina**
- Cálculo: Ver, Crear -> Preparación de nómina.
- Pagos: Ver -> Información de pagos de nómina.
- Prestaciones: Ver, Editar -> Gestión de prestaciones.

**Módulo: Asistencia**
- Registros: Ver, Editar -> Control de asistencia.
- Ausencias: Ver, Crear -> Gestión de ausencias.

**Módulo: Desarrollo**
- Evaluaciones: Ver, Crear, Editar -> Evaluación de desempeño.
- Capacitación: Ver, Crear -> Programas de capacitación.

**Módulo: Reportes**
- Nómina: Ver, Exportar -> Reportes de nómina.
- Personal: Ver, Exportar -> Reportes de personal.

---

# PARTE 4: ROLES DE LA PLATAFORMA 3 - APP CLIENTE FINAL (B2B)

Esta sección define los roles para los clientes empresariales y finales que acceden al portal B2B para realizar pedidos, consultar estados de cuenta y comunicarse con Quesera D&G.

---

## [ROL: CLIENTE MAYORISTA]

**Descripción y Alcance:** Cliente empresarial que compra productos de Quesera D&G al por mayor para su negocio. Tiene acceso al portal de pedidos con precios mayoristas, puede realizar pedidos, consultar estado de cuenta y gestionar sus pagos. Este rol representa a las tiendas y negocios que son clientes de Quesera D&G.

**ALCANCE DE DATOS (Visibility):**

**Ver:** Catálogo de productos con PRECIOS MAYORISTAS únicamente (diferentes a precios minoristas), su propio historial de pedidos, sus propias facturas y estados de cuenta, su propio límite de crédito y saldo disponible, sus propios pagos registrados, información de sus entregas.

**Ocultar:** Precios minoristas de productos, precios de costo de productos, información de otros clientes, catálogos de otros clientes, pedidos de otros clientes, información interna de Quesera D&G, inventarios detallados, información de empleados, configuraciones del sistema.

---

**PERMISOS POR ACCIÓN (CRUD + ESPECIALES):**

**Módulo: Catálogo**
- Productos: Ver -> Catálogo con precios mayoristas.
- Búsqueda: Ver -> Búsqueda de productos.
- Filtrado: Ver -> Filtrar por categoría, disponibilidad.

**Módulo: Carrito**
- Items: Ver, Crear, Editar, Eliminar -> Gestión del carrito.
- Total: Ver -> Resumen de compra.

**Módulo: Pedidos**
- Pedidos: Ver, Crear, Cancelar -> Crear y gestionar sus pedidos.
- Detalle: Ver -> Detalle de cada pedido.
- Seguimiento: Ver -> Estado de pedidos.
- Historial: Ver -> Historial de pedidos.

**Módulo: Facturación**
- Facturas: Ver -> Sus propias facturas.
- Historial: Ver -> Historial de facturas.
- Saldo: Ver -> Saldo pendiente.

**Módulo: Pagos**
- Pagos: Ver, Crear -> Registrar sus pagos.
- Comprobantes: Ver -> Sus comprobantes subidos.
- Estado: Ver -> Estado de verificación de pagos.

**Módulo: Cuenta**
- Perfil: Ver, Editar -> Información de su cuenta.
- Crédito: Ver -> Límite y saldo disponible.
- Dirección: Ver, Editar -> Direcciones de entrega.

**Módulo: Comunicación**
- Mensajes: Ver, Crear -> Comunicación con Quesera D&G.
- Tickets: Ver, Crear -> Soporte técnico.

---

## [ROL: CLIENTE MINORISTA]

**Descripción y Alcance:** Cliente que compra productos de Quesera D&G al detal para consumo propio. Tiene acceso al portal con precios minoristas, puede realizar pedidos y consultar su historial. Este rol representa a consumidores finales.

**ALCANCE DE DATOS (Visibility):**

**Ver:** Catálogo de productos con PRECIOS MINORISTAS únicamente, su propio historial de pedidos, sus propias facturas, sus propios pagos.

**Ocultar:** Precios mayoristas de productos, precios de costo, información de otros clientes, catálogos de otros clientes, inventarios detallados, información interna de Quesera D&G, información de empleados, configuraciones del sistema.

---

**PERMISOS POR ACCIÓN (CRUD + ESPECIALES):**

**Módulo: Catálogo**
- Productos: Ver -> Catálogo con precios minoristas.
- Búsqueda: Ver -> Búsqueda de productos.

**Módulo: Carrito**
- Items: Ver, Crear, Editar, Eliminar -> Gestión del carrito.

**Módulo: Pedidos**
- Pedidos: Ver, Crear, Cancelar -> Crear y gestionar sus pedidos.
- Detalle: Ver -> Detalle de cada pedido.

**Módulo: Cuenta**
- Perfil: Ver, Editar -> Información de su cuenta.
- Historial: Ver -> Historial de pedidos y pagos.

**Módulo: Comunicación**
- Mensajes: Ver, Crear -> Comunicación con Quesera D&G.

---

## [ROL: CLIENTE VIP / ESPECIAL]

**Descripción y Alcance:** Cliente empresarial con estatus especial que tiene acceso a precios preferenciales, límites de crédito mayores, atención prioritaria y funcionalidades adicionales del portal. Este rol se asigna manualmente por la empresa.

**ALCANCE DE DATOS (Visibility):**

**Ver:** Catálogo de productos con PRECIOS VIP (los más bajos disponibles), su propio historial completo, sus propias facturas con condiciones especiales, su propio límite de crédito mayor, sus propias promociones especiales.

**Ocultar:** Precios de otros clientes, información de otros clientes, información interna de Quesera D&G, inventarios detallados, información de empleados.

---

**PERMISOS POR ACCIÓN (CRUD + ESPECIALES):**

**Módulo: Catálogo**
- Productos: Ver -> Catálogo con precios VIP.
- Promociones: Ver -> Promociones especiales para VIP.

**Módulo: Pedidos**
- Pedidos: Ver, Crear, Cancelar -> Gestión de pedidos con prioridad.
- Seguimiento: Ver -> Seguimiento con prioridad.

**Módulo: Facturación**
- Facturas: Ver -> Sus propias facturas.
- Crédito: Ver -> Límite VIP y saldo disponible.

**Módulo: Cuenta**
- Perfil: Ver, Editar -> Información de su cuenta.
- Gestor: Ver -> Contacto de su gestor de cuenta.

**Módulo: Comunicación**
- Canal Prioritario: Ver, Crear -> Canal de comunicación prioritario.

---

## [ROL: CLIENTE POTENCIAL / REGISTRADO]

**Descripción y Alcance:** Usuario que se ha registrado en el portal pero aún no ha sido aprobado por Quesera D&G. Tiene acceso limitado al sistema mientras espera aprobación. Este es un estado transitorio antes de convertirse en cliente activo.

**ALCANCE DE DATOS (Visibility):**

**Ver:** Catálogo público con precios (según el tipo solicitado), estado de su solicitud de registro, información básica de la empresa.

**Ocultar:** historial de pedidos (no tiene), estado de cuenta (no tiene), información de otros clientes, información interna de Quesera D&G, inventarios detallados.

---

**PERMISOS POR ACCIÓN (CRUD + ESPECIALES):**

**Módulo: Registro**
- Solicitud: Ver, Editar -> Su propia solicitud de registro.

**Módulo: Catálogo (限ado)**
- Productos: Ver -> Catálogo público.

**Módulo: Cuenta**
- Estado: Ver -> Estado de su solicitud pendiente.
- Información: Ver, Editar -> Completar su perfil.

---

## [ROL: CLIENTE SUSPENDIDO / BLOQUEADO]

**Descripción y Alcance:** Cliente que ha sido suspendido temporalmente por falta de pago, deuda vencida u otra razón administrativa. Tiene acceso muy limitado al sistema para consultar su situación y regularizar.

**ALCANCE DE DATOS (Visibility):**

**Ver:** Mensaje de suspensión con razón, información de su cuenta con saldo pendiente, información de contacto para regularizar, catálogo público (sin precios detallados).

**Ocultar:** Realizar pedidos (bloqueado), ver precios detallados (bloqueado), historial de pedidos (solo lectura), estado de cuenta (solo ver saldo pendiente).

---

**PERMISOS POR ACCIÓN (CRUD + ESPECIALES):**

**Módulo: Cuenta**
- Perfil: Ver -> Información de su cuenta.
- Saldo: Ver -> Saldo pendiente y razón de suspensión.

**Módulo: Comunicación**
- Pagos: Crear -> Registrar pago para regularizar.
- Soporte: Ver, Crear -> Contactar para resolver situación.

**Módulo: Catálogo (限ado)**
- Catálogo: Ver -> Solo catálogo público (sin precios).

---

# PARTE 5: MATRIZ DE SEGURIDAD DE PRECIOS

Esta sección documenta explícitamente qué roles pueden ver qué tipo de precios en el sistema, aplicando el principio de separación de información sensible.

## 5.1 Matriz de Precios por Rol

| Rol | Precio de Costo | Precio Mayorista | Precio Minorista | Precio VIP | Margen de Utilidad |
|-----|-----------------|------------------|------------------|------------|-------------------|
| Super Admin QFlow Pro | SI | SI | SI | SI | SI |
| Admin Corporativo Quesera D&G | SI | SI | SI | SI | SI |
| Dueño Quesera D&G | SI | SI | SI | SI | SI |
| Contador Corporativo | SI | SI | SI | SI | SI |
| Contador Sucursal | SI | NO | NO | NO | SI |
| Admin Sucursal | NO | SI | SI | SI | NO |
| Supervisor Sucursal | NO | SI | SI | SI | NO |
| Cajero | NO | NO | SI | NO | NO |
| Almacenista | NO | NO | NO | NO | NO |
| Auxiliar Compras | NO | NO | SI | NO | NO |
| RRHH | NO | NO | NO | NO | NO |
| Cliente Mayorista | NO | SI | NO | NO | NO |
| Cliente Minorista | NO | NO | SI | NO | NO |
| Cliente VIP | NO | NO | NO | SI | NO |

## 5.2 Justificación de la Matriz

**Precio de Costo (Solo roles administrativos y financieros):** El conocimiento del precio de costo por parte de personal operativo podría facilitar prácticas fraudulentas como venta informal de productos, fugas de información a competidores o negociación desleal con clientes. Por esta razón, únicamente roles con responsabilidad administrativa o financiera pueden ver estos datos.

**Precio Mayorista (Roles comerciales y clientes mayoristas):** Este precio es relevante para operaciones B2B y debe ser visible para el personal que gestiona estas relaciones comerciales, así como para los clientes mayoristas que realizan compras a este precio.

**Precio Minorista (Roles operativos y clientes minoristas):** Este es el precio público de venta al detal y puede ser visible para todo el personal que interactúa con clientes y para los clientes minoristas.

**Precio VIP (Roles con clientes especiales):** Este precio preferencial es visible para roles que atienden clientes VIP y para los propios clientes con este estatus.

**Margen de Utilidad (Solo roles ejecutivos y financieros):** El margen de utilidad es información estratégica confidencial que solo puede ser conocida por la alta dirección y el área financiera para toma de decisiones.

---

# PARTE 6: REGLAS DE APROBACIÓN Y SEPARACIÓN DE FUNCIONES

Esta sección documenta las reglas de separación de funciones que requieren aprobación de roles superiores para ciertas operaciones críticas.

## 6.1 Operaciones que Requieren Aprobación

| Operación | Rol que Ejecuta | Rol que Aprueba | Condición |
|-----------|-----------------|-----------------|-----------|
| Anular venta | Cajero | Supervisor/Admin | Monto > X |
| Devolución | Cajero | Supervisor/Admin | Monto > X |
| Ajuste inventario (entrada) | Almacenista | Admin Sucursal | Valor > Y |
| Ajuste inventario (salida) | Almacenista | Admin Sucursal | Cualquier valor |
| Descuento > 10% | Cajero | Supervisor | Siempre |
| Crédito > límite | Cajero | Admin Sucursal | Siempre |
| Pago a proveedor | Auxiliar Compras | Admin Sucursal | Monto > Z |
| Cierre de caja con diferencia | Cajero | Supervisor | Diferencia > umbral |
| Crear usuario | Admin Sucursal | Admin Corporativo | Crear Admin |
| Editar precio de costo | Admin Corporativo | Dueño | Siempre |
| Eliminar producto | Admin Corporativo | Dueño | Siempre |
| Cancelar pedido | Cliente | Admin Sucursal | Después de confirmación |

## 6.2 Límites Configurables (Ejemplo)

| Concepto | Valor Sugerido | Descripción |
|----------|----------------|-------------|
| Límite anulación venta | $100,000 | Máximo que puede anular un cajero sin aprobación |
| Límite devolución | $50,000 | Máximo que puede devolver un cajero sin aprobación |
| Límite ajuste inventario | $200,000 | Valor máximo de ajuste sin aprobación de Admin |
| Límite pago proveedor | $500,000 | Monto máximo que puede pagar un auxiliar sin aprobación |
| Umbral diferencia caja | $50,000 | Diferencia máxima sin justificación |
| Límite descuento cajero | 5% | Descuento máximo sin aprobación |
| Límite crédito cajero | 50% del límite | Porcentaje del límite que puede otorgar el cajero |

---

# PARTE 7: AUDITORÍA DE ACCESOS

## 7.1 Eventos de Seguridad a Registrar

Todos los eventos relacionados con accesos y permisos deben ser registrados en `audit_logs`:

- Intentos de login exitosos y fallidos
- Cambios de permisos de usuarios
- Accesos a datos sensibles (precios de costo, nóminas)
- Operaciones que requieren aprobación
- Cambios de rol de usuarios
- Exportaciones de datos
- Acceso a información de otros tenants/clientes

## 7.2 Políticas de Revisión

**Revisión mensual:** Revisión de permisos otorgados para verificar que siguen siendo necesarios.

**Revisión trimestral:** Auditoría completa de accesos y ajustes de roles según evolución del negocio.

**Revisión inmediata:** Cuando se detecta un incidente de seguridad o comportamiento anómalo.

---

# ANEXO A: ÍNDICE DE ROLES POR PLATAFORMA

## Plataforma 1: Admin QFlow Pro

| Rol | Código | Alcance |
|-----|--------|---------|
| Super Administrador QFlow Pro | SA-QFLOW | Todos los tenants |
| Administrador de Ventas QFlow Pro | AV-QFLOW | Comercial de clientes |
| Administrador de Soporte QFlow Pro | AS-QFLOW | Tickets y soporte |
| Administrador Financiero QFlow Pro | AF-QFLOW | Facturación y cobros |
| Analista de Métricas QFlow Pro | AM-QFLOW | Métricas y reportes |

## Plataforma 2: Portal Empresarial (Quesera D&G)

| Rol | Código | Alcance |
|-----|--------|---------|
| Dueño / Propietario | OWNER | Toda la empresa |
| Administrador Corporativo | ADMIN-CORP | Toda la empresa |
| Administrador de Sucursal | ADMIN-SUC | Sucursal asignada |
| Contador Corporativo | CONT-CORP | Contabilidad global |
| Contador de Sucursal | CONT-SUC | Contabilidad local |
| Supervisor de Sucursal | SUP-SUC | Supervisión local |
| Cajero / Vendedor | CAJERO | Operaciones locales |
| Almacenista / Bodeguero | BODEGA | Inventario local |
| Auxiliar de Compras | COMPRAS | Compras locales |
| Recursos Humanos | RRHH | Personal |

## Plataforma 3: App Cliente Final

| Rol | Código | Alcance |
|-----|--------|---------|
| Cliente Mayorista | CLI-MAY | Su propia cuenta |
| Cliente Minorista | CLI-MIN | Su propia cuenta |
| Cliente VIP | CLI-VIP | Su propia cuenta |
| Cliente Potencial | CLI-POT | Solo registro |
| Cliente Suspendido | CLI-SUS | Cuenta restringida |

---

**FIN DEL DOCUMENTO**

*Este documento define la Matriz de Roles y Permisos (RBAC) completa para las tres plataformas del ecosistema QFlow Pro. Cualquier modificación a los roles o permisos debe seguir el proceso de control de cambios establecido y ser documentada en el sistema de auditoría.*
