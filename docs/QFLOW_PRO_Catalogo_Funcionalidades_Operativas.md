# QFlow Pro - Catálogo de Funcionalidades Operativas
## Arquitectura de Tres Plataformas: Admin SaaS, Portal Empresarial y App Cliente Final

---

**Versión del Documento:** 1.0  
**Fecha de Creación:** 13 de Enero de 2026  
**Arquitecto:** Analista Funcional de Sistemas  
**Clasificación:** Confidencial - Uso Interno  

---

# INTRODUCCIÓN

Este documento define el catálogo completo de funcionalidades operativas para las tres plataformas que componen el ecosistema QFlow Pro. Cada funcionalidad se describe mediante su flujo operativo: entradas requeridas, acciones secuenciales del sistema, y salidas generadas.

El catálogo está organizado por plataformas y dentro de cada plataforma por módulos funcionales, siguiendo la estructura definida en los requisitos de negocio y el modelo de datos.

---

# PLATAFORMA 1: ADMIN QFLOW PRO (Proveedor SaaS)

Esta plataforma es utilizada por el equipo de QFlow Pro para administrar el negocio SaaS: clientes empresariales, licencias, facturación, soporte, métricas y operaciones centrales.

---

## M1: GESTIÓN DE CLIENTES EMPRESARIALES

### ID-FUNC-M1-001: Registrar Nuevo Cliente Empresarial

**Descripción General:** Crear el registro de una nueva empresa que utilizará la plataforma QFlow Pro como cliente SaaS, incluyendo sus datos comerciales, contacto principal y configuración inicial.

**Entradas (Inputs):**
- Nombre comercial de la empresa
- Razón social
- Número de identificación tributaria (NIT)
- Sector o industria
- Tamaño de la empresa (pequeña, mediana, grande)
- País y ciudad de ubicación
- Dirección física completa
- Sitio web empresarial
- Datos del contacto principal: nombre completo, cargo, email corporativo, teléfono, WhatsApp
- Canal de origen de la oportunidad (marketing, referido, demo, otro)
- Notas internas sobre el cliente prospecto

**Acciones del Sistema (Pasos Operativos):**
1. Validar que el NIT no exista previamente en el sistema de clientes.
2. Crear registro en la tabla de tenants con estado inicial "lead".
3. Generar identificador único de cliente empresarial.
4. Asignar fecha de registro y fuente de origen.
5. Guardar los datos de contacto principal.
6. Generar registro en el historial de interacciones con la empresa.
7. Notificar al equipo de ventas sobre el nuevo lead.
8. Habilitar acceso inicial al portal de autoservicio para completar registro.

**Salidas (Outputs):**
- Cliente empresarial creado con estado "lead".
- Identificador único asignado.
- Registro de interacción inicial en el historial.
- Notificación enviada al equipo de ventas.

---

### ID-FUNC-M1-002: Convertir Lead en Cliente Trial

**Descripción General:** Transformar un prospecto en un cliente activo con acceso a período de prueba gratuito de 30 días, activando la licencia trial correspondiente.

**Entradas (Inputs):**
- Identificador del cliente lead
- Plan trial a asignar (configuración estándar: Trial 30 días)
- Fecha de inicio del trial
- Usuario responsable de la conversión

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que el lead exista y tenga estado pendiente de conversión.
2. Crear licencia trial en la tabla de licencias.
3. Generar clave de activación única para el trial.
4. Configurar límites del trial: 1 sucursal, 3 usuarios, 5GB almacenamiento, 500 transacciones mensuales.
5. Cambiar estado del cliente de "lead" a "trial".
6. Establecer fecha de inicio y fecha de vencimiento del trial.
7. Enviar email automático al contacto principal con credenciales de activación.
8. Registrar la conversión en el historial del cliente.
9. Configurar recordatorios para el seguimiento del trial.

**Salidas (Outputs):**
- Licencia trial creada y asociada al cliente.
- Clave de activación generada.
- Estado del cliente actualizado a "trial".
- Email de bienvenida enviado.
- Registro de conversión en historial.

---

### ID-FUNC-M1-003: Activar Licencia Comercial

**Descripción General:** Convertir una licencia trial o crear una nueva licencia comercial cuando el cliente contrata un plan de pago, habilitando todos los módulos y límites correspondientes al plan contratado.

**Entradas (Inputs):**
- Identificador del cliente
- Plan contratado (Basic, Pro, Enterprise, Custom)
- Ciclo de facturación (mensual o anual)
- Método de pago registrado del cliente
- Datos de facturación (dirección fiscal, contacto de facturación)
- Addons adicionales opcionales

**Acciones del Sistema (Pasos Operativos):**
1. Validar que el cliente exista y tenga licencia activa o trial.
2. Crear nueva suscripción en la tabla de suscripciones.
3. Calcular monto a cobrar según plan y ciclo de facturación.
4. Generar factura proforma inicial.
5. Procesar cobro con el método de pago registrado.
6. Si el cobro es exitoso:
   - Activar la suscripción
   - Establecer período de facturación actual
   - Habilitar módulos según el plan contratado
   - Configurar límites de usuarios, sucursales, almacenamiento y transacciones
7. Generar factura fiscal del período.
8. Enviar confirmación de activación al cliente.
9. Registrar la activación en el historial de licencias.
10. Configurar renovación automática según preferencia del cliente.

**Salidas (Outputs):**
- Suscripción comercial activa creada.
- Factura generada y enviada al cliente.
- Módulos del plan habilitados para el cliente.
- Límites configurados según el plan.
- Confirmación de activación enviada.

---

### ID-FUNC-M1-004: Gestionar Cambio de Plan

**Descripción General:** Procesar el cambio de plan de un cliente (upgrade o downgrade), ajustando los límites, módulos habilitados y calculando los cargos o créditos correspondientes de forma prorrateada.

**Entradas (Inputs):**
- Identificador del cliente
- Nuevo plan a contratar
- Tipo de cambio (upgrade o downgrade)
- Justificación del cambio (para downgrade)

**Acciones del Sistema (Pasos Operativos):**
1. Verificar la suscripción actual del cliente.
2. Calcular días restantes del período actual.
3. Obtener precios del plan actual y del nuevo plan.
4. Calcular diferencia prorrateada:
   - Para upgrade: diferencia inmediata a cobrar
   - Para downgrade: crédito a aplicar en próxima factura
5. Verificar que el nuevo plan tenga suficientes límites para el uso actual:
   - Si el downgrade reduce sucursales por debajo de las existentes, alertar al cliente
   - Si el downgrade reduce usuarios por debajo de los activos, alertar al cliente
6. Si el downgrade reduce límites por debajo del uso actual:
   - Generar alerta de ajuste requerido
   - Dar plazo de 30 días para reducir uso
   - Bloquear nuevas creaciones hasta cumplimiento
7. Actualizar la suscripción con el nuevo plan.
8. Ajustar los límites de la licencia.
9. Habilitar o deshabilitar módulos según el nuevo plan.
10. Generar factura de ajuste si aplica.
11. Registrar el cambio en el historial de suscripciones.
12. Notificar al cliente sobre el cambio de plan.

**Salidas (Outputs):**
- Plan del cliente actualizado.
- Límites ajustados según el nuevo plan.
- Factura de ajuste generada (si aplica).
- Módulos habilitados/deshabilitados correspondientemente.
- Notificación de confirmación enviada al cliente.

---

### ID-FUNC-M1-005: Suspender Licencia por Falta de Pago

**Descripción General:** Aplicar la suspensión del acceso a la plataforma cuando el cliente tiene pagos pendientes después del período de gracia, preservando los datos pero bloqueando las operaciones.

**Entradas (Inputs):**
- Identificador del cliente
- Factura(s) pendiente(s) de pago
- Días de mora acumulados
- Usuario responsable de la suspensión

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que existan facturas vencidas sin pagar.
2. Confirmar que se hayan agotado los intentos de cobro y el período de gracia.
3. Cambiar estado de la licencia a "suspended".
4. Bloquear acceso a todos los módulos de la plataforma.
5. Deshabilitar tokens de API asociados.
6. Generar y enviar notificación urgente al cliente sobre la suspensión.
7. Informar sobre el plazo de regularización (7 días) antes de eliminación de datos.
8. Registrar el evento de suspensión en el historial de licencias.
9. Actualizar métricas de cuentas por cobrar.
10. Crear ticket de seguimiento para el equipo de cobranzas.

**Salidas (Outputs):**
- Licencia suspendida y acceso bloqueado.
- Notificación de suspensión enviada al cliente.
- Ticket de cobranza creado.
- Métricas de cartera actualizadas.

---

### ID-FUNC-M1-006: Reactivar Licencia Suspendida

**Descripción General:** Restaurar el acceso completo a la plataforma cuando el cliente realiza el pago de las facturas pendientes y desea continuar con el servicio.

**Entradas (Inputs):**
- Identificador del cliente suspendido
- Comprobante de pago de facturas pendientes
- Usuario que procesa la reactivación

**Acciones del Sistema (Pasos Operativos):**
1. Validar que la licencia esté en estado "suspended".
2. Verificar que las facturas pendientes estén pagadas.
3. Registrar el pago recibido en las facturas correspondientes.
4. Actualizar el estado de las facturas a "paid".
5. Cambiar el estado de la licencia de "suspended" a "active".
6. Restaurar acceso a todos los módulos.
7. Habilitar nuevamente los tokens de API.
8. Calcular y aplicar cualquier crédito o ajuste prorrateado del período de suspensión.
9. Generar confirmación de reactivación.
10. Enviar notificación al cliente sobre la restauración del servicio.
11. Registrar la reactivación en el historial de licencias.
12. Cerrar el ticket de cobranzas relacionado.

**Salidas (Outputs):**
- Licencia reactivada y acceso restaurado.
- Facturas marcadas como pagadas.
- Acceso a módulos y API habilitado.
- Notificación de confirmación enviada.

---

### ID-FUNC-M1-007: Cancelar Suscripción de Cliente

**Descripción General:** Procesar la cancelación de la suscripción de un cliente, ya sea inmediata o al final del período pagado, generando la documentación correspondiente y programando la retención o eliminación de datos.

**Entradas (Inputs):**
- Identificador del cliente
- Tipo de cancelación (inmediata o al final del período)
- Motivo de la cancelación (selección de lista o texto libre)
- Opción de exportación de datos solicitada por el cliente

**Acciones del Sistema (Pasos Operativos):**
1. Validar la suscripción actual del cliente.
2. Si la cancelación es al final del período:
   - Deshabilitar la renovación automática
   - Mantener licencia activa hasta la fecha de vencimiento
   - Generar encuesta de salida para identificar razones de cancelación
3. Si la cancelación es inmediata:
   - Calcular prorrateo para reembolso si aplica según política
   - Generar nota de crédito si corresponde
   - Bloquear acceso inmediatamente
   - Programar eliminación de datos para 90 días después
4. Generar exportación completa de datos del cliente si fue solicitada.
5. Enviar confirmación de cancelación con detalle de próximos pasos.
6. Registrar la cancelación en el historial del cliente.
7. Actualizar métricas de churn.
8. Transferir el registro a tabla de clientes cancelados para análisis.

**Salidas (Outputs):**
- Suscripción cancelada con el tipo especificado.
- Email de confirmación enviado con instrucciones.
- Encuesta de salida registrada (si aplica).
- Exportación de datos generada (si se solicitó).
- Métricas de churn actualizadas.

---

### ID-FUNC-M1-008: Consultar Panel de Clientes Activos

**Descripción General:** Obtener información consolidada sobre todos los clientes empresariales con sus licencias activas, incluyendo métricas de uso, estado de suscripción y alertas pendientes.

**Entradas (Inputs):**
- Filtros opcionales: estado de licencia, plan, fecha de registro, región
- Usuario solicitante con permisos de administración

**Acciones del Sistema (Pasos Operativos):**
1. Verificar permisos del usuario solicitante.
2. Consultar tabla de tenants con filtros aplicados.
3. Para cada cliente activo, consultar:
   - Licencia actual y estado
   - Planes contratados y módulos habilitados
   - Métricas de uso actual: usuarios activos, sucursales, almacenamiento, transacciones
   - Datos de facturación y método de pago
   - Tickets de soporte abiertos
   - Fecha de próximo cobro
4. Calcular métricas consolidadas para el panel:
   - Total de clientes activos
   - Distribución por plan
   - Ingresos mensuales recurrentes (MRR)
   - Clientes con riesgo de churn
   - Licencias próximas a vencer
5. Generar vista consolidada para visualización en dashboard.

**Salidas (Outputs):**
- Lista de clientes con sus datos y métricas.
- Métricas consolidadas calculadas.
- Distribución por planes visualizable.
- Alertas de riesgo identificadas.

---

## M2: GESTIÓN DE LICENCIAS Y PLANES

### ID-FUNC-M2-001: Crear Nuevo Plan de Suscripción

**Descripción General:** Definir un nuevo plan de suscripción con sus características, precios, límites y módulos incluidos, dejándolo disponible para asignación a clientes.

**Entradas (Inputs):**
- Nombre del plan
- Slug único para URL (identificador)
- Descripción corta y descripción larga
- Precio mensual
- Precio anual con descuento opcional
- Moneda
- Límites: sucursales máximas, usuarios máximos, almacenamiento GB, transacciones mensuales
- Lista de módulos habilitados
- Lista de características destacadas
- Días de prueba (trial days)
- Indicador de visibilidad pública
- Orden de visualización

**Acciones del Sistema (Pasos Operativos):**
1. Validar que el slug sea único en el sistema.
2. Validar que los límites sean coherentes (sucursales >= 1, usuarios >= 1).
3. Crear registro en la tabla de subscription_plans.
4. Registrar los módulos habilitados en la tabla de plan_features.
5. Guardar las características destacadas.
6. Configurar visibilidad y orden.
7. Generar vista previa del plan para verificación.
8. Registrar creación en auditoría.

**Salidas (Outputs):**
- Plan de suscripción creado y activo.
- Módulos asociados registrados.
- Características destacadas configuradas.
- Registro de auditoría generado.

---

### ID-FUNC-M2-002: Configurar Addons y Complementos

**Descripción General:** Definir complementos adicionales que los clientes pueden agregar a su suscripción, como almacenamiento extra, usuarios adicionales o módulos especiales.

**Entradas (Inputs):**
- Nombre del addon
- Slug único
- Descripción
- Precio mensual
- Tipo de addon (storage, users, module, feature)
- Valor del addon (cantidad en GB, número de usuarios)
- Plan(es) con los que es compatible
- Estado activo/inactivo

**Acciones del Sistema (Pasos Operativos):**
1. Validar que el slug sea único.
2. Crear registro en la tabla de addons.
3. Definir compatibilidad con planes existentes.
4. Configurar precio y valor del addon.
5. Activar el addon para uso.
6. Registrar en el sistema de facturación.

**Salidas (Outputs):**
- Addon creado y disponible.
- Compatibilidad con planes configurada.
- Precio registrado para facturación.

---

### ID-FUNC-M2-003: Generar Clave de Activación

**Descripción General:** Crear una clave de activación única que permite a un cliente activar su licencia en la plataforma, con formato legible y seguridad contra duplicados.

