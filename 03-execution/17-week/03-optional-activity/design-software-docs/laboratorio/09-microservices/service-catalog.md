# Catalogo de servicios

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Fuente: tabla de microservicios definida para el laboratorio

Registro centralizado de los microservicios que se van a trabajar. Cada servicio tiene una base de datos propia y es dueno de las entidades listadas.

## Servicios y entidades

| Servicio | BD | Entidades que posee | Componentes desplegables |
|---|---|---|---|
| [iam-service](./services/01-iam-service/README.md) | iam_db | usuario, rol, permiso, sesion, token | iam-api |
| [reference-data-service](./services/02-reference-data-service/README.md) | ref_db | macroregion -> centro_formacion, catalogo, estado, parametro | reference-data-api |
| [academic-management-service](./services/03-academic-management-service/README.md) | academic_db | programa, competencia, RAP, ficha, oferta | academic-management-api |
| [training-environment-service](./services/04-training-environment-service/README.md) | env_db | ambiente, inventario, mantenimiento, reserva, disponibilidad | training-environment-api |
| [scheduling-service](./services/05-scheduling-service/README.md) | scheduling_db | horario, sesion_clase, franja, asignacion, conflicto | schedules-api; scheduling-engine-workflow; conflict-validator-worker |
| [actors-service](./services/06-actors-service/README.md) | actors_db | instructor, aprendiz, empresa, etapa_productiva, bitacora | actors-api |
| [document-service](./services/07-document-service/README.md) | document_db | documento, version, plantilla | document-api; template-api; pdf-renderer-worker; document-lifecycle-worker |
| [monitoring-service](./services/08-monitoring-service/README.md) | monitoring_db | seguimiento_kpi, alerta, notificacion, sesion_seguimiento, plan_mejoramiento | monitoring-api; alert-worker; notification-worker |
| [audit-service](./services/09-audit-service/README.md) | audit_db | auditoria (append-only, sin updates) | audit-worker |

## Total

9 servicios, 17 componentes desplegables.

## Componentes desplegables por servicio

### iam-service
- iam-api

### reference-data-service
- reference-data-api

### academic-management-service
- academic-management-api

### training-environment-service
- training-environment-api

### scheduling-service
- schedules-api
- scheduling-engine-workflow
- conflict-validator-worker

### actors-service
- actors-api

### document-service
- document-api
- template-api
- pdf-renderer-worker
- document-lifecycle-worker

### monitoring-service
- monitoring-api
- alert-worker
- notification-worker

### audit-service
- audit-worker

## Reglas base

- Cada servicio escribe solo en su propia BD.
- Las entidades de esta tabla son propiedad canonica del servicio indicado.
- audit-service es append-only: registra auditoria sin updates sobre registros historicos.
- Las integraciones entre servicios se documentan en dependency-map.md, event-catalog.md y communication-patterns.md.

