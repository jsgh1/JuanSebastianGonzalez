# Modelo de datos del servicio

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Datos / Desarrollo

## Entidades

| Entidad | Proposito | Campos clave | Reglas |
|---|---|---|---|
| entidad_ejemplo | Agregado principal | id, estado, created_at | Pertenece solo a este servicio |

## Ownership

- El servicio es fuente canonica de sus entidades.
- Otros servicios consultan por API, evento o cache.
- No se permite escritura directa desde otra BD.

