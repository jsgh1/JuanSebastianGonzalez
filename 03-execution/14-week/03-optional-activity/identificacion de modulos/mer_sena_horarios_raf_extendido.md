# Modelo Entidad-Relacion (MER) - Sistema Academico SENA para Gestion de Horarios y RAF

## 1. Objetivo

Disenar un Modelo Entidad-Relacion para un sistema academico del SENA enfocado en:

- Gestion de lineas tecnologicas
- Gestion de programas de formacion
- Gestion de fichas o grupos
- Gestion de RAF
- Gestion de instructores
- Gestion de ambientes
- Gestion de horarios
- Gestion de observaciones
- Gestion de seguridad y configuracion

Este MER consolida la documentacion revisada en las carpetas del workspace y deja visibles las entidades tecnicas que aparecen repetidamente en los archivos base:

- `instructor`
- `environment`
- `training_group`
- `schedule`
- `observation`
- `classroom`
- `student_group`
- `room`
- `schedule_block`

---

## 2. Principio de modelado

Para evitar malas practicas, cada modulo debe tener:

- entidades maestras
- entidades transaccionales
- tablas pivote
- entidades de trazabilidad o historico cuando aplique

Ademas, algunas entidades encontradas en los archivos base son equivalentes funcionales entre si. En este documento se conservan como entidades tecnicas visibles para mantener compatibilidad documental, pero se aclara su rol dentro del modelo.

---

## 3. Modulos y entidades

## 3.1. Modulo de Seguridad

Responsable de autenticacion, autorizacion, sesiones y auditoria.

### Entidades

- `user`
- `role`
- `permission`
- `user_role`
- `role_permission`
- `audit_log`
- `session`

## 3.2. Modulo de Configuracion

Responsable de catalogos maestros y parametros globales.

### Entidades

- `system_configuration`
- `instructor_type`
- `raf_type`
- `call_type`
- `schedule_rule`
- `academic_term`
- `journey`
- `day_catalog`

## 3.3. Modulo de Estructura Academica

Responsable de la estructura institucional y academica.

### Entidades

- `technology_line`
- `training_program`
- `call`
- `training_group`
- `student_group`

## 3.4. Modulo de RAF

Responsable de resultados de aprendizaje y sus reglas de comparticion.

### Entidades

- `raf`
- `training_program_raf`
- `training_group_raf`
- `raf_extension`
- `raf_assignment_rule`

## 3.5. Modulo de Instructores

Responsable del maestro de instructores, su vinculacion y su capacidad operativa.

### Entidades

- `instructor`
- `instructor_technology_line`
- `instructor_raf`
- `instructor_availability`
- `instructor_workload`

## 3.6. Modulo de Ambientes

Responsable de la gestion de espacios fisicos y logicos.

### Entidades

- `environment`
- `classroom`
- `room`
- `environment_type`
- `environment_availability`

## 3.7. Modulo de Horarios

Responsable de la planeacion, asignacion y validacion de horarios.

### Entidades

- `schedule`
- `schedule_block`
- `schedule_conflict`
- `schedule_change_log`

## 3.8. Modulo de Observaciones y Seguimiento

Responsable de registrar observaciones academicas y operativas.

### Entidades

- `observation`
- `observation_type`
- `observation_attachment`

## 3.9. Modulo de Reportes e Integracion

Responsable de exposicion de datos, eventos e interoperabilidad.

### Entidades

- `integration_event`
- `export_job`
- `report_snapshot`

---

## 4. Entidades principales del MER

## 4.1. Modulo de Seguridad

### Entidad: `user`

| Campo | Tipo | Restriccion |
|---|---|---|
| user_id | UUID | PK |
| username | VARCHAR(100) | UNIQUE, NOT NULL |
| email | VARCHAR(150) | UNIQUE, NOT NULL |
| password_hash | VARCHAR(255) | NOT NULL |
| status | BOOLEAN | DEFAULT TRUE |
| created_at | TIMESTAMP | NOT NULL |

