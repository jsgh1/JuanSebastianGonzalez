```yaml
data_model:
  data_model_document: |
    # Modelo Lógico de Datos

    El modelo de datos del MVP utiliza cinco raíces de agregado: classroom, student_group,
    instructor, schedule y observation. El agregado schedule referencia las
    raíces de catálogo por identificador y contiene validaciones específicas del horario como
    día, hora de inicio y hora de fin. Observation pertenece a schedule y almacena
    texto de seguimiento. Los nombres lógicos están en inglés, en singular y en ASCII. No se requieren
    metadatos físicos de MongoDB en los objetos de dominio; el diseño físico de colecciones e índices
    se delega a A13, mientras que los adaptadores de persistencia del backend mapean
    documentos a entidades de dominio puras.

    Los datos PII se limitan al correo del instructor y al número de documento. El MVP no
    incluye autenticación ni gestión de roles, por lo que la identidad del coordinador queda
    fuera del alcance. La retención es conservadora: los registros operativos de horarios se mantienen
    mientras el periodo de formación esté activo y luego se archivan de acuerdo con la política académica.
  entities:
    - name: classroom
      purpose: "Entorno físico de aprendizaje disponible para programación"
      attributes:
        - name: id
          type: string
          required: true
        - name: code
          type: string
          required: true
        - name: name
          type: string
          required: true
        - name: location
          type: string
          required: true
        - name: capacity
          type: integer
          required: true
    - name: student_group
      purpose: "Grupo de formación asignado a horarios"
      attributes:
        - name: id
          type: string
          required: true
        - name: code
          type: string
          required: true
        - name: program_name
          type: string
          required: true
        - name: learner_count
          type: integer
          required: true
    - name: instructor
      purpose: "Instructor asignado a sesiones de formación"
      attributes:
        - name: id
          type: string
          required: true
        - name: document_number
          type: string
          required: true
        - name: full_name
          type: string
          required: true
        - name: email
          type: string
          required: true
        - name: instructor_type
          type: enum
          required: true
          allowed_value: "staff|contractor"
    - name: schedule
      purpose: "Sesión de formación planificada"
      attributes:
        - name: id
          type: string
          required: true
        - name: classroom_id
          type: string
          required: true
        - name: student_group_id
          type: string
          required: true
        - name: instructor_id
          type: string
          required: true
        - name: day
          type: date
          required: true
        - name: start_time
          type: time
          required: true
        - name: end_time
          type: time
          required: true
        - name: status
          type: enum
          required: true
          allowed_value: "planned|cancelled"
    - name: observation
      purpose: "Nota de seguimiento adjunta a un horario"
      attributes:
        - name: id
          type: string
          required: true
        - name: schedule_id
          type: string
          required: true
        - name: note
          type: string
          required: true
        - name: created_at
          type: datetime
          required: true
  relationships:
    - name: schedule_classroom
      from: schedule
      to: classroom
      type: many_to_one
    - name: schedule_student_group
      from: schedule
      to: student_group
      type: many_to_one
    - name: schedule_instructor
      from: schedule
      to: instructor
      type: many_to_one
    - name: observation_schedule
      from: observation
      to: schedule
      type: many_to_one
  pii_fields:
    - entity: instructor
      field: document_number
      classification: personal_identifier
    - entity: instructor
      field: email
      classification: contact
  retention_rules:
    - "Los registros de schedule y observation se conservan durante el periodo académico activo y se archivan después."
    - "Los campos de contacto del instructor se conservan solo mientras sean necesarios para coordinar horarios."
    - "Los datos semilla deben ser sintéticos y no deben contener datos personales reales."
  query_patterns:
    - "listar classroom ordenado por code"
    - "listar student_group ordenado por code"
    - "listar instructor ordenado por full_name"
    - "listar schedule por day y classroom_id"
    - "listar schedule por day y instructor_id"
    - "listar observation por schedule_id"
  quality_score: 0.92
```
