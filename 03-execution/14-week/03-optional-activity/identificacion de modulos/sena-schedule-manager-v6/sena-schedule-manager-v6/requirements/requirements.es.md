```yaml
requirements:
  prd_document: |
    # PRD SENA Schedule Manager V6

    El producto es un MVP para gestionar horarios de formación del SENA con Go,
    React, MongoDB, Docker y Docker Compose. El sistema soporta la gestión de classroom,
    student_group, instructor, schedule y observation. El usuario objetivo
    es un coordinador de horarios que necesita una herramienta operativa simple para
    crear registros de catálogo, crear horarios con rangos de tiempo validados y
    registrar observaciones para seguimiento.

    Este MVP reduce intencionalmente el alcance funcional, no la calidad técnica.
    El workspace generado debe mantener database, backend y frontend como
    componentes separados. La propiedad del esquema/init/index/seed pertenece
    al componente database. El dominio/core del backend debe permanecer independiente de
    MongoDB y de detalles de transporte; los documentos de persistencia y mapeadores pertenecen a
    repository/infrastructure. El frontend debe usar una capa service/API y no
    convertirse en un componente App monolítico.

    Los identificadores técnicos, código fuente, contratos API, diagramas, nombres de contenedores
    y objetos de base de datos deben usar inglés. El español se permite solo para
    textos visibles al usuario y documentación funcional. La ejecución es una prueba de fuego del
    Agentic SDLC OS, así que la evidencia de QA, AppSec y release debe generarse
    como artefactos reales antes de completar.
  functional_requirements:
    - Crear y listar registros classroom con code, name, location y capacity.
    - Crear y listar registros student_group con code, program_name y learner_count.
    - Crear y listar registros instructor con tipo staff o contractor.
    - Crear y listar registros schedule vinculados a classroom, student_group e instructor.
    - Validar day, start_time y end_time del schedule antes de persistir.
    - Crear y listar observation vinculadas a un schedule.
    - Exponer endpoints backend de salud y CRUD para las entidades del MVP.
    - Proveer pantallas frontend para listar y crear entidades del MVP a través de un cliente API.
  non_functional_requirements:
    architecture: "database, backend y frontend son componentes independientes del workspace con su propio límite de contenedor."
    maintainability: "ningún archivo fuente supera 300 líneas; no hay main, App, página, repositorio, handler o archivo CSS monolítico."
    language: "los identificadores técnicos, el código fuente, los contratos API y los objetos de base de datos usan inglés; los textos de UI pueden estar en español."
    data: "las colecciones y atributos de MongoDB usan nombres en inglés, singulares y lower_snake_case cuando aplica."
    domain_boundary: "domain/core no contiene metadatos de persistencia ni transporte; los modelos de persistencia y mapeadores viven en repository/infrastructure."
    testing: "backend y frontend incluyen pruebas reales con comandos ejecutables."
    security: "el backend sanea errores internos, restringe CORS, declara timeouts y evita almacenamiento de secretos en cliente."
    release: "Docker Compose, release readiness, plan de despliegue y plan de rollback se producen antes de completar."
  user_stories:
    - id: US-001
      as: "coordinador de horarios"
      i_want: "crear y listar aulas"
      so_that: "los horarios puedan asignarse a entornos físicos"
    - id: US-002
      as: "coordinador de horarios"
      i_want: "crear y listar grupos de estudiantes"
      so_that: "los grupos de formación puedan programarse con precisión"
    - id: US-003
      as: "coordinador de horarios"
      i_want: "crear y listar instructores con tipo staff o contractor"
      so_that: "las asignaciones docentes distingan la relación laboral"
    - id: US-004
      as: "coordinador de horarios"
      i_want: "crear horarios con aula, grupo, instructor, día y rango horario"
      so_that: "las sesiones de formación puedan planificarse de forma consistente"
    - id: US-005
      as: "coordinador de horarios"
      i_want: "adjuntar observaciones a los horarios"
      so_that: "las notas de seguimiento permanezcan conectadas al registro del horario"
    - id: US-006
      as: "coordinador de horarios"
      i_want: "ver errores de validación por campos faltantes o rangos horarios inválidos"
      so_that: "no se persistan horarios incorrectos"
  acceptance_criteria:
    - "Docker Compose puede iniciar database, backend y frontend como servicios distintos."
    - "Los artefactos de init, índices y seed de MongoDB viven bajo database, no en backend."
    - "El backend expone endpoints de salud y CRUD para classroom, student_group, instructor, schedule y observation."
    - "Los archivos de domain/core del backend no contienen bson, gorm, db, sql, anotaciones ORM/ODM ni imports de controladores de BD."
    - "El frontend lista y crea registros del MVP mediante un cliente API con manejo de timeout."
    - "Backend y frontend incluyen pruebas reales y comandos de verificación declarados."
    - "A09 produce evidencia de QA con comandos de prueba y clasificación de defectos."
    - "A12 produce evidencia de AppSec con cobertura OWASP/amenazas/controles/riesgos y evidencia de runtime."
    - "A11 produce evidencia de release readiness, despliegue y rollback."
  scope_boundaries:
    in_scope:
      - "gestión de classroom"
      - "gestión de student_group"
      - "gestión de instructor"
      - "gestión de schedule"
      - "observaciones de schedule"
      - "runtime local con Docker Compose"
      - "evidencia de QA, AppSec y release"
    out_of_scope:
      - "autenticación y gestión de roles"
      - "arrastrar y soltar en calendario"
      - "reportería masiva"
      - "importación/exportación"
      - "despliegue productivo en nube"
  stakeholders:
    - "coordinador de horarios: usuario operativo principal"
    - "coordinación académica SENA: dueño del negocio"
    - "revisor técnico: valida arquitectura, QA, seguridad y release readiness"
  quality_score: 0.91
```
