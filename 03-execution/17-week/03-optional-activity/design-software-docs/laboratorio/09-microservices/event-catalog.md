# Catálogo de eventos

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Documentacion

## Estructura de evento

Todo evento sigue este envelope:

```json
{
  \"id\": \"evt-uuid\",
  \"type\": \"dominio.entidad.verbo\",
  \"version\": \"1.0\",
  \"timestamp\": \"2026-06-22T14:30:00Z\",
  \"userId\": \"usr-001\",
  \"source\": \"iam-service\",
  \"payload\": { /* datos específicos */ },
  \"metadata\": {
    \"correlationId\": \"corr-uuid\",
    \"causationId\": \"evt-uuid-anterior\",
    \"environment\": \"production\"
  }
}
```

## Catálogo por servicio

### IAM Service

| Evento | Disparador | Consumidores | Payload |
|---|---|---|---|
| `iam.usuario.creado` | Usuario registrado | Audit, Notifications | usuarioId, email, rol, timestamp |
| `iam.usuario.desactivado` | Admin desactiva usuario | Scheduling, Audit, Notifications | usuarioId, razon |
| `iam.sesion.iniciada` | Login exitoso | Audit, Monitoring | usuarioId, ip, userAgent |
| `iam.rol.modificado` | Cambio en permisos de rol | Audit, todos (revalidar) | rolId, permisosAntes, permisosAhora |

### Reference Data Service

| Evento | Disparador | Consumidores | Payload |
|---|---|---|---|
| `refdata.parametro.actualizado` | Admin actualiza parámetro | Audit, Scheduling (invalida caché) | parametroKey, valorAntes, valorAhora |
| `refdata.centro.registrado` | Nuevo centro agregado | Audit, Notifications | centroId, nombre |
| `refdata.centro.modificado` | Centro editado | Audit, todos (caché) | centroId, cambios |

### Academic Management Service

| Evento | Disparador | Consumidores | Payload |
|---|---|---|---|
| `academic.ficha.creada` | Nueva ficha registrada | Scheduling, Audit, Notifications | fichaId, programa, centro, jornada, coordinador |
| `academic.ficha.modificada` | Cambio en ficha | Scheduling, Audit, Notifications, Monitoring | fichaId, cambios (antes/ahora) |
| `academic.ficha.finalizada` | Cierre de ficha | Documents (certificados), Audit, Monitoring, Notifications | fichaId, fecha |
| `academic.competencia.modificada` | Cambio en competencia | Scheduling (invalida caché), Audit | competenciaId, cambios |
| `academic.rap.modificado` | RAP editado | Scheduling, Document, Audit | rapId, cambios |
| `academic.aprendiz.asignado` | Aprendiz inscrito en ficha | Audit, Notifications, Monitoring | aprendizId, fichaId |

### Training Environment Service

| Evento | Disparador | Consumidores | Payload |
|---|---|---|---|
| `env.ambiente.creado` | Nuevo ambiente registrado | Scheduling, Audit | ambienteId, nombre, capacidad, centro |
| `env.ambiente.nodisponible` | Ambiente en mantenimiento | Scheduling (generar conflictos), Audit, Notifications | ambienteId, fechaInicio, fechaFin, razon |
| `env.ambiente.disponible` | Mantenimiento completado | Scheduling (revalidar), Audit | ambienteId |
| `env.inventario.actualizado` | Cambio en recursos | Audit | ambienteId, recurso, cantidadAntes, cantidadAhora |

### Actors Service

| Evento | Disparador | Consumidores | Payload |
|---|---|---|---|
| `actors.instructor.registrado` | Nuevo instructor | Scheduling, Audit | instructorId, especialidades, centro |
| `actors.instructor.modificado` | Cambio en instructor | Scheduling (revalidar asignaciones), Audit, Notifications | instructorId, cambios |
| `actors.aprendiz.registrado` | Nuevo aprendiz | Academic, Audit, Monitoring | aprendizId, documento, nombre, centro |
| `actors.empresa.registrada` | Empresa para etapa productiva | Audit | empresaId, razonSocial, nit |