### Entidad: `role`

| Campo | Tipo | Restriccion |
|---|---|---|
| role_id | UUID | PK |
| code | VARCHAR(50) | UNIQUE |
| name | VARCHAR(100) | NOT NULL |
| description | TEXT | NULL |

### Entidad: `permission`

| Campo | Tipo | Restriccion |
|---|---|---|
| permission_id | UUID | PK |
| code | VARCHAR(100) | UNIQUE |
| name | VARCHAR(150) | NOT NULL |

### Entidad: `user_role`

| Campo | Tipo | Restriccion |
|---|---|---|
| user_role_id | UUID | PK |
| user_id | UUID | FK |
| role_id | UUID | FK |

### Entidad: `role_permission`

| Campo | Tipo | Restriccion |
|---|---|---|
| role_permission_id | UUID | PK |
| role_id | UUID | FK |
| permission_id | UUID | FK |

### Entidad: `audit_log`

| Campo | Tipo | Restriccion |
|---|---|---|
| audit_log_id | UUID | PK |
| user_id | UUID | FK |
| module_name | VARCHAR(100) | NOT NULL |
| action_name | VARCHAR(100) | NOT NULL |
| detail | TEXT | NULL |
| event_at | TIMESTAMP | NOT NULL |

### Entidad: `session`

| Campo | Tipo | Restriccion |
|---|---|---|
| session_id | UUID | PK |
| user_id | UUID | FK |
| token_hash | VARCHAR(255) | NOT NULL |
| started_at | TIMESTAMP | NOT NULL |
| expires_at | TIMESTAMP | NOT NULL |
| status | VARCHAR(30) | NOT NULL |

---

## 4.2. Modulo de Configuracion

### Entidad: `system_configuration`

| Campo | Tipo | Restriccion |
|---|---|---|
| configuration_id | UUID | PK |
| config_key | VARCHAR(100) | UNIQUE |
| config_value | TEXT | NOT NULL |
| description | TEXT | NULL |

### Entidad: `instructor_type`

| Campo | Tipo | Restriccion |
|---|---|---|
| instructor_type_id | UUID | PK |
| code | VARCHAR(50) | UNIQUE |
| name | VARCHAR(100) | NOT NULL |

Valores:

- `PLANTA`
- `CONTRATISTA`

### Entidad: `raf_type`

| Campo | Tipo | Restriccion |
|---|---|---|
| raf_type_id | UUID | PK |
| code | VARCHAR(50) | UNIQUE |
| name | VARCHAR(100) | NOT NULL |

Valores:

- `TECNICO`
- `TRANSVERSAL`

### Entidad: `call_type`

| Campo | Tipo | Restriccion |
|---|---|---|
| call_type_id | UUID | PK |
| code | VARCHAR(50) | UNIQUE |
| name | VARCHAR(100) | NOT NULL |

Valores:

- `ABIERTA`
- `CERRADA`

### Entidad: `schedule_rule`

| Campo | Tipo | Restriccion |
|---|---|---|
| schedule_rule_id | UUID | PK |
| code | VARCHAR(50) | UNIQUE |
| name | VARCHAR(150) | NOT NULL |
| value | TEXT | NULL |
| status | BOOLEAN | DEFAULT TRUE |

### Entidad: `academic_term`

| Campo | Tipo | Restriccion |
|---|---|---|
| academic_term_id | UUID | PK |
| name | VARCHAR(100) | NOT NULL |
| start_date | DATE | NOT NULL |
| end_date | DATE | NOT NULL |
| status | BOOLEAN | DEFAULT TRUE |

### Entidad: `journey`

| Campo | Tipo | Restriccion |
|---|---|---|
| journey_id | UUID | PK |
| code | VARCHAR(50) | UNIQUE |
| name | VARCHAR(100) | NOT NULL |

Valores sugeridos:

- `MANANA`
- `TARDE`
- `NOCHE`

### Entidad: `day_catalog`

