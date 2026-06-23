# Estrategia de pruebas

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Calidad

## Niveles

| Nivel | Objetivo |
|---|---|
| Unitarias | Validar reglas internas |
| Integracion | Validar BD, broker, cache y APIs internas |
| API | Validar contratos HTTP |
| End to end | Validar flujos completos |
| Regresion | Evitar romper funcionalidades existentes |

## Flujos criticos

- Autenticacion y permisos.
- Crear ficha y datos academicos.
- Reservar ambiente.
- Crear horario sin conflicto.
- Detectar conflicto.
- Generar documento.
- Registrar auditoria.

## Criterio minimo

Cada servicio debe cubrir reglas de negocio principales, contratos publicos y errores esperados.

