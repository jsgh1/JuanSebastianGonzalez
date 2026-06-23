# Requisitos no funcionales

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Arquitectura / Calidad

| ID | Categoria | Requisito | Criterio |
|---|---|---|---|
| RNF-001 | Seguridad | Toda API protegida debe validar JWT y permisos. | Requests no autorizados responden 401 o 403 |
| RNF-002 | Trazabilidad | Toda operacion critica debe generar auditoria. | audit-service recibe evento o registro |
| RNF-003 | Disponibilidad | Servicios core deben exponer health checks. | /health y /ready disponibles |
| RNF-004 | Rendimiento | Consultas de horario deben responder rapido. | p95 menor a 3 segundos |
| RNF-005 | Escalabilidad | Workers deben procesar tareas pesadas asincronamente. | Colas para PDF, alertas y validaciones pesadas |
| RNF-006 | Mantenibilidad | Contratos y modelos deben estar documentados. | README, API, datos y eventos actualizados |
| RNF-007 | Integridad | Ningun servicio escribe en BD de otro servicio. | Revisiones de arquitectura y pruebas |
| RNF-008 | Recuperacion | Bases de datos deben tener backup y plan de restauracion. | RPO menor a 1h, RTO menor a 4h |

