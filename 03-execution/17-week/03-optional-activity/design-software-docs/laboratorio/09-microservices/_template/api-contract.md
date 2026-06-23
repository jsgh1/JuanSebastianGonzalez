# Contrato API del servicio

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Arquitectura / Desarrollo

## Endpoints

| Metodo | Ruta | Proposito | Autenticacion | Respuestas |
|---|---|---|---|---|
| GET | /api/v1/recurso/{id} | Consultar recurso | JWT | 200, 401, 404 |
| POST | /api/v1/recurso | Crear recurso | JWT + permiso | 201, 400, 409 |

## Reglas

- Versionar desde /api/v1.
- Documentar errores y ejemplos.
- No exponer campos internos de BD.
- Enlazar OpenAPI oficial cuando exista.

