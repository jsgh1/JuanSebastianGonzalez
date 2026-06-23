# Alcance del proyecto

> Estado: En progreso En progreso | Última actualización: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Documentacion

## En alcance

- Gestión de **fichas de formación** (agregar, editar, eliminar, consultar)
- Gestión de **competencias y RAPs** asociados a fichas
- Gestión de **instructores** (registro, perfiles, disponibilidad)
- Gestión de **aprendices** (inscritos, etapa productiva)
- Gestión de **ambientes de formación** (aulas, laboratorios, inventario)
- **Motor de asignación automática** de horarios basado en restricciones
- **Validación de conflictos** antes de guardar asignaciones
- **Notificaciones** a instructores y responsables administrativos
- **Reporte de horarios** por ficha, instructor y ambiente
- **KPIs de ocupación** y utilización de recursos
- **Auditoría append-only** de todas las operaciones
- **Documentos y plantillas** (certificados, diplomas, reportes PDF)
- **Gestión de datos de referencia** (centros, regiones, formadores, parámetros)

## Fuera de alcance

- Gestión de nóminas o contratos de instructores
- Evaluación y calificaciones de aprendices
- Plataforma de aprendizaje virtual (LMS)
- Registro y control de asistencia biométrica
- Integración con sistemas financieros o presupuestales
- Gestión de eventos externos (seminarios, conferencias)
- Exportación a formatos propietarios de terceros (SAP, Oracle, etc.)

## Supuestos

- Se asume que existen instructores y ambientes registrados previamente en el sistema
- Las fichas de formación siguen un calendario académico definido por el SENA
- Los usuarios tienen acceso a navegadores web modernos
- Existe conectividad de red estable en todas las sedes
- La capacidad computacional disponible es suficiente para cálculos de asignación en tiempo real
- Los datos de entrada (competencias, RAPs, disponibilidades) son validados antes de ingreso

## Restricciones

- **Regulatorias:** El sistema debe cumplir con normativas internas del SENA sobre gobernanza de datos
- **Técnicas:** Tiempo de respuesta del motor de asignación < 5 segundos para fichas típicas
- **Operacionales:** Las asignaciones no pueden cambiar sin autorización explícita de directores de centro
- **De seguridad:** No se puede modificar auditoría una vez registrada (append-only)
- **De datos:** Retención mínima de 7 años para registros de auditoría
- **De acceso:** Acceso basado en roles: dirección, coordinación, instructor