**Entradas (Inputs):**
- Identificador de la licencia a activar
- Usuario que genera la clave
- Vigencia de la clave (días)

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que la licencia exista y esté en estado pendiente.
2. Generar clave en formato QFLOW-XXXX-XXXX-XXXX-XXXX.
3. Excluir caracteres ambiguos (0, O, I, 1).
4. Verificar que la clave no exista previamente.
5. Registrar la clave en license_activation_keys con referencia a la licencia.
6. Establecer fecha de vencimiento de la clave.
7. Enviar la clave al cliente por email.
8. Registrar generación en auditoría.

**Salidas (Outputs):**
- Clave de activación única generada.
- Clave asociada a la licencia.
- Email de envío registrado.
- Registro de auditoría creado.

---

### ID-FUNC-M2-004: Validar Licencia al Inicio de Sesión

**Descripción General:** Verificar el estado y validez de la licencia de un cliente cada vez que un usuario intenta acceder a la plataforma, bloqueando el acceso si la licencia está vencida, suspendida o los límites están excedidos.

**Entradas (Inputs):**
- Identificador del tenant
- Identificador del usuario solicitando acceso
- Timestamp de la solicitud

**Acciones del Sistema (Pasos Operativos):**
1. Buscar la licencia activa del tenant.
2. Verificar estado de la licencia (debe ser "active" o "trial").
3. Verificar fecha de vencimiento (debe ser >= fecha actual).
4. Verificar límites contra uso actual:
   - Número de usuarios activos vs límite del plan
   - Número de sucursales activas vs límite del plan
   - Almacenamiento usado vs límite del plan
   - Transacciones del mes vs límite del plan
5. Si todos los controles pasan: permitir acceso.
6. Si la licencia está vencida o suspendida: bloquear acceso y mostrar pantalla de renovación.
7. Si los límites están cerca del 80%: mostrar warning pero permitir acceso.
8. Registrar el intento de acceso en auditoría.

**Salidas (Outputs):**
- Acceso permitido o bloqueado según validación.
- Warning generado si límites cerca del umbral.
- Registro de intento de acceso en logs.

---

### ID-FUNC-M2-005: Procesar Renovación Automática

**Descripción General:** Ejecutar el proceso nocturno de renovación de licencias con renovación automática, generando las facturas correspondientes, procesando los cobros y extendiendo los períodos de suscripción.

**Entradas (Inputs):**
- Fecha de ejecución del proceso (normalmente diaria)
- Configuración de reintentos de cobro

**Acciones del Sistema (Pasos Operativos):**
1. Identificar todas las licencias con renovación automática cuyo período vence hoy.
2. Para cada licencia:
   - Calcular monto a cobrar: precio del plan + addons activos + impuestos
   - Generar factura con nuevo período
   - Intentar cobro con método de pago registrado del cliente
3. Si el cobro es exitoso:
   - Marcar factura como pagada
   - Extender período de suscripción (agregar 1 mes o 1 año según ciclo)
   - Mantener estado de licencia como activo
   - Generar y enviar recibo por email
   - Registrar transacción de renovación
4. Si el cobro falla:
   - Marcar factura como pendiente
   - Enviar notificación de pago fallido al cliente
   - Programar reintentos para día +3, +5, +7
   - Mantener licencia activa durante período de gracia
5. Generar reporte de proceso de renovación con resultados.
6. Registrar el proceso en auditoría.

**Salidas (Outputs):**
- Licencias renovadas exitosamente.
- Facturas de renovación generadas.
- Notificaciones de pago fallido enviadas (si aplica).
- Reporte de proceso de renovación.

---

## M3: FACTURACIÓN SAAS

### ID-FUNC-M3-001: Generar Factura de Suscripción

**Descripción General:** Crear la factura fiscal correspondiente a la suscripción del período, detallando el plan contratado, addons, impuestos y total a pagar.

**Entradas (Inputs):**
- Identificador de la suscripción
- Período facturado (fecha inicio y fin)
- Datos de facturación del cliente

**Acciones del Sistema (Pasos Operativos):**
1. Verificar la suscripción activa.
2. Obtener datos del plan y precio.
3. Calcular subtotal: precio del plan + suma de addons.
4. Calcular impuestos según configuración fiscal.
5. Generar número de factura secuencial.
6. Crear detalle de líneas:
   - Línea del plan base
   - Línea(s) de addons activos
   - Línea de impuestos
7. Calcular total final.
8. Guardar factura con estado "pending" o "paid" según corresponda.
9. Generar PDF de la factura.
10. Enviar por email al cliente.

**Salidas (Outputs):**
- Factura generada con número único.
- Detalle de líneas creado.
- PDF de factura disponible.
- Email de envío confirmado.

---

### ID-FUNC-M3-002: Procesar Cobro de Factura

**Descripción General:** Ejecutar el cobro de una factura de suscripción a través de la pasarela de pago configurada, actualizando el estado de la factura y la suscripción.

**Entradas (Inputs):**
- Identificador de la factura
- Método de pago del cliente
- Datos de la pasarela de pago

**Acciones del Sistema (Pasos Operativos):**
1. Obtener detalles de la factura a cobrar.
2. Obtener método de pago registrado del cliente.
3. Enviar solicitud de cobro a la pasarela de pago con monto y moneda.
4. Recibir respuesta de la pasarela:
   - Si es exitosa:
     - Actualizar estado de factura a "paid"
     - Registrar transacción con ID de la pasarela
     - Generar recibo de pago
     - Enviar confirmación por email
     - Actualizar métricas de ingresos
   - Si es fallida:
     - Registrar motivo del rechazo
     - Actualizar estado de factura a "pending"
     - Notificar al cliente sobre el fallo
     - Programar reintento según configuración
5. Registrar el cobro en el historial financiero.

**Salidas (Outputs):**
- Estado de factura actualizado.
- Transacción de cobro registrada.
- Recibo generado y enviado.
- Métricas de ingresos actualizadas.

---

### ID-FUNC-M3-003: Generar Reporte de Facturación

**Descripción General:** Consolidar la información de facturación de un período para generar reportes financieros, métricas de negocio y exportación para contabilidad.

**Entradas (Inputs):**
- Período del reporte (mensual, trimestral, anual)
- Tipo de reporte (resumen, detalle, exportación)
- Formato de salida solicitado

**Acciones del Sistema (Pasos Operativos):**
1. Filtrar facturas por período de fechas.
2. Calcular métricas consolidadas:
   - Total facturado
   - Total cobrado
   - Total pendiente
   - Total moroso
   - Ingresos recurrentes mensuales (MRR)
   - Ingresos recurrentes anuales (ARR)
3. Desglosar por plan:
   - Facturación de cada plan
   - Número de clientes por plan
4. Desglosar por addon:
   - Uso de cada addon
   - Ingresos por addon
5. Calcular métricas de churn:
   - Ingresos perdidos por cancelaciones
   - Ingresos recuperados por reactivaciones
6. Generar documento en formato solicitado (Excel, PDF, CSV).
7. Guardar reporte para histórico.

**Salidas (Outputs):**
- Reporte de facturación generado.
- Métricas MRR/ARR calculadas.
- Desgloses por plan y addon incluidos.
- Archivo exportable disponible.

---

## M4: SOPORTE TÉCNICO

### ID-FUNC-M4-001: Crear Ticket de Soporte

**Descripción General:** Registrar una nueva solicitud de soporte técnico de un cliente empresarial, clasificándola por categoría, prioridad y asignándola al equipo correspondiente.

**Entradas (Inputs):**
- Identificador del cliente/empresa
- Usuario que reporta el problema
- Categoría del ticket (Técnico, Facturación, Consulta, Feature Request, Bug)
- Prioridad (Baja, Media, Alta, Crítica)
- Título del problema
- Descripción detallada
- Archivos adjuntos (capturas, logs)
- Sucursal afectada (si aplica)

**Acciones del Sistema (Pasos Operativos):**
1. Validar que el cliente exista y tenga licencia activa.
2. Generar número de ticket único: TKT-YYYY-00000.
3. Crear registro en la tabla de support_tickets.
4. Asignar estado inicial "open".
5. Clasificar por categoría y prioridad.
6. Determinar asignación automática:
   - Por categoría (técnico → equipo técnico, facturación → finanzas)
   - Round-robin entre agentes disponibles
7. Si es ticket crítico: escalar inmediatamente a supervisor.
8. Enviar notificación al agente asignado.
9. Crear registro de inicio de conversación.
10. Adjuntar archivos al ticket.

**Salidas (Outputs):**
- Ticket creado con número único.
- Estado inicial asignado.
- Agent asignado automáticamente.
- Notificación enviada.
- Archivos adjuntados.

---

### ID-FUNC-M4-002: Gestionar Flujo de Estado de Ticket

**Descripción General:** Procesar los cambios de estado de un ticket de soporte, actualizando su trazabilidad y notificando a las partes interesadas.

**Entradas (Inputs):**
- Identificador del ticket
- Nuevo estado solicitado
- Usuario que realiza el cambio
- Comentario o nota asociada al cambio

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que el ticket exista y no esté cerrado.
2. Validar que la transición de estado sea válida según flujo:
   - Nuevo → Abierto → En Progreso → Esperando Cliente → Resuelto → Cerrado
   - Cualquier estado → Reabierto (si el cliente indica que persiste el problema)
3. Actualizar estado del ticket.
4. Registrar cambio en historial del ticket.
5. Agregar nota o comentario asociado.
6. Enviar notificación al cliente si el cambio afecta la atención:
   - Cambiado a "En Progreso": notificar que estamos trabajando
   - Cambiado a "Esperando Cliente": solicitar información
   - Cambiado a "Resuelto": confirmar solución y pedir confirmación
7. Si es escalamiento a prioridad mayor: notificar a supervisor.
8. Actualizar métricas de tiempo de respuesta.

**Salidas (Outputs):**
- Estado del ticket actualizado.
- Historial de cambios ampliado.
- Notificaciones enviadas a partes interesadas.
- Métricas de SLA actualizadas.

---

### ID-FUNC-M4-003: Enviar Encuesta de Satisfacción

**Descripción General:** Enviar automáticamente una encuesta de satisfacción al cliente cuando un ticket es marcado como resuelto, recopilando feedback sobre la calidad del soporte.

**Entradas (Inputs):**
- Identificador del ticket cerrado
- Datos del cliente (email)
- Plantilla de encuesta configurada

**Acciones del Sistema (Pasos Operativos):**
1. Detectar ticket marcado como "resuelto".
2. Generar encuesta con identificador único.
3. Enviar email al cliente con enlace a la encuesta.
4. La encuesta solicita:
   - ¿Se resolvió tu problema? (Sí/No)
   - Calificación de atención (1-5 estrellas)
   - Comentarios adicionales (opcional)
5. Registrar respuesta cuando el cliente completa la encuesta.
6. Calcular Score de Satisfacción (CSAT) promedio.
7. Si la calificación es baja (1-2 estrellas): generar alerta para revisión.
8. Actualizar métricas de satisfacción del equipo de soporte.

**Salidas (Outputs):**
- Encuesta enviada al cliente.
- Respuesta registrada cuando se completa.
- CSAT calculado.
- Alerta generada para calificaciones bajas.

---

### ID-FUNC-M4-004: Consultar Base de Conocimientos

**Descripción General:** Proporcionar acceso a los artículos de ayuda, tutoriales y FAQs almacenados en el sistema, permitiendo búsqueda y filtrado para orientar a los usuarios.

**Entradas (Inputs):**
- Término de búsqueda (opcional)
- Categoría del artículo (opcional)
- Filtros adicionales (fecha, popularidad)

**Acciones del Sistema (Pasos Operativos):**
1. Si hay término de búsqueda:
   - Buscar en títulos y contenido de artículos
   - Aplicar algoritmo de relevancia
   - Ordenar por coincidencia y popularidad
2. Si hay categoría seleccionada:
   - Filtrar artículos de esa categoría
3. Para cada artículo encontrado:
   - Verificar que esté publicado y activo
   - Obtener métricas de vistas y utilidad
4. Generar resultados con:
   - Título del artículo
   - Extracto del contenido
   - Categoría
   - Fecha de última actualización
   - Número de vistas
5. Presentar artículos sugeridos basados en el ticket abierto del usuario (si existe).

**Salidas (Outputs):**
- Lista de artículos relevantes encontrados.
- Sugerencias basadas en contexto.
- Métricas de uso registradas.

---

## M5: MÉTRICAS Y REPORTES SAAS

### ID-FUNC-M5-001: Calcular Métricas de Ingresos

**Descripción General:** Procesar los datos de facturación y cobros para calcular las métricas clave de ingresos del negocio SaaS: MRR, ARR, New MRR, Expansion MRR, Churned MRR y Net MRR Growth.

**Entradas (Inputs):**
- Período de cálculo (mensual)
- Datos de suscripciones activas
- Datos de cobros del período
- Datos de cancelaciones del período
- Datos de upgrades/downgrades del período

**Acciones del Sistema (Pasos Operativos):**
1. Obtener todas las suscripciones activas al inicio del período.
2. Calcular MRR: suma de ingresos mensuales de todas las suscripciones activas.
3. Calcular ARR: MRR × 12.
4. Identificar nuevos clientes del período y calcular su MRR (New MRR).
5. Identificar upgrades del período y calcular el ingreso adicional (Expansion MRR).
6. Identificar cancelaciones del período y calcular el MRR perdido (Churned MRR).
7. Calcular Net MRR Growth: New MRR + Expansion MRR - Churned MRR.
8. Desglosar métricas por plan (Basic, Pro, Enterprise).
9. Calcular tasa de crecimiento month-over-month.
10. Generar visualización de tendencia histórica.
11. Guardar métricas en tabla de analytics para histórico.

**Salidas (Outputs):**
- MRR calculado y desglosado.
- ARR proyectado.
- New MRR, Expansion MRR, Churned MRR identificados.
- Net MRR Growth calculado.
- Tendencia histórica disponible.

---

### ID-FUNC-M5-002: Calcular Métricas de Clientes

**Descripción General:** Procesar los datos de clientes para calcular métricas de adquisición, retención, churn y valor de vida del cliente.

**Entradas (Inputs):**
- Período de análisis
- Datos de nuevos clientes del período
- Datos de clientes que cancelaron
- Datos de transacciones de clientes activos
- Historial de pagos

**Acciones del Sistema (Pasos Operativos):**
1. Contar nuevos clientes del período.
2. Contar clientes que churnaron (cancelaron).
3. Calcular Churn Rate: (clientes que churnaron / clientes al inicio) × 100.
4. Calcular Customer Lifetime Value (LTV):
   - LTV = ARPU / Churn Rate
   - Donde ARPU = Ingresos promedio por usuario
5. Calcular CAC (Customer Acquisition Cost):
   - CAC = (Gasto en Marketing + Gasto en Ventas) / Clientes Nuevos
6. Calcular CAC Payback Period: meses para recuperar CAC.
7. Calcular Trial to Paid Conversion Rate.
8. Generar análisis de cohortes:
   - Agrupar clientes por mes de adquisición
   - Calcular retención por cada mes posterior
9. Identificar clientes en riesgo de churn (scoring).
10. Generar desglose por fuente de adquisición.

**Salidas (Outputs):**
- Churn Rate calculado.
- LTV calculado.
- CAC y Payback Period calculados.
- Trial to Paid Conversion Rate.
- Análisis de cohortes disponible.
- Scoring de riesgo de churn.

