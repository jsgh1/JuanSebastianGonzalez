# academic-management-service

> Fuente: tabla de microservicios definida para el laboratorio

## Base de datos

academic_db

## Responsabilidad

Gestion academica: programas, competencias, resultados de aprendizaje, fichas y oferta.

## Entidades que posee

- programa
- competencia
- RAP
- ficha
- oferta

## Componentes desplegables

- academic-management-api

## Regla de ownership

Este servicio es la fuente canonica de las entidades listadas. Otros servicios deben consultar por API, eventos o cache documentada; no deben escribir directamente en esta base de datos.


