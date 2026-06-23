# actors-service

> Fuente: tabla de microservicios definida para el laboratorio

## Base de datos

actors_db

## Responsabilidad

Gestion de actores del proceso formativo: instructores, aprendices, empresas y etapa productiva.

## Entidades que posee

- instructor
- aprendiz
- empresa
- etapa_productiva
- bitacora

## Componentes desplegables

- actors-api

## Regla de ownership

Este servicio es la fuente canonica de las entidades listadas. Otros servicios deben consultar por API, eventos o cache documentada; no deben escribir directamente en esta base de datos.


