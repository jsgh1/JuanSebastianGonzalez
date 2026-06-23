# Eventos del servicio

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Arquitectura / Desarrollo

## Publicados

| Evento | Cuando ocurre | Payload minimo | Consumidores |
|---|---|---|---|
| dominio.entidad.creada | Se crea una entidad | id, fecha, usuarioId | audit-service |

## Consumidos

| Evento | Productor | Accion local | Idempotencia |
|---|---|---|---|
| refdata.parametro.actualizado | reference-data-service | Invalidar cache | eventId unico |

## Reglas

- Incluir eventId, occurredAt, producer y correlationId.
- Consumidores idempotentes.
- Fallos persistentes van a DLQ.

