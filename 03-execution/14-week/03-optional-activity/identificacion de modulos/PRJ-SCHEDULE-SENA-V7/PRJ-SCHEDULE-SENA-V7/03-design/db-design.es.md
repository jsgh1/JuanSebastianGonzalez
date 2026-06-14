# Diseño de Base de Datos

## Motor
PostgreSQL 16+

## Tipos Físicos
- IDs: `UUID` (`gen_random_uuid`)
- Cadenas: `VARCHAR` o `TEXT`
- Tiempos: `TIME` y `TIMESTAMP`
- Números: `INT`

## Índices
- `idx_schedule_instructor`: Sobre `schedule(instructor_id)`
- `idx_schedule_classroom_time_slot`: Restricción única `(classroom_id, time_slot_id)`
- `idx_observation_schedule`: Sobre `observation(schedule_id)`

## RTO/RPO
- RTO: 4 horas
- RPO: 24 horas (copias de seguridad diarias)
