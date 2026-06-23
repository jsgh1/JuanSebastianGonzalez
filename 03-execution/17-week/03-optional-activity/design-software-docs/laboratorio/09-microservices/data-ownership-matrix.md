# Matriz de propiedad de datos

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Documentacion

## Principio

Cada servicio es **dueño canónico** de sus datos. Otros servicios pueden consultar pero no modificar directamente. Mantener consistencia mediante eventos.

## Matriz de responsabilidades

| Dominio/Entidad | Dueño | Consulta | Replicas |  |
|---|---|---|---|---|
| **IAM** | | | | |
| Usuario | iam-service | todos | ninguna | |
| Rol | iam-service | todos | ninguna | |
| Permiso | iam-service | todos | ninguna | |
| Sesión | iam-service | iam-service | ninguna | |
| Token | iam-service | iam-service | ninguna | |
| **Reference Data** | | | | |
| Centro | ref-data-service | todos | caché (24h) | |
| Región | ref-data-service | todos | caché (24h) | |
| Parámetro | ref-data-service | todos | caché (1h) | |
| **Académico** | | | | |
| Programa | academic-service | todos | scheduling | |
| Competencia | academic-service | todos | scheduling, actors | |
| RAP | academic-service | todos | scheduling, document | |
| Ficha | academic-service | todos | scheduling, actors, monitoring | |
| Oferta | academic-service | academic | ninguna | |
| **Ambientes** | | | | |
| Ambiente | env-service | todos | scheduling (caché) | |
| Disponibilidad | env-service | scheduling, monitoring | ninguna | |
| Inventario | env-service | env-service | ninguna | |
| Mantenimiento | env-service | scheduling | ninguna | |
| **Scheduling** | | | | |
| Horario | scheduling-service | todos | monitoring, document | |
| Sesión de clase | scheduling-service | todos | monitoring, document | |
| Conflicto | scheduling-service | scheduling, monitoring | ninguna | |
| Franja horaria | scheduling-service | todos | caché (24h) | |
| **Actores** | | | | |
| Instructor | actors-service | todos | scheduling, monitoring | |
| Aprendiz | actors-service | todos | academic, scheduling | |
| Empresa | actors-service | todos | academic | |
| Etapa productiva | actors-service | academic | ninguna | |
| **Documentos** | | | | |
| Plantilla | document-service | document-service | ninguna | |
| Documento | document-service | document-service | ninguna | |
| Versión | document-service | document-service | ninguna | |
| **Monitoreo** | | | | |
| KPI | monitoring-service | todos | caché (1h) | |
| Alerta | monitoring-service | monitoring, usuarios | ninguna | |
| Notificación | monitoring-service | usuarios | ninguna | |
| **Auditoría** | | | | |
| Registro | audit-service | audit, compliance | ninguna (append-only) | |

## Reglas de acceso a datos

### Permisos de lectura

```
┌─────────────────────────────────────────────────────────────┐
│  Acceso de solo lectura a datos de otros servicios          │
├─────────────────────────────────────────────────────────────┤
│ Servicio A puede LEER datos de Servicio B:                  │
│  • Vía REST: GET /api/v1/resource/{id}                      │
│  • Vía gRPC: ReadRequest(resourceId)                        │
│  • Vía replicación: Escuchando eventos de Servicio B        │
└─────────────────────────────────────────────────────────────┘
```

### Prohibiciones

- ❌ **No UPDATE/DELETE directo:** `PATCH /academic-service/fichas/{id}` desde scheduling-service
- ❌ **No raw SQL:** Escribir directamente en BD de otro servicio
- ❌ **No compartir conexiones:** Cada servicio tiene su pool de conexiones
- ❌ **No consultas cross-service en transacción:** Las transacciones distribuidas no son permitidas

### Modificación de datos de otros servicios

Si el Servicio A necesita que el Servicio B modifique sus datos:

```
┌────────────┐                 ┌──────────────────┐
│ Servicio A │  Publica evento │  Servicio B      │
│            │  \"EntidadCreada\"│  (escucha)       │
└────────────┘                 │  Replica o cache │
                               └──────────────────┘

O:

┌────────────┐                 ┌──────────────────┐
│ Servicio A │  POST/PUT/DELETE │  API Servicio B  │
│            │  solicitud       │  (expone endpoint)│
└────────────┘                 └──────────────────┘
```

## Ejemplos de interacciones

### Ejemplo 1: Scheduling consulta competencias

```
schedule-api recibe: POST /schedules
  - fichaId: F123
  - instructorId: I456
  - rapId: R789

Acción:
  1. Lee academic_db (caché local replicada)
  2. Valida que RAP existe y está activo
  3. Si caché es viejo, consulta via gRPC:
     GetRap(rapId) → academic-service
  4. Crea horario si válido
  5. Publica HorarioAsignado
```

### Ejemplo 2: Monitoring obtiene datos consolidados

```
monitoring-service recibe: GET /kpis?centro=C001&fecha=2026-06-22

Acción:
  1. Consulta monitoring_db (KPIs pre-calculados)
  2. Si no está en caché o está stale:
     a. GetFichas(centro) → academic-service
     b. GetHorarios(fichas) → scheduling-service  
     c. GetInstructores(fichas) → actors-service
     d. Calcula KPIs
     e. Guarda en BD local
  3. Responde con KPIs
```

### Ejemplo 3: Document service genera certificado

```
document-service recibe: POST /documents/certificates
  - fichaId: F123
  - aprendizId: A456

Acción:
  1. Lee plantilla local (certificate_template_v2.docx)
  2. Consulta datos necesarios (read-only):
     a. GetFicha(F123) → academic-service
     b. GetAprendiz(A456) → actors-service
     c. GetRAPsCompletados(A456, F123) → scheduling-service
  3. Renderiza PDF
  4. Guarda en cloud storage
  5. Crea registro Document en BD local
  6. Publica DocumentoGenerado
  7. Responde con URL descargable
```

## Sincronización de datos

### Caché distribuido

Datos que pueden cachear otros servicios:

| Dato | TTL | Actualización | Cambio crítico? |
|------|-----|---|---|
| Centros | 24h | Evento ParametroActualizado | No |
| Parámetros | 1h | Evento ParametroActualizado | Sí (purga inmediata) |
| Competencias | 4h | Evento CompetenciaModificada | Sí (purga inmediata) |
| Instructores (disponibilidad) | 30m | Evento InstructorModificado | Sí (purga inmediata) |
| Ambientes (capacidad) | 4h | Evento AmbienteModificado | No |

### Patrón de invalidación de caché

```
Academic-service modifica Competencia
  ↓
Publica CompetenciaModificada
  ↓
Scheduling-service escucha → invalida caché local
Monitoring-service escucha → invalida caché local
Document-service escucha → invalida caché local
```"

