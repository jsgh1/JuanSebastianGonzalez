# Patrones de comunicación

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Documentacion

## Comunicación síncrona

### REST (Principal)

- **Uso:** Consultas, operaciones CRUD simples, solicitudes que requieren respuesta inmediata
- **Protocolo:** HTTP/HTTPS
- **Versionado:** Mediante header `Accept: application/vnd.service+json;version=1`
- **Documentación:** OpenAPI 3.0 en [07-api/contracts/openapi/](../../07-api/contracts/openapi/)

**Ejemplo:** `GET /api/v1/fichas/{fichaId}` (academic-management-service)

### gRPC (Para operaciones internas heavy)

- **Uso:** Comunicación interna entre servicios de alto volumen; scheduling-engine consultando datos académicos
- **Protocolo:** Protocol Buffers + HTTP/2
- **Latencia esperada:** < 100ms
- **Resiliencia:** Reintentos automáticos con backoff exponencial

**Ejemplo:** scheduling-service llama internamente a academic-management-service para validar RAPs

## Comunicación asíncrona

### Event Streaming (Principal)

- **Broker:** Azure Service Bus o Apache Kafka (por definir)
- **Modelo:** Publicador-Suscriptor (publish-subscribe)
- **Garantía:** At-least-once delivery
- **Formato:** JSON + envelope estándar (tipo evento, timestamp, usuario, payload)

**Flujo principal:**
1. Servicio A publica evento
2. Broker distribuye a suscriptores registrados
3. Cada consumidor procesa en su propia transacción
4. Audit registra el evento recibido

**Ejemplo:**
```
FichaCreada 
  → Scheduling (actualiza matriz)
  → Documents (prepara plantillas)
  → Audit (registra creación)
  → Notifications (avisa coordinador)
```

### Eventos típicos por servicio

Ver [event-catalog.md](./event-catalog.md) para el listado completo.

## Resiliencia y tolerancia a fallos

### Circuit Breaker

- **Librería:** Polly (.NET) o Resilience4j (Java)
- **Umbrales:** Activación en 3 fallos consecutivos
- **Estados:** Closed → Open (fallo) → Half-Open (recuperación) → Closed
- **Timeout:** 30 segundos en estado Open

### Retry

- **Política:** Exponential backoff (1s, 2s, 4s, máx 32s)
- **Máx intentos:** 3
- **Aplica solo a:** Errores transitorios (5xx, timeout)

### Timeout

- **REST:** 30 segundos
- **gRPC:** 5 segundos
- **Async (evento):** Sin timeout (se reinventa bajo demanda)

### Dead Letter Queue

- **Uso:** Eventos que fallan después de máx intentos
- **Retención:** 30 días
- **Monitoreo:** Alerta si DLQ recibe > 5 mensajes/hora

## Patrones por caso de uso

### Asignación de horarios (síncrona)

```
Cliente 
  → POST /schedules (scheduling-service)
  → Valida capacidad (training-environment gRPC)
  → Valida competencias (academic-management gRPC)
  → Valida disponibilidad instructor (actors gRPC)
  → Genera/detecta conflictos
  → Responde 201 Created o 400 Conflict
```

### Notificación de alerta (asíncrona)

```
Monitoring-service 
  → Publica AlertaGenerada
  → notification-worker escucha
  → Envía email/SMS
  → Publica NotificacionEnviada
  → Audit registra
```

### Cambio de ficha (mixto)

```
Cliente 
  → PUT /fichas/{id} (academic-management-service)
  → Valida cambio (síncrono)
  → Publica FichaModificada (asíncrono)
  → Otros servicios reaccionan en background
  → Responde 200 OK inmediatamente
```


