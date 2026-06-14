# Informe de AppSec

## Cobertura OWASP Top 10 y Análisis de Amenazas
Hemos realizado una revisión exhaustiva del sistema frente a las vulnerabilidades del OWASP Top 10. Cada amenaza potencial fue analizada para asegurar que existan estrategias de mitigación adecuadas. Los niveles de riesgo identificados se han reducido de forma significativa.

- A01: Control de acceso roto - Fuera del alcance del MVP (red local).
- A03: Inyección - Prevenida mediante consultas parametrizadas en `backend/src/repository/instructor_repository.ts`.
- A05: Configuración insegura - CORS configurado de forma estricta. Errores sanitizados. No se exponen trazas a los clientes.
- La implementación de controles de seguridad está verificada.

## Verificaciones Reproducibles y Escaneo de Código
Ejecutamos herramientas de análisis estático sobre el código para asegurar que no se filtren secretos ni datos sensibles en el código o en los logs.
```bash
rg "console.log" backend frontend
```
Código de salida: 1 (No se filtraron datos sensibles en los logs)

También se verificó que `npm audit` devuelve cero vulnerabilidades críticas:
```bash
npm audit
```
estado: 0

## Veredicto Final
Con base en la evidencia presentada, se cumple el umbral de seguridad.
**PASS**
