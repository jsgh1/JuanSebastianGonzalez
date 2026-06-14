```yaml
db_design:
  engine: "MongoDB 7.0"
  physical_objects:
    - name: room
      type: collection
      purpose: "Almacena salas físicas o virtuales disponibles para programación."
      fields:
        - id
        - name
        - capacity
        - location
        - equipment_item
        - is_active
        - created_at
        - updated_at
    - name: training_group
      type: collection
      purpose: "Representa un grupo de estudiantes que reciben formación juntos."
      fields:
        - id
        - name
        - code
        - student_count
        - is_active
        - created_at
        - updated_at
    - name: instructor
      type: collection
      purpose: "Representa un instructor permanente o contratista, incluyendo campos PII."
      fields:
        - id
        - first_name
        - last_name
        - email
        - phone
        - document_id
        - hire_type
        - expertise_area
        - is_active
        - created_at
        - updated_at
    - name: schedule_block
      type: collection
      purpose: "Representa una franja horaria programada que vincula sala, grupo e instructor."
      fields:
        - id
        - room_id
        - training_group_id
        - instructor_id
        - start_time
        - end_time
        - status
        - is_cancelled
        - created_at
        - updated_at
    - name: observation
      type: collection
      purpose: "Observación adjunta a un bloque horario; incluye el campo PII author."
      fields:
        - id
        - schedule_block_id
        - author
        - text
        - severity
        - created_at
  indexes:
    - object: schedule_block
      fields: [ room_id, start_time, end_time ]
      reason: "Detección de conflictos: bloques superpuestos para una sala."
    - object: schedule_block
      fields: [ training_group_id, start_time, end_time ]
      reason: "Detección de conflictos para un grupo de formación."
    - object: schedule_block
      fields: [ instructor_id, start_time, end_time ]
      reason: "Detección de conflictos para un instructor."
    - object: observation
      fields: [ schedule_block_id ]
      reason: "Recuperación rápida de observaciones para un bloque horario."
    - object: room
      fields: [ is_active ]
      reason: "Listar salas activas."
    - object: training_group
      fields: [ is_active ]
      reason: "Listar grupos de formación activos."
    - object: instructor
      fields: [ is_active ]
      reason: "Listar instructores activos."
  db_design_document: >
    La base de datos es MongoDB 7.0 ejecutándose en un replica set para alta disponibilidad y recuperación a un punto en el tiempo. Cinco colecciones (room, training_group, instructor, schedule_block, observation) almacenan las entidades del dominio con sus atributos según el modelo de datos. Las referencias entre colecciones usan campos ObjectId (room_id, training_group_id, instructor_id, schedule_block_id). Todos los nombres de colecciones y campos siguen inglés singular lower_snake_case. Los campos PII se identifican para cifrado a nivel de aplicación y acceso restringido. La política de retención archiva registros 5 años después de la desactivación o cancelación. El diseño físico separa los activos de base de datos bajo `database/` con subdirectorios `init/`, `seed/` y opcionalmente `migrations/`. Las entidades de dominio permanecen como structs Go puros; el mapeo a BSON ocurre en la capa de infraestructura del repositorio.
  migration_strategy: >
    Dada la flexibilidad de esquema de MongoDB, las migraciones se limitan a cambios de índices y actualizaciones de seed. Todos los scripts de creación de índices residen en `database/init/` y son idempotentes. Los datos seed se almacenan en `database/seed/` como archivos JSON por entidad. Los cambios de esquema se manejan desde el código de aplicación con valores por defecto; no se requiere ALTER explícito. La compatibilidad hacia atrás para documentos antiguos se asegura en la capa de repositorio.
  backup_recovery: >
    Se toman backups completos diarios mediante `mongodump` a un volumen separado, retenidos por 30 días. Los backups incrementales del oplog se toman cada hora para permitir recuperación puntual dentro de 24 horas. Los archivos de respaldo están en `database/backup/` y se prueban mensualmente mediante simulacros de restauración. El RTO es de 2 horas y el RPO de 1 hora.
  quality_score: 8.5
```
