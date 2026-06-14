```yaml
requirements:
  prd: |
    # Documento de Requisitos del Producto
    ## Proyecto
    SENA Schedule Manager

    ## Objetivo del Producto
    Construir un MVP con forma de producción para gestionar horarios académicos del SENA. MVP significa alcance funcional reducido, no reducción de calidad de ingeniería.
    El producto debe soportar la programación de salas, grupos de formación, instructores, bloques de horario y observaciones. La UI visible al usuario y la documentación para usuarios deben estar en español. Todo el código técnico, nombres de carpetas, nombres de objetos de base de datos, nombres de entidades, atributos, diagramas, contratos API, pruebas, comentarios y documentación para desarrolladores deben estar en inglés.

    ## Stack Obligatorio
    - Backend: Go
    - Frontend: React
    - Database: MongoDB
    - Runtime: Docker and Docker Compose

    ## Límites de Componentes
    - database/ – Init de MongoDB, seed, índices, validación, Dockerfile.
    - backend/ – Solo API en Go.
    - frontend/ – Solo UI en React.
    - Root – docker-compose.yml, .env.example, .gitignore, docs transversales.
    Cada componente tiene su propio contenedor.

    ## Alcance Funcional
    - Rooms: CRUD + deshabilitar, detectar conflictos por sala y tiempo.
    - Training Groups: CRUD + deshabilitar, detectar conflictos por grupo y tiempo.
    - Instructors: CRUD + deshabilitar (permanent/contractor), detectar conflictos por instructor y tiempo.
    - Schedule Blocks: CRUD + cancelar, validar end>start, prevenir conflictos.
    - Observations: Agregar a bloques de horario (texto, autor, fecha, severidad: info/warning/critical).

    ## Requisitos de Arquitectura
    - Capas backend: cmd/api, internal/{config,domain,application,http,repository,infrastructure}. Reglas estrictas de dependencia.
    - Frontend features: src/{app,features,components,services,hooks,types}. Llamadas API fuera de componentes.
    - Base de datos: nombres de colecciones singulares en inglés (room, trainingGroup, etc.), scripts propios de init, seed e índices.

    ## Requisitos de Calidad
    - Pruebas unitarias backend para reglas de dominio y detección de conflictos.
    - Pruebas frontend para cliente API e interacciones clave de UI.
    - Comandos ejecutables de build/test con cwd, run, purpose y expected exit code.
    - Reportes QA citando comandos/archivos; reportes AppSec citando controles específicos.
    - Preparación para release: Docker Compose, healthchecks, .env.example, despliegue/rollback y startup reproducible.

    ## Criterios de Aceptación
    - docker compose up --build inicia todos los servicios.
    - El healthcheck del backend verifica alcanzabilidad de dependencias.
    - CRUD completo + prevención de conflictos vía API.
    - Pruebas/comandos ejecutables desde checkout limpio.
    - No archivos monolíticos; no nombres técnicos en español.
    - El estado final solo se completa con evidencia verificable de QA/AppSec/release.

  functional_requirements:
    - "Gestión de rooms: crear, listar, actualizar y deshabilitar con código, nombre, capacidad, ubicación y estado activo."
    - "Gestión de training groups: crear, listar, actualizar y deshabilitar con código, nombre del programa, fechas y estado activo."
    - "Gestión de instructors: crear, listar, actualizar y deshabilitar con nombre completo, email, tipo de contrato, especialización y estado activo."
    - "Gestión de schedule blocks: crear, listar, actualizar y cancelar con fecha, hora inicio/fin, room, group, instructor y actividad. Validar end > start y prevenir conflictos."
    - "Observations: agregar observaciones a bloques de horario con texto, autor, fecha de creación y severidad."
    - "Detección de conflictos: impedir doble asignación de room, training group o instructor dentro de rangos de tiempo superpuestos."

  non_functional_requirements:
    - "El backend debe usar arquitectura Go por capas."
    - "Los handlers HTTP no deben acceder directamente a MongoDB; usar interfaces de repositorio."
    - "El código de dominio no debe importar paquetes HTTP, DB o frameworks."
    - "El servidor debe incluir timeouts de lectura/escritura/idle/shutdown."
    - "CORS no debe ser wildcard en producción."
    - "Las respuestas 500 no deben exponer errores internos crudos."
    - "Archivos fuente < 300 líneas."
    - "El frontend debe usar arquitectura React orientada a funcionalidades."
    - "Las llamadas API viven fuera de componentes React; el cliente API tiene timeout y manejo estructurado de errores."
    - "Textos de UI en español, nombres de código en inglés."
    - "Las colecciones MongoDB usan nombres singulares en inglés."
    - "Los scripts init/seed de base de datos se almacenan solo en database/."
    - "Incluir pruebas unitarias backend para reglas de dominio y detección de conflictos."
    - "Incluir pruebas frontend para cliente API e interacciones clave."
    - "Comandos de prueba ejecutables desde checkout limpio con cwd, run, purpose y expected exit code."
    - "Los reportes QA deben citar comandos, códigos de salida y archivos reales."
    - "Los reportes AppSec deben citar archivos, líneas o controles concretos."
    - "La preparación para release debe verificar Docker Compose, healthchecks, .env.example, despliegue, rollback y startup reproducible."

  user_stories:
    - "Como gestor de horarios, quiero crear y administrar rooms para asignar espacios físicos a bloques de horario."
    - "Como gestor de horarios, quiero crear y administrar training groups para asignar cohortes a bloques de horario."
    - "Como gestor de horarios, quiero crear y administrar instructors para asignar personal calificado a bloques de horario."
    - "Como gestor de horarios, quiero crear schedule blocks con asignaciones de room/group/instructor y que el sistema prevenga conflictos."
    - "Como gestor de horarios, quiero agregar observations a los bloques para comunicar incidencias."
    - "Como gestor de horarios, quiero ver un endpoint de healthcheck que confirme la conexión del backend con la base de datos."

  acceptance_criteria:
    - "docker compose up --build inicia contenedores de database, backend y frontend."
    - "El healthcheck del backend retorna 200 solo cuando MongoDB es alcanzable."
    - "El frontend puede listar y crear rooms, instructors, training groups, schedule blocks y observations a través de la API backend."
    - "Las reglas de conflicto impiden doble asignación de room, instructor o training group en rangos superpuestos."
    - "Todas las pruebas pasan desde un checkout limpio con los comandos proporcionados."
    - "Ningún componente se entrega como archivo monolítico."
    - "Ningún código técnico ni objeto de esquema usa nombres en español."
    - "El estado final no se marca como completed a menos que QA, AppSec y release gates pasen con evidencia verificable."

  scope:
    in_scope:
      - "CRUD de room y detección de conflictos"
      - "CRUD de training group y detección de conflictos"
      - "CRUD de instructor y detección de conflictos"
      - "CRUD de schedule block, validación y prevención de conflictos"
      - "Creación de observation en bloques con niveles de severidad"
      - "Backend Go por capas con MongoDB"
      - "Frontend React orientado a funcionalidades con UI en español"
      - "Orquestación con Docker Compose y healthchecks"
      - "Pruebas unitarias de reglas de dominio y conflictos"
      - "Pruebas frontend para cliente API e interacciones clave"
      - "Datos seed y scripts de inicialización en inglés"
    out_of_scope:
      - "Autenticación y autorización de usuarios"
      - "Notificaciones en tiempo real o alertas por correo"
      - "Dashboards de analítica o reportes"
      - "Soporte multilenguaje"
      - "Optimización de diseño móvil"
      - "Integración con calendarios externos"
      - "Algoritmos automáticos de programación"
      - "Auditoría más allá del historial de observaciones"

  stakeholders:
    - "Coordinadores académicos y gestores de horarios del SENA"
    - "Instructores"
    - "Equipo de operaciones TI del SENA"
    - "Equipo de aseguramiento de calidad"
    - "Equipo de seguridad"
    - "Equipo de desarrollo"

  quality_score: 92
```
