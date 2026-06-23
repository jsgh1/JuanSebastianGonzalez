# Checklist de preparación de servicios

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Documentacion

## Propósito

Verificación sistemática de que un microservicio está listo para:
1. **Merge a rama main** (código)
2. **Deploy a producción** (infraestructura, seguridad, operaciones)
3. **Integración en sistema** (APIs, eventos, datos)

## Fase 1: Documentación (Pre-desarrollo)

### Definición del servicio

- [ ] Bounded context definido (ver [domain-map.md](./domain-map.md))
- [ ] Responsabilidad del servicio en una línea
- [ ] Dependencias mapeadas (ver [dependency-map.md](./dependency-map.md))
- [ ] ADR creada en `05-architecture/decisions/records/ADR-XXX-service-creation.md`
- [ ] Servicio registrado en [service-catalog.md](./service-catalog.md)
- [ ] Eventos documentados en [event-catalog.md](./event-catalog.md)
- [ ] Datos mapeados en [data-ownership-matrix.md](./data-ownership-matrix.md)
- [ ] Límites con otros servicios claros (ver [service-boundary-rules.md](./service-boundary-rules.md))

## Fase 2: Implementación

### Código y arquitectura

- [ ] Estructura de carpetas sigue convención
- [ ] Cada componente (api, worker, etc.) es independiente
- [ ] BD propia creada (aislada, sin acceso compartido)
- [ ] Conexión a BD usa pool (no conexión única)
- [ ] Migración de schema está versionada
- [ ] Modelos de dominio mapeados a schema

### APIs

- [ ] API definida en OpenAPI 3.0 (archivo `.yaml` en `07-api/contracts/openapi/`)
- [ ] Endpoints documentados (descripción, parámetros, respuestas, errores)
- [ ] Versionado: `/api/v1/` como prefijo
- [ ] Códigos HTTP correctos (200, 201, 400, 404, 500, etc.)
- [ ] Paginación implementada si retorna listas
- [ ] Rate limiting configurado
- [ ] CORS configurado (si aplica)

### Seguridad

- [ ] Autenticación vía JWT (token validado)
- [ ] Autorización basada en roles
- [ ] Entrada validada (schema, tipos, límites)
- [ ] No hay credenciales en código
- [ ] Secrets en Key Vault, no en config
- [ ] HTTPS solo (TLS 1.3)
- [ ] Logs no exponen PII o secrets

### Calidad

- [ ] Unit tests (coverage > 70%)
- [ ] Integration tests (testcontainers para BD)
- [ ] API tests (Postman, HTTP client)
- [ ] Linting sin errores
- [ ] SonarQube / code review aprobado
- [ ] No hay deudas técnicas críticas

### Observabilidad

- [ ] Logs estructurados (JSON)
- [ ] Niveles de log configurables (DEBUG, INFO, WARN, ERROR)
- [ ] Rastreo distribuido (correlation ID)
- [ ] Métricas expuestas (Prometheus /metrics)
- [ ] Health checks (`/health`, `/ready`)
- [ ] APM integrado (Application Insights, Jaeger, etc.)

## Fase 3: Integración

### Eventos

- [ ] Publicador de eventos implementado
- [ ] Suscriptor de eventos implementado (si aplica)
- [ ] Idempotencia garantizada (deduplicación)
- [ ] Dead Letter Queue configurada
- [ ] Reintentos con exponential backoff
- [ ] Timeout configurado (> 5 min)

### Comunicación síncrona

- [ ] Llamadas a otros servicios tienen circuit breaker
- [ ] Fallback a caché si otro servicio falla
- [ ] Timeout < 30 segundos
- [ ] Retry con backoff en errores transitorios

### BD y datos

- [ ] BD propia creada en entorno (dev, qa, prod)
- [ ] Credenciales de BD en Key Vault
- [ ] Migración de schema automatizada
- [ ] Backup/restore probado
- [ ] Índices creados en columnas de búsqueda
- [ ] Query performance aceptable (< 200ms para 99%ile)

### Documentación

- [ ] `README.md` completo en carpeta de servicio
- [ ] `data-model.md` documenta entidades
- [ ] `api-contract.md` documentado (o referencia OpenAPI)
- [ ] `events.md` documenta eventos publicados/consumidos
- [ ] `runbook.md` con deploy, rollback, troubleshooting
- [ ] Todos archivos en 🟡 o 🟢 (no 🟡 Pendiente)

