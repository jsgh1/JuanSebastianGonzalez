# Despliegue

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: DevOps / Arquitectura

## Ambientes

| Ambiente | Uso | Datos |
|---|---|---|
| local | Desarrollo individual | Datos semilla |
| dev | Integracion temprana | Datos de prueba |
| qa | Validacion funcional y regresion | Datos controlados |
| stage | Ensayo de produccion | Datos anonimizados |
| prod | Operacion real | Datos reales |

## Unidad de despliegue

Cada API o worker se despliega como componente independiente. Los componentes pesados, como generacion de PDF o validacion asincrona, se ejecutan como workers.

## Reglas

- Configuracion por variables de entorno.
- Secrets fuera del repositorio.
- Health checks obligatorios.
- Rollback documentado por servicio.
- Migraciones versionadas antes de liberar cambios incompatibles.