### Scheduling Service (CORE)

| Evento | Disparador | Consumidores | Payload |
|---|---|---|---|
| `scheduling.horario.asignado` | Horario creado (sin conflictos) | Audit, Notifications, Documents, Monitoring | horarioId, fichaId, instructorId, ambienteId, franja |
| `scheduling.horario.cancelado` | Cancelación de horario | Audit, Notifications, Monitoring | horarioId, razon |
| `scheduling.conflicto.detectado` | Solapamiento encontrado | Audit, Notifications (alerta director) | conflictoId, tipo, horariosInvolucrados |
| `scheduling.sesion.completada` | Sesión de clase finalizada | Audit, Monitoring (KPI), Documents | sesionId, aprendicesPresentes |
| `scheduling.motor.ejecutado` | Algoritmo de asignación termina | Audit, Notifications (sugerencias) | fichaId, horariosAsignados, conflictosEncontrados |

### Document Service

| Evento | Disparador | Consumidores | Payload |
|---|---|---|---|
| `document.documento.generado` | PDF creado | Audit, Notifications (usuario) | documentoId, tipo, destinatarioId, urlDescarga |
| `document.documento.descargado` | Usuario descarga | Audit, Monitoring | documentoId, usuarioId |
| `document.documento.archivado` | Documento obsoleto marcado | Audit | documentoId, razon |

### Monitoring Service

| Evento | Disparador | Consumidores | Payload |
|---|---|---|---|
| `monitoring.kpi.calculado` | Cálculo diario 23:59 | Audit, Notifications (si hay alertas) | fecha, kpis (ocupacion, cargaInstructor, eficiencia) |
| `monitoring.alerta.generada` | KPI cruza umbral | Audit, Notifications, Dashboard | alertaId, tipo, kpi, valor, umbral, entidadAfectada |
| `monitoring.notificacion.enviada` | Mensaje enviado | Audit | notificacionId, usuarioId, tipo, canal |

### Audit Service

| Evento | Disparador | Consumidores | Payload |
|---|---|---|---|
| `audit.operacion.registrada` | (Recibe todos los eventos) | BD append-only | timestamp, usuarioId, accion, entidad, cambios |

## Ejemplo: Flujo completo de creación de ficha

```
1. Usuario crea ficha via academic-api
   ↓
2. Academic-service publica:
   \"academic.ficha.creada\"
   {
     \"fichaId\": \"F123\",
     \"programa\": \"ADSO\",
     \"centro\": \"C001\",
     \"jornada\": \"MANANA\",
     \"coordinador\": \"U456\"
   }
   ↓
3. Múltiples consumidores reaccionan en paralelo:

   ├─ Scheduling-service:
      ├─ Escucha evento
      ├─ Prepara matriz de horarios
      └─ Publica \"scheduling.motor.ejecutado\"
   │
   ├─ Audit-service:
      ├─ Escucha evento
      ├─ Crea registro append-only
      └─ (fin)
   │
   └─ Notifications-service:
      ├─ Escucha evento
      ├─ Envía email coordinador
      └─ Publica \"monitoring.notificacion.enviada\"
```

## Garantías de entrega

- **At-least-once:** Cada evento se entrega mínimo una vez
- **Idempotencia:** Los consumidores deben ser idempotentes (pueden procesar duplicados)
- **Ordenamiento:** FIFO por fichaId (partición)
- **Timeout:** Si evento no se procesa en 5 minutos, va a Dead Letter Queue

## Versionado de eventos

Si el schema de evento cambia:

1. Crear nueva versión: `academic.ficha.creada@2.0`
2. Antiguos consumidores aún escuchan `@1.0`
3. Nuevos consumidores escuchan `@2.0`
4. Bridge puede traducir si es necesario
5. Deprecar `@1.0` después de 6 meses"