---

### ID-FUNC-M5-003: Generar Dashboard Ejecutivo

**Descripción General:** Consolidar todas las métricas clave en un dashboard ejecutivo que presente una vista integral del estado del negocio SaaS, con gráficos, tendencias y alertas.

**Entradas (Inputs):**
- Período del dashboard (día, semana, mes, año)
- Preferencias de visualización del usuario
- Métricas actualizadas del sistema

**Acciones del Sistema (Pasos Operativos):**
1. Obtener métricas de ingresos actualizadas:
   - MRR actual y tendencia
   - Ingresos del mes actual
   - Proyección del mes
2. Obtener métricas de clientes:
   - Total de clientes activos
   - Nuevos clientes del período
   - Churn Rate
   - Clientes en riesgo
3. Obtener métricas de soporte:
   - Tickets abiertos
   - Tiempo promedio de resolución
   - CSAT promedio
   - Tickets con SLA en riesgo
4. Obtener métricas de producto:
   - Transacciones del mes
   - Uso de almacenamiento
   - Usuarios activos
5. Identificar alertas y anomalías:
   - Churn aumentando
   - Ingresos por debajo de proyección
   - Tickets críticos sin resolver
6. Generar visualización de gráficos:
   - Tendencia de MRR (línea)
   - Distribución por plan (torta)
   - New vs Churned (barras)
   - Métricas de soporte (indicadores)
7. Calcular comparativas:
   - vs mes anterior
   - vs mismo período año anterior
8. Preparar insights y recomendaciones automáticas.

**Salidas (Outputs):**
- Dashboard ejecutivo renderizado.
- Gráficos y métricas visualizables.
- Alertas identificadas.
- Comparativas disponibles.
- Insights generados.

---

# PLATAFORMA 2: PORTAL EMPRESARIAL (Cliente - Quesera D&G)

Esta plataforma es utilizada por Quesera D&G y sus empleados para operar el negocio: inventario, ventas, caja, compras, contabilidad, recursos humanos y todos los módulos ERP.

---

## M6: GESTIÓN DE SUCURSALES Y CONFIGURACIÓN

### ID-FUNC-M6-001: Crear Nueva Sucursal

**Descripción General:** Configurar una nueva sucursal operativa dentro del tenant, asignando sus datos básicos, dirección, responsable y parámetros de funcionamiento.

**Entradas (Inputs):**
- Nombre de la sucursal
- Código identificador
- Dirección completa
- Teléfono de contacto
- Email de la sucursal
- Usuario responsable o administrador asignado
- Configuración local: moneda, zona horaria
- Horarios de operación
- Métodos de pago aceptados

**Acciones del Sistema (Pasos Operativos):**
1. Validar que el código de sucursal no exista previamente en el tenant.
2. Verificar que no se exceda el límite de sucursales del plan.
3. Crear registro en la tabla de branches.
4. Generar configuración inicial de sucursal:
   - Generar sequence para numeración de facturas
   - Generar sequence para numeración de órdenes de compra
   - Generar sequence para numeración de pedidos
5. Asignar usuario(s) responsable(s).
6. Configurar métodos de pago disponibles para la sucursal.
7. Crear registro de caja inicial (cash_register) para la sucursal.
8. Inicializar inventario de la sucursal en cero.
9. Registrar creación en auditoría.

**Salidas (Outputs):**
- Sucursal creada y activa.
- Sequences de numeración inicializados.
- Caja inicial configurada.
- Usuario(s) asignado(s).
- Registro de auditoría generado.

---

### ID-FUNC-M6-002: Configurar Caja Registradora

**Descripción General:** Definir los parámetros de una caja registradora física dentro de una sucursal, incluyendo la configuración de impresora térmica, numeración de recibos y límites de operación.

**Entradas (Inputs):**
- Sucursal donde se instala la caja
- Código de la caja
- Nombre descriptivo
- Configuración de impresora (IP, puerto, modelo, tamaño de papel)
- Límite de transacción en efectivo (opcional)
- Límite de descuento autorizado (opcional)

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que la sucursal exista y esté activa.
2. Validar que el código de caja no exista en la sucursal.
3. Crear registro en cash_registers.
4. Guardar configuración de impresora en formato JSON.
5. Configurar parámetros de límites.
6. Generar primer número de secuencia de transacciones.
7. Registrar en auditoría.

**Salidas (Outputs):**
- Caja registradora configurada.
- Configuración de impresora guardada.
- Parámetros de límites establecidos.
- Registro de auditoría generado.

---

### ID-FUNC-M6-003: Apertura de Sesión de Caja

**Descripción General:** Iniciar una sesión de caja al inicio de la jornada operativa, registrando el monto de dinero disponible al abrir y habilitando las operaciones de venta y cobro.

**Entradas (Inputs):**
- Identificador de la caja
- Usuario que abre la caja
- Monto inicial de efectivo en caja
- Fecha y hora de apertura

**Acciones del Sistema (Pasos Operativos):**
1. Validar que la caja exista y esté activa.
2. Verificar que no exista una sesión abierta para hoy.
3. Crear registro en cash_sessions:
   - Asignar usuario responsable
   - Registrar monto inicial
   - Setear estado "open"
   - Inicializar contadores en cero: total_cash_in, total_cash_out, total_sales_cash, total_credit_payments
4. Calcular system_amount inicial = initial_amount.
5. Registrar apertura en auditoría.
6. Habilitar el POS para operaciones de la caja.

**Salidas (Outputs):**
- Sesión de caja abierta.
- Usuario registrado como responsable.
- Contadores inicializados.
- POS habilitado para operaciones.
- Registro de auditoría generado.

---

### ID-FUNC-M6-004: Configurar Usuario y Asignar Roles

**Descripción General:** Crear un nuevo usuario dentro del tenant, asignándole credenciales de acceso, rol(es) y sucursal(es) de trabajo, definiendo sus permisos en el sistema.

**Entradas (Inputs):**
- Datos personales: nombre completo, email, teléfono
- Sucursal(es) asignada(s)
- Rol(es) asignado(s)
- Código de empleado (opcional)
- Configuración de PIN de seguridad (si aplica)

**Acciones del Sistema (Pasos Operativos):**
1. Validar que el email no exista previamente en el tenant.
2. Generar código de empleado único.
3. Crear registro en users con estado "active".
4. Asignar contraseña temporal (o generar link de activación).
5. Vincular usuario con tenant_id y branch_id(s).
6. Asignar roles del sistema.
7. Generar token de autenticación inicial.
8. Enviar credenciales de acceso al usuario.
9. Registrar en auditoría.

**Salidas (Outputs):**
- Usuario creado con credenciales.
- Roles asignados.
- Token de autenticación generado.
- Email de credenciales enviado.
- Registro de auditoría generado.

---

## M7: CATÁLOGO Y PRECIOS

### ID-FUNC-M7-001: Registrar Categoría de Producto

**Descripción General:** Crear una nueva categoría en la estructura jerárquica de productos, definiendo su nombre, categoría padre y características para la organización del catálogo.

**Entradas (Inputs):**
- Nombre de la categoría
- Categoría padre (si es subcategoría)
- Descripción de la categoría
- Imagen representativa (opcional)
- Estado activo/inactivo

**Acciones del Sistema (Pasos Operativos):**
1. Validar unicidad del nombre dentro de la categoría padre.
2. Si tiene categoría padre, verificar que exista.
3. Crear registro en product_categories.
4. Calcular nivel jerárquico automáticamente:
   - Nivel 1 si no tiene padre
   - Nivel del padre + 1 si tiene padre
5. Generar path de categoría: "Padre / Hija / Nieta"
6. Guardar imagen si se proporcionó.
7. Registrar en auditoría.

**Salidas (Outputs):**
- Categoría creada con path completo.
- Nivel jerárquico calculado.
- Imagen guardada (si aplica).
- Registro de auditoría generado.

---

### ID-FUNC-M7-002: Registrar Marca

**Descripción General:** Crear el registro de una marca comercial que se asociará a los productos, permitiendo la gestión de fabricantes y proveedores de mercancías.

**Entradas (Inputs):**
- Nombre de la marca
- Descripción de la marca
- Logo de la marca (opcional)
- País de origen
- Datos de contacto del representante (opcional)

**Acciones del Sistema (Pasos Operativos):**
1. Validar que el nombre de marca no exista previamente en el tenant.
2. Crear registro en brands.
3. Guardar logo si se proporcionó.
4. Registrar país de origen.
5. Guardar datos de contacto si se proporcionaron.
6. Activar la marca por defecto.
7. Registrar en auditoría.

**Salidas (Outputs):**
- Marca creada y activa.
- Logo guardado (si aplica).
- Datos de contacto registrados.
- Registro de auditoría generado.

---

### ID-FUNC-M7-003: Registrar Unidad de Medida

**Descripción General:** Definir una nueva unidad de medida para los productos, especificando su tipo, abreviatura y factor de conversión respecto a la unidad base del sistema.

**Entradas (Inputs):**
- Nombre de la unidad de medida
- Abreviatura
- Tipo de unidad (peso, volumen, count, etc.)
- Factor de conversión respecto a unidad base
- Unidad base del sistema (definida)

**Acciones del Sistema (Pasos Operativos):**
1. Validar unicidad de la abreviatura dentro del tenant.
2. Validar que el tipo de unidad sea válido.
3. Crear registro en units_of_measure.
4. Calcular conversión respecto a unidad base del tipo.
5. Si es la primera unidad del tipo, marcarla como default.
6. Registrar en auditoría.

**Salidas (Outputs):**
- Unidad de medida creada.
- Factor de conversión almacenado.
- Registro de auditoría generado.

---

### ID-FUNC-M7-004: Crear Producto Base

**Descripción General:** Registrar un nuevo producto en el catálogo maestro, definiendo sus datos básicos, clasificación y características generales que aplicarán a todas las variantes del producto.

**Entradas (Inputs):**
- Código del producto
- Nombre del producto
- Descripción
- Categoría
- Marca
- Unidad de medida base
- Indicador de producto perecedero (requiere fecha de vencimiento)
- IVA aplicable (tarifa)
- Estado activo/inactivo

**Acciones del Sistema (Pasos Operativos):**
1. Validar que el código de producto no exista previamente en el tenant.
2. Verificar que la categoría exista y esté activa.
3. Verificar que la marca exista y esté activa.
4. Crear registro en products.
5. Generar código secuencial si no se proporciona.
6. Asociar categoría y marca.
7. Configurar indicador de vencimiento según tipo de producto.
8. Asignar tarifa de IVA.
9. Setear estado inicial activo.
10. Registrar en auditoría.

**Salidas (Outputs):**
- Producto base creado.
- Código generado o validado.
- Clasificación completada.
- IVA configurado.
- Registro de auditoría generado.

---

### ID-FUNC-M7-005: Crear Variante de Producto (SKU)

**Descripción General:** Definir una variante específica de un producto base con atributos diferenciadores como presentación, tamaño, peso o formato, generando el SKU único para inventario y venta.

**Entradas (Inputs):**
- Producto base al que pertenece
- Código SKU (o generación automática)
- Código de barras (EAN-13, UPC)
- Atributos diferenciadores (presentación, formato, tamaño)
- Unidad de medida de venta
- Estado activo/inactivo

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que el producto base exista y esté activo.
2. Validar unicidad del SKU dentro del tenant.
3. Validar unicidad del código de barras si se proporciona.
4. Crear registro en product_variants.
5. Generar SKU automático combinando código de producto + atributos si no se proporciona.
6. Generar código de barras si no se proporciona (opcional).
7. Guardar atributos en formato JSON.
8. Si es la primera variante, marcarla como default.
9. Setear estado inicial activo.
10. Registrar en auditoría.

**Salidas (Outputs):**
- Variante creada con SKU único.
- Código de barras generado (si aplica).
- Atributos guardados.
- Variante default marcada (si es la primera).
- Registro de auditoría generado.

---

### ID-FUNC-M7-006: Crear Lista de Precios

**Descripción General:** Definir una lista de precios que se aplicará a un tipo específico de cliente, configurando vigencia, alcance geográfico y condiciones de aplicación.

**Entradas (Inputs):**
- Nombre de la lista de precios
- Tipo de cliente objetivo (minorista, mayorista, VIP)
- Sucursal de aplicación (todas o específica)
- Fecha de inicio de vigencia
- Fecha de fin de vigencia (opcional)
- Indicador de lista por defecto para el tipo

**Acciones del Sistema (Pasos Operativos):**
1. Validar unicidad del nombre de lista.
2. Crear registro en price_lists.
3. Asignar tipo de cliente objetivo.
4. Vincular con sucursal específica o null para todas.
5. Configurar fechas de vigencia.
6. Si es lista por defecto para el tipo y sucursal:
   - Verificar que no exista otra lista default
   - Marcar como default
7. Setear estado inicial activo.
8. Registrar en auditoría.

**Salidas (Outputs):**
- Lista de precios creada.
- Tipo de cliente y alcance configurados.
- Vigencia establecida.
- Indicador de default asignado (si aplica).
- Registro de auditoría generado.

---

### ID-FUNC-M7-007: Configurar Precio en Lista

**Descripción General:** Asignar un precio específico a una variante de producto dentro de una lista de precios, estableciendo el valor comercial para los clientes de ese tipo.

**Entradas (Inputs):**
- Lista de precios
- Variante de producto
- Precio unitario
- Precio por volumen (opcional, para descuentos por cantidad)
- Cantidad mínima para precio por volumen
- Descuento porcentual (opcional)
- Fecha de inicio
- Fecha de fin (opcional)

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que la lista de precios exista y esté vigente.
2. Verificar que la variante exista y esté activa.
3. Crear registro en price_list_items.
4. Guardar precio unitario.
5. Si hay precio por volumen:
   - Guardar precio y cantidad mínima
   - La lógica de aplicación determinará el precio según cantidad
6. Guardar descuento porcentual si aplica.
7. Configurar fechas de vigencia.
8. Registrar en auditoría.

**Salidas (Outputs):**
- Precio configurado en la lista.
- Precio por volumen guardado (si aplica).
- Registro de auditoría generado.

---

## M8: GESTIÓN DE INVENTARIO Y LOTES

### ID-FUNC-M8-001: Consultar Stock Disponible

**Descripción General:** Obtener la información de inventario disponible para una o múltiples variantes de producto en una sucursal específica, mostrando cantidades por lote y estado de disponibilidad.

**Entradas (Inputs):**
- Sucursal solicitante
- Lista de variantes a consultar (todas o específicas)
- Filtrar por categoría (opcional)
- Filtrar por estado de lote (opcional)

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que la sucursal exista y esté activa.
2. Para cada variante solicitada:
   - Consultar lotes en inventory_lotes:
     - filter: branch_id = sucursal, status = 'active'
     - order: created_at ASC (FIFO)
   - Sumar current_quantity de todos los lotes activos
   - Calcular quantity_reserved para pedidos confirmados
   - Calcular quantity_available = total - reserved
   - Verificar fecha de vencimiento de cada lote
   - Clasificar estado: vigente, próximo a vencer, vencido
3. Si hay filtro por categoría:
   - Unir con products para filtrar por categoría
4. Generar resultado consolidado:
   - SKU, nombre, categoría
   - Cantidad total
   - Cantidad disponible
   - Cantidad reservada
   - Lotes con fechas de vencimiento
   - Valor del inventario (costo promedio)

