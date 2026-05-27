# Tree Docs

## Introducción

Esta estructura está pensada como una base documental reutilizable para proyectos de software modernos, especialmente proyectos construidos con microservicios.

La idea principal es que no dependa de un negocio específico. Es decir, la misma estructura puede servir para:

- una fintech,
- un ecommerce,
- un ERP,
- una plataforma educativa,
- un sistema de salud,
- una app logística,
- un SaaS,
- o cualquier otro sistema.

La estructura original estaba bastante bien orientada a microservicios, pero tenía partes acopladas al dominio SENA. Esta versión se reorganizó para volverla completamente reutilizable y adaptable a cualquier proyecto.

---

# Cómo está distribuida la estructura

La estructura sigue una lógica progresiva:

```text
Gobierno documental
    ↓
Contexto del proyecto
    ↓
Dominio del negocio
    ↓
Definición del producto
    ↓
Arquitectura técnica
    ↓
Datos y APIs
    ↓
Seguridad
    ↓
DevOps y QA
    ↓
UX y backlog
    ↓
Microservicios
    ↓
Operación
    ↓
Capacitación
    ↓
Archivo histórico
```

La idea es que la documentación no quede desordenada, sino conectada con el ciclo real del sistema.

---

# Árbol de la estructura final

```text
TREE-DOCS/
│
├── README.md
├── CHANGELOG.md
├── CONTRIBUTING.md
├── CODE_OF_CONDUCT.md
├── LICENSE
│
├── .github/
│   ├── pull_request_template.md
│   └── workflows/
│       ├── docs-lint.yml
│       ├── links-check.yml
│       └── docs-build.yml
│
├── docs/
│   │
│   ├── README.md
│   │
│   ├── 00-documentation-governance/
│   │   ├── README.md
│   │   ├── repository-purpose.md
│   │   ├── documentation-rules.md
│   │   ├── naming-conventions.md
│   │   ├── folder-conventions.md
│   │   ├── versioning-rules.md
│   │   ├── review-process.md
│   │   ├── contribution-workflow.md
│   │   └── definition-of-done.md
│   │
│   ├── 01-project-context/
│   │   ├── README.md
│   │   ├── business-context.md
│   │   ├── problem-space.md
│   │   ├── stakeholders.md
│   │   ├── business-objectives.md
│   │   ├── scope.md
│   │   ├── out-of-scope.md
│   │   ├── constraints.md
│   │   ├── assumptions.md
│   │   ├── risks.md
│   │   └── glossary.md
│   │
│   ├── 02-domain/
│   │   ├── README.md
│   │   ├── domain-overview.md
│   │   ├── domain-glossary.md
│   │   ├── actors.md
│   │   ├── business-rules.md
│   │   ├── domain-boundaries.md
│   │   ├── bounded-contexts.md
│   │   └── examples/
│   │       └── .gitkeep
│   │
│   ├── 03-product-definition/
│   │   ├── README.md
│   │   ├── product-vision.md
│   │   ├── product-goals.md
│   │   ├── mvp-definition.md
│   │   ├── roadmap.md
│   │   ├── user-personas.md
│   │   ├── user-journeys.md
│   │   ├── functional-requirements.md
│   │   ├── non-functional-requirements.md
│   │   └── acceptance-criteria.md
│   │
│   ├── 04-architecture/
│   │   ├── README.md
│   │   ├── architecture-principles.md
│   │   ├── architecture-overview.md
│   │   ├── architecture-decisions-summary.md
│   │   ├── quality-attributes.md
│   │   ├── integration-strategy.md
│   │   ├── deployment-strategy.md
│   │   ├── scalability-strategy.md
│   │   ├── resilience-strategy.md
│   │   │
│   │   ├── c4/
│   │   │   ├── README.md
│   │   │   ├── level-1-context.md
│   │   │   ├── level-2-containers.md
│   │   │   ├── level-3-components.md
│   │   │   └── level-4-code.md
│   │   │
│   │   ├── adr/
│   │   │   ├── README.md
│   │   │   ├── proposed/
│   │   │   │   └── ADR-000-template.md
│   │   │   ├── accepted/
│   │   │   │   └── .gitkeep
│   │   │   ├── superseded/
│   │   │   │   └── .gitkeep
│   │   │   └── rejected/
│   │   │       └── .gitkeep
│   │   │
│   │   └── diagrams/
│   │       ├── README.md
│   │       ├── source/
│   │       │   ├── plantuml/
│   │       │   │   └── .gitkeep
│   │       │   ├── mermaid/
│   │       │   │   └── .gitkeep
│   │       │   └── drawio/
│   │       │       └── .gitkeep
│   │       └── exported/
│   │           ├── png/
│   │           │   └── .gitkeep
│   │           └── svg/
│   │               └── .gitkeep
│   │
│   ├── 05-data-architecture/
│   │   ├── README.md
│   │   ├── conceptual-model.md
│   │   ├── logical-model.md
│   │   ├── relational-model.md
│   │   ├── event-model.md
│   │   ├── entity-catalog.md
│   │   ├── data-dictionary.md
│   │   ├── database-standards.md
│   │   ├── migration-strategy.md
│   │   └── diagrams/
│   │       ├── erd.md
│   │       ├── mer.md
│   │       └── event-storming.md
│   │
│   ├── 06-api-design/
│   │   ├── README.md
│   │   ├── api-standards.md
│   │   ├── naming-conventions.md
│   │   ├── error-handling.md
│   │   ├── pagination-filtering-sorting.md
│   │   ├── authentication-authorization.md
│   │   ├── rate-limiting.md
│   │   ├── versioning.md
│   │   └── contracts/
│   │       ├── openapi/
│   │       │   └── .gitkeep
│   │       ├── asyncapi/
│   │       │   └── .gitkeep
│   │       └── graphql/
│   │           └── .gitkeep
│   │
│   ├── 07-security/
│   │   ├── README.md
│   │   ├── security-principles.md
│   │   ├── identity-access-management.md
│   │   ├── roles-permissions.md
│   │   ├── threat-model.md
│   │   ├── data-protection.md
│   │   ├── secrets-management.md
│   │   ├── compliance.md
│   │   ├── auditability.md
│   │   └── security-checklist.md
│   │
│   ├── 08-devops/
│   │   ├── README.md
│   │   ├── repository-strategy.md
│   │   ├── branching-strategy.md
│   │   ├── ci-cd-strategy.md
│   │   ├── infrastructure-as-code.md
│   │   ├── environments.md
│   │   ├── docker-standards.md
│   │   ├── kubernetes-guidelines.md
│   │   ├── deployment-checklist.md
│   │   └── observability.md
│   │
│   ├── 09-quality-assurance/
│   │   ├── README.md
│   │   ├── testing-strategy.md
│   │   ├── unit-testing.md
│   │   ├── integration-testing.md
│   │   ├── contract-testing.md
│   │   ├── e2e-testing.md
│   │   ├── performance-testing.md
│   │   ├── security-testing.md
│   │   ├── accessibility-testing.md
│   │   └── quality-gates.md
│   │
│   ├── 10-user-experience/
│   │   ├── README.md
│   │   ├── ux-principles.md
│   │   ├── information-architecture.md
│   │   ├── navigation-model.md
│   │   ├── wireframes.md
│   │   ├── design-system.md
│   │   ├── accessibility-guidelines.md
│   │   └── usability-testing.md
│   │
│   ├── 11-backlog/
│   │   ├── README.md
│   │   ├── epics/
│   │   │   └── .gitkeep
│   │   ├── features/
│   │   │   └── .gitkeep
│   │   ├── user-stories/
│   │   │   └── HU-000-template.md
│   │   ├── tasks/
│   │   │   └── TASK-000-template.md
│   │   ├── spikes/
│   │   │   └── .gitkeep
│   │   └── traceability-matrix.md
│   │
│   ├── 12-microservices/
│   │   ├── README.md
│   │   ├── microservice-catalog.md
│   │   ├── communication-patterns.md
│   │   ├── service-mesh.md
│   │   ├── event-driven-architecture.md
│   │   │
│   │   ├── microservice-template/
│   │   │   ├── README.md
│   │   │   ├── service-context.md
│   │   │   ├── service-responsibilities.md
│   │   │   ├── service-boundaries.md
│   │   │   ├── service-api.md
│   │   │   ├── service-events.md
│   │   │   ├── service-data-model.md
│   │   │   ├── service-security.md
│   │   │   ├── service-deployment.md
│   │   │   ├── service-testing.md
│   │   │   ├── service-observability.md
│   │   │   └── service-runbook.md
│   │   │
│   │   └── services/
│   │       ├── .gitkeep
│   │       └── README.md
│   │
│   ├── 13-operations/
│   │   ├── README.md
│   │   ├── runbooks.md
│   │   ├── incident-management.md
│   │   ├── backup-restore.md
│   │   ├── monitoring-alerting.md
│   │   ├── sla-slo-sli.md
│   │   ├── disaster-recovery.md
│   │   └── support-model.md
│   │
│   ├── 14-training-and-adoption/
│   │   ├── README.md
│   │   ├── onboarding.md
│   │   ├── developer-guide.md
│   │   ├── user-manual.md
│   │   ├── administrator-guide.md
│   │   ├── faq.md
│   │   └── tutorials/
│   │       └── .gitkeep
│   │
│   └── 99-archive/
│       ├── README.md
│       ├── deprecated/
│       │   └── .gitkeep
│       └── legacy/
│           └── .gitkeep
│
├── templates/
│   ├── README.md
│   ├── adr-template.md
│   ├── backlog-item-template.md
│   ├── api-contract-template.md
│   ├── microservice-doc-template.md
│   ├── runbook-template.md
│   ├── incident-template.md
│   ├── test-plan-template.md
│   ├── risk-template.md
│   └── decision-log-template.md
│
├── assets/
│   ├── README.md
│   ├── images/
│   │   └── .gitkeep
│   ├── icons/
│   │   └── .gitkeep
│   ├── diagrams/
│   │   └── .gitkeep
│   └── exports/
│       └── .gitkeep
│
└── tools/
    ├── README.md
    ├── validate-docs.ps1
    ├── validate-links.ps1
    ├── generate-index.ps1
    ├── generate-diagrams.ps1
    └── validate-adr.ps1
```

