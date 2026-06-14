```yaml
data_model:
  data_model_document: "Este documento describe el modelo lógico de datos para SENA Schedule Manager v8, basado en el PRD proporcionado y en las guías de Clean Architecture. Define entidades, relaciones, restricciones propuestas, identificación de PII, reglas de retención y patrones comunes de consulta. El modelo cumple las convenciones de nombres especificadas: inglés, singular y lower_snake_case para todas las entidades y atributos."
  entities:
    - name: instructor
      description: "Representa a un instructor dentro del centro de formación. Puede ser de planta o contratista."
      attributes:
        - name: id
          type: ObjectId
          description: "Identificador único del instructor."
          is_primary_key: true
          is_required: true
        - name: name
          type: String
          description: "Nombre completo del instructor."
          is_required: true
          max_length: 100
        - name: email
          type: String
          description: "Dirección de correo del instructor."
          is_required: true
          is_unique: true
          regex_pattern: "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
          max_length: 100
        - name: type
          type: String
          description: "Tipo de instructor: 'staff' o 'contractor'."
          is_required: true
          allowed_values: ["staff", "contractor"]
        - name: expertise_area
          type: Array
          items_type: String
          description: "Lista de áreas de experiencia del instructor."
          is_required: false
          max_items: 10
          max_length_item: 50
    - name: environment
      description: "Representa un entorno de aprendizaje donde puede realizarse formación (por ejemplo, aula o laboratorio)."
      attributes:
        - name: id
          type: ObjectId
          description: "Identificador único del entorno de aprendizaje."
          is_primary_key: true
          is_required: true
        - name: name
          type: String
          description: "Nombre o identificador del entorno (por ejemplo, 'Aula A' o 'Laboratorio 2')."
          is_required: true
          is_unique: true
          max_length: 50
        - name: capacity
          type: Number
          description: "Número máximo de personas que puede albergar el entorno."
          is_required: true
          min_value: 1
        - name: type
          type: String
          description: "Tipo de entorno (por ejemplo, 'classroom', 'laboratory', 'virtual')."
          is_required: true
          max_length: 50
        - name: equipment_item
          type: Array
          items_type: String
          description: "Lista de equipos clave disponibles en el entorno."
          is_required: false
          max_items: 20
          max_length_item: 50
    - name: training_group
      description: "Representa un grupo de aprendices asociado a un programa de formación específico."
      attributes:
        - name: id
          type: ObjectId
          description: "Identificador único del grupo de formación."
          is_primary_key: true
          is_required: true
        - name: name
          type: String
          description: "Nombre o código del grupo de formación."
          is_required: true
          is_unique: true
          max_length: 100
        - name: student_count
          type: Number
          description: "Cantidad de estudiantes en el grupo."
          is_required: true
          min_value: 1
        - name: start_date
          type: Date
          description: "Fecha de inicio del programa del grupo de formación."
          is_required: true
        - name: end_date
          type: Date
          description: "Fecha de finalización del programa del grupo de formación."
          is_required: true
          validation_rule: "end_date >= start_date"
    - name: schedule
      description: "Representa una sesión de formación programada, vinculando un instructor, grupo y entorno para un tiempo específico."
      attributes:
        - name: id
          type: ObjectId
          description: "Identificador único de la entrada de horario."
          is_primary_key: true
          is_required: true
        - name: instructor_id
          type: ObjectId
          description: "Referencia al instructor asignado a este horario."
          is_required: true
          foreign_key_to: instructor
        - name: training_group_id
          type: ObjectId
          description: "Referencia al grupo de formación de este horario."
          is_required: true
          foreign_key_to: training_group
        - name: environment_id
          type: ObjectId
          description: "Referencia al entorno de aprendizaje de este horario."
          is_required: true
          foreign_key_to: environment
        - name: start_time
          type: Date
          description: "Marca de tiempo de inicio de la sesión programada."
          is_required: true
        - name: end_time
          type: Date
          description: "Marca de tiempo de finalización de la sesión programada."
          is_required: true
          validation_rule: "end_time > start_time"
        - name: status
          type: String
          description: "Estado actual del horario (por ejemplo, 'scheduled', 'completed', 'cancelled')."
          is_required: true
          allowed_values: ["scheduled", "completed", "cancelled"]
          default_value: "scheduled"
        - name: description
          type: String
          description: "Descripción breve del contenido de la sesión."
          is_required: false
          max_length: 250
    - name: observation
      description: "Representa una observación o comentario operativo, vinculado a un instructor o a un horario."
      attributes:
        - name: id
          type: ObjectId
          description: "Identificador único de la observación."
          is_primary_key: true
          is_required: true
        - name: description
          type: String
          description: "Descripción detallada de la observación."
          is_required: true
          max_length: 500
        - name: observation_date
          type: Date
          description: "Fecha y hora en que se realizó la observación."
          is_required: true
          default_value: "now()"
        - name: observed_by
          type: String
          description: "Identificador del usuario que realizó la observación (por ejemplo, ID del coordinador)."
          is_required: true
          max_length: 100
        - name: reference_type
          type: String
          description: "Indica si la observación se refiere a un 'schedule' o a un 'instructor'."
          is_required: true
          allowed_values: ["schedule", "instructor"]
        - name: reference_id
          type: ObjectId
          description: "ID del horario o instructor al que se refiere esta observación."
          is_required: true
          polymorphic_references:
            - entity: schedule
              field: id
            - entity: instructor
              field: id
  relationships:
    - name: instructor_to_schedule
      from_entity: instructor
      from_attribute: id
      to_entity: schedule
      to_attribute: instructor_id
      type: One-to-Many
      description: "Un instructor puede estar asignado a múltiples horarios."
    - name: training_group_to_schedule
      from_entity: training_group
      from_attribute: id
      to_entity: schedule
      to_attribute: training_group_id
      type: One-to-Many
      description: "Un grupo de formación puede estar asociado a múltiples horarios."
    - name: environment_to_schedule
      from_entity: environment
      from_attribute: id
      to_entity: schedule
      to_attribute: environment_id
      type: One-to-Many
      description: "Un entorno puede albergar múltiples horarios."
    - name: observation_to_entity
      from_entity: observation
      from_attribute: reference_id
      to_entity: null # Relación polimórfica; la entidad destino depende de reference_type
      to_attribute: null
      type: Polymorphic
      description: "Una observación puede vincularse a un horario o a un instructor."
  pii_fields:
    - entity: instructor
      attribute: name
      reason: "Identificador directo de una persona."
      privacy_level: "Confidential"
      handling_guidance: "Requiere control de acceso. Enmascarar en logs. Cifrar en reposo."
    - entity: instructor
      attribute: email
      reason: "Información de contacto directa, identificador único."
      privacy_level: "Confidential"
      handling_guidance: "Requiere control de acceso. Enmascarar en logs. Cifrar en reposo. Usado para comunicación."
    - entity: observation
      attribute: observed_by
      reason: "Identificador de la persona que realiza la observación."
      privacy_level: "Internal"
      handling_guidance: "Requiere control de acceso interno. Debe ser un ID de usuario del sistema, no nombre completo, si es posible."
  retention_rules:
    - entity: schedule
      rule: "Conservar durante 5 años después de end_time; luego archivar o hacer soft delete. Rastro de auditoría operativa."
      justification: "Registro histórico para progreso académico y utilización de recursos."
    - entity: observation
      rule: "Conservar durante 5 años después de observation_date. Asociado a horarios/instructores."
      justification: "Documentación de cumplimiento y revisión de desempeño."
    - entity: instructor
      rule: "Conservar durante 7 años después del último horario activo; luego anonimizar datos personales."
      justification: "Requisitos legales y posible recontratación. Anonimizar campos sensibles para cumplir minimización de datos."
    - entity: training_group
      rule: "Conservar durante 7 años después de end_date; luego archivar o hacer soft delete."
      justification: "Contexto histórico para programas educativos."
    - entity: environment
      rule: "Conservar indefinidamente o hasta el desmantelamiento de la instalación."
      justification: "Dato de referencia estático, cambia con poca frecuencia."
  query_patterns:
    - name: "Obtener horarios de un instructor"
      description: "Recuperar todos los horarios de un instructor específico dentro de un rango de fechas."
      entities_involved: ["instructor", "schedule"]
      fields_filtered: ["schedule.instructor_id", "schedule.start_time", "schedule.end_time"]
      indexes_proposed:
        - collection: schedule
          fields: ["instructor_id", "start_time", "end_time"]
          type: compound
    - name: "Encontrar entornos disponibles"
      description: "Encontrar entornos disponibles para una franja horaria y capacidad dadas."
      entities_involved: ["environment", "schedule"]
      fields_filtered: ["schedule.start_time", "schedule.end_time", "environment.capacity"]
      indexes_proposed:
        - collection: schedule
          fields: ["start_time", "end_time"]
          type: compound
        - collection: environment
          fields: ["capacity"]
          type: single
    - name: "Obtener vista general del horario de un grupo"
      description: "Recuperar todos los horarios de un grupo de formación específico."
      entities_involved: ["training_group", "schedule"]
      fields_filtered: ["schedule.training_group_id"]
      indexes_proposed:
        - collection: schedule
          fields: ["training_group_id"]
          type: single
    - name: "Listar observaciones de instructor/horario"
      description: "Traer todas las observaciones relacionadas con un instructor u horario específico."
      entities_involved: ["observation"]
      fields_filtered: ["observation.reference_type", "observation.reference_id"]
      indexes_proposed:
        - collection: observation
          fields: ["reference_type", "reference_id"]
          type: compound
  quality_score: 0.95
```
