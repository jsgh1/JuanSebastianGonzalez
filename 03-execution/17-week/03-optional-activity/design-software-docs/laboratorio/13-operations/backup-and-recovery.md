# Backup y recuperacion

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Operaciones / Datos

## Politica

| Elemento | Frecuencia | Retencion |
|---|---|---|
| Bases transaccionales | Diario | 30 dias |
| Auditoria | Diario + archivado | 7 anos |
| Documentos generados | Diario | 3 anos |
| Configuracion | Por cambio | 1 ano |

## Objetivos

- RPO menor a 1 hora para datos criticos.
- RTO menor a 4 horas para servicios core.
- Prueba de restauracion al menos por entrega importante.

## Recuperacion

1. Identificar servicio afectado.
2. Detener escrituras si hay riesgo de corrupcion.
3. Restaurar backup en ambiente controlado.
4. Validar integridad.
5. Promover restauracion si aplica.
6. Registrar auditoria del proceso.

