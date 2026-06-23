# Roadmap

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Producto

## Fases

| Fase | Objetivo | Entregables |
|---|---|---|
| 1. Base documental | Alinear vision, alcance, dominio y microservicios | Contexto, dominio, catalogo de servicios |
| 2. Requerimientos | Definir necesidades funcionales y no funcionales | Historias, requisitos, trazabilidad |
| 3. Arquitectura y datos | Definir estructura tecnica y modelo de datos | Arquitectura, modelos, diccionario, migraciones |
| 4. Contratos | Formalizar API, autenticacion y reglas de integracion | OpenAPI, guidelines, eventos |
| 5. Construccion | Implementar servicios core | IAM, reference-data, academic, actors, environment, scheduling |
| 6. Operacion | Preparar monitoreo, backup, incidentes y capacitacion | Runbooks, observabilidad, manuales |

## Prioridad de servicios

1. iam-service y reference-data-service.
2. academic-management-service, actors-service y training-environment-service.
3. scheduling-service.
4. document-service, monitoring-service y audit-service.

## Criterios de avance

- Cada fase debe tener documentos en estado En progreso o Estable.
- Cada servicio debe tener entidades, BD, componentes y dependencias claras.
- Cada requisito funcional debe mapearse a servicio y prueba.