| Campo | Tipo | Restriccion |
|---|---|---|
| day_id | UUID | PK |
| numeric_value | SMALLINT | UNIQUE |
| name | VARCHAR(50) | NOT NULL |

---

## 4.3. Modulo de Estructura Academica

### Entidad: `technology_line`

| Campo | Tipo | Restriccion |
|---|---|---|
| technology_line_id | UUID | PK |
| code | VARCHAR(50) | UNIQUE |
| name | VARCHAR(150) | UNIQUE, NOT NULL |
| description | TEXT | NULL |
| status | BOOLEAN | DEFAULT TRUE |

### Entidad: `training_program`

| Campo | Tipo | Restriccion |
|---|---|---|
| training_program_id | UUID | PK |
| technology_line_id | UUID | FK, NOT NULL |
| code | VARCHAR(50) | UNIQUE |
| name | VARCHAR(200) | NOT NULL |
| level | VARCHAR(50) | NOT NULL |
| duration_months | INT | NOT NULL |
| status | BOOLEAN | DEFAULT TRUE |

### Entidad: `call`

| Campo | Tipo | Restriccion |
|---|---|---|
| call_id | UUID | PK |
| call_type_id | UUID | FK, NOT NULL |
| name | VARCHAR(150) | NOT NULL |
| start_date | DATE | NOT NULL |
| end_date | DATE | NOT NULL |
| status | BOOLEAN | DEFAULT TRUE |

### Entidad: `training_group`

Entidad tecnica recomendada en los archivos base. En el contexto SENA representa funcionalmente la ficha.

| Campo | Tipo | Restriccion |
|---|---|---|
| training_group_id | UUID | PK |
| training_program_id | UUID | FK, NOT NULL |
| call_id | UUID | FK, NOT NULL |
| journey_id | UUID | FK |
| group_number | VARCHAR(50) | UNIQUE, NOT NULL |
| start_date | DATE | NOT NULL |
| planned_end_date | DATE | NOT NULL |
| max_end_date | DATE | NOT NULL |
| status | VARCHAR(30) | NOT NULL |

### Entidad: `student_group`

Entidad de compatibilidad documental. Puede usarse como alias logico o vista operativa del grupo de aprendices.

| Campo | Tipo | Restriccion |
|---|---|---|
| student_group_id | UUID | PK |
| training_group_id | UUID | FK, UNIQUE |
| display_name | VARCHAR(150) | NOT NULL |
| learner_count | INT | NULL |
| status | BOOLEAN | DEFAULT TRUE |

---

## 4.4. Modulo RAF

### Entidad: `raf`

| Campo | Tipo | Restriccion |
|---|---|---|
| raf_id | UUID | PK |
| raf_type_id | UUID | FK, NOT NULL |
| code | VARCHAR(50) | UNIQUE |
| name | VARCHAR(255) | NOT NULL |
| description | TEXT | NULL |
| duration_hours | INT | NULL |
| status | BOOLEAN | DEFAULT TRUE |

### Entidad: `training_program_raf`

Relacion entre programa y RAF.

| Campo | Tipo | Restriccion |
|---|---|---|
| training_program_raf_id | UUID | PK |
| training_program_id | UUID | FK, NOT NULL |
| raf_id | UUID | FK, NOT NULL |
| is_required | BOOLEAN | DEFAULT TRUE |
| status | BOOLEAN | DEFAULT TRUE |

### Entidad: `training_group_raf`

Relacion entre grupo y RAF, incluyendo fechas reales del RAF dentro de la ficha.

| Campo | Tipo | Restriccion |
|---|---|---|
| training_group_raf_id | UUID | PK |
| training_group_id | UUID | FK, NOT NULL |
| raf_id | UUID | FK, NOT NULL |
| start_date | DATE | NOT NULL |
| planned_end_date | DATE | NOT NULL |
| max_end_date | DATE | NOT NULL |
| assigned_at | TIMESTAMP | NOT NULL |
| status | BOOLEAN | DEFAULT TRUE |

