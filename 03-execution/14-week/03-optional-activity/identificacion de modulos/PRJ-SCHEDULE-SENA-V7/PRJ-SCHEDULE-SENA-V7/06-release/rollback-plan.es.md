# Plan de Reversión

## Disparadores
- Problema crítico P0 en producción después del despliegue.
- Falla en una migración de base de datos.

## Procedimiento
1. `docker compose down`
2. Revertir a las etiquetas de imagen anteriores en `docker-compose.yml`.
3. Restaurar la base de datos desde la copia previa al despliegue.
4. `docker compose up -d`

## Tiempo Estimado
15 minutos.

## Responsable
Gerente de Release A11.
