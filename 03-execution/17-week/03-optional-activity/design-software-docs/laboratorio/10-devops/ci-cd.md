# CI/CD

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: DevOps

## Pipeline sugerido

1. Validar formato y lint.
2. Ejecutar pruebas unitarias.
3. Ejecutar pruebas de integracion si aplica.
4. Construir artefacto o imagen.
5. Escanear vulnerabilidades.
6. Publicar artefacto.
7. Desplegar en dev.
8. Promover a qa, stage y prod segun aprobaciones.

## Reglas

- Ningun cambio debe llegar a prod sin pruebas basicas.
- Las migraciones se ejecutan de forma controlada.
- El rollback debe estar documentado por servicio.
- Los workers se despliegan como componentes independientes.