### Entidad: `raf_extension`

Registra prorrogas sobre el RAF dentro del grupo.

| Campo | Tipo | Restriccion |
|---|---|---|
| raf_extension_id | UUID | PK |
| training_group_raf_id | UUID | FK, NOT NULL |
| instructor_id | UUID | FK, NOT NULL |
| extension_date | TIMESTAMP | NOT NULL |
| new_end_date | DATE | NOT NULL |
| reason | TEXT | NOT NULL |

### Entidad: `raf_assignment_rule`

Reglas complementarias de asignacion curricular.

| Campo | Tipo | Restriccion |
|---|---|---|
| raf_assignment_rule_id | UUID | PK |
| raf_id | UUID | FK |
| rule_code | VARCHAR(50) | NOT NULL |
| rule_description | TEXT | NOT NULL |
| status | BOOLEAN | DEFAULT TRUE |

---

## 4.5. Modulo de Instructores

### Entidad: `instructor`

| Campo | Tipo | Restriccion |
|---|---|---|
| instructor_id | UUID | PK |
| instructor_type_id | UUID | FK, NOT NULL |
| document_number | VARCHAR(30) | UNIQUE |
| first_name | VARCHAR(150) | NOT NULL |
| last_name | VARCHAR(150) | NOT NULL |
| email | VARCHAR(150) | UNIQUE |
| phone | VARCHAR(30) | NULL |
| max_weekly_hours | INT | NULL |
| status | BOOLEAN | DEFAULT TRUE |

### Entidad: `instructor_technology_line`

| Campo | Tipo | Restriccion |
|---|---|---|
| instructor_technology_line_id | UUID | PK |
| instructor_id | UUID | FK, NOT NULL |
| technology_line_id | UUID | FK, NOT NULL |
| assigned_at | TIMESTAMP | NOT NULL |
| status | BOOLEAN | DEFAULT TRUE |

### Entidad: `instructor_raf`

| Campo | Tipo | Restriccion |
|---|---|---|
| instructor_raf_id | UUID | PK |
| instructor_id | UUID | FK, NOT NULL |
| raf_id | UUID | FK, NOT NULL |
| expertise_level | VARCHAR(50) | NULL |
| certified | BOOLEAN | DEFAULT FALSE |

### Entidad: `instructor_availability`

| Campo | Tipo | Restriccion |
|---|---|---|
| instructor_availability_id | UUID | PK |
| instructor_id | UUID | FK, NOT NULL |
| day_id | UUID | FK, NOT NULL |
| start_time | TIME | NOT NULL |
| end_time | TIME | NOT NULL |
| valid_from | DATE | NOT NULL |
| valid_to | DATE | NULL |
| status | BOOLEAN | DEFAULT TRUE |

### Entidad: `instructor_workload`

| Campo | Tipo | Restriccion |
|---|---|---|
| instructor_workload_id | UUID | PK |
| instructor_id | UUID | FK, NOT NULL |
| academic_term_id | UUID | FK |
| assigned_hours | INT | NOT NULL |
| max_allowed_hours | INT | NOT NULL |

---

## 4.6. Modulo de Ambientes

### Entidad: `environment`

Entidad general recomendada en los archivos base para representar el espacio academico.

| Campo | Tipo | Restriccion |
|---|---|---|
| environment_id | UUID | PK |
| environment_type_id | UUID | FK |
| code | VARCHAR(50) | UNIQUE |
| name | VARCHAR(150) | NOT NULL |
| campus | VARCHAR(100) | NULL |
| capacity | INT | NULL |
| status | BOOLEAN | DEFAULT TRUE |

### Entidad: `classroom`

Subtipo funcional de `environment`.

| Campo | Tipo | Restriccion |
|---|---|---|
| classroom_id | UUID | PK |
| environment_id | UUID | FK, UNIQUE |
| board_type | VARCHAR(50) | NULL |
| has_projector | BOOLEAN | DEFAULT FALSE |

