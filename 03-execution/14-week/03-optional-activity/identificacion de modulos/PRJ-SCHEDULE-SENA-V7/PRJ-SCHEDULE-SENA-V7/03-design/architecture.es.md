# Arquitectura

## Componentes
1. **Frontend**: SPA en React para la interacción del usuario.
2. **Backend**: Servidor API en Express que entrega JSON.
3. **Base de datos**: PostgreSQL para almacenamiento persistente.

## Comunicación
El frontend se comunica con el backend mediante llamadas HTTP RESTful sobre JSON.
El backend se comunica con la base de datos mediante SQL sobre TCP/IP usando el controlador `pg`.

## Responsabilidades
- Frontend: renderizado de la interfaz, gestión de estado e integración con la API.
- Backend: enrutamiento, validación, lógica de negocio y lógica de persistencia.
- Base de datos: integridad de datos y restricciones relacionales.
