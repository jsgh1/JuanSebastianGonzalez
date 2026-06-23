# Aspectos transversales

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Arquitectura

## Seguridad

- JWT para autenticacion.
- Roles y permisos administrados por iam-service.
- Minimo privilegio por endpoint.
- No registrar tokens, claves ni informacion sensible en logs.

## Observabilidad

- Logs estructurados.
- Correlation ID por solicitud.
- Metricas por latencia, errores, colas y disponibilidad.
- Trazas para flujos entre servicios.

## Resiliencia

- Timeouts en llamadas sincronas.
- Retry solo para errores transitorios.
- Circuit breaker para dependencias externas.
- Dead Letter Queue para eventos no procesados.

## Datos

- Cada servicio es propietario de su BD.
- Sin escritura directa entre bases de datos.
- Eventos para sincronizacion eventual.
- Auditoria append-only para operaciones relevantes.