### Entidad: `room`

Entidad tecnica de compatibilidad. Puede representar una vista operativa simplificada del espacio.

| Campo | Tipo | Restriccion |
|---|---|---|
| room_id | UUID | PK |
| environment_id | UUID | FK, UNIQUE |
| display_name | VARCHAR(100) | NOT NULL |
| room_code | VARCHAR(50) | UNIQUE |

### Entidad: `environment_type`

| Campo | Tipo | Restriccion |
|---|---|---|
| environment_type_id | UUID | PK |
| code | VARCHAR(50) | UNIQUE |
| name | VARCHAR(100) | NOT NULL |

### Entidad: `environment_availability`

| Campo | Tipo | Restriccion |
|---|---|---|
| environment_availability_id | UUID | PK |
| environment_id | UUID | FK, NOT NULL |
| day_id | UUID | FK, NOT NULL |
| start_time | TIME | NOT NULL |
| end_time | TIME | NOT NULL |
| valid_from | DATE | NOT NULL |
| valid_to | DATE | NULL |
| status | BOOLEAN | DEFAULT TRUE |

---

## 4.7. Modulo de Horarios

### Entidad: `schedule`

Encabezado de planeacion academica.

| Campo | Tipo | Restriccion |
|---|---|---|
| schedule_id | UUID | PK |
| training_group_id | UUID | FK, NOT NULL |
| academic_term_id | UUID | FK |
| name | VARCHAR(150) | NOT NULL |
| status | VARCHAR(30) | NOT NULL |
| created_at | TIMESTAMP | NOT NULL |

### Entidad: `schedule_block`

Bloque operativo del horario. Esta entidad es la que realmente se valida contra cruces.

| Campo | Tipo | Restriccion |
|---|---|---|
| schedule_block_id | UUID | PK |
| schedule_id | UUID | FK, NOT NULL |
| training_group_id | UUID | FK, NOT NULL |
| instructor_id | UUID | FK, NOT NULL |
| raf_id | UUID | FK, NOT NULL |
| environment_id | UUID | FK, NOT NULL |
| day_id | UUID | FK, NOT NULL |
| start_time | TIME | NOT NULL |
| end_time | TIME | NOT NULL |
| start_date | DATE | NOT NULL |
| end_date | DATE | NOT NULL |
| status | VARCHAR(30) | NOT NULL |

### Entidad: `schedule_conflict`

Registro de conflictos detectados o historicos.

| Campo | Tipo | Restriccion |
|---|---|---|
| schedule_conflict_id | UUID | PK |
| schedule_block_id | UUID | FK |
| conflict_type | VARCHAR(50) | NOT NULL |
| conflict_detail | TEXT | NOT NULL |
| detected_at | TIMESTAMP | NOT NULL |
| resolved | BOOLEAN | DEFAULT FALSE |

### Entidad: `schedule_change_log`

Historial de cambios del horario.

| Campo | Tipo | Restriccion |
|---|---|---|
| schedule_change_log_id | UUID | PK |
| schedule_block_id | UUID | FK |
| changed_by_user_id | UUID | FK |
| change_type | VARCHAR(50) | NOT NULL |
| old_value | TEXT | NULL |
| new_value | TEXT | NULL |
| changed_at | TIMESTAMP | NOT NULL |

---

## 4.8. Modulo de Observaciones

### Entidad: `observation`

Entidad recomendada en los archivos base y necesaria para seguimiento academico y operativo.

| Campo | Tipo | Restriccion |
|---|---|---|
| observation_id | UUID | PK |
| schedule_block_id | UUID | FK, NULL |
| instructor_id | UUID | FK, NULL |
| training_group_id | UUID | FK, NULL |
| observation_type_id | UUID | FK, NULL |
| author_user_id | UUID | FK, NULL |
| text | TEXT | NOT NULL |
| severity | VARCHAR(30) | NULL |
| created_at | TIMESTAMP | NOT NULL |
| status | BOOLEAN | DEFAULT TRUE |

