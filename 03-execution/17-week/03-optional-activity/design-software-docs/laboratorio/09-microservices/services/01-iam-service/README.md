# iam-service

> Fuente: tabla de microservicios definida para el laboratorio

## Base de datos

iam_db

## Responsabilidad

Autenticacion, autorizacion, roles, permisos, sesiones y tokens.

## Entidades que posee

- usuario
- rol
- permiso
- sesion
- token

## Componentes desplegables

- iam-api

## Regla de ownership

Este servicio es la fuente canonica de las entidades listadas. Otros servicios deben consultar por API, eventos o cache documentada; no deben escribir directamente en esta base de datos.