**Salidas (Outputs):**
- Listado de variantes con stock disponible.
- Cantidades totales y disponibles.
- Reservas activas.
- Estado de vencimiento por lote.
- Valor del inventario calculado.

---

### ID-FUNC-M8-002: Registrar Entrada de Inventario por Compra

**Descripción General:** Procesar la recepción de mercancía comprada a un proveedor, creando los lotes correspondientes, actualizando el inventario y generando la trazabilidad hacia la factura de compra.

**Entradas (Inputs):**
- Identificador de la factura de compra
- Items recibidos con cantidades
- Número de lote (opcional, o generación automática)
- Fecha de fabricación (si aplica)
- Fecha de vencimiento (para perecederos)
- Precio de compra unitario

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que la factura de compra exista.
2. Validar que el estado de la factura permita recepción.
3. Para cada item recibido:
   - Generar número de lote único: SKU-YYMMDD-SEQ
   - Crear registro en inventory_lotes:
     - Vincular con variante
     - Registrar branch_id de la sucursal
     - Registrar purchase_invoice_id
     - Guardar initial_quantity = cantidad_recibida
     - Guardar current_quantity = cantidad_recibida
     - Guardar purchase_price = precio de la factura
     - Registrar expiry_date si aplica
     - Setear status = 'active'
   - Crear movimiento en inventory_movements:
     - movement_type = 'purchase'
     - quantity = cantidad_recibida (entrada positiva)
     - reference_type = 'purchase_invoice'
     - reference_id = factura_id
4. Actualizar estado de la factura:
   - Si todo recibido: marcar como received
   - Si parcial: mantener parcial y registrar backorder
5. Registrar en auditoría por cada lote creado.
6. Generar alerta si la fecha de vencimiento es próxima.

**Salidas (Outputs):**
- Lotes de inventario creados.
- Movimiento de kardez generado.
- Stock de la sucursal actualizado.
- Factura actualizada a estado received o partial.
- Registro de auditoría por cada entrada.

---

### ID-FUNC-M8-003: Registrar Entrada de Inventario por Suministro Corporativo

**Descripción General:** Procesar la recepción de productos enviados desde el corporativo del dueño, creando lotes especiales con trazabilidad interna, sin factura de proveedor externa.

**Entradas (Inputs):**
- Identificador de la transferencia corporativa
- Items recibidos con cantidades
- Precio de transferencia definido por corporativo

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que la transferencia corporativa exista y esté en estado "in_transit".
2. Para cada item recibido:
   - Generar número de lote con prefijo "CORP": SKU-CORP-YYMMDD-SEQ
   - Crear registro en inventory_lotes:
     - NOTA: purchase_invoice_id = NULL (no hay factura externa)
     - Registrar branch_id = sucursal destino
     - Registrar purchase_price = precio_de_transferencia (no costo real)
     - Setear status = 'active'
     - Marcar con indicador de origen corporativo
   - Crear movimiento en inventory_movements:
     - movement_type = 'corporate_transfer_in'
     - quantity = cantidad_recibida
     - reference_type = 'corporate_transfer'
     - reference_id = transferencia_id
3. Crear cuenta por pagar corporativa:
   - Registrar en corporate_accounts_payable
   - amount = cantidad × precio_de_transferencia
   - status = 'pending'
4. Actualizar estado de la transferencia a 'received'.
5. Registrar en auditoría.

**Salidas (Outputs):**
- Lotes corporativos creados con标识 "CORP".
- Movimiento de ingreso registrado.
- Cuenta por pagar corporativa generada.
- Transferencia actualizada a estado received.
- Registro de auditoría generado.

---

### ID-FUNC-M8-004: Consumir Inventario por Venta (FIFO)

**Descripción General:** Descontar del inventario los productos vendidos en una transacción POS, aplicando el método FIFO para consumir primero los lotes más antiguos y registrar el costo de venta.

**Entradas (Inputs):**
- Lista de items vendidos (variante, cantidad)
- Sucursal de la venta
- Identificador de la venta asociada

**Acciones del Sistema (Pasos Operativos):**
1. Para cada item vendido:
   - Identificar lotes disponibles en la sucursal:
     - Consultar inventory_lotes
     - Filter: variant_id, branch_id, status = 'active', current_quantity > 0
     - Order: created_at ASC (FIFO)
   - Distribuir la cantidad solicitada entre los lotes:
     - Consumir del lote más antiguo hasta agotar
     - Continuar con el siguiente lote si hace falta
   - Para cada porción consumida:
     - Crear registro en inventory_movements:
       - movement_type = 'sale'
       - quantity = -cantidad_consumida (negativo = salida)
       - lot_id = lote consumido
       - reference_type = 'sale'
       - reference_id = venta_id
     - Actualizar current_quantity del lote:
       - Si llega a 0: setear status = 'depleted'
     - Calcular costo del consumo para margen
2. Registrar totales en la tabla de ventas:
   - total_cost = suma de costos de lotes consumidos
   - profit_margin = total_venta - total_cost
3. Si algún item no tiene stock suficiente:
   - Registrar falta en log
   - Generar alerta de stock crítico
4. Registrar en auditoría por cada movimiento.

**Salidas (Outputs):**
- Inventario descontado por lotes (FIFO).
- Movimientos de kardex registrados.
- Lotes agotados marcados como depleted.
- Costo de venta calculado para margen.
- Alertas de stock crítico generadas.
- Registro de auditoría por cada salida.

---

### ID-FUNC-M8-005: Procesar Ajuste de Inventario

**Descripción General:** Registrar correcciones al inventario por diferencias detectadas en conteos físicos, mermas, daños o pérdidas, actualizando los lotes correspondientes y generando los registros de trazabilidad.

**Entradas (Inputs):**
- Sucursal del ajuste
- Variante y lote afectado
- Tipo de ajuste (sobrante, faltante, merma, daño)
- Cantidad de ajuste (positiva para entrada, negativa para salida)
- Causa del ajuste
- Notas descriptivas
- Foto de evidencia (si aplica y es requerido)

**Acciones del Sistema (Pasos Operativos):**
1. Validar que el lote exista y esté activo.
2. Verificar que la cantidad de ajuste sea válida:
   - Si es salida (negativa): no puede dejar stock negativo
   - Si es entrada (positiva): crear nuevo lote o aumentar existente
3. Crear movimiento en inventory_movements:
   - movement_type según tipo de ajuste:
     - 'adjustment' para correcciones
     - 'waste' para mermas
     - 'expired' para vencidos
   - quantity = cantidad (positiva o negativa)
   - lot_id = lote afectado
   - reference_type = 'inventory_adjustment'
   - reference_id = ajuste_id
4. Actualizar current_quantity del lote:
   - Si la cantidad llega a 0: setear status correspondiente
   - Si queda negativo: rechazar (validar antes)
5. Si es entrada a nuevo lote:
   - Crear nuevo registro en inventory_lotes
   - Generar número de lote con prefijo "ADJ"
6. Si el valor del ajuste supera umbral:
   - Generar solicitud de aprobación
   - Bloquear hasta aprobación de supervisor
7. Generar asiento contable automático.
8. Registrar en auditoría.

**Salidas (Outputs):**
- Movimiento de ajuste generado.
- Inventario corregido.
- Lote actualizado o creado.
- Asiento contable generado.
- Solicitud de aprobación creada (si aplica).
- Registro de auditoría generado.

---

### ID-FUNC-M8-006: Registrar Transferencia entre Sucursales

**Descripción General:** Procesar el movimiento de inventario desde una sucursal origen hacia una sucursal destino dentro del mismo tenant, generando la trazabilidad y actualizando los stocks correspondientes.

**Entradas (Inputs):**
- Sucursal origen
- Sucursal destino
- Items a transferir (variante, cantidad)
- Usuario responsable de la transferencia
- Motivo de la transferencia

**Acciones del Sistema (Pasos Operativos):**
1. Validar que ambas sucursales existan y estén activas.
2. Para cada item a transferir:
   - Verificar stock suficiente en sucursal origen
   - Identificar lotes disponibles (FIFO) en origen
   - Consumir de lotes origen:
     - Crear movimiento en inventory_movements:
       - movement_type = 'transfer_out'
       - quantity = -cantidad
       - reference_type = 'branch_transfer'
       - reference_id = transferencia_id
     - Actualizar current_quantity de lotes origen
   - Crear nuevos lotes en destino:
     - Generar número de lote: SKU-TRANS-YYMMDD-SEQ
     - purchase_price = costo promedio del origen
     - current_quantity = cantidad transferida
     - status = 'active'
     - Marcar como recibido por transferencia
   - Crear movimiento en destino:
     - movement_type = 'transfer_in'
     - quantity = cantidad
3. Crear registro maestro de la transferencia:
   - Definir estado: pending, in_transit, received, cancelled
   - Registrar fechas y responsables
4. Si los items salen completamente del origen:
   - Cerrar los lotes consumidos
5. Actualizar estado a "in_transit".
6. Registrar en auditoría.

**Salidas (Outputs):**
- Lotes consumidos en origen.
- Lotes creados en destino.
- Movimientos de kardex en ambas sucursales.
- Registro maestro de transferencia creado.
- Estado actualizado a in_transit.
- Registro de auditoría generado.

---

### ID-FUNC-M8-007: Procesar Confirmación de Recepción de Transferencia

**Descripción General:** Validar y confirmar la recepción de los productos transferidos en la sucursal destino, actualizando el estado de la transferencia y generando las alertas correspondientes.

**Entradas (Inputs):**
- Identificador de la transferencia
- Usuario que recibe en destino
- Items efectivamente recibidos (con diferencias si las hay)
- Observaciones de recepción

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que la transferencia exista y esté en estado "in_transit".
2. Validar items recibidos contra items enviados:
   - Comparar cantidades
   - Identificar faltantes o sobrantes
   - Registrar diferencias si las hay
3. Para cada item recibido:
   - Verificar que los lotes creados coincidan con lo esperado
   - Si hay diferencias, ajustar los lotes:
     - Crear nota de diferencia
     - Actualizar quantities según lo realmente recibido
4. Si todo está conforme:
   - Cambiar estado de la transferencia a "received"
5. Si hay diferencias significativas (>5%):
   - Generar alerta de revisión
   - Marcar transferencia como "received_with_differences"
6. Notificar a la sucursal origen sobre la recepción.
7. Registrar en auditoría.

**Salidas (Outputs):**
- Transferencia confirmada o marcada con diferencias.
- Lotes destino actualizados.
- Notificación enviada a origen.
- Alerta de revisión generada (si aplica).
- Registro de auditoría generado.

---

### ID-FUNC-M8-008: Procesar Devolución a Proveedor

**Descripción General:** Registrar la devolución de productos a un proveedor por defectos, vencimiento, erreur de entrega u otras razones, actualizando el inventario y generando la documentación correspondiente.

**Entradas (Inputs):**
- Factura de compra original
- Items a devolver (variante, lote, cantidad)
- Motivo de la devolución
- Notas descriptivas
- Evidencia fotográfica (si aplica)

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que la factura de compra exista y esté en estado que permita devolución.
2. Para cada item a devolver:
   - Verificar que el lote exista y tenga stock suficiente
   - Crear movimiento en inventory_movements:
     - movement_type = 'purchase_return'
     - quantity = -cantidad (negativo = salida)
     - lot_id = lote original
     - reference_type = 'supplier_return'
     - reference_id = devolución_id
   - Actualizar current_quantity del lote:
     - Si llega a 0: setear status = 'returned'
3. Generar nota de devolución al proveedor.
4. Si la factura ya estaba pagada:
   - Crear cuenta por cobrar al proveedor (reembolso)
   - Generar nota de crédito
5. Si la factura está pendiente:
   - Disminuir el balance pendiente de la factura
6. Registrar en corporate_accounts_payable si aplica.
7. Generar asiento contable de devolución.
8. Registrar en auditoría.

**Salidas (Outputs):**
- Inventario reducido por la devolución.
- Movimiento de purchase_return registrado.
- Lote marcado como returned si quedó en cero.
- Nota de devolución generada.
- Nota de crédito generada (si aplica).
- Asiento contable de devolución generado.
- Registro de auditoría generado.

---

## M9: GESTIÓN DE COMPRAS A PROVEEDORES

### ID-FUNC-M9-001: Crear Orden de Compra

**Descripción General:** Generar una solicitud formal de compra a un proveedor especificando los productos, cantidades y precios acordados, iniciando el proceso de abastecimiento.

**Entradas (Inputs):**
- Proveedor seleccionado
- Sucursal destino
- Items a ordenar (variante, cantidad, precio unitario)
- Condiciones comerciales (plazo de pago, descuento)
- Notas adicionales
- Usuario creador

**Acciones del Sistema (Pasos Operativos):**
1. Validar que el proveedor exista y esté activo.
2. Verificar que el proveedor no esté bloqueado.
3. Validar que la sucursal exista y esté activa.
4. Generar número de orden de compra: OC-SUC-YYYY-00000.
5. Para cada item:
   - Validar que la variante exista y esté activa
   - Verificar precio acordado (si existe precio histórico)
   - Calcular subtotal = cantidad × precio
6. Calcular totales:
   - Subtotal = suma de subtotales de items
   - IVA = subtotal × tarifa IVA del producto
   - Total = subtotal + IVA
7. Crear registro en purchase_orders:
   - Asignar número único
   - Vincular proveedor
   - Vincular sucursal
   - Guardar items con cantidades y precios
   - Setear estado inicial "draft"
   - Registrar created_by
8. Registrar creación en auditoría.
9. Generar documento imprimible de la orden.

**Salidas (Outputs):**
- Orden de compra creada con número único.
- Items registrados con cantidades y precios.
- Totales calculados.
- Estado inicial draft establecido.
- Documento de orden disponible.
- Registro de auditoría generado.

---

### ID-FUNC-M9-002: Enviar Orden de Compra a Proveedor

**Descripción General:** Cambiar el estado de la orden de compra a "enviada", marcando el inicio formal del proceso de suministro con el proveedor.

**Entradas (Inputs):**
- Identificador de la orden de compra
- Usuario que envía la orden
- Medio de envío (email, portal proveedor, físico)

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que la orden exista y esté en estado "draft".
2. Validar que todos los items tengan variante y precio válidos.
3. Cambiar estado de la orden a "sent".
4. Registrar fecha y hora de envío.
5. Registrar medio de envío utilizado.
6. Generar documento final de la orden (PDF).
7. Enviar documento al proveedor por el medio seleccionado.
8. Bloquear modificaciones a los items de la orden.
9. Registrar en auditoría.

**Salidas (Outputs):**
- Orden actualizada a estado "sent".
- Fecha de envío registrada.
- Documento PDF generado.
- Email/envío al proveedor confirmado.
- Registro de auditoría generado.

---

### ID-FUNC-M9-003: Registrar Recepción de Mercancía

**Descripción General:** Procesar la llegada de mercancía del proveedor, verificando las cantidades recibidas contra la orden de compra, generando la factura ajustada y creando los lotes de inventario.

**Entradas (Inputs):**
- Identificador de la orden de compra
- Items recibidos con cantidades reales
- Factura del proveedor (número, fecha, monto)
- Observaciones por item si aplica

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que la orden exista y esté en estado "sent" o "partial".
2. Para cada item de la orden:
   - Comparar cantidad recibida vs cantidad ordenada
   - Marcar estado: recibido (completo), parcial, no recibido
   - Registrar cantidad recibida
   - Guardar observaciones si las hay
