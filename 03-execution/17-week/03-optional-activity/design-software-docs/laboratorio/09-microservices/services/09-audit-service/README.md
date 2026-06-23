# audit-service

> Fuente: tabla de microservicios definida para el laboratorio

## Base de datos

audit_db

## Responsabilidad

Auditoria inmutable append-only para trazabilidad de operaciones.

## Entidades que posee

- auditoria (append-only, sin updates)

## Componentes desplegables

- audit-worker

## Regla de ownership

Este servicio es la fuente canonica de auditoria. Otros servicios publican o envian eventos para registro, pero no modifican directamente esta base de datos.

## Regla especial

La auditoria es append-only: los registros historicos no se actualizan ni se eliminan; cualquier correccion se registra como un nuevo evento de auditoria.


