# Code review

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Desarrollo / Calidad

## Checklist

- El cambio respeta el ownership del servicio.
- No escribe en bases de datos ajenas.
- Contratos API o eventos estan actualizados.
- Incluye pruebas suficientes para el riesgo.
- No expone secrets ni datos sensibles.
- Maneja errores y validaciones.
- Actualiza documentacion relacionada.
- Mantiene trazabilidad de auditoria si aplica.

## Bloqueantes

- Credenciales en codigo.
- Breaking change sin versionado.
- Falta de pruebas en flujo critico.
- Acoplamiento directo entre bases de datos.
- Logs con tokens o informacion sensible.

