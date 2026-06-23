# Servicios

> Fuente: tabla de microservicios definida para el laboratorio

Indice navegable de los 9 microservicios reales. Esta carpeta ayuda a abrir cada servicio sin perder de vista la tabla principal.

| Servicio | BD | Entidades que posee | Componentes desplegables |
|---|---|---|---|
| [iam-service](./01-iam-service/README.md) | iam_db | usuario, rol, permiso, sesion, token | iam-api |
| [reference-data-service](./02-reference-data-service/README.md) | ref_db | macroregion -> centro_formacion, catalogo, estado, parametro | reference-data-api |
| [academic-management-service](./03-academic-management-service/README.md) | academic_db | programa, competencia, RAP, ficha, oferta | academic-management-api |
| [training-environment-service](./04-training-environment-service/README.md) | env_db | ambiente, inventario, mantenimiento, reserva, disponibilidad | training-environment-api |
| [scheduling-service](./05-scheduling-service/README.md) | scheduling_db | horario, sesion_clase, franja, asignacion, conflicto | schedules-api; scheduling-engine-workflow; conflict-validator-worker |
| [actors-service](./06-actors-service/README.md) | actors_db | instructor, aprendiz, empresa, etapa_productiva, bitacora | actors-api |
| [document-service](./07-document-service/README.md) | document_db | documento, version, plantilla | document-api; template-api; pdf-renderer-worker; document-lifecycle-worker |
| [monitoring-service](./08-monitoring-service/README.md) | monitoring_db | seguimiento_kpi, alerta, notificacion, sesion_seguimiento, plan_mejoramiento | monitoring-api; alert-worker; notification-worker |
| [audit-service](./09-audit-service/README.md) | audit_db | auditoria (append-only, sin updates) | audit-worker |

## Total

9 servicios, 17 componentes desplegables.


