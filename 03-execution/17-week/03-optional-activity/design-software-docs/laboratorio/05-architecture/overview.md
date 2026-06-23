# Vista general de arquitectura

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Arquitectura

## Estilo arquitectonico

El sistema se organiza como microservicios orientados a dominio. Cada servicio posee su base de datos y expone capacidades mediante API, eventos o workers.

## Servicios

- iam-service: seguridad y sesiones.
- reference-data-service: datos de referencia.
- academic-management-service: gestion academica.
- training-environment-service: ambientes y disponibilidad.
- scheduling-service: motor central de horarios.
- actors-service: instructores, aprendices y empresas.
- document-service: documentos y plantillas.
- monitoring-service: KPIs, alertas y seguimiento.
- audit-service: auditoria append-only.

## Principios

- Database per service.
- Comunicacion asincrona cuando el proceso no requiere respuesta inmediata.
- Contratos API versionados.
- Auditoria de operaciones criticas.
- Separacion clara de responsabilidades.

