# Ambientes

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: DevOps

| Ambiente | Proposito | Aprobacion |
|---|---|---|
| local | Desarrollo individual | Desarrollador |
| dev | Integracion de cambios | Equipo tecnico |
| qa | Pruebas funcionales y regresion | QA |
| stage | Simulacion de produccion | Lider tecnico |
| prod | Operacion real | Responsable del proyecto |

## Reglas

- Configuracion separada por ambiente.
- Secrets fuera del repositorio.
- Datos reales solo en produccion.
- Datos de stage deben estar anonimizados.
- Cambios en prod requieren evidencia de QA o aprobacion.