3. Calcular totales de la recepción:
   - Subtotal = suma(recibido × precio_unitario)
   - IVA según tarifas de cada producto
   - Total = subtotal + IVA
4. Crear factura de compra en purchase_invoices:
   - Generar número: FC-SUC-YYYY-00000
   - Vincular con orden de compra
   - Guardar totales calculados
   - Setear estado "registered"
5. Para cada item recibido:
   - Crear lote en inventory_lotes (ver M8-002)
   - Crear movimiento de entrada en inventory_movements
6. Actualizar estado de la orden:
   - Si todo recibido: "received"
   - Si parcial: "partial_received"
   - Si hay diferencias significativas: "received_with_differences"
7. Generar cuenta por pagar al proveedor.
8. Registrar en auditoría.

**Salidas (Outputs):**
- Items verificados con estados de recepción.
- Factura de compra creada.
- Lotes de inventario creados.
- Movimientos de kardex registrados.
- Orden de compra actualizada a estado final.
- Cuenta por pagar generada.
- Registro de auditoría generado.

---

### ID-FUNC-M9-004: Registrar Pago a Proveedor

**Descripción General:** Procesar el pago de una factura de compra al proveedor, actualizando el saldo pendiente, generando el movimiento de caja y vinculando el comprobante de pago.

**Entradas (Inputs):**
- Identificador de la factura a pagar
- Monto del pago (total o parcial)
- Método de pago (efectivo, transferencia, cheque, Nequi)
- Referencia de la transacción bancaria
- Comprobante de pago (foto o documento)
- Fecha del pago

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que la factura exista y tenga saldo pendiente.
2. Validar que el monto no exceda el saldo pendiente.
3. Crear registro de pago en purchase_payments:
   - Vincular con factura
   - Guardar monto, método, referencia
   - Guardar comprobante si se proporcionó
   - Setear estado "registered"
4. Actualizar saldo de la factura:
   - Restar pago del balance pendiente
   - Si balance llega a 0: marcar factura como "paid"
5. Si el pago es en efectivo:
   - Crear movimiento en cash_movements:
     - movement_type = 'expense'
     - category = 'supplier_payment'
     - reference_type = 'purchase_invoice'
   - Disminuir total_cash_out de la sesión de caja
6. Si el pago es transferencia:
   - Crear movimiento en online_account_movements
7. Generar asiento contable del pago.
8. Registrar en auditoría.

**Salidas (Outputs):**
- Pago registrado y vinculado a la factura.
- Saldo de factura actualizado.
- Movimiento de caja generado (si aplica).
- Asiento contable creado.
- Registro de auditoría generado.

---

## M10: VENTAS Y PUNTO DE VENTA (POS)

### ID-FUNC-M10-001: Buscar Producto en POS

**Descripción General:** Localizar un producto en el catálogo para agregarlo a una venta, buscando por múltiples criterios y retornando la información necesaria para la transacción.

**Entradas (Inputs):**
- Término de búsqueda (código, nombre parcial, código de barras)
- Sucursal donde se realiza la búsqueda
- Lista de precios a aplicar (según cliente)

**Acciones del Sistema (Pasos Operativos):**
1. Ejecutar búsqueda en product_variants con los siguientes criterios:
   - Coincidencia exacta en barcode
   - Coincidencia exacta en SKU
   - Coincidencia parcial en nombre del producto (con trigramas)
   - Coincidencia en nombre de categoría
2. Para cada resultado encontrado:
   - Verificar que la variante esté activa
   - Verificar que el producto base esté activo
   - Consultar stock disponible en la sucursal:
     - Sumar current_quantity de lotes activos
     - Restar quantity_reserved para pedidos
     - Si stock = 0: marcar como agotado
   - Determinar precio según lista de precios del cliente:
     - Buscar en price_list_items
     - Aplicar precio de volumen si cantidad >= mínimo
     - Aplicar promociones activas si aplican
   - Obtener foto del producto
3. Ordenar resultados por relevancia:
   - Barcode exacto primero
   - SKU exacto segundo
   - Nombre coincidente tercero
4. Retornar resultados con información completa.

**Salidas (Outputs):**
- Listado de productos encontrados.
- Para cada producto: SKU, nombre, foto, precio, stock disponible.
- Indicador de agotado si aplica.
- Precio por volumen aplicado si aplica.
- Promociones activas mostradas.

---

### ID-FUNC-M10-002: Agregar Item a Venta en Progreso

**Descripción General:** Incorporar un producto al carrito de venta activo, calculando subtotales, aplicando descuentos y actualizando el estado de la transacción en proceso.

**Entradas (Inputs):**
- Identificador de la venta en progreso (o crear nueva)
- Variante del producto
- Cantidad solicitada
- Precio unitario (desde lista de precios)
- Descuento aplicado (si aplica)
- Notas del item (si aplica)

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que la variante exista y esté activa.
2. Verificar disponibilidad de stock:
   - Consultar quantity_available en la sucursal
   - Si stock < cantidad solicitada: rechazar o permitir cantidad máxima
3. Si es venta a crédito:
   - Validar límite de crédito del cliente
   - Verificar que no tenga facturas vencidas
4. Calcular precio:
   - Obtener precio de la lista correspondiente
   - Aplicar descuento por volumen si cantidad >= mínimo
   - Aplicar promociones activas
5. Calcular subtotal = cantidad × precio unitario
6. Si hay descuento:
   - Calcular discount_amount = subtotal × porcentaje / 100
   - Guardar descuento para el ítem
7. Agregar item a la venta:
   - Crear registro en sales_details
   - Guardar lot_id consumido (para trazabilidad FIFO)
   - Guardar unit_price, quantity, discount
8. Recalcular totales de la venta:
   - subtotal = suma de subtotales de items
   - discount_amount = suma de descuentos
   - tax = subtotal × tarifa IVA promedio
   - total = subtotal - discount + tax
9. Registrar en auditoría el item agregado.

**Salidas (Outputs):**
- Item agregado a sales_details.
- Totales de venta recalculados.
- Stock reservado para la venta.
- Descuento aplicado (si aplica).
- Registro de auditoría generado.

---

### ID-FUNC-M10-003: Confirmar Venta y Generar Comprobante

**Descripción General:** Finalizar una venta, consumir el inventario de los productos vendidos, registrar el movimiento de caja, calcular el costo de venta para margen y generar el comprobante para el cliente.

**Entradas (Inputs):**
- Identificador de la venta
- Método de pago (efectivo, tarjeta, transferencia, crédito)
- Datos del método de pago (monto recibido, referencia)
- Cliente (si es cliente registrado)
- Imprimir comprobante (sí/no)
- Enviar por email/WhatsApp (si aplica)

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que la venta exista y esté en estado "pending".
2. Validar que todos los items tengan stock disponible:
   - Si algún item ya no tiene stock: rechazar o ajustar cantidades
3. Consumir inventario (ver M8-004):
   - Aplicar FIFO para cada item
   - Crear inventory_movements tipo "sale"
   - Actualizar current_quantity de lotes
   - Calcular total_cost desde lotes consumidos
4. Calcular profit_margin = total_venta - total_cost.
5. Registrar pago:
   - Si efectivo:
     - Crear cash_movements tipo "income"
     - category = "sale"
     - Aumentar total_cash_in de la sesión
   - Si tarjeta/transferencia:
     - Crear registro en sales_payments
     - Crear online_account_movements si aplica
   - Si crédito:
     - Crear cargo en credit_accounts
     - Crear credit_transactions tipo "charge"
6. Actualizar estado de la venta a "completed".
7. Generar número de comprobante secuencial.
8. Generar documento del comprobante:
   - Ticket simplificado o factura completa
   - Incluir items, precios, totales
   - Incluir método de pago
9. Si está configurado: enviar a impresora térmica.
10. Si se solicitó: enviar por email/WhatsApp.
11. Registrar en auditoría.

**Salidas (Outputs):**
- Venta completada con estado updated.
- Inventario consumido (lotes actualizados).
- Movimiento de caja generado.
- Costo de venta y margen calculados.
- Comprobante generado.
- Comprobante impreso/enviado.
- Registro de auditoría generado.

---

### ID-FUNC-M10-004: Procesar Anulación de Venta

**Descripción General:** Cancelar una venta previamente completada, revertiendo los movimientos de inventario, caja y generando la documentación de anulación correspondiente.

**Entradas (Inputs):**
- Identificador de la venta a anular
- Motivo de la anulación
- Usuario que autoriza la anulación
- Procedencia de la devolución (si aplica)

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que la venta exista y esté en estado "completed".
2. Validar permisos para anulación:
   - Cajero: hasta monto X
   - Supervisor: hasta monto Y
   - Administrador: sin límite
3. Si excede límites: requerir código de autorización.
4. Para cada item de la venta:
   - Retornar inventario:
     - Crear lote de devolución o incrementar existente
     - Crear inventory_movements tipo "sale_return"
     - quantity = +cantidad (entrada)
   - Revertir costo:
     - Restar del total_cost de la venta
5. Generar nota de crédito:
   - Crear registro en credit_notes
   - Generar número secuencial
6. Generar movimiento de caja inverso:
   - Si fue efectivo: crear egreso por el monto
   - Si fue tarjeta: reversar transacción
7. Si fue venta a crédito:
   - Revertir el cargo en credit_accounts
8. Actualizar estado de la venta a "cancelled".
9. Registrar datos de anulación: usuario, fecha, motivo.
10. Generar comprobante de anulación.
11. Registrar en auditoría.

**Salidas (Outputs):**
- Venta marcada como anulada.
- Inventario restaurado.
- Movimiento de caja inverso generado.
- Nota de crédito creada.
- Cargo de crédito revertido (si aplica).
- Comprobante de anulación generado.
- Registro de auditoría generado.

---

## M11: CONTROL DE CAJA DIARIO

### ID-FUNC-M11-001: Registrar Crédito Otorgado (Venta a Crédito)

**Descripción General:** Documentar una venta realizada a crédito cuando no se registra ticket individual, creando el registro de deuda del cliente para el cuadre diario.

**Entradas (Inputs):**
- Sesión de caja activa
- Cliente (nombre o registro)
- Monto del crédito
- Descripción de productos vendidos (general)
- Fecha del crédito

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que la sesión de caja esté abierta.
2. Si el cliente está registrado:
   - Validar límite de crédito disponible
   - Verificar que no tenga facturas vencidas
3. Si el cliente no está registrado:
   - Crear registro temporal con nombre y documento básico
4. Crear registro en day_credits:
   - Generar número de comprobante: CRE-SUC-YYYYMMDD-0000
   - Guardar monto
   - Setear estado "pending"
   - Associar con sesión de caja
5. Crear cuenta por cobrar:
   - Crear credit_transactions tipo "charge"
   - Aumentar balance del cliente
6. No modificar totales de caja (efectivo aún no entra).
7. Registrar en auditoría.

**Salidas (Outputs):**
- Crédito registrado en day_credits.
- Cuenta por cobrar creada.
- Balance del cliente actualizado.
- Comprobante de crédito generado.
- Registro de auditoría generado.

---

### ID-FUNC-M11-002: Registrar Cobro de Crédito en Efectivo

**Descripción General:** Documentar el pago en efectivo de un crédito previamente otorgado, incrementando el efectivo de la caja y reduciendo la cuenta por cobrar del cliente.

**Entradas (Inputs):**
- Sesión de caja activa
- Identificador del crédito o cliente
- Monto del pago
- Referencias del cobro (si aplica)

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que la sesión de caja esté abierta.
2. Validar el crédito exista y esté en estado "pending" o "partial".
3. Verificar que el monto no exceda el saldo pendiente.
4. Crear movimiento de caja:
   - Crear cash_movements tipo "income"
   - category = "credit_payment"
   - reference_type = "day_credit"
   - reference_id = crédito_id
5. Actualizar totales de la sesión:
   - total_cash_in += monto
   - total_credit_payments += monto
6. Actualizar el crédito:
   - restar monto del saldo pendiente
   - si llega a 0: setear estado "paid"
7. Crear credit_transactions tipo "payment".
8. Actualizar balance del cliente.
9. Registrar en auditoría.

**Salidas (Outputs):**
- Movimiento de caja de ingreso generado.
- Totales de sesión actualizados.
- Crédito marcado como pagado o parcial.
- Balance del cliente reducido.
- Registro de auditoría generado.

---

### ID-FUNC-M11-003: Registrar Salida de Dinero

**Descripción General:** Documentar cualquier egreso de efectivo de la caja, clasificando por tipo (gasto operativo, pago a proveedor, retiro del dueño) y vinculando con la documentación de soporte.

**Entradas (Inputs):**
- Sesión de caja activa
- Tipo de salida (gasto operativo, pago a proveedor, retiro dueño, otro)
- Beneficiario o concepto
- Monto
- Método de pago (efectivo, online)
- Referencia de la factura o documento
- Foto del comprobante (opcional)
- Notas adicionales

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que la sesión de caja esté abierta.
2. Validar que el monto no exceda el efectivo disponible.
3. Crear movimiento de caja:
   - Crear cash_movements tipo "expense" o "withdrawal"
   - category según tipo seleccionado
   - reference_type y reference_id si hay factura vinculada
   - notes con concepto y observaciones
   - evidence_url con foto del comprobante si se proporcionó
4. Actualizar totales de la sesión:
   - total_cash_out += monto
5. Si es pago a proveedor:
   - Actualizar saldo de la factura en purchase_invoices
   - Crear registro en purchase_payments
6. Generar asiento contable del egreso.
7. Registrar en auditoría.

**Salidas (Outputs):**
- Movimiento de egreso registrado.
- Totales de sesión actualizados.
- Factura de proveedor actualizada (si aplica).
- Asiento contable generado.
- Registro de auditoría generado.

---

### ID-FUNC-M11-004: Ejecutar Cierre de Caja (Cuadre Ciego)

**Descripción General:** Finalizar la sesión de caja del día, comparando el efectivo calculado por el sistema con el efectivo físicamente contado, calculando diferencias y generando el reporte de cierre.

**Entradas (Inputs):**
- Sesión de caja activa
- Usuario que realiza el cierre
- Monto de efectivo contado físicamente
- Fecha y hora del cierre

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que la sesión de caja esté abierta.
2. Calcular system_amount (efectivo esperado):
   - system_amount = initial_amount + total_cash_in + total_credit_payments - total_cash_out
3. Solicitar al usuario el declared_amount (efectivo contado físicamente).
4. Calcular diferencia:
   - difference = declared_amount - system_amount
5. Validar diferencia contra umbral configurable:
   - Si |difference| <= umbral: aprobar automáticamente
   - Si |difference| > umbral: requerir justificación
6. Si se requiere justificación:
   - Solicitar texto explicativo
   - Registrar en difference_justification
   - Si no se proporciona o es insuficiente: bloquear cierre
7. Si la diferencia es mayor al umbral y hay justificación:
   - Crear solicitud de aprobación para supervisor
8. Actualizar sesión de caja:
   - declared_amount = monto contado
   - closing_date = timestamp actual
   - status = "closed" o "pending_approval"