---

# Explicación de cada bloque

## Archivos raíz

### `README.md`
Presentación principal del repositorio.

### `CHANGELOG.md`
Historial de cambios importantes.

### `CONTRIBUTING.md`
Reglas para contribuir al proyecto.

### `CODE_OF_CONDUCT.md`
Normas de convivencia y colaboración.

### `LICENSE`
Licencia legal del proyecto.

---

# `.github/`

Contiene automatizaciones y flujos de trabajo.

Aquí normalmente viven:

- validaciones automáticas,
- pipelines,
- reglas de revisión,
- workflows de CI/CD,
- templates de pull requests.

Sirve para mantener ordenado el trabajo entre equipos.

---

# `docs/`

Es el núcleo completo de la documentación.

---

## `00-documentation-governance/`

Define cómo se maneja la documentación.

Aquí se establecen:

- reglas de escritura,
- convenciones de nombres,
- versionado,
- revisiones,
- flujo de contribuciones,
- definición de terminado.

Es el “manual interno” de la documentación.

---

## `01-project-context/`

Explica el contexto del proyecto.

Aquí se documenta:

- el problema,
- los objetivos,
- el alcance,
- las restricciones,
- los riesgos,
- el glosario.

Sirve para entender por qué existe el sistema.

---

## `02-domain/`

