# Mapa de dominio

> Estado: En progreso En progreso | Última actualización: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Documentacion

## Contextos acotados principales

El sistema **Horarios SENA** se divide en 9 contextos de dominio alineados con la arquitectura de microservicios:

### 1. **IAM** (Identity & Access Management)
- **Responsabilidad:** Autenticación, autorización y gestión de sesiones
- **Entidades:** Usuario, Rol, Permiso, Sesión, Token
- **Lenguaje ubicuo:** credenciales, acesso, sesión activa

### 2. **Datos de referencia** (Reference Data)
- **Responsabilidad:** Estructura institucional y catálogos compartidos
- **Entidades:** Macroregión, Centro, Formación, Parámetro, Catalizador
- **Lenguaje ubicuo:** jurisdicción, locación, catálogo

### 3. **Ambientes** (Training Environment)
- **Responsabilidad:** Gestión de espacios físicos y recursos
- **Entidades:** Ambiente, Inventario, Mantenimiento, Reserva, Disponibilidad
- **Lenguaje ubicuo:** aula, laboratorio, capacidad, disponible

### 4. **Formación académica** (Academic Management)
- **Responsabilidad:** Estructura curricular y fichas de formación
- **Entidades:** Programa, Competencia, RAP, Ficha, Oferta
- **Lenguaje ubicuo:** competencia, resultado de aprendizaje, ficha

### 5. **Actores** (Actors)
- **Responsabilidad:** Personas involucradas en formación
- **Entidades:** Instructor, Aprendiz, Empresa, Etapa Productiva, Bitácora
- **Lenguaje ubicuo:** formador, estudiante, empresario, práctica

### 6. **Programación** (Scheduling)
- **Responsabilidad:** Asignación y validación de horarios
- **Entidades:** Horario, Sesión de clase, Franja, Asignación, Conflicto
- **Lenguaje ubicuo:** programación, bloque horario, colisión, válido

### 7. **Monitoreo** (Monitoring)
- **Responsabilidad:** KPIs, alertas y notificaciones
- **Entidades:** Seguimiento KPI, Alerta, Notificación, Sesión de seguimiento, Plan de mejoramiento
- **Lenguaje ubicuo:** métrica, umbral, anomalía, mejora

### 8. **Documentos** (Documents) — *Transversal*
- **Responsabilidad:** Ciclo de vida de documentos y plantillas
- **Entidades:** Documento, Versión, Plantilla, Ciclo de vida
- **Lenguaje ubicuo:** plantilla, generación, PDF, ciclo de vida

### 9. **Auditoría** (Audit) — *Transversal*
- **Responsabilidad:** Registro inmutable de operaciones
- **Entidades:** Registro de auditoría (append-only)
- **Lenguaje ubicuo:** evento, traza, no modificable, completo

## Mapa de interacciones

```
┌─────────────────────────────────────────────┐
│           SCHEDULING (Core)                  │ ← Motor de asignación
│     [Horarios, Sesiones, Conflictos]        │
└────────┬────────────────────────────┬────────┘
         │                            │
    Usa de →                      ← Consulta
         │                            │
    ┌────┴─────┐  ┌────────┐  ┌──────┴──────┐
    │  ACADEMIC │  │ ACTORS │  │ ENVIRONMENT│
    │  MGMT     │  │        │  │             │
    └──────┬────┘  └───┬────┘  └──────┬──────┘
           │           │              │
           └─────┬─────┴──────┬───────┘
                 │            │
           REFERENCE DATA ←──┘
           [Centros, Parámetros]
                 │
           Respalda ↓
          IAM [Usuarios, Roles]
                 │
           ┌──────┴──────┐
           │  DOCUMENTS  │
           │  + AUDIT    │
           │ (Transversal)│
           └─────────────┘
                 ↑
       MONITORING recibe
           eventos de:
        SCHEDULING + otros
```

## Supuestos del mapa

1. Cada contexto tiene su propia base de datos (Database per Service)
2. La comunicación entre contextos es principalmente asíncrona (eventos)
3. Scheduling es el contexto central; otros lo respaldan
4. IAM es transversal: todos lo usan para autenticación
5. Audit registra operaciones de todos los contextos

