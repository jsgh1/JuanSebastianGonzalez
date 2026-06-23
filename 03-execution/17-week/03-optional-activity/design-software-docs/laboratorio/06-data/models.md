# Modelos de datos

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Datos / Arquitectura

## Modelos por servicio

| Servicio | BD | Entidades |
|---|---|---|
| iam-service | iam_db | usuario, rol, permiso, sesion, token |
| reference-data-service | ref_db | macroregion, centro_formacion, catalogo, estado, parametro |
| academic-management-service | academic_db | programa, competencia, RAP, ficha, oferta |
| training-environment-service | env_db | ambiente, inventario, mantenimiento, reserva, disponibilidad |
| scheduling-service | scheduling_db | horario, sesion_clase, franja, asignacion, conflicto |
| actors-service | actors_db | instructor, aprendiz, empresa, etapa_productiva, bitacora |
| document-service | document_db | documento, version, plantilla |
| monitoring-service | monitoring_db | seguimiento_kpi, alerta, notificacion, sesion_seguimiento, plan_mejoramiento |
| audit-service | audit_db | auditoria |

## Regla base

Cada modelo se modifica solo desde el servicio propietario. Las relaciones entre servicios se resuelven por identificadores, APIs o eventos.