Documenta el dominio del negocio.

Aquí viven:

- actores,
- reglas de negocio,
- límites del dominio,
- bounded contexts,
- glosarios,
- ejemplos.

Esta carpeta es una de las más importantes en microservicios porque ayuda a separar responsabilidades correctamente.

---

## `03-product-definition/`

Define qué va a construir el sistema.

Incluye:

- visión,
- roadmap,
- MVP,
- requisitos,
- personas,
- user journeys.

Convierte las necesidades del negocio en producto.

---

## `04-architecture/`

Es el centro técnico de la estructura.

Aquí se documenta:

- arquitectura general,
- decisiones técnicas,
- integración,
- despliegue,
- escalabilidad,
- resiliencia.

También incluye:

### `c4/`
Diagramas arquitectónicos en distintos niveles.

### `adr/`
Architectural Decision Records.

### `diagrams/`
Diagramas fuente y exportados.

---

## `05-data-architecture/`

Documenta cómo se manejan los datos.

Incluye:

- modelos conceptuales,
- modelos lógicos,
- modelos relacionales,
- catálogo de entidades,
- diccionario de datos,
- modelos de eventos,
- migraciones.

Muy importante en arquitecturas distribuidas.

---

## `06-api-design/`

Define cómo se comunican los servicios.

Incluye:

