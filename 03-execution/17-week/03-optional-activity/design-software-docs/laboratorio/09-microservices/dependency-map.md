# Mapa de dependencias entre servicios

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Documentacion

## Dependencias por servicio

### iam-service
- **Depende de:** Reference Data (validar roles/permisos globales)
- **Lo usan:** TODOS los servicios (transversal)
- **Crítico:** SÍ

### reference-data-service
- **Depende de:** Ninguno
- **Lo usan:** Todos (centros, parámetros)
- **Crítico:** SÍ

### academic-management-service
- **Depende de:** Reference Data
- **Lo usan:** Scheduling (RAPs, programas), Actors, Monitoring
- **Crítico:** SÍ

### training-environment-service
- **Depende de:** Reference Data
- **Lo usan:** Scheduling (disponibilidad ambientes)
- **Crítico:** SÍ

### scheduling-service (CORE)
- **Depende de:** Academic, Actors, Training Environment, Reference Data
- **Lo usan:** Monitoring, Documents, Audit
- **Crítico:** SÍ

### actors-service
- **Depende de:** Reference Data
- **Lo usan:** Scheduling, Monitoring, Documents
- **Crítico:** SÍ

### document-service
- **Depende de:** Academic, Actors, Scheduling, Reference Data
- **Lo usan:** Ninguno (solo consultas)
- **Crítico:** NO

### monitoring-service
- **Depende de:** Scheduling, Academic, Actors, Reference Data
- **Lo usan:** Dashboard, Alerts
- **Crítico:** NO

### audit-service
- **Depende de:** Ninguno (solo escucha eventos)
- **Lo usan:** Reporting, Compliance
- **Crítico:** NO

## Matiz de dependencias

```
┌─────────────────────────────────────────────────────────────┐
│                    TRANSVERSAL                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │          IAM (Autenticación & Autorización)         │   │
│  └────────────────────┬─────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘

┌──────────────────────────┐
│  REFERENCE DATA (Base)   │  ← Ninguno depende arriba
│   Centros, Parámetros    │
└─────────────┬────────────┘
              │
    ┌─────────┼─────────┬─────────┐
    │         │         │         │
    ↓         ↓         ↓         ↓
┌────────┐ ┌──────┐ ┌──────┐ ┌───────┐
│Academic│ │Actors│ │  Env │ │Audit  │
└───┬────┘ └──┬───┘ └───┬──┘ └───────┘
    │         │         │
    └─────────┼─────────┘
              ↓
         ┌─────────────┐
         │ SCHEDULING  │ (Core)
         │ (Motor)     │
         └──────┬──────┘
                │
    ┌───────────┼───────────┬─────────┐
    │           │           │         │
    ↓           ↓           ↓         ↓
┌──────┐    ┌────────┐  ┌─────────┐ ┌──────┐
│Monitoring
│ │Documents│ │Notifications
│ │Reporting│
└──────┘    └────────┘  └─────────┘ └──────┘
```

## Tabla de criticidad

| Servicio | Criticidad | Impacto si cae |
|----------|-----------|------------------|
| reference-data | CRÍTICA | Toda operación se bloquea |
| iam | CRÍTICA | Ningún acceso permitido |
| scheduling | CRÍTICA | No se pueden asignar horarios |
| academic | CRÍTICA | No se pueden validar competencias |
| actors | CRÍTICA | No se pueden consultar instructores/aprendices |
| training-environment | CRÍTICA | No se valida disponibilidad de ambientes |
| audit | IMPORTANTE | Operaciones continúan, pero sin registro |
| monitoring | IMPORTANTE | Operaciones continúan, alertas retrasadas |
| document | IMPORTANTE | Generación de documentos se retrasa |

## Patrones de comunicación entre dependencias

- **Reference Data → (todos):** REST (consultas cacheds)
- **IAM → (todos):** Tokens JWT validados localmente
- **Scheduling ← (académico, actores, ambiente):** gRPC síncrono (< 100ms)
- **Audit ← (todos):** Eventos asincronos (at-least-once)
- **Monitoring ← (scheduling):** Eventos asincronos + logs
- **Documents ← (scheduling, académico):** Eventos asincronos

