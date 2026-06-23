# Estrategia de migraciones

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Datos / DevOps

## Principios

- Cada servicio versiona sus propias migraciones.
- Una migracion no debe modificar tablas de otra BD.
- Los cambios destructivos requieren plan de compatibilidad.
- Toda migracion debe poder ejecutarse en dev, qa, stage y prod.

## Tipos de cambio

| Tipo | Manejo |
|---|---|
| Agregar tabla | Migracion normal con rollback documentado |
| Agregar columna nullable | Permitido sin version mayor |
| Renombrar columna | Crear nueva, migrar datos, deprecar anterior |
| Eliminar columna | Solo despues de confirmar que ningun consumidor la usa |
| Cambiar relacion | ADR o registro de decision requerido |

## Validacion

- Ejecutar migraciones en entorno de prueba.
- Verificar datos semilla.
- Probar rollback si aplica.
- Registrar cambios en CHANGELOG.

