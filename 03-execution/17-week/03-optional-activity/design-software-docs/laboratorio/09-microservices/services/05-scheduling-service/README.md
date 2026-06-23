# scheduling-service

> Fuente: tabla de microservicios definida para el laboratorio

## Base de datos

scheduling_db

## Responsabilidad

Motor de asignacion de horarios, sesiones de clase, franjas, asignaciones y conflictos.

## Entidades que posee

- horario
- sesion_clase
- franja
- asignacion
- conflicto

## Componentes desplegables

- schedules-api
- scheduling-engine-workflow
- conflict-validator-worker

## Regla de ownership

Este servicio es la fuente canonica de las entidades listadas. Otros servicios deben consultar por API, eventos o cache documentada; no deben escribir directamente en esta base de datos.


