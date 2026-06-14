```yaml
data_model:
  data_model_document: |
    # SENA Schedule Manager - Modelo de Datos
    Este documento define el modelo lógico de datos para el sistema MVP basado en MongoDB.
    Las colecciones están nombradas en inglés singular, como se requiere.
    El modelo soporta las entidades room, training_group, instructor, schedule_block y observation.
    La detección de conflictos se maneja mediante índices sobre schedule_block para intervalos de tiempo superpuestos por sala, grupo o instructor.
    Los campos PII se identifican para instructores y autores de observaciones.
    Las reglas de retención conservan los datos durante 5 años después de la desactivación (o cancelación) por motivos legales/auditoría.
  entities:
    - name: room
      description: Representa una sala física o virtual disponible para programación.
      attributes:
        - name: id
          type: ObjectId
          required: true
          description: Identificador único generado por MongoDB.
        - name: name
          type: string
          required: true
          description: Nombre legible de la sala (por ejemplo, "Aula 101").
        - name: capacity
          type: integer
          required: false
          description: Número máximo de personas que la sala puede albergar.
        - name: location
          type: string
          required: false
          description: Ubicación física o edificio.
        - name: equipment_item
          type: Array
          items_type: string
          required: false
          description: Lista de equipos disponibles en la sala.
        - name: is_active
          type: boolean
          required: true
          description: Indica si la sala está disponible para programación.
        - name: created_at
          type: datetime
          required: true
          description: Marca de tiempo de creación.
        - name: updated_at
          type: datetime
          required: true
          description: Marca de tiempo de última actualización.
    - name: training_group
      description: Representa un grupo de estudiantes que reciben formación juntos.
      attributes:
        - name: id
          type: ObjectId
          required: true
          description: Identificador único.
        - name: name
          type: string
          required: true
          description: Nombre visible del grupo.
        - name: code
          type: string
          required: true
          description: Código institucional del grupo.
        - name: student_count
          type: integer
          required: false
          description: Número de estudiantes matriculados.
        - name: is_active
          type: boolean
          required: true
          description: Indica si el grupo está activo.
        - name: created_at
          type: datetime
          required: true
          description: Marca de tiempo de creación.
        - name: updated_at
          type: datetime
          required: true
          description: Marca de tiempo de última actualización.
    - name: instructor
      description: Representa un instructor permanente o contratista.
      attributes:
        - name: id
          type: ObjectId
          required: true
          description: Identificador único.
        - name: first_name
          type: string
          required: true
          description: Nombre del instructor.
        - name: last_name
          type: string
          required: true
          description: Apellido del instructor.
        - name: email
          type: string
          required: true
          description: Correo electrónico (PII).
          pii: true
        - name: phone
          type: string
          required: false
          description: Número telefónico (PII).
          pii: true
        - name: document_id
          type: string
          required: true
          description: Número de identificación nacional (PII).
          pii: true
        - name: hire_type
          type: string
          required: true
          description: "Tipo de contrato: 'permanent' o 'contractor'."
        - name: expertise_area
          type: Array
          items_type: string
          required: false
          description: Áreas de especialidad.
        - name: is_active
          type: boolean
          required: true
          description: Indica si el instructor puede ser asignado.
        - name: created_at
          type: datetime
          required: true
          description: Marca de tiempo de creación.
        - name: updated_at
          type: datetime
          required: true
          description: Marca de tiempo de última actualización.
    - name: schedule_block
      description: Representa un bloque horario programado para una sala, grupo e instructor.
      attributes:
        - name: id
          type: ObjectId
          required: true
          description: Identificador único.
        - name: room_id
          type: ObjectId
          required: true
          description: Referencia a la sala asignada.
        - name: training_group_id
          type: ObjectId
          required: true
          description: Referencia al grupo de formación asignado.
        - name: instructor_id
          type: ObjectId
          required: true
          description: Referencia al instructor asignado.
        - name: start_time
          type: datetime
          required: true
          description: Fecha y hora de inicio del bloque.
        - name: end_time
          type: datetime
          required: true
          description: Fecha y hora de fin del bloque. Debe ser posterior a start_time.
        - name: status
          type: string
          required: true
          description: "Estado del bloque: 'scheduled', 'cancelled'."
        - name: is_cancelled
          type: boolean
          required: true
          description: Derivado de status; permite filtrado rápido.
        - name: created_at
          type: datetime
          required: true
          description: Marca de tiempo de creación.
        - name: updated_at
          type: datetime
          required: true
          description: Marca de tiempo de última actualización.
    - name: observation
      description: Observación adjunta a un bloque horario.
      attributes:
        - name: id
          type: ObjectId
          required: true
          description: Identificador único.
        - name: schedule_block_id
          type: ObjectId
          required: true
          description: Referencia al bloque horario asociado.
        - name: author
          type: string
          required: true
          description: Nombre de la persona que escribió la observación (PII).
          pii: true
        - name: text
          type: string
          required: true
          description: Contenido libre de la observación.
        - name: severity
          type: string
          required: true
          description: "Nivel de severidad: 'info', 'warning', 'critical'."
        - name: created_at
          type: datetime
          required: true
          description: Marca de tiempo de creación.
  relationships:
    - name: schedule_block_room
      description: Un bloque de horario está asignado exactamente a una sala.
      source_entity: schedule_block
      target_entity: room
      cardinality: many-to-one
      foreign_key: room_id
    - name: schedule_block_training_group
      description: Un bloque de horario está asignado exactamente a un grupo de formación.
      source_entity: schedule_block
      target_entity: training_group
      cardinality: many-to-one
      foreign_key: training_group_id
    - name: schedule_block_instructor
      description: Un bloque de horario está asignado exactamente a un instructor.
      source_entity: schedule_block
      target_entity: instructor
      cardinality: many-to-one
      foreign_key: instructor_id
    - name: observation_schedule_block
      description: Una observación pertenece exactamente a un bloque de horario.
      source_entity: observation
      target_entity: schedule_block
      cardinality: many-to-one
      foreign_key: schedule_block_id
  pii_fields:
    - entity: instructor
      fields:
        - email
        - phone
        - document_id
      justification: "Email, teléfono y documento son datos personales según la Ley 1581 de Colombia."
    - entity: observation
      fields:
        - author
      justification: "El campo author almacena el nombre de una persona natural y por tanto es PII."
  retention_rules:
    - entity: room
      rule: "Las salas activas se conservan indefinidamente. Las deshabilitadas se retienen 5 años tras su desactivación y luego se archivan."
      duration: "5 años post-desactivación"
    - entity: training_group
      rule: "Los grupos activos se conservan indefinidamente. Los deshabilitados se retienen 5 años tras la desactivación."
      duration: "5 años post-desactivación"
    - entity: instructor
      rule: "Los instructores activos se conservan indefinidamente. Los deshabilitados se retienen 5 años y luego se anonimizan los campos PII."
      duration: "5 años post-desactivación, luego anonimización"
    - entity: schedule_block
      rule: "Los bloques programados se retienen 5 años después de `end_time`. Los cancelados se retienen 2 años."
      duration: "5 años (programados), 2 años (cancelados)"
    - entity: observation
      rule: "Las observaciones se retienen el mismo tiempo que su bloque horario padre."
      duration: "Heredado de schedule_block"
  query_patterns:
    - name: conflict_detection
      description: "Encontrar bloques superpuestos para una sala, grupo o instructor dentro de un rango horario."
      collections:
        - schedule_block
      indexes_used:
        - schedule_block_room_time
        - schedule_block_training_group_time
        - schedule_block_instructor_time
      example_query: "{ room_id: <id>, start_time: { $lt: <end> }, end_time: { $gt: <start> }, is_cancelled: false }"
    - name: list_active_entities
      description: "Listar todas las salas, grupos o instructores activos."
      collections:
        - room
        - training_group
        - instructor
      filter: "{ is_active: true }"
    - name: schedule_blocks_for_room
      description: "Recuperar todos los bloques de una sala específica, ordenados por hora."
      collections:
        - schedule_block
      index: "schedule_block_room_time"
    - name: observations_for_block
      description: "Obtener todas las observaciones para un bloque horario dado."
      collections:
        - observation
      index: "observation_schedule_block_id"
  quality_score:
    score: 95
    reasons:
      - "Todos los nombres de entidades y atributos están en inglés, en singular, lower_snake_case y cumplen las reglas de nomenclatura."
      - "Los campos PII están marcados y justificados explícitamente."
      - "Se definen políticas de retención para cada entidad con duraciones."
      - "Se identifican índices para detección de conflictos y consultas comunes."
      - "Las relaciones están definidas claramente con claves foráneas."
      - "Deducción menor: observation usa 'author' como PII; podría anonimizarse más."
```
