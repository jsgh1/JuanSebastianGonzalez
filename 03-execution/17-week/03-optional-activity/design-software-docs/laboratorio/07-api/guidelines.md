# Guidelines de API

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: API / Arquitectura

## Convenciones REST

- Prefijo de version: /api/v1.
- Recursos en plural.
- JSON como formato principal.
- Codigos HTTP consistentes.
- Paginacion para listados.

## Codigos comunes

| Codigo | Uso |
|---|---|
| 200 | Consulta exitosa |
| 201 | Recurso creado |
| 400 | Error de validacion |
| 401 | No autenticado |
| 403 | Sin permisos |
| 404 | Recurso no encontrado |
| 409 | Conflicto de negocio |
| 500 | Error interno |

## Reglas

- No exponer campos internos innecesarios.
- Validar entrada con schema.
- Incluir correlationId en errores.
- Documentar contratos en OpenAPI.

