# training-environment-service

> Fuente: tabla de microservicios definida para el laboratorio

## Base de datos

env_db

## Responsabilidad

Ambientes de formacion, inventario, mantenimiento, reservas y disponibilidad.

## Entidades que posee

- ambiente
- inventario
- mantenimiento
- reserva
- disponibilidad

## Componentes desplegables

- training-environment-api

## Regla de ownership

Este servicio es la fuente canonica de las entidades listadas. Otros servicios deben consultar por API, eventos o cache documentada; no deben escribir directamente en esta base de datos.


