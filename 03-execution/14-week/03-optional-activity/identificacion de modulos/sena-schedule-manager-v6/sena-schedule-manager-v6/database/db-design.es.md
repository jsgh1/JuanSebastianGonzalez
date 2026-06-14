```yaml
db_design:
  db_design_document: |
    # Diseño Físico de MongoDB

    Se selecciona MongoDB porque el MVP necesita una persistencia documental simple para
    horarios operativos y catálogos relacionados, con baja complejidad relacional
    y una configuración local rápida. Las colecciones permanecen normalizadas por raíz de agregado:
    classroom, student_group, instructor, schedule y observation. Los documentos
    schedule referencian identificadores de catálogos en lugar de embeberlos para que
    las reglas del backend validen dependencias de forma explícita. El diseño
    conserva entidades de dominio puras en el backend: nombres BSON, conversión de ObjectId y
    validación documental viven en archivos de inicialización de base de datos y documentos de repositorio,
    nunca en domain/core. El proyecto de base de datos es dueño de init, seed, índices y scripts smoke de validación.
  engine: MongoDB
  physical_objects:
    - name: classroom
      type: collection
      purpose: "Almacenar entornos físicos de aprendizaje"
      fields:
        - _id
        - code
        - name
        - location
        - capacity
    - name: student_group
      type: collection
      purpose: "Almacenar grupos de formación"
      fields:
        - _id
        - code
        - program_name
        - learner_count
    - name: instructor
      type: collection
      purpose: "Almacenar registros del catálogo de instructores"
      fields:
        - _id
        - document_number
        - full_name
        - email
        - instructor_type
    - name: schedule
      type: collection
      purpose: "Almacenar sesiones de formación planificadas"
      fields:
        - _id
        - classroom_id
        - student_group_id
        - instructor_id
        - day
        - start_time
        - end_time
        - status
    - name: observation
      type: collection
      purpose: "Almacenar notas de seguimiento vinculadas al horario"
      fields:
        - _id
        - schedule_id
        - note
        - created_at
  indexes:
    - object: classroom
      fields:
        - code
      reason: "búsqueda única y orden de listado"
    - object: student_group
      fields:
        - code
      reason: "búsqueda única y orden de listado"
    - object: instructor
      fields:
        - document_number
      reason: "búsqueda única de identidad del instructor"
    - object: schedule
      fields:
        - day
        - classroom_id
      reason: "detectar conflictos de aula y listar por día"
    - object: schedule
      fields:
        - day
        - instructor_id
      reason: "detectar conflictos de instructor y listar por día"
    - object: observation
      fields:
        - schedule_id
      reason: "cargar observaciones de un horario"
  migration_strategy: |
    Usar scripts versionados propios de la base de datos bajo database/init y archivos seed
    bajo database/seed. Cada script es idempotente y crea colecciones,
    validadores e índices si faltan. El arranque del backend nunca crea índices ni
    registros seed. Scripts de validación bajo database/tests comprueban la presencia de colecciones e
    índices antes del lanzamiento.
  backup_recovery: |
    Para el runtime local del MVP, documentar comandos de backup y restore usando mongodump
    y mongorestore contra el servicio de base de datos. La preparación para producción requiere
    backups cifrados, acceso restringido, prueba diaria de restauración y valores RPO/RTO
    antes del release. Los datos seed deben ser sintéticos y nunca incluir PII reales.
  quality_score: 0.91
```
