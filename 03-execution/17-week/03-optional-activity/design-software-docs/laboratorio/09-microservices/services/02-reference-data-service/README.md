# reference-data-service

> Fuente: tabla de microservicios definida para el laboratorio

## Base de datos

ref_db

## Responsabilidad

Datos de referencia institucionales y catalogos compartidos.

## Entidades que posee

- macroregion -> centro_formacion
- catalogo
- estado
- parametro

## Componentes desplegables

- reference-data-api

## Regla de ownership

Este servicio es la fuente canonica de las entidades listadas. Otros servicios deben consultar por API, eventos o cache documentada; no deben escribir directamente en esta base de datos.


