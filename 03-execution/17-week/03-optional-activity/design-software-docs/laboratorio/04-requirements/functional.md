# Requisitos funcionales

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Analisis

| ID | Requisito | Servicio principal | Prioridad |
|---|---|---|---|
| RF-001 | El sistema debe autenticar usuarios y validar permisos por rol. | iam-service | Alta |
| RF-002 | El sistema debe administrar centros de formacion, catalogos, estados y parametros. | reference-data-service | Alta |
| RF-003 | El sistema debe gestionar programas, competencias, RAP, fichas y oferta academica. | academic-management-service | Alta |
| RF-004 | El sistema debe registrar ambientes, inventario, mantenimiento, reservas y disponibilidad. | training-environment-service | Alta |
| RF-005 | El sistema debe crear horarios por ficha, instructor, ambiente y franja. | scheduling-service | Critica |
| RF-006 | El sistema debe detectar conflictos de horario, ambiente, instructor o franja. | scheduling-service | Critica |
| RF-007 | El sistema debe gestionar instructores, aprendices, empresas, etapa productiva y bitacora. | actors-service | Alta |
| RF-008 | El sistema debe generar documentos desde plantillas versionadas. | document-service | Media |
| RF-009 | El sistema debe calcular KPIs, alertas, sesiones de seguimiento y planes de mejoramiento. | monitoring-service | Media |
| RF-010 | El sistema debe registrar auditoria append-only de operaciones relevantes. | audit-service | Alta |