### Entidad: `observation_type`

| Campo | Tipo | Restriccion |
|---|---|---|
| observation_type_id | UUID | PK |
| code | VARCHAR(50) | UNIQUE |
| name | VARCHAR(100) | NOT NULL |

### Entidad: `observation_attachment`

| Campo | Tipo | Restriccion |
|---|---|---|
| observation_attachment_id | UUID | PK |
| observation_id | UUID | FK, NOT NULL |
| file_name | VARCHAR(255) | NOT NULL |
| file_url | TEXT | NOT NULL |
| created_at | TIMESTAMP | NOT NULL |

---

## 4.9. Modulo de Reportes e Integracion

### Entidad: `integration_event`

| Campo | Tipo | Restriccion |
|---|---|---|
| integration_event_id | UUID | PK |
| event_name | VARCHAR(100) | NOT NULL |
| payload | TEXT | NOT NULL |
| published_at | TIMESTAMP | NOT NULL |

### Entidad: `export_job`

| Campo | Tipo | Restriccion |
|---|---|---|
| export_job_id | UUID | PK |
| requested_by_user_id | UUID | FK |
| export_type | VARCHAR(50) | NOT NULL |
| status | VARCHAR(30) | NOT NULL |
| created_at | TIMESTAMP | NOT NULL |

### Entidad: `report_snapshot`

| Campo | Tipo | Restriccion |
|---|---|---|
| report_snapshot_id | UUID | PK |
| report_name | VARCHAR(100) | NOT NULL |
| generated_at | TIMESTAMP | NOT NULL |
| report_data | TEXT | NOT NULL |

---

## 5. Entidades recomendadas encontradas en los archivos base

Esta es la respuesta directa sobre las entidades que debian quedar en el Markdown:

| Entidad | Quedo como entidad formal |
|---|---|
| `instructor` | Si |
| `environment` | Si |
| `training_group` | Si |
| `schedule` | Si |
| `observation` | Si |
| `classroom` | Si |
| `student_group` | Si |
| `room` | Si |
| `schedule_block` | Si |

---

## 6. Relaciones y cardinalidades principales

- `technology_line 1:N training_program`
- `call 1:N training_group`
- `training_program 1:N training_group`
- `training_group 1:1 student_group`
- `training_program N:M raf` por `training_program_raf`
- `training_group N:M raf` por `training_group_raf`
- `instructor N:M technology_line` por `instructor_technology_line`
- `instructor N:M raf` por `instructor_raf`
- `environment 1:1 classroom`
- `environment 1:1 room`
- `environment 1:N environment_availability`
- `training_group 1:N schedule`
- `schedule 1:N schedule_block`
- `schedule_block N:1 instructor`
- `schedule_block N:1 environment`
- `schedule_block N:1 raf`
- `training_group_raf 1:N raf_extension`
- `schedule_block 1:N observation`
- `user N:M role` por `user_role`
- `role N:M permission` por `role_permission`

---

## 7. Reglas de negocio criticas

## 7.1. Prorroga de RAF

Un instructor puede prolongar el plazo del RAF de un grupo solo si:

```text
raf_extension.new_end_date <= training_group_raf.max_end_date
```

## 7.2. Horarios no pueden cruzarse

No se puede insertar un `schedule_block` si existe otro bloque activo con:

- mismo `instructor_id`
- mismo `day_id`
- rango de fechas superpuesto
- rango horario superpuesto

La misma regla aplica para:

- `environment_id`
- `training_group_id`

## 7.3. RAF transversal compartido

Si un RAF es `TRANSVERSAL`:

- puede existir en multiples registros de `training_program_raf`

## 7.4. RAF tecnico exclusivo

Si un RAF es `TECNICO`:

- solo puede existir una vez en `training_program_raf`

## 7.5. Coherencia curricular

