# Runbook del servicio

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Operaciones / Desarrollo

## Health checks

- /health: proceso vivo.
- /ready: dependencias disponibles.

## Despliegue

1. Validar variables de entorno.
2. Ejecutar migraciones si aplica.
3. Desplegar version.
4. Verificar health checks.

## Rollback

1. Detener despliegue actual.
2. Restaurar version anterior.
3. Validar compatibilidad de datos.
4. Registrar incidente si hubo impacto.

