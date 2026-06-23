# monitoring-service

> Fuente: tabla de microservicios definida para el laboratorio

## Base de datos

monitoring_db

## Responsabilidad

Seguimiento de KPIs, alertas, notificaciones, sesiones de seguimiento y planes de mejoramiento.

## Entidades que posee

- seguimiento_kpi
- alerta
- notificacion
- sesion_seguimiento
- plan_mejoramiento

## Componentes desplegables

- monitoring-api
- alert-worker
- notification-worker

## Regla de ownership

Este servicio es la fuente canonica de las entidades listadas. Otros servicios deben consultar por API, eventos o cache documentada; no deben escribir directamente en esta base de datos.