- estándares API,
- autenticación,
- autorización,
- versionado,
- manejo de errores,
- contratos OpenAPI,
- AsyncAPI,
- GraphQL.

---

## `07-security/`

Centraliza la seguridad del sistema.

Aquí se documenta:

- identidades,
- permisos,
- amenazas,
- protección de datos,
- secretos,
- cumplimiento,
- auditoría.

---

## `08-devops/`

Documenta cómo se construye y despliega el sistema.

Incluye:

- CI/CD,
- Docker,
- Kubernetes,
- infraestructura como código,
- ambientes,
- observabilidad.

---

## `09-quality-assurance/`

Agrupa toda la estrategia de pruebas.

Incluye:

- unit testing,
- integration testing,
- contract testing,
- e2e,
- performance,
- quality gates.

---

## `10-user-experience/`

Contiene toda la documentación UX.

Incluye:

- wireframes,
- navegación,
- arquitectura de información,
- design system,
- accesibilidad,
- pruebas de usabilidad.

---

## `11-backlog/`

Organiza el trabajo del producto.

Incluye:

- épicas,
- features,
- historias,
- tareas,
- spikes,
- trazabilidad.

---

## `12-microservices/`

Es la carpeta principal para arquitectura distribuida.

Aquí se documenta:

- catálogo de microservicios,
- patrones de comunicación,
- arquitectura orientada a eventos,
- service mesh,
- plantillas por servicio.

Cada microservicio puede tener su propia documentación independiente.

---

## `13-operations/`

Documentación operacional.

Incluye:

- runbooks,
- monitoreo,
- incidentes,
- backups,
- disaster recovery,
- soporte,
- SLAs.

Sirve cuando el sistema ya está funcionando en producción.

---

## `14-training-and-adoption/`

Se usa para onboarding y capacitación.

Incluye:

- manuales,
- FAQs,
- onboarding,
- tutoriales,
- guía de desarrolladores,
- guía de administradores.

---

## `99-archive/`

Material legado o deprecated.

Se usa para guardar documentación antigua sin eliminarla.

---

# `templates/`

Plantillas reutilizables.

Ayudan a que todos documenten con el mismo formato.

---

# `assets/`

Recursos gráficos y archivos de apoyo.

---

# `tools/`

Scripts de automatización y validación documental.

---

# Comparación entre la estructura original y la estructura final

## Lo que tenía la estructura original

La estructura original ya era bastante buena para microservicios.

Tenía:

- arquitectura,
- APIs,
- seguridad,
- DevOps,
- QA,
- documentación por microservicio,
- ADRs,
- C4,
- modelos de datos.

El principal problema era que algunas partes estaban acopladas a un proyecto específico.

Ejemplo:

```text
02-sena-domain/
├── aprendiz.md
├── instructor.md
├── ficha.md
```

Eso hacía que la estructura estuviera ligada al contexto SENA.

---

# Qué se cambió en la versión final

## 1. Se volvió genérica

Se eliminó el acoplamiento al dominio SENA.

Antes:

```text
02-sena-domain/
```

Ahora:

```text
02-domain/
```

Eso permite usar la estructura en cualquier proyecto.

---

## 2. Se fortaleció la arquitectura de microservicios

Se agregaron elementos más modernos:

- event-driven-architecture,
- service mesh,
- contract testing,
- resiliencia,
- escalabilidad,
- observabilidad,
- GraphQL,
- infraestructura como código.

---

## 3. Se mejoró la parte operacional

Se agregaron:

- SLA/SLO/SLI,
- disaster recovery,
- tutorials,
- developer-guide.

---

## 4. Se hizo más enterprise

La estructura final ya funciona como:

- framework documental,
- plantilla enterprise,
- base reutilizable,
- estándar multi-equipo,
- documentación cloud-native.

---

# Conclusión

La estructura final cumple dos objetivos importantes:

## 1. Está preparada para microservicios

Porque incluye:
- comunicación entre servicios,
- APIs,
- eventos,
- DevOps,
- observabilidad,
- resiliencia,
- despliegues independientes,
- documentación por servicio.

## 2. Es reutilizable

Porque ya no depende de un negocio concreto.

Puede reutilizarse en prácticamente cualquier proyecto moderno sin necesidad de rehacer toda la organización documental.
