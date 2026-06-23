# document-service

> Fuente: tabla de microservicios definida para el laboratorio

## Base de datos

document_db

## Responsabilidad

Documentos, versiones, plantillas, generacion de PDF y ciclo de vida documental.

## Entidades que posee

- documento
- version
- plantilla

## Componentes desplegables

- document-api
- template-api
- pdf-renderer-worker
- document-lifecycle-worker

## Regla de ownership

Este servicio es la fuente canonica de las entidades listadas. Otros servicios deben consultar por API, eventos o cache documentada; no deben escribir directamente en esta base de datos.


