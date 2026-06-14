# Modelo de Datos

## Entidades
- **Instructor**: Representa a un docente.
  - Atributos: `instructor_id` (UUID), `name` (String), `type` (String), `max_hours_per_week` (Int), `email` (String)
- **Classroom**: Representa un aula física.
  - Atributos: `classroom_id` (UUID), `name` (String), `capacity` (Int), `location` (String)
- **TimeSlot**: Representa un segmento de tiempo en la semana.
  - Atributos: `time_slot_id` (UUID), `day_of_week` (Int 0-6), `start_time` (Time), `end_time` (Time)
- **Schedule**: El mapeo de asignación.
  - Atributos: `schedule_id` (UUID), `instructor_id` (FK), `classroom_id` (FK), `time_slot_id` (FK), `program_name` (String), `group_code` (String)
- **Observation**: Notas sobre un horario.
  - Atributos: `observation_id` (UUID), `schedule_id` (FK), `content` (String), `type` (String), `created_by` (String)

## Relaciones
- Instructor 1:N Schedule
- Classroom 1:N Schedule
- TimeSlot 1:N Schedule
- Schedule 1:N Observation