9. Generar reporte de cierre con todos los movimientos del día:
   - Resumen de ingresos y egresos
   - Detalle de créditos otorgados
   - Detalle de cobros de créditos
   - Comparación system vs declared
   - Diferencias y justificaciones
10. Generar asientos contables automáticos.
11. Registrar en auditoría.

**Salidas (Outputs):**
- Sesión de caja cerrada.
- system_amount y declared_amount registrados.
- Diferencia calculada.
- Justificación registrada (si aplica).
- Solicitud de aprobación creada (si aplica).
- Reporte de cierre generado.
- Asientos contables generados.
- Registro de auditoría generado.

---

## M12: GESTIÓN DE PEDIDOS DEL PORTAL

### ID-FUNC-M12-001: Registrar Pedido desde Portal Cliente

**Descripción General:** Crear un pedido en el sistema cuando un cliente final realiza una orden a través del portal B2B, generando la trazabilidad y notificando a la sucursal destino.

**Entradas (Inputs):**
- Cliente que realiza el pedido
- Sucursal destino del pedido
- Items del pedido (variante, cantidad)
- Dirección de entrega
- Notas del cliente

**Acciones del Sistema (Pasos Operativos):**
1. Validar que el cliente exista y tenga cuenta activa.
2. Verificar que la sucursal exista y esté activa.
3. Para cada item del pedido:
   - Verificar disponibilidad de stock:
     - Consultar inventory_lotes en la sucursal
     - Si no hay stock suficiente: alertar pero permitir continuar
   - Crear reserva de inventario:
     - Crear inventory_reservations
     - quantity = cantidad solicitada
     - expires_at = ahora + 24 horas
     - Marcar como "active"
4. Generar número de pedido: PED-SUC-YYYY-00000.
5. Crear registro en orders:
   - customer_id = cliente
   - branch_id = sucursal destino
   - status = "requested"
   - subtotal, shipping_cost, tax, total calculados
   - delivery_address = dirección proporcionada
   - customer_notes = notas del cliente
6. Crear registros en order_items:
   - variant_id, quantity, unit_price
   - subtotal = quantity × unit_price
7. Generar factura proforma en invoices:
   - status = "pending_payment"
   - total = total del pedido
8. Enviar notificación a la sucursal destino.
9. Enviar confirmación al cliente con número de pedido.
10. Registrar en auditoría.

**Salidas (Outputs):**
- Pedido creado con número único.
- Items registrados con precios.
- Reservas de inventario creadas (con vencimiento).
- Factura proforma generada.
- Notificación enviada a sucursal.
- Confirmación enviada al cliente.
- Registro de auditoría generado.

---

### ID-FUNC-M12-002: Confirmar Pedido en Sucursal

**Descripción General:** Cambiar el estado de un pedido de "solicitado" a "confirmado" cuando la sucursal valida la disponibilidad y acepta el pedido.

**Entradas (Inputs):**
- Identificador del pedido
- Usuario que confirma
- Observaciones de confirmación (si aplica)

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que el pedido exista y esté en estado "requested".
2. Validar disponibilidad de los items:
   - Verificar reservas activas
   - Si hay items sin stock: notificar al cliente para ajustar
3. Convertir reservas en consumo real:
   - Para cada item:
     - Crear inventory_movements tipo "sale"
     - quantity = -cantidad (salida)
     - reference_type = "order"
     - reference_id = pedido_id
     - Actualizar current_quantity de lotes
     - Marcar reserva como "consumed"
4. Cambiar estado del pedido a "confirmed".
5. Actualizar estado de la factura proforma a "pending_payment" (o "paid" si ya hay pago).
6. Enviar notificación al cliente: "Tu pedido ha sido confirmado".
7. Registrar en auditoría.

**Salidas (Outputs):**
- Pedido confirmado.
- Inventario consumido (reservas convertidas).
- Lotes actualizados.
- Reserva marcada como consumida.
- Notificación de confirmación enviada.
- Registro de auditoría generado.

---

### ID-FUNC-M12-003: Actualizar Estado de Pedido

**Descripción General:** Gestionar los cambios de estado de un pedido a través de su ciclo de vida (preparando, listo, en tránsito, entregado), generando notificaciones en cada transición.

**Entradas (Inputs):**
- Identificador del pedido
- Nuevo estado solicitado
- Usuario que realiza el cambio
- Notas o comentarios asociados

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que el pedido exista y permita el cambio de estado.
2. Validar que la transición sea válida:
   - confirmed → preparing → ready → in_transit → delivered
   - cancelled desde cualquier estado previo a confirmación
3. Cambiar estado del pedido.
4. Registrar cambio en historial del pedido:
   - timestamp, usuario, estado anterior, estado nuevo, notas
5. Generar notificaciones específicas según transición:
   - preparing: notificar al cliente "Tu pedido está siendo preparado"
   - ready: notificar "Tu pedido está listo"
   - in_transit: notificar con hora estimada de llegada
   - delivered: notificar "Tu pedido ha sido entregado"
6. Si el estado es "in_transit":
   - Registrar información de entrega si aplica
7. Si el estado es "delivered":
   - Solicitar confirmación de recepción al cliente
8. Registrar en auditoría.

**Salidas (Outputs):**
- Estado del pedido actualizado.
- Historial de cambios ampliado.
- Notificaciones enviadas según transición.
- Solicitud de confirmación generada (si entregado).
- Registro de auditoría generado.

---

### ID-FUNC-M12-004: Procesar Pago de Factura desde Portal

**Descripción General:** Registrar un pago realizado por el cliente para saldar una factura pendiente, vinculando el comprobante y cambiando el estado para verificación.

**Entradas (Inputs):**
- Identificador de la factura
- Cliente que realiza el pago
- Monto del pago
- Método de pago (efectivo, transferencia, Nequi, Daviplata)
- Referencia de la transacción
- Foto del comprobante (opcional)
- Fecha del pago

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que la factura exista y tenga saldo pendiente.
2. Validar que el monto no exceda el saldo.
3. Crear registro en customer_payments:
   - status = "pending_verification"
   - payment_date = fecha proporcionada
   - amount = monto
   - payment_method = método seleccionado
   - reference = referencia de transacción
   - proof_url = foto del comprobante si se proporcionó
4. Crear registro en customer_payments_invoices vinculando pago con factura.
5. Cambiar estado de la factura a "payment_pending_verification".
6. Enviar notificación a la sucursal: "El cliente ha registrado un pago".
7. Registrar en auditoría.

**Salidas (Outputs):**
- Pago registrado con estado "pending_verification".
- Factura marcada como pendiente de verificación.
- Vinculación pago-factura creada.
- Notificación enviada a la sucursal.
- Registro de auditoría generado.

---

### ID-FUNC-M12-005: Verificar y Confirmar Pago de Cliente

**Descripción General:** Validar un pago registrado por el cliente, confirmando que el dinero fue efectivamente recibido y aplicando el cobro a la factura correspondiente.

**Entradas (Inputs):**
- Identificador del pago
- Usuario que verifica (vendedor/administrador)
- Resultado de la verificación (aprobado/rechazado)
- Notas de la verificación (obligatorio si es rechazo)
- Referencia bancaria confirmada (si aplica)

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que el pago exista y esté en estado "pending_verification".
2. Validar permisos del usuario para verificar pagos.
3. Si la verificación es APROBADA:
   - Cambiar estado del pago a "verified"
   - Setear verified_by y verified_at
   - Registrar notas si las hay
   - Actualizar invoice:
     - restar monto del balance pendiente
     - si balance llega a 0: setear estado "paid"
   - Crear credit_transactions tipo "payment"
   - Si el pago es en efectivo:
     - Crear cash_movements tipo "income"
     - category = "customer_payment"
     - Aumentar total_cash_in de la sesión
   - Si el pago es online:
     - Crear online_account_movements
   - Notificar al cliente: "Tu pago ha sido confirmado"
4. Si la verificación es RECHAZADA:
   - Cambiar estado del pago a "rejected"
   - Registrar rejection_reason obligatorio
   - Notificar al cliente con la razón
5. Registrar en auditoría.

**Salidas (Outputs):**
- Pago aprobado o rechazado.
- Factura actualizada (balance reducido o pagada).
- Movimiento de caja generado (si efectivo).
- Balance del cliente actualizado.
- Notificación de confirmación enviada al cliente.
- Registro de auditoría generado.

---

## M13: CONTABILIDAD SIMPLIFICADA

### ID-FUNC-M13-001: Generar Asiento Contable por Compra

**Descripción General:** Crear automáticamente los asientos contables correspondientes a una factura de compra, aplicando partida doble y respetando el PUC colombiano.

**Entradas (Inputs):**
- Identificador de la factura de compra
- Datos de la factura (subtotal, IVA, total, proveedor)

**Acciones del Sistema (Pasos Operativo:**)
1. Verificar que la factura exista y esté en estado que permita asiento.
2. Verificar que el período contable esté abierto.
3. Crear registro en accounting_entries:
   - entry_number = ASI-SUC-YYYY-00000
   - entry_date = fecha de la factura
   - reference_type = "purchase_invoice"
   - reference_id = factura_id
   - description = "Compra a [proveedor] - Factura [número]"
   - is_auto_generated = true
4. Crear líneas de asiento en accounting_entry_lines:
   - Línea 1 (Débito): Cuenta de Compras (5xxx) por el subtotal
   - Línea 2 (Débito): IVA Descontable (2370) por el IVA
   - Línea 3 (Crédito): Proveedores (21xx) por el total
5. Validar partida doble: SUM(débitos) = SUM(créditos).
6. Si hay retención: agregar líneas adicionales.
7. Setear estado del asiento como "draft" o "posted" según configuración.
8. Registrar en auditoría.

**Salidas (Outputs):**
- Asiento contable creado.
- Líneas de débito y crédito generadas.
- Validación de partida doble cumplida.
- Asiento vinculado a la factura.
- Registro de auditoría generado.

---

### ID-FUNC-M13-002: Generar Asiento Contable por Cierre de Caja

**Descripción General:** Crear automáticamente los asientos contables derivados del cuadre diario de caja, consolidando las ventas del día y todos los movimientos de efectivo.

**Entradas (Inputs):**
- Identificador de la sesión de caja cerrada
- Datos del cierre (initial_amount, total_cash_in, total_cash_out, total_credit_payments)

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que la sesión de caja esté cerrada.
2. Verificar que el período contable esté abierto.
3. Crear asiento de ventas del día:
   - entry_date = fecha del cierre
   - reference_type = "cash_session"
   - reference_id = sesión_id
   - description = "Cierre de caja - Ventas del día [fecha]"
   - Líneas:
     - Débito: Caja General (1105) por efectivo contado
     - Débito: Cuentas Online (12xx) por pagos online
     - Crédito: Ventas (41xx) por subtotal de ventas
     - Crédito: IVA Generado (2408) por impuesto
4. Crear asiento de cobros de créditos:
   - Débito: Caja General (1105)
   - Crédito: Clientes (13xx)
5. Crear asiento de costos de venta:
   - Débito: Costo de Ventas (61xx)
   - Crédito: Inventario (14xx)
6. Crear asiento de egresos:
   - Débito: Gastos o Proveedores según categoría
   - Crédito: Caja General (1105)
7. Validar partida doble en cada asiento.
8. Registrar todos los asientos.
9. Registrar en auditoría.

**Salidas (Outputs):**
- Asiento de ventas generado.
- Asiento de cobros de créditos generado.
- Asiento de costo de venta generado.
- Asientos de egresos generados.
- Todos vinculados a la sesión de caja.
- Registro de auditoría generado.

---

### ID-FUNC-M13-003: Generar Asiento Contable por Suministro Corporativo

**Descripción General:** Crear los asientos contables para el registro de suministros del corporativo hacia la sucursal, diferenciando de las compras externas.

**Entradas (Inputs):**
- Identificador de la transferencia corporativa confirmada
- Datos del suministro (total, items)

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que la transferencia esté en estado "received".
2. Verificar que el período contable esté abierto.
3. Crear asiento en la sucursal:
   - Débito: Inventario (14xx) por el total del suministro
   - Crédito: Cuentas por Pagar Corporativo (21xx) por el total
4. Crear asiento inverso en la contabilidad del corporativo (si existe en el sistema):
   - Débito: Cuentas por Cobrar Corporativo (13xx)
   - Crédito: Ingresos por Suministros (41xx)
5. NO generar IVA (es movimiento interno).
6. Validar partida doble.
7. Registrar en auditoría.

**Salidas (Outputs):**
- Asiento de entrada de inventario generado.
- Asiento de cuenta por pagar corporativa generado.
- Asiento inverso en corporativo (si aplica).
- Sin movimientos de IVA.
- Registro de auditoría generado.

---

### ID-FUNC-M13-004: Generar Asiento Contable por Pago a Corporativo

**Descripción General:** Crear los asientos contables cuando la sucursal realiza un pago hacia el corporativo por los suministros recibidos.

**Entradas (Inputs):**
- Identificador del pago corporativo
- Datos del pago (monto, método)

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que el pago corporativo exista.
2. Verificar que el período contable esté abierto.
3. Crear asiento en la sucursal:
   - Débito: Cuentas por Pagar Corporativo (21xx)
   - Crédito: Caja General (1105) si es efectivo
   - Crédito: Bancos (12xx) si es transferencia
4. Crear asiento inverso en corporativo:
   - Débito: Caja/Bancos
   - Crédito: Cuentas por Cobrar Corporativo (13xx)
5. Validar partida doble.
6. Registrar en auditoría.

**Salidas (Outputs):**
- Asiento de egreso por pago corporativo generado.
- Cuenta por pagar reducida.
- Asiento de cobro en corporativo generado.
- Registro de auditoría generado.

---

### ID-FUNC-M13-005: Generar Reportes Contables

**Descripción General:** Consolidar los asientos contables de un período para generar los libros oficiales (diario, mayor, balance de prueba) y reportes para declaraciones tributarias.

**Entradas (Inputs):**
- Período contable (año, mes)
- Tipo de reporte (diario, mayor, balance, libro ventas, libro compras)
- Formato de salida (PDF, Excel, CSV)

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que el período exista.
2. Filtrar accounting_entries por período:
   - entry_date entre period_start y period_end
3. Para cada tipo de reporte:
   - Si es libro diario:
     - Listar asientos en orden cronológico
     - Incluir todas las líneas de cada asiento
     - Calcular totales por cuenta
   - Si es libro mayor:
     - Agrupar por cuenta contable
     - Mostrar movimientos de cada cuenta
     - Calcular saldo final
   - Si es balance de prueba:
     - Listar todas las cuentas con saldos
     - Calcular totales de débitos y créditos
     - Verificar equilibrio
   - Si es libro de ventas:
     - Filtrar asientos con reference_type = "sale"
     - Agrupar por cliente/tipo
     - Aplicar formato DIAN
   - Si es libro de compras:
     - Filtrar asientos con reference_type = "purchase"
     - Agrupar por proveedor
     - Aplicar formato DIAN
4. Calcular totales y subtotales.
5. Generar documento en formato solicitado.
6. Registrar generación del reporte en auditoría.

**Salidas (Outputs):**
- Reporte contable generado.
- Libro en formato solicitado (PDF/Excel/CSV).
- Totales y saldos calculados.
- Formato DIAN aplicado (si aplica).
- Registro de auditoría generado.

---

