# Observabilidad

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Operaciones

## Logs

- JSON estructurado.
- Correlation ID.
- Nivel: DEBUG, INFO, WARN, ERROR.
- Sin tokens ni datos sensibles.

## Metricas

| Metrica | Servicio |
|---|---|
| Latencia API | Todos |
| Errores 4xx y 5xx | Todos |
| Eventos procesados | Workers |
| Mensajes en DLQ | Eventos |
| Conflictos detectados | scheduling-service |
| PDFs generados | document-service |
| Alertas activas | monitoring-service |

## Alertas

- API no disponible.
- Error rate alto.
- Latencia p95 elevada.
- Cola acumulada.
- DLQ con mensajes.