No se puede crear un `schedule_block` si el RAF no esta previamente asociado al grupo en `training_group_raf`.

## 7.6. Disponibilidad del instructor

No se puede crear un `schedule_block` fuera de la `instructor_availability`.

---

## 8. Restricciones de integridad recomendadas

### Unicidad

```sql
UNIQUE(user.username)
UNIQUE(user.email)
UNIQUE(training_program.code)
UNIQUE(training_group.group_number)
UNIQUE(instructor.document_number)
UNIQUE(instructor.email)
UNIQUE(raf.code)
UNIQUE(environment.code)
UNIQUE(room.room_code)
UNIQUE(training_program_raf.training_program_id, training_program_raf.raf_id)
UNIQUE(training_group_raf.training_group_id, training_group_raf.raf_id)
```

### Tiempo

```sql
CHECK(schedule_block.start_time < schedule_block.end_time)
CHECK(schedule_block.start_date <= schedule_block.end_date)
CHECK(training_group.planned_end_date <= training_group.max_end_date)
CHECK(training_group_raf.planned_end_date <= training_group_raf.max_end_date)
CHECK(instructor_availability.start_time < instructor_availability.end_time)
CHECK(environment_availability.start_time < environment_availability.end_time)
```

### Dominio

```sql
CHECK(call_type.code IN ('ABIERTA','CERRADA'))
CHECK(instructor_type.code IN ('PLANTA','CONTRATISTA'))
CHECK(raf_type.code IN ('TECNICO','TRANSVERSAL'))
```

---

## 9. Validacion de cruces de horario

Consulta logica base para instructor:

```sql
SELECT 1
FROM schedule_block sb
WHERE sb.instructor_id = :instructor_id
  AND sb.day_id = :day_id
  AND sb.start_date <= :end_date
  AND sb.end_date >= :start_date
  AND :start_time < sb.end_time
  AND :end_time > sb.start_time;
```

Si retorna filas:

```text
NO se puede asignar el bloque.
```

La misma validacion debe repetirse para:

- `environment_id`
- `training_group_id`

En PostgreSQL se recomienda estudiar `EXCLUDE CONSTRAINT` sobre `schedule_block`.

---

## 10. Arquitectura escalable para microservicios

### Identity Service

- `user`
- `role`
- `permission`
- `user_role`
- `role_permission`
- `audit_log`
- `session`

### Configuration Service

- `system_configuration`
- `instructor_type`
- `raf_type`
- `call_type`
- `schedule_rule`
- `academic_term`
- `journey`
- `day_catalog`

### Academic Structure Service

- `technology_line`
- `training_program`
- `call`
- `training_group`
- `student_group`

### Curriculum Service

- `raf`
- `training_program_raf`
- `training_group_raf`
- `raf_extension`
- `raf_assignment_rule`

### Instructor Service

- `instructor`
- `instructor_technology_line`
- `instructor_raf`
- `instructor_availability`
- `instructor_workload`

### Environment Service

- `environment`
- `classroom`
- `room`
- `environment_type`
- `environment_availability`

### Schedule Service

- `schedule`
- `schedule_block`
- `schedule_conflict`
- `schedule_change_log`

### Observation Service

- `observation`
- `observation_type`
- `observation_attachment`

### Reporting and Integration Service

- `integration_event`
- `export_job`
- `report_snapshot`

---

## 11. Conclusiones

El MER ahora queda corregido en estos puntos:

- cada modulo tiene varias entidades y no una sola
- las entidades tecnicas recomendadas en los archivos base quedaron presentes
- RAF compartidos y RAF tecnicos exclusivos quedaron modelados correctamente
- las prorrogas del RAF quedaron trazables
- seguridad y configuracion quedaron como parte real del modelo
- horarios y bloques de horario quedaron preparados para validacion de cruces

Este archivo ya puede servir como base para:

- diagrama entidad-relacion formal
- modelo logico relacional
- scripts SQL
- APIs por modulo
- futura separacion en microservicios