## M14: GESTIÓN DE CRÉDITOS A CLIENTES

### ID-FUNC-M14-001: Configurar Límite de Crédito a Cliente

**Descripción General:** Asignar o modificar el límite de crédito y plazo de pago de un cliente, calculando el score crediticio automáticamente.

**Entradas (Inputs):**
- Identificador del cliente
- Nuevo límite de crédito
- Nuevo plazo de crédito (días)
- Justificación del cambio

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que el cliente exista y esté activo.
2. Calcular score crediticio automático:
   - payment_history_score: % de pagos a tiempo
   - antiguedad: meses como cliente
   - volume_score: volumen de compras
   - credit_utilization: % del límite usado
   - overdue_history: días promedio de retraso
   - score = weighted_average de los anteriores
3. Generar límite sugerido:
   - suggested_limit = min(score × 10000, ticket_promedio × 3, current_limit × 1.2)
4. Permitir al usuario aprobar, aumentar o disminuir el sugerido.
5. Validar que el nuevo límite sea razonable.
6. Actualizar credit_account:
   - credit_limit = nuevo límite
   - credit_days = nuevo plazo
   - credit_score = score calculado
7. Registrar en limit_change_history:
   - old_limit, new_limit
   - justification
   - usuario, timestamp
8. Registrar en auditoría.

**Salidas (Outputs):**
- Límite de crédito actualizado.
- Score crediticio calculado.
- Plazo de crédito actualizado.
- Historial de cambios registrado.
- Registro de auditoría generado.

---

### ID-FUNC-M14-002: Validar Otorgamiento de Crédito en Venta

**Descripción General:** Verificar si un cliente puede realizar una compra a crédito basándose en su límite disponible, historial de pagos y estado de la cuenta.

**Entradas (Inputs):**
- Identificador del cliente
- Monto de la venta a crédito

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que el cliente exista y tenga credit_account activa.
2. Verificar que el estado del cliente no sea "suspended" o "blocked".
3. Calcular crédito disponible:
   - available_credit = credit_limit - current_credit
4. Validar que la venta no exceda el límite:
   - Si sale_total > available_credit: rechazar
5. Verificar que no tenga facturas vencidas:
   - Consultar invoices con status "overdue"
   - Si existen: rechazar o requerir pago parcial
6. Si todo está OK: aprobar la venta a crédito.
7. Si hay restricciones: retornar理由 específica del rechazo.

**Salidas (Outputs):**
- Aprobación o rechazo del crédito.
- Razón específica si es rechazado.
- Crédito disponible mostrado.

---

### ID-FUNC-M14-003: Calcular Aging de Cartera

**Descripción General:** Analizar las cuentas por cobrar de todos los clientes, clasificando las deudas según su antigüedad y calculando los montos vencidos por rango de días.

**Entradas (Inputs):**
- Fecha de corte para el análisis
- Sucursal a filtrar (todas o específica)

**Acciones del Sistema (Pasos Operativos):**
1. Para cada cliente con saldo pendiente:
   - Obtener invoices con balance > 0
   - Para cada invoice:
     - Calcular días desde due_date
     - Clasificar en rangos:
       - Por vencer (días < 0)
       - 1-30 días vencidos
       - 31-60 días vencidos
       - 61-90 días vencidos
       - >90 días vencidos
     - Sumar al total del rango
2. Calcular para cada cliente:
   - overdue_balance = suma de todos los vencidos
   - payment_history_days = promedio de retraso
3. Clasificar clientes según antigüedad:
   - Si overdue_balance > 0 y días > 30: clasificar como "Riesgo"
   - Si >90 días: clasificar como "Moroso"
4. Calcular totales por rango de antigüedad.
5. Generar resumen ejecutivo.

**Salidas (Outputs):**
- Aging de cartera por cliente.
- Totales por rango de antigüedad.
- Clasificación de clientes por riesgo.
- Resumen ejecutivo disponible.

---

## M15: RECURSOS HUMANOS Y NÓMINA

### ID-FUNC-M15-001: Registrar Nuevo Empleado

**Descripción General:** Crear el registro de un nuevo empleado en el sistema, vinculándolo con un usuario del sistema si aplica y definiendo sus datos laborales.

**Entradas (Inputs):**
- Datos personales: nombre completo, cédula, email, teléfono
- Datos laborales: cargo, departamento, sucursal asignada
- Datos salariales: salario, frecuencia de pago
- Datos bancarios para nómina (opcional)
- Fecha de inicio de labores

**Acciones del Sistema (Pasos Operativos):**
1. Validar que la cédula no exista previamente en el tenant.
2. Generar código de empleado: EMP-SUC-00000.
3. Crear registro en employees:
   - Guardar datos personales
   - Guardar datos laborales
   - Guardar datos salariales
   - Setear status = "active"
   - Setear hire_date
4. Si se especifica usuario del sistema:
   - Vincular employee_id con user_id
   - Verificar que pertenezcan al mismo tenant y sucursal
5. Generar registro de historial laboral inicial.
6. Registrar en auditoría.

**Salidas (Outputs):**
- Empleado registrado con código único.
- Usuario vinculado (si aplica).
- Datos laborales y salariales guardados.
- Registro de auditoría generado.

---

### ID-FUNC-M15-002: Ejecutar Procesamiento de Nómina

**Descripción General:** Calcular y procesar la nómina de un período, generando los registros de pago para cada empleado activo.

**Entradas (Inputs):**
- Período de nómina (semana, quincena, mes)
- Fecha de pago
- Usuario que ejecuta la nómina

**Acciones del Sistema (Pasos Operativos):**
1. Crear registro en payroll_runs:
   - Generar número de nómina: NOM-YYYY-MM-000
   - Definir period_start y period_end
   - Setear payment_date
   - Setear status = "calculated"
2. Para cada empleado activo con esa frecuencia de pago:
   - Calcular gross_salary según configuración:
     - Mensual: salario base
     - Quincenal: salario / 2
     - Semanal: salario / 4
   - Calcular deducciones:
     - Salud: 4% del salario (si aplica)
     - Pensión: 4% del salario (si aplica)
     - Retención en la fuente si aplica
   - Calcular bonificaciones:
     - Auxilio de transporte si aplica
     - Horas extras si las hay
     - Bonificaciones adicionales
   - Calcular net_salary = gross + bonificaciones - deducciones
   - Crear payroll_details:
     - employee_id
     - gross_salary
     - deductions (JSONB)
     - total_deductions
     - bonuses (JSONB)
     - total_bonuses
     - net_salary
     - days_worked, days_absent, overtime_hours
3. Sumar totales en payroll_runs:
   - total_gross = suma de gross_salary
   - total_deductions = suma de deducciones
   - total_bonuses = suma de bonificaciones
   - total_net = suma de net_salary
4. Registrar creación en auditoría.
5. Generar comprobantes de pago para cada empleado.

**Salidas (Outputs):**
- Nómina procesada con número único.
- Detalles de nómina por empleado generados.
- Totales calculados (gross, deductions, bonuses, net).
- Comprobantes de pago generados.
- Registro de auditoría generado.

---

### ID-FUNC-M15-003: Generar Asiento Contable de Nómina

**Descripción General:** Crear los asientos contables correspondientes a la nómina procesada, distribuyendo los valores en las cuentas correspondientes del PUC.

**Entradas (Inputs):**
- Identificador del payroll_run procesado

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que el payroll_run esté en estado "calculated" o "approved".
2. Crear asiento principal de nómina:
   - Débito: Gastos de Personal (5xxx) por total_gross
   - Crédito: Nómina por Pagar (21xx) por total_net
   - Crédito: Aportes de Seguridad Social (2xxx) por total de aportes de employer
   - Crédito: Retención en la Fuente (2xxx) por total de retenciones
3. Crear asiento de deducciones de empleados:
   - Débito: Nómina por Pagar (21xx)
   - Crédito: Aportes de Seguridad Social por pagar
   - Crédito: Retención en la Fuente por pagar
4. Crear asiento de provisión de prestaciones sociales si aplica.
5. Validar partida doble en cada asiento.
6. Setear payroll_runs.status = "posted".
7. Registrar en auditoría.

**Salidas (Outputs):**
- Asiento de nómina principal generado.
- Asientos de deducciones generados.
- Asiento de provisiones (si aplica).
- Nómina marcada como contabilizada.
- Registro de auditoría generado.

---

# PLATAFORMA 3: APP CLIENTE FINAL (B2B)

Esta plataforma es utilizada por los clientes mayoristas/minoristas de Quesera D&G para: ver catálogo, hacer pedidos, consultar estado de cuenta, registrar pagos y comunicarse con la empresa.

---

## M16: GESTIÓN DE REGISTRO Y ACCESO

### ID-FUNC-M16-001: Registrar Nuevo Cliente en Portal

**Descripción General:** Crear el registro de un nuevo cliente en el portal B2B, solicitando los datos básicos y estableciendo el estado inicial como "pendiente de aprobación".

**Entradas (Inputs):**
- Nombre del negocio
- Número de identificación (NIT o cédula)
- Nombre del contacto responsable
- Email de acceso
- Teléfono/WhatsApp
- Dirección de entrega
- Tipo de cliente solicitado (minorista/mayorista)
- Password inicial

**Acciones del Sistema (Pasos Operativos):**
1. Validar que el email no exista en customers del tenant.
2. Validar que el NIT no exista en customers del tenant.
3. Generar código de cliente: CLI-SUC-00000.
4. Crear registro en customers:
   - Guardar datos del negocio y contacto
   - Setear customer_type = tipo solicitado
   - Setear status = "pending_approval"
   - Setear app_user_id si es nuevo registro de usuario
5. Crear usuario en auth.users si el email es nuevo.
6. Enviar hash de password.
7. Crear credit_account con límites default (credit_limit = 0, credit_days = 0).
8. Notificar al administrador de la empresa sobre el nuevo registro.
9. Registrar en auditoría.

**Salidas (Outputs):**
- Cliente creado con estado pending_approval.
- Código de cliente asignado.
- Usuario del portal creado.
- Credit account inicializado.
- Notificación enviada al administrador.
- Registro de auditoría generado.

---

### ID-FUNC-M16-002: Aprobar/Rechazar Registro de Cliente

**Descripción General:** Procesar la solicitud de registro de un cliente, aprobando y asignando tipo de cliente y límites de crédito, o rechazando con justificación.

**Entradas (Inputs):**
- Identificador del cliente pendiente
- Decisión (aprobar/rechazar)
- Tipo de cliente asignado (si se aprueba)
- Límite de crédito (si se aprueba)
- Plazo de crédito en días (si se approve)
- Motivo de rechazo (si se rechaza)

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que el cliente exista y esté en estado "pending_approval".
2. Si la decisión es APROBAR:
   - Setear status = "active"
   - Asignar customer_type definitivo (puede diferir del solicitado)
   - Actualizar credit_account:
     - credit_limit = límite proporcionado
     - credit_days = plazo proporcionado
   - Habilitar acceso del usuario al portal
   - Enviar notificación al cliente: "Tu cuenta ha sido aprobada"
   - Enviar credenciales de acceso (si es necesario)
3. Si la decisión es RECHAZAR:
   - Setear status = "rejected"
   - Solicitar rejection_reason obligatorio
   - Notificar al cliente con la razón del rechazo
4. Registrar en auditoría.

**Salidas (Outputs):**
- Cliente aprobado o rechazado.
- Tipo de cliente asignado (si aprueba).
- Límite de crédito configurado (si aprueba).
- Acceso al portal habilitado/deshabilitado.
- Notificaciones enviadas.
- Registro de auditoría generado.

---

### ID-FUNC-M16-003: Iniciar Sesión en Portal Cliente

**Descripción General:** Autenticar a un cliente en el portal B2B, verificando credenciales y estableciendo la sesión activa.

**Entradas (Inputs):**
- Email del cliente
- Password

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que el email exista en auth.users.
2. Verificar que el cliente exista y esté activo.
3. Validar password contra hash almacenado.
4. Generar JWT token de sesión.
5. Verificar estado de la licencia del tenant (no vencida).
6. Registrar inicio de sesión en auditoría.
7. Retornar token y datos del cliente.

**Salidas (Outputs):**
- Token de sesión generado.
- Datos del cliente retornados.
- Inicio de sesión registrado.

---

### ID-FUNC-M16-004: Recuperar Contraseña

**Descripción General:** Generar un código OTP o enlace mágico para permitir al cliente recuperar el acceso a su cuenta.

**Entradas (Inputs):**
- Email del cliente

**Acciones del Sistema (Pasos Operativo:**)
1. Verificar que el email exista en auth.users.
2. Generar OTP de 6 dígitos o Magic Link.
3. Enviar por email al cliente.
4. Registrar intento de recuperación en auditoría (sin revelar si el email existe).
5. Si el cliente ingresa el código correcto:
   - Permitir setear nueva contraseña
   - Invalidar el código después de uso
6. Invalidar código después de 15-30 minutos.

**Salidas (Outputs):**
- OTP/Magic Link enviado por email.
- Tentativa registrada.
- Validación de código exitosa.

---

## M17: CATÁLOGO Y PEDIDOS

### ID-FUNC-M17-001: Consultar Catálogo de Productos

**Descripción General:** Obtener el listado de productos disponibles para un cliente, filtrando por tipo y mostrando los precios correspondientes a su lista de precios.

**Entradas (Inputs):**
- Cliente autenticado
- Tipo de cliente (minorista/mayorista)
- Filtros opcionales: categoría, búsqueda, disponibilidad
- Lista de precios del cliente

**Acciones del Sistema (Pasos Operativos):**
1. Obtener customer_type del cliente.
2. Determinar lista de precios aplicable:
   - Si el cliente tiene lista asignada: usarla
   - Sino usar lista default para customer_type
3. Si hay filtro de categoría:
   - Filtrar productos por categoría
4. Si hay término de búsqueda:
   - Buscar en nombre, SKU, código de barras
5. Para cada producto resultante:
   - Verificar disponibilidad de stock:
     - Consultar inventario consolidado
     - Mostrar cantidad disponible o "Agotado"
   - Obtener precio de la lista de precios:
     - price_list_items con variant_id y price_list_id
     - Aplicar precio por volumen si aplica
   - Mostrar foto, nombre, unidad de medida
6. Ordenar resultados por categoría o relevancia.

**Salidas (Outputs):**
- Listado de productos filtrados.
- Para cada producto: foto, nombre, precio, disponibilidad.
- Precio por volumen mostrado si aplica.
- Indicador de agotado.

---

### ID-FUNC-M17-002: Agregar Producto al Carrito

**Descripción General:** Agregar uno o más productos al carrito de compras del cliente, validando disponibilidad y aplicando precios de su lista.

**Entradas (Inputs):**
- Cliente autenticado
- Variante del producto
- Cantidad solicitada
- Carrito actual del cliente

**Acciones del Sistema (Pasos Operativos):**
1. Validar que el cliente esté activo.
2. Verificar que la variante exista y esté activa.
3. Validar disponibilidad de stock:
   - Si es cantidad menor o igual al disponible: continuar
   - Si es mayor: permitir solo hasta el disponible o rechazar
4. Si el cliente es mayorista:
   - Validar cantidad mínima de pedido si existe
5. Calcular precio:
   - Obtener precio de la lista del cliente
   - Aplicar precio por volumen si cantidad >= mínimo
