# Entidades y reglas de negocio

> Estado: En progreso En progreso | Última actualización: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Documentacion

## Entidades principales por contexto

### IAM Context

**Usuario**
- Propiedades: ID, correo, nombre, estado (activo/inactivo), último login
- Invariantes: correo único, contraseña hasheada

**Rol**
- Propiedades: nombre, descripción, permisos
- Valores: DIRECTOR, COORDINADOR, INSTRUCTOR, APRENDIZ, ADMIN

**Sesión**
- Propiedades: token, usuario, fecha inicio, fecha expiración, IP
- Invariantes: una sesión activa por usuario a la vez (configurable)

### Reference Data Context

**Centro de formación**
- Propiedades: ID, nombre, región, dirección, teléfono
- Invariantes: nombre único por región

**Región**
- Propiedades: ID, nombre, dirección nacional
- Invariantes: nombre único

**Parámetro**
- Propiedades: clave, valor, tipo, descripción
- Ejemplos: MAX_APRENDICES_POR_FICHA, JORNADA_INICIO_MANANA, etc.

### Training Environment Context

**Ambiente**
- Propiedades: ID, nombre, centro, capacidad, tipo (aula/laboratorio/taller), recursos
- Invariantes: capacidad > 0, nombre único por centro

**Disponibilidad de Ambiente**
- Propiedades: ambiente ID, horario (día/hora), disponible (sí/no), razón
- Regla: se regenera semanalmente o a demanda

**Inventario**
- Propiedades: ambiente ID, recurso, cantidad, estado
- Ejemplos: computadoras, escritorios, proyectores

### Academic Management Context

**Programa**
- Propiedades: ID, nombre, duración (horas), competencias
- Ejemplo: ADSO (Análisis y Desarrollo de Sistemas de Información)

**Competencia**
- Propiedades: ID, nombre, descripción, programa ID, RAPs
- Invariantes: nombre único por programa

**RAP (Resultado de Aprendizaje Específico)**
- Propiedades: ID, nombre, competencia ID, criterios de evaluación
- Invariantes: identificable únicamente dentro de su competencia

**Ficha de formación**
- Propiedades: ID, programa, centro, jornada, fecha inicio, aprendices, coordinador
- Invariantes: debe tener al menos 1 aprendiz
- Estados: PLANEACION, EJECUCION, FINALIZADA

### Actors Context

**Instructor**
- Propiedades: ID, nombre, especialidades (competencias), disponibilidad
- Invariantes: debe tener al menos una especialidad
- Relaciones: puede impartir múltiples RAPs

**Aprendiz**
- Propiedades: ID, nombre, documento, ficha ID, estado
- Estados: FORMACION_COMPLEMENTARIA, ETAPA_PRODUCTIVA, EGRESADO
- Invariantes: pertenece a exactamente una ficha

**Empresa**
- Propiedades: ID, razón social, NIT, sector, ubicación
- Invariantes: NIT único

### Scheduling Context

**Horario**
- Propiedades: ID, ficha, instructor, ambiente, bloque horario (día/hora), sesión_clase
- Invariantes: no puede haber conflicto (ver regla Conflicto)
- Estados: ASIGNADO, EJECUTANDO, COMPLETADO, CANCELADO

**Conflicto**
- Propiedades: ID, tipo (instructor duplicado / ambiente duplicado), horarios involucrados
- Regla: Se genera automáticamente si se intenta crear un horario conflictivo

**Sesión de clase**
- Propiedades: ID, ficha, instructor, ambiente, bloque horario, aprendices, RAPs
- Invariantes: debe incluir al menos 1 RAP

### Monitoring Context

**KPI**
- Tipos: ocupación (%), carga instructor (horas/semana), eficiencia ambiente (%)
- Frecuencia: cálculo diario a las 23:59

**Alerta**
- Generada cuando KPI cruza umbral definido
- Ejemplo: instructor > 30 horas/semana → ALERTA de sobrecarga

**Notificación**
- Propiedades: ID, usuario destino, tipo, contenido, fecha, leída
- Canales: email, SMS (en v2)

### Documents Context (Transversal)

**Plantilla**
- Propiedades: ID, nombre, tipo (certificado/diploma/reporte), variables, formato

**Documento**
- Propiedades: ID, plantilla, ficha/usuario destino, contenido generado, PDF, fecha
- Versiones: cada cambio crea nueva versión

### Audit Context (Transversal)

**Registro de auditoría**
- Propiedades: ID, timestamp, usuario, acción, entidad, cambios (antes/después)
- Regla: **APPEND-ONLY** — nunca se modifica ni elimina
- Retención: mínimo 7 años

## Reglas de negocio clave

### R1: No solapamiento de horarios

**Regla:** Un instructor no puede estar asignado a dos fichas en el mismo horario. Un ambiente no puede tener dos sesiones simultáneas.

**Consecuencia:** Si se intenta crear un horario que viola esto, el sistema rechaza y registra un Conflicto.

### R2: Capacidad de ambiente

**Regla:** El número de aprendices en una sesión no puede exceder la capacidad del ambiente.

**Consecuencia:** Error al crear/editar sesión.

### R3: Instructor debe tener competencia

**Regla:** Un instructor solo puede impartir RAPs en sus especialidades registradas.

**Consecuencia:** Error al asignar instructor a sesión que requiere RAP no cubierto.

### R4: Disponibilidad de ambiente

**Regla:** Un ambiente solo puede programarse en franjas horarias donde esté disponible (mantenimiento, etc.).

**Consecuencia:** Error al crear horario fuera de disponibilidad.

### R5: Auditoría inmutable

**Regla:** Ningún registro en la tabla de auditoría puede ser modificado, solo leído.

**Consecuencia:** Implementación técnica con BD append-only o constrains a nivel aplicación.

### R6: Notificaciones automáticas

**Regla:** Cambios en horarios, conflictos o KPIs generan automáticamente notificaciones a interesados.

**Consecuencia:** Coordinadores e instructores reciben alertas en tiempo real.

### R7: Cálculo de KPIs diario

**Regla:** KPIs se recalculan cada día; comparación con umbrales genera alertas.

**Frecuencia:** 23:59 (configurable).

### R8: Una ficha, un coordinador

**Regla:** Cada ficha tiene exactamente un coordinador responsable.

**Consecuencia:** Cambio de coordinador requiere explicitación en auditoría.

