```yaml
architecture:
  adr_document: |
    # ADR-001: Decisión Arquitectónica - Clean Architecture para SENA Schedule Manager v8

    ## Contexto

    El producto SENA Schedule Manager v8 es una aplicación interna para gestionar operaciones de un centro de formación. Incluye la administración de entornos de aprendizaje, horarios, grupos de formación, instructores y observaciones operativas. El MVP busca funcionalidades básicas de CRUD, pero con un énfasis no negociable en arquitectura, calidad, seguridad y preparación para el lanzamiento. El equipo es de tamaño moderado y se espera que el producto tenga una vida útil considerable con posibles extensiones futuras. Se requiere una división clara en `database/`, `backend/` y `frontend/`, con independencia de contenedores.

    ## Decisión

    Se ha seleccionado **Clean Architecture** como patrón arquitectónico primario para el backend (Go) y sus principios para el frontend (React).

    ### Justificación
    1.  **Dominio Complejo a Mediano Plazo**: Aunque el MVP actual es un CRUD básico, el dominio de gestión de horarios y personal en un centro de formación puede crecer en complejidad (por ejemplo, optimización de horarios, gestión avanzada de recursos, integración con otros sistemas). Clean Architecture proporciona la flexibilidad necesaria para acomodar esta evolución sin reescrituras mayores.
    2.  **Mantenibilidad y Testeabilidad**: La separación estricta de capas y la inversión de dependencias garantizan que la lógica de negocio central (`domain` y `application`) sea completamente independiente de detalles externos como la base de datos o el framework web. Esto facilita pruebas unitarias e integración robustas, y simplifica el mantenimiento a largo plazo.
    3.  **Independencia de Frameworks y Base de Datos**: Uno de los principios clave de Clean Architecture es la independencia de los detalles externos. Esto permite, por ejemplo, cambiar la base de datos o el framework web con un impacto mínimo sobre la lógica central del negocio.
    4.  **Cumplimiento de NFRs y Reglas No Negociables**:
        *   "Backend must respect dependency inversion and clean architecture boundaries": cumplimiento directo.
        *   "Frontend must avoid monolithic pages/components and must keep API clients outside components": los principios de Clean Architecture se adaptan bien a la separación de responsabilidades en frontend.
        *   Asegura calidad y robustez del sistema desde el inicio, alineándose con el requisito de no reducir arquitectura ni calidad por tratarse de un MVP.

    ### Descartes
    *   **DDD (Domain-Driven Design)**: Aunque apropiado para dominios muy complejos, para un MVP con CRUD básicos podría introducir una sobrecarga inicial significativa.
    *   **Hexagonal Architecture**: Muy similar a Clean Architecture. Clean ofrece una guía más detallada sobre las capas internas, por eso se elige por su explicitud.
    *   **Modular Monolith**: No aplica dado el requisito explícito de tener tres proyectos independientes (`database/`, `backend/`, `frontend/`).
    *   **CQRS**: Demasiado complejo para un MVP cuyas necesidades asimétricas de lectura/escritura aún no están demostradas.

    ## Consecuencias

    ### Positivas
    *   **Alta Cohesión, Bajo Acoplamiento**: Cada capa tiene una responsabilidad clara, lo que facilita el entendimiento y la modificación.
    *   **Mayor Testeabilidad**: La lógica de negocio puede probarse de forma aislada, sin infraestructura externa.
    *   **Flexibilidad Tecnológica**: Permite cambiar componentes de infraestructura con menor impacto.
    *   **Escalabilidad del Equipo**: Facilita que distintos equipos trabajen en diferentes capas o dominios con menos conflictos.

    ### Negativas
    *   **Curva de Aprendizaje Inicial**: Requiere un entendimiento sólido de los principios de Clean Architecture.
    *   **Boilerplate**: Puede introducir más archivos y abstracciones para tareas simples.
    *   **Configuración Inicial Más Compleja**: El wiring o inyección de dependencias puede ser más elaborado al inicio.

    ## Estructura de Capas y Restricciones

    ### Backend (Go) - Clean Architecture
    La dirección de las flechas indica la dirección permitida de las dependencias.

    ```
    infrastructure/
      ├─ transport/ (HTTP handlers, DTOs, routing)
      ├─ persistence/ (Repository implementations, DB clients, ORM)
      └─ services/ (External service clients, e.g., email sender)
          ↓
    application/
      ├─ usecase/ (Application-specific business rules, orchestrates domain entities)
      ├─ port/ (Interfaces for secondary actors - repositories, external services)
      └─ event/ (Application-specific events)
          ↓
    domain/
      ├─ entity/ (Enterprise-wide business rules, core entities)
      ├─ valueobject/ (Small objects that represent a conceptual whole)
      ├─ service/ (Domain services that encapsulate business logic involving multiple entities)
      └─ event/ (Domain events)
    ```

    **Reglas de Dependencia (Backend):**
    *   Las dependencias solo pueden apuntar hacia adentro.
    *   `infrastructure` depende de `application`.
    *   `application` depende de `domain`.
    *   `main.go` es el punto de entrada y se encarga del wiring e inicialización. No debe contener lógica de negocio.

    ### Frontend (React) - Principios de Clean Architecture
    Aunque React no impone una arquitectura estricta, aplicaremos los principios de Clean Architecture para organizar el código.

    ```
    frontend/
      ├─ src/
      │  ├─ app/ (Root application setup, routing, layout)
      │  ├─ features/ (Self-contained, domain-specific modules with components, hooks, services)
      │  │  ├─ [feature-name]/
      │  │  │  ├─ components/ (UI components specific to this feature)
    │  │  │  ├─ hooks/ (Custom hooks for feature logic)
    │  │  │  ├─ services/ (API client calls specific to this feature, interacts with backend ports)
    │  │  │  ├─ pages/ (Feature-specific pages, orchestrates components and hooks)
      │  ├─ shared/
      │  │  ├─ components/ (Reusable UI components across features)
      │  │  ├─ hooks/ (Reusable general-purpose hooks)
      │  │  ├─ services/ (General-purpose API client, authentication, utilities)
      │  │  ├─ utils/ (Utility functions)
      │  ├─ lib/ (External libraries or configurations)
      │  ├─ public/ (Static assets)
      │  ├─ index.js (Entry point)
    ```

    **Reglas de Dependencia (Frontend):**
    *   `features/` puede usar componentes, hooks y servicios de `shared/`.
    *   `app/` orquesta `features/` y `shared/components`.
    *   Las páginas dentro de `features/[feature-name]/pages` orquestan los componentes y hooks de su propia funcionalidad.
    *   Los servicios son la única capa que interactúa directamente con la API del backend. Los componentes y hooks NO deben hacer llamadas `fetch` directamente.

    ### Database (MongoDB)
    ```
    database/
      ├─ Dockerfile (MongoDB container setup)
      ├─ docker-compose.yml (Service definition, volumes)
      ├─ init-mongo.js (Initialization script, user creation)
      ├─ schema-validation/ (JSON Schema for collections)
      │  ├─ instructor.json
      │  ├─ environment.json
      │  ├─ group.json
      │  ├─ schedule.json
      │  ├─ observation.json
      ├─ migrations/ (Scripts for schema changes)
      ├─ seed/ (Initial data for collections)
      │  ├─ seed-instructors.js
      │  ├─ seed-environments.js
    ```

    **Reglas de Dependencia (Database):**
    *   El directorio `database/` es autocontenido y no debe depender de `backend/` o `frontend/` para su inicialización.
    *   Las validaciones de esquema son la única "lógica de negocio" que reside en la base de datos, asegurando la integridad de los datos en persistencia.
  patterns:
    - Clean Architecture
  quality_score: 0.9
  separation_of_concerns:
    backend_root: backend
    domain: backend/domain
    application: backend/application
    transport: backend/infrastructure/transport
    persistence: backend/infrastructure/persistence
    database_root: database
    database_migrations: database/migrations
    database_seed: database/seed
    frontend_root: frontend
    frontend_app: frontend/src/app
    frontend_features: frontend/src/features
    frontend_services: frontend/src/shared/services
  architecture_contract:
    database:
      root: database
      required_paths:
        - migrations
        - seed
        - Dockerfile
        - init-mongo.js
      source_extensions:
        - .js
        - .json
      test_patterns:
        - "database/tests/**/*.js"
      minimum_source_files: 4
    backend:
      root: backend
      required_paths:
        - Dockerfile
        - domain
        - application
        - infrastructure/transport
        - infrastructure/persistence
      source_extensions:
        - .go
      test_patterns:
        - "backend/**/*_test.go"
      minimum_source_files: 10
      entrypoints:
        - path: main.go
          purpose: Solo bootstrap y wiring
          forbidden_patterns:
            - "func (s *Service) "
            - "db.Collection("
            - "http.HandleFunc"
          max_function_declarations: 3
    frontend:
      root: frontend
      required_paths:
        - Dockerfile
        - src/app
        - src/features
        - src/shared/components
        - src/shared/services
      source_extensions:
        - .js
        - .jsx
        - .ts
        - .tsx
      test_patterns:
        - "frontend/**/*.test.js"
        - "frontend/**/*.test.jsx"
      minimum_source_files: 8
      entrypoints:
        - path: src/app/App.jsx
          purpose: Solo composición/routing
          forbidden_patterns:
            - localStorage
            - sessionStorage
            - "fetch("
            - "axios."
            - "db.Collection("
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