6. Agregar item al carrito:
   - Crear o actualizar registro en cart_items
   - variant_id, quantity, unit_price, subtotal
7. Recalcular totales del carrito.
8. Registrar en auditoría.

**Salidas (Outputs):**
- Item agregado al carrito.
- Totales del carrito recalculados.
- Validación de stock aplicada.
- Registro de auditoría generado.

---

### ID-FUNC-M17-003: Confirmar Pedido

**Descripción General:** Finalizar el proceso de compra convirtiendo el carrito en un pedido formal, generando la factura proforma y notificando a la empresa.

**Entradas (Inputs):**
- Cliente autenticado
- Carrito con items
- Dirección de entrega
- Notas del pedido

**Acciones del Sistema (Pasos Operativos):**
1. Validar que el cliente esté activo.
2. Verificar que el carrito tenga items.
3. Para cada item del carrito:
   - Verificar stock disponible actualizado
   - Si no hay stock: alertar y excluir del pedido
4. Calcular totales:
   - subtotal = suma(quantity × unit_price)
   - shipping_cost = calcular según zona y volumen
   - tax = aplicar si corresponde
   - total = subtotal + shipping + tax
5. Generar número de pedido: PED-SUC-YYYY-00000.
6. Crear registro en orders:
   - customer_id, branch_id (sucursal destino)
   - status = "requested"
   - subtotal, shipping_cost, tax, total
   - delivery_address, customer_notes
7. Crear registros en order_items.
8. Generar reserva de inventario:
   - Crear inventory_reservations
   - expires_at = ahora + 24 horas
9. Crear factura proforma en invoices:
   - status = "pending_payment"
10. Eliminar items del carrito.
11. Enviar notificación a la sucursal destino.
12. Enviar confirmación al cliente con número de pedido.
13. Registrar en auditoría.

**Salidas (Outputs):**
- Pedido creado con número único.
- Items registrados.
- Reservas de inventario creadas.
- Factura proforma generada.
- Carrito limpiado.
- Notificaciones enviadas.
- Registro de auditoría generado.

---

### ID-FUNC-M17-004: Consultar Estado de Pedido

**Descripción General:** Mostrar al cliente el estado actual de sus pedidos, incluyendo historial de cambios y trazabilidad de la entrega.

**Entradas (Inputs):**
- Cliente autenticado
- Identificador del pedido (opcional, o listar todos)

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que el cliente esté activo.
2. Si se proporciona ID específico:
   - Buscar el pedido verificando ownership del cliente
   - Si no existe o no pertenece: retornar error
3. Si no se proporciona ID:
   - Listar todos los pedidos del cliente
   - Filtrar por estado si se especifica
4. Para cada pedido:
   - Obtener datos básicos: número, fecha, total, estado
   - Obtener items del pedido
   - Obtener historial de cambios de estado
   - Calcular fecha estimada de entrega si aplica
   - Obtener información de seguimiento si está en tránsito
5. Retornar información completa con estados posibles:
   - Solicitado, Confirmado, Preparando, Listo, En Tránsito, Entregado, Cancelado

**Salidas (Outputs):**
- Listado de pedidos del cliente.
- Para cada pedido: estado actual, items, totales.
- Historial de cambios de estado.
- Información de seguimiento (si aplica).

---

### ID-FUNC-M17-005: Cancelar Pedido

**Descripción General:** Permitir al cliente cancelar un pedido que aún no ha sido confirmado por la empresa.

**Entradas (Inputs):**
- Cliente autenticado
- Identificador del pedido

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que el pedido exista y pertenezca al cliente.
2. Validar que el estado permita cancelación:
   - Solo se puede cancelar en estado "requested"
3. Si el estado es diferente:
   - Retornar error: "No se puede cancelar un pedido ya confirmado"
4. Si se permite:
   - Liberar reservas de inventario:
     - Marcar inventory_reservations como "cancelled"
     - Restaurar quantity_available
   - Cambiar estado del pedido a "cancelled"
   - Cancelar la factura proforma
5. Enviar notificación a la sucursal.
6. Registrar en auditoría.

**Salidas (Outputs):**
- Pedido cancelado.
- Reservas de inventario liberadas.
- Factura proforma cancelada.
- Notificación enviada a la sucursal.
- Registro de auditoría generado.

---

## M18: GESTIÓN DE CRÉDITOS Y PAGOS

### ID-FUNC-M18-001: Consultar Estado de Cuenta

**Descripción General:** Mostrar al cliente un resumen de su cuenta, incluyendo límite de crédito, saldo utilizado, facturas pendientes y movimientos recientes.

**Entradas (Inputs):**
- Cliente autenticado

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que el cliente esté activo.
2. Obtener datos del credit_account:
   - credit_limit
   - current_credit (saldo utilizado)
   - credit_available = credit_limit - current_credit
   - credit_days
   - credit_score
3. Obtener facturas pendientes:
   - invoices con status "pending_payment" o "payment_pending_verification"
   - Para cada factura: número, fecha, total, saldo, fecha de vencimiento
4. Calcular antigüedad de cartera:
   - Facturas por vencer
   - Facturas vencidas 1-30 días
   - Facturas vencidas 31-60 días
   - Facturas vencidas >60 días
5. Obtener historial de pagos recientes:
   - customer_payments últimos 10
6. Generar resumen consolidado.

**Salidas (Outputs):**
- Resumen de cuenta mostrado.
- Límite y saldo disponible.
- Listado de facturas pendientes con vencimiento.
- Antigüedad de cartera calculada.
- Historial de pagos recientes.

---

### ID-FUNC-M18-002: Registrar Pago de Factura

**Descripción General:** Permitir al cliente registrar un pago realizado fuera del sistema (efectivo, transferencia) para una factura pendiente, incluyendo la carga de comprobante.

**Entradas (Inputs):**
- Cliente autenticado
- Factura(s) a pagar
- Monto del pago
- Método de pago (efectivo, transferencia, Nequi, Daviplata)
- Referencia de la transacción
- Foto del comprobante (opcional)
- Fecha del pago

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que el cliente esté activo.
2. Validar que las facturas existan y pertenezcan al cliente.
3. Verificar que las facturas estén en estado "pending_payment".
4. Validar que el monto no exceda el total pendiente de las facturas.
5. Si se selecciona factura específica:
   - Restringir pago a esas facturas
6. Si es pago general:
   - Aplicar a las facturas más antiguas primero
7. Crear registro en customer_payments:
   - status = "pending_verification"
   - payment_date = fecha proporcionada
   - amount = monto
   - payment_method = método seleccionado
   - reference = referencia
   - proof_url = foto del comprobante si se proporcionó
8. Crear vínculos en customer_payments_invoices.
9. Cambiar estado de las facturas a "payment_pending_verification".
10. Enviar notificación a la sucursal.
11. Registrar en auditoría.

**Salidas (Outputs):**
- Pago registrado con estado pending_verification.
- Vinculación con facturas creada.
- Facturas marcadas como pendientes de verificación.
- Notificación enviada a- Registro de auditoría la sucursal.
 generado.

---

### ID-FUNC-M18-003: Consultar Historial de Pagos

**Descripción General:** Mostrar al cliente el histórico completo de sus pagos, incluyendo pagos verificados, rechazados y pendientes de verificación.

**Entradas (Inputs):**
- Cliente autenticado
- Filtros opcionales: fecha, estado, factura

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que el cliente esté activo.
2. Obtener pagos del cliente con filtros aplicados:
   - customer_payments where customer_id = cliente
3. Para cada pago:
   - Obtener detalles: monto, método, referencia, fecha
   - Obtener estado actual (pending_verification, verified, rejected)
   - Si está verificado: mostrar fecha de verificación
   - Si está rechazado: mostrar motivo
   - Obtener facturas vinculadas
4. Ordenar por fecha descendente.
5. Retornar lista paginada.

**Salidas (Outputs):**
- Listado de pagos del cliente.
- Para cada pago: monto, método, referencia, estado, facturas.
- Indicación de verificación o rechazo.
- Motivo de rechazo (si aplica).

---

## M19: COMUNICACIÓN Y SOPORTE

### ID-FUNC-M19-001: Enviar Mensaje a la Empresa

**Descripción General:** Permitir al cliente enviar un mensaje a la empresa a través del portal, categorizando el motivo y adjuntando información relevante.

**Entradas (Inputs):**
- Cliente autenticado
- Categoría del mensaje (consulta, pedido, problema, otro)
- Asunto
- Mensaje
- Pedido relacionado (opcional)
- Archivo adjunto (opcional)

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que el cliente esté activo.
2. Crear registro en customer_messages:
   - customer_id
   - category
   - subject
   - content
   - order_id si aplica
   - status = "sent"
   - created_at = now()
3. Si hay archivo: guardar en storage y vincular URL.
4. Asignar al equipo correspondiente según categoría:
   - Pedido → Ventas
   - Problema → Soporte
   - Consulta → Administrativo
5. Enviar notificación interna al responsable.
6. Registrar en auditoría.

**Salidas (Outputs):**
- Mensaje enviado y registrado.
- Categorización aplicada.
- Archivo adjuntado (si aplica).
- Notificación interna generada.
- Registro de auditoría generado.

---

### ID-FUNC-M19-002: Crear Ticket de Soporte

**Descripción General:** Registrar una solicitud de soporte técnico o comercial desde el portal del cliente.

**Entradas (Inputs):**
- Cliente autenticado
- Categoría (técnico, facturación, pedido, otro)
- Prioridad (baja, media, alta)
- Descripción del problema
- Archivos adjuntos (capturas de pantalla)

**Acciones del Sistema (Pasos Operativos):**
1. Verificar que el cliente esté activo.
2. Generar número de ticket: TKT-CLI-YYYY-00000.
3. Crear registro en support_tickets:
   - ticket_number
   - customer_id
   - category
   - priority
   - description
   - status = "open"
   - created_at = now()
4. Asignar al equipo correspondiente:
   - Por categoría (routing automático)
   - Por disponibilidad (round-robin)
5. Adjuntar archivos si los hay.
6. Notificar al equipo asignado.
7. Enviar confirmación al cliente con número de ticket.
8. Registrar en auditoría.

**Salidas (Outputs):**
- Ticket creado con número único.
- Asignación determinada.
- Archivos adjuntos guardados.
- Notificación al equipo.
- Confirmación al cliente.
- Registro de auditoría generado.

---

### ID-FUNC-M19-003: Consultar Base de Ayuda

**Descripción General:** Proporcionar al cliente acceso a artículos de ayuda, tutoriales y FAQs para resolver dudas comunes sin necesidad de contactar soporte.

**Entradas (Inputs):**
- Cliente autenticado (opcional)
- Término de búsqueda (opcional)
- Categoría de artículo (opcional)

**Acciones del Sistema (Pasos Operativos):**
1. Si hay término de búsqueda:
   - Buscar en títulos y contenido de artículos
   - Ordenar por relevancia y popularidad
2. Si hay categoría:
   - Filtrar artículos de esa categoría
3. Para cada artículo encontrado:
   - Verificar que esté publicado y activo
   - Obtener métricas: vistas, útiles, última actualización
4. Retornar resultados con:
   - Título
   - Extracto del contenido
   - Categoría
   - Última actualización
   - Indicador de popularidad

**Salidas (Outputs):**
- Artículos encontrados según búsqueda/filtrado.
- Extractos y metadatos incluidos.
- Artículos sugeridos por contexto.

---

## M20: NOTIFICACIONES Y ALERTAS

### ID-FUNC-M20-001: Recibir Notificación de Cambio de Estado

**Descripción General:** Entregar al cliente una notificación cuando cambia el estado de su pedido, manteniendo comunicación proactiva sobre el avance.

**Entradas (Inputs):**
- Identificador del pedido
- Nuevo estado
- Datos adicionales (hora estimada, repartidor, etc.)

**Acciones del Sistema (Pasos Operativos):**
1. Obtener datos del pedido y cliente.
2. Generar mensaje según el nuevo estado:
   - "Tu pedido #[número] ha sido confirmado"
   - "Tu pedido está siendo preparado"
   - "Tu pedido está listo para recoger/enviar"
   - "Tu pedido está en camino"
   - "Tu pedido ha sido entregado"
3. Agregar información adicional según estado:
   - En tránsito: hora estimada, datos del repartidor
   - Entregado: instrucciones de confirmación
4. Enviar notificación por el canal preferido del cliente:
   - Push notification si tiene la app
   - Email si está configurado
   - WhatsApp si está configurado
5. Registrar envío en notifications_log.

**Salidas (Outputs):**
- Notificación compuesta según estado.
- Envío por canal preferido.
- Registro de envío generado.

---

### ID-FUNC-M20-002: Alertar Sobre Pago Verificado

**Descripción General:** Informar al cliente que su pago ha sido verificado y confirmado, reduciendo su saldo pendiente.

**Entradas (Inputs):**
- Identificador del pago verificado
- Monto verificado
- Factura(s) pagadas

**Acciones del Sistema (Pasos Operativos):**
1. Obtener datos del pago y cliente.
2. Generar mensaje de confirmación:
   - "Tu pago de $[monto] ha sido verificado exitosamente"
   - "Tu saldo pendiente se ha reducido en $[monto]"
   - "Gracias por tu compra"
3. Enviar notificación por email/WhatsApp.
4. Registrar en notifications_log.

**Salidas (Outputs):**
- Notificación de confirmación compuesta.
- Envío realizado.
- Registro de envío generado.

---

# ANEXO: ÍNDICE DE FUNCIONALIDADES POR PLATAFORMA

## Plataforma 1: Admin QFlow Pro (M1-M5)
| Módulo | Funcionalidades |
|--------|-----------------|
| Gestión de Clientes | M1-001 a M1-008 |
| Licencias y Planes | M2-001 a M2-005 |
| Facturación SaaS | M3-001 a M3-003 |
| Soporte Técnico | M4-001 a M4-004 |
| Métricas y Reportes | M5-001 a M5-003 |

## Plataforma 2: Portal Empresarial (M6-M15)
| Módulo | Funcionalidades |
|--------|-----------------|
| Sucursales y Configuración | M6-001 a M6-004 |
| Catálogo y Precios | M7-001 a M7-007 |
| Inventario y Lotes | M8-001 a M8-008 |
| Compras a Proveedores | M9-001 a M9-004 |
| Ventas y POS | M10-001 a M10-004 |
| Control de Caja | M11-001 a M11-004 |
| Pedidos del Portal | M12-001 a M12-005 |
| Contabilidad | M13-001 a M13-005 |
| Créditos a Clientes | M14-001 a M14-003 |
| Recursos Humanos | M15-001 a M15-003 |

## Plataforma 3: App Cliente Final (M16-M20)
| Módulo | Funcionalidades |
|--------|-----------------|
| Registro y Acceso | M16-001 a M16-004 |
| Catálogo y Pedidos | M17-001 a M17-005 |
| Créditos y Pagos | M18-001 a M18-003 |
| Comunicación y Soporte | M19-001 a M19-003 |
| Notificaciones | M20-001 a M20-002 |

---

**FIN DEL DOCUMENTO**

*Este documento define el catálogo completo de funcionalidades operativas para las tres plataformas del ecosistema QFlow Pro. Cada funcionalidad describe las entradas, acciones del sistema y salidas, sin dependencia de interfaces específicas.*