## Fase 4: DevOps e Infraestructura

### Containerización

- [ ] Dockerfile multi-stage
- [ ] Base image slim/alpine (< 300MB)
- [ ] Health check en Dockerfile
- [ ] Non-root user
- [ ] Imagen builds sin errores
- [ ] Imagen escanea vulnerabilidades (< 5 críticas)

### Orquestación (Kubernetes si aplica)

- [ ] Deployment manifest
- [ ] Service manifest
- [ ] ConfigMap para configuración
- [ ] Secret para credenciales (vinculado a Key Vault)
- [ ] Resource requests/limits
- [ ] Autoscaling configurado (HPA)
- [ ] Health probes (liveness, readiness)
- [ ] Resource quotas respetadas

### CI/CD

- [ ] Pipeline automático (GitHub Actions, Azure Pipelines)
- [ ] Build triggered en push a rama feature
- [ ] Tests ejecutan antes de merge
- [ ] Imagen se sube a registry (ACR)
- [ ] Deploy automático a dev/qa
- [ ] Deploy manual aprobado a prod (PAT)
- [ ] Rollback automático si health checks fallan

### Monitoreo

- [ ] Application Insights / Datadog / New Relic configurado
- [ ] Alertas en errores > 5% de requests
- [ ] Alertas en latencia p99 > umbral
- [ ] Dashboard creado (overview, errors, latency, dependencies)
- [ ] SLA documentado (uptime, latency, error rate)

### Operaciones

- [ ] Runbook en servicio (deploy, rollback, troubleshooting)
- [ ] Oncall rotation definida
- [ ] Escalation path claro
- [ ] Postmortem template listo (incident.md)
- [ ] Backup automático (si BD transaccional)
- [ ] Disaster recovery plan (RTO < 4h, RPO < 1h)

## Fase 5: Producción

### Validación previa

- [ ] Smoke tests en prod (endpoint básico responde)
- [ ] Datos de test completamente removidos
- [ ] Credenciales reales en Key Vault (no hardcoded)
- [ ] Logs van a almacenamiento centralizado
- [ ] Alertas configuradas correctamente
- [ ] Runbook y oncall notificados

### Deployment

- [ ] Blue-green deployment o canary
- [ ] Rollback plan activado (si needed)
- [ ] Versión de código tageada en Git
- [ ] CHANGELOG actualizado
- [ ] Release notes publicadas

### Post-deployment

- [ ] Monitoreo de errores durante 24h
- [ ] Métricas de éxito evaluadas
- [ ] Feedback de usuarios recolectado
- [ ] Observaciones documentadas
- [ ] Mejoras identificadas para v1.1

## Checklist rápido (1 página)

**Antes de merge a main:**
- [ ] Documentación 🟡 o 🟢
- [ ] Tests > 70%
- [ ] Linting OK
- [ ] No secrets en código
- [ ] APIs versionadas
- [ ] Eventos idempotentes
- [ ] Circuit breaker + retries

**Antes de prod:**
- [ ] Dockerfile multi-stage < 300MB
- [ ] Kubernetes manifests
- [ ] CI/CD pipeline OK
- [ ] Application Insights / moniteo
- [ ] Backup/restore probado
- [ ] Oncall notificado
- [ ] Smoke tests OK

**En producción:**
- [ ] Monitorear 24h
- [ ] Incident response listo
- [ ] Métricas de éxito evaluadas
- [ ] Retroalimentación documentada

## Cambios después de producción

| Cambio | Requiere... | Urgencia |
|---|---|---|
| Bug crítico (fallo 100%) | Hotfix, deploy inmediato | CRÍTICA |
| Bug mayor (fallo > 10%) | Hotfix, deploy < 2h | ALTA |
| Bug menor (fallo < 10%) | Siguiente release | NORMAL |
| Feature nueva | Release planeado | NORMAL |
| Breaking change API | Major version + deprecación | NORMAL |
| Cambio de seguridad | Hotfix inmediato | CRÍTICA |

## Estado de servicios

- 🟡 **Pendiente:** Documentación no iniciada
- 🟡 **En progreso:** Código en desarrollo o testing
- 🟢 **Estable:** En producción, mantenido
- ⚫ **Deprecado:** Reemplazado, sunset en progreso"

