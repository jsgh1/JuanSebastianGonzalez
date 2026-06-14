```yaml
architecture:
  adr_document: |
    # ADR-001: Arquitectura en Capas Go React Mongo

    Contexto: SENA Schedule Manager V6 es un MVP operativo pequeño, pero tiene
    suficientes reglas de dominio para requerir límites limpios: validación de tiempo de horario,
    tipo de instructor, capacidad de aula y observaciones vinculadas a horarios.
    El runtime también exige que base de datos, backend y frontend se validen como
    componentes independientes.

    Decisión: usar Clean Architecture con límites hexagonales para el backend,
    un frontend React orientado a funcionalidades y un proyecto MongoDB separado.
    Las dependencias del backend apuntan hacia adentro: los adaptadores de transporte llaman casos de uso,
    application coordina dominio y puertos de repositorio, domain permanece puro,
    y repository/infrastructure mapea documentos de persistencia a objetos de dominio.
    La inicialización, índices y datos semilla de la base de datos viven solo en el
    componente database. La composición y el routing del frontend viven en app, la UI de cada feature
    vive en features, los widgets reutilizables en components y todas las llamadas API
    viven en services con manejo de timeout.

    Consecuencias: esta estructura es mayor que la de una demo rápida, pero evita
    fallos observados en pruebas anteriores: handlers/páginas monolíticos, metadatos Mongo
    en entidades de dominio, seed embebido en backend, evidencia de QA narrativa
    y release sin rollback. El alcance MVP se reduce a CRUD y
    flujos de validación centrales, mientras arquitectura, pruebas, seguridad y release readiness
    siguen siendo obligatorios.

    Lista de validación: el entrypoint del backend es solo bootstrap; domain/core no tiene
    metadatos de persistencia ni transporte; los handlers no contienen acceso directo a la base de datos;
    los repositorios no contienen preocupaciones HTTP; App.jsx es solo composición;
    database es dueña de init, seed e índices; cada componente tiene un
    límite de contenedor; los artefactos de QA, AppSec y release se producen antes de completar.
  patterns:
    - Clean Architecture
    - Hexagonal Architecture
    - SOLID
  quality_score: 0.91
  separation_of_concerns:
    backend_root: backend
    domain: backend/internal/domain
    application: backend/internal/application
    transport: backend/internal/http
    persistence: backend/internal/repository
    database_root: database
    database_migrations: database/init
    database_seed: database/seed
    frontend_root: frontend
    frontend_app: frontend/src/app
    frontend_features: frontend/src/features
    frontend_services: frontend/src/services
  architecture_contract:
    database:
      root: database
      required_paths:
        - Dockerfile
        - init
        - seed
        - tests
      source_extensions:
        - .js
        - .json
      test_patterns:
        - "*.test.js"
        - "validate-*.js"
      minimum_source_files: 2
    backend:
      root: backend
      required_paths:
        - Dockerfile
        - cmd/api
        - internal/config
        - internal/domain
        - internal/application
        - internal/http
        - internal/repository
      source_extensions:
        - .go
      test_patterns:
        - "*_test.go"
      minimum_source_files: 8
      entrypoints:
        - path: cmd/api/main.go
          purpose: Solo bootstrap e inyección de dependencias
          forbidden_patterns:
            - "mongo.Connect"
            - "InsertOne"
            - "Find("
            - "CreateOne"
            - "seed"
            - "createIndexes"
          max_function_declarations: 3
    frontend:
      root: frontend
      required_paths:
        - Dockerfile
        - src/app
        - src/features
        - src/components
        - src/services
        - src/hooks
      source_extensions:
        - .js
        - .jsx
      test_patterns:
        - "*.test.jsx"
        - "*.test.js"
      minimum_source_files: 8
      entrypoints:
        - path: src/app/App.jsx
          purpose: Solo composición y routing
          forbidden_patterns:
            - localStorage
            - sessionStorage
            - "fetch("
            - "axios."
          max_function_declarations: 5
  skill_selection:
    backend:
      - backend/senior-backend.md
      - backend/go.md
    frontend:
      - frontend/senior-frontend.md
      - frontend/react.md
    database:
      - database/mongo.md
    qa:
      - qa/contract-verification.md
    security:
      - security/api.md
  tech_stack:
    backend: Go
    frontend: React
    database: MongoDB
    runtime: Docker Compose
```
