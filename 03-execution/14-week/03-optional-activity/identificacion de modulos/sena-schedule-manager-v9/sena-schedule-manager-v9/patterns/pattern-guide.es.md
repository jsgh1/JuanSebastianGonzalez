```yaml
architecture:
  adr_document: |
    # ADR-001: Decisión arquitectónica - Clean Architecture

    ## Contexto
    El proyecto SENA Schedule Manager requiere un backend Go con capas estrictas y un frontend React con estructura orientada a funcionalidades. El dominio tiene complejidad moderada: CRUD de entidades con reglas de conflicto por superposición de horarios. La vida útil del producto es a largo plazo, con alta exigencia de testeabilidad, mantenibilidad y sustitución de adaptadores.

    ## Decisión
    Se adopta **Clean Architecture** como patrón primario para el backend. Las capas siguen la regla de dependencia hacia adentro:
    - Dominio: entidades y reglas de negocio puras.
    - Aplicación: casos de uso.
    - Transporte (HTTP): handlers, DTOs y routing.
    - Persistencia: repositorios como interfaces en `internal/repository` e implementaciones concretas en `internal/infrastructure`.
    - Infraestructura: configuración, cliente MongoDB, logging, etc.

    ## Consecuencias
    - Alta testeabilidad: dominio y aplicación pueden probarse sin infraestructura.
    - Sustitución de adaptadores sin afectar la lógica de negocio.
    - Curva de aprendizaje inicial para el equipo.
    - Riesgo de sobreingeniería, mitigado manteniendo el alcance MVP.
  patterns:
    - Clean Architecture
  quality_score: 0.90
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
        - init
        - seed
        - Dockerfile
      source_extensions:
        - .sh
        - .js
      test_patterns:
        - "*.test.sh"
      minimum_source_files: 1
    backend:
      root: backend
      required_paths:
        - Dockerfile
        - cmd/api
        - internal/domain
        - internal/application
        - internal/http
        - internal/repository
        - internal/infrastructure
      source_extensions:
        - .go
      test_patterns:
        - "*_test.go"
      minimum_source_files: 4
      entrypoints:
        - path: backend/cmd/api/main.go
          purpose: Solo bootstrap y wiring
          forbidden_patterns:
            - mongodb\.Connect
            - .*repository\.New.*Mongo.*
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
        - src/types
      source_extensions:
        - .ts
        - .tsx
      test_patterns:
        - "*.test.ts"
        - "*.test.tsx"
      minimum_source_files: 4
      entrypoints:
        - path: frontend/src/app/main.tsx
          purpose: Solo composición/routing
          forbidden_patterns:
            - localStorage
            - sessionStorage
            - fetch(
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
```
