# Matriz de trazabilidad

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Analisis / Calidad

| Requisito | Historia | Servicio | Prueba sugerida |
|---|---|---|---|
| RF-001 | HU-001 | iam-service | Login, permisos, expiracion de token |
| RF-002 | HU-002 | reference-data-service | CRUD de parametros y centro_formacion |
| RF-003 | HU-002 | academic-management-service | Crear ficha con programa y RAP validos |
| RF-004 | HU-003 | training-environment-service | Reserva y bloqueo por mantenimiento |
| RF-005 | HU-004 | scheduling-service | Crear horario sin conflicto |
| RF-006 | HU-004 | scheduling-service | Detectar solapamiento de franja |
| RF-007 | HU-005, HU-006 | actors-service | Consultar instructor y aprendiz |
| RF-008 | HU-007 | document-service | Generar PDF desde plantilla |
| RF-009 | HU-008 | monitoring-service | Calcular KPI y generar alerta |
| RF-010 | Todas | audit-service | Verificar registro append-only |

