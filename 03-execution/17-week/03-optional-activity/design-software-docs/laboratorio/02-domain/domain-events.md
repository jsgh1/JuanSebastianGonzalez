# Eventos de dominio

> Estado: En progreso En progreso | Última actualización: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Documentacion

## Eventos principales por contexto

### IAM Context

**UsuarioCreado**
- Disparador: Nuevo usuario registrado
- Consumidores: Audit, Notifications
- Payload: usuarioID, email, rol, fecha

**UsuarioDesactivado**
- Disparador: Usuario desactivado por admin
- Consumidores: Scheduling (cancelar horarios asociados), Audit, Notifications
- Payload: usuarioID, razon, fecha

**SesiónIniciada**
- Disparador: Login exitoso
- Consumidores: Audit, Monitoring
- Payload: usuarioID, IP, timestamp

### Reference Data Context

**ParametroActualizado**
- Disparador: Cambio en parámetro (ej: MAX_APRENDICES_POR_FICHA)
- Consumidores: Audit, Scheduling (revalidar horarios si aplica)
- Payload: parametroID, valorAnterior, valorNuevo

### Academic Management Context

**FichaCreada**
- Disparador: Nueva ficha de formación registrada
- Consumidores: Scheduling (preparar matriz de horarios), Audit, Notifications
- Payload: fichaID, programa, centro, jornada, coordinador

**FichaModificada**
- Disparador: Cambio en ficha (coordinador, jornada, aprendices)
- Consumidores: Audit, Scheduling (revalidar conflictos), Notifications
- Payload: fichaID, cambios (antes/después)

**FichaFinalizada**
- Disparador: Cierre de ficha (todas las sesiones completadas)
- Consumidores: Audit, Documents (generar certificados), Monitoring (cálculo final KPI)
- Payload: fichaID, fecha finalización

**AprendizAsignado**
- Disparador: Aprendiz inscrito en ficha
- Consumidores: Audit, Notifications
- Payload: aprendizID, fichaID

### Actors Context

**InstructorRegistrado**
- Disparador: Nuevo instructor en sistema
- Consumidores: Audit, Scheduling (incluir en pool para asignación)
- Payload: instructorID, especialidades, centro

**InstructorActualizado**
- Disparador: Cambio en especialidades o disponibilidad
- Consumidores: Audit, Scheduling (revalidar asignaciones), Notifications
- Payload: instructorID, cambios

### Training Environment Context

**AmbienteCreado**
- Disparador: Nuevo ambiente registrado
- Consumidores: Audit, Scheduling
- Payload: ambienteID, nombre, capacidad, centro

**AmbienteNoDisponible**
- Disparador: Ambiente marcado como no disponible (mantenimiento, evento)
- Consumidores: Audit, Scheduling (generar conflictos si ya tiene asignación)
- Payload: ambienteID, fechaInicio, fechaFin, razon

**AmbienteDisponible**
- Disparador: Ambiente vuelve a estar disponible
- Consumidores: Audit, Notifications
- Payload: ambienteID

### Scheduling Context (Core)

**HorarioAsignado**
- Disparador: Creación exitosa de horario sin conflictos
- Consumidores: Audit, Notifications (instructor + coordinador), Documents (actualizar plantillas)
- Payload: horarioID, fichaID, instructorID, ambienteID, franja, sesiónID

**ConflictoDetectado**
- Disparador: Intento de crear horario que viola R1 (solapamiento)
- Consumidores: Audit, Notifications (coordinador alert)
- Payload: conflictoID, tipo, horarios involucrados, razon

**HorarioCancelado**
- Disparador: Cancelación de horario (cambio de plan)
- Consumidores: Audit, Notifications, Documents
- Payload: horarioID, razon, fecha

**SesiónCompletada**
- Disparador: Sesión de clase finalizada
- Consumidores: Audit, Monitoring (actualizar KPI), Documents (registro)
- Payload: sesiónID, aprendices presentes, horarioID

**MotorAsignaciónEjecutado**
- Disparador: Algoritmo de asignación automática completado
- Consumidores: Audit, Notifications (mostrar sugerencias), Monitoring
- Payload: fichaID, horariosSugeridos, conflictosIdentificados

### Monitoring Context

**KPICalculado**
- Disparador: Cálculo diario de métricas (23:59)
- Consumidores: Audit, Notifications (si hay alertas)
- Payload: fecha, KPIs (ocupación, carga instructor, eficiencia)

**AlertaGenerada**
- Disparador: KPI cruza umbral (ej: instructor > 30 hrs/semana)
- Consumidores: Audit, Notifications (director, coordinador), Monitoring dashboard
- Payload: alertaID, tipo, KPI, valor, umbral, entidad afectada

**NotificaciónEnviada**
- Disparador: Generación de mensaje para usuario
- Consumidores: Audit, Notifications service
- Payload: notificaciónID, usuarioID, tipo, contenido, canal

### Documents Context (Transversal)

**DocumentoGenerado**
- Disparador: Creación de certificado/diploma/reporte
- Consumidores: Audit, Documents (almacenamiento)
- Payload: documentoID, plantillaID, destinatarioID, PDF url

**DocumentoDescargado**
- Disparador: Usuario descarga documento
- Consumidores: Audit
- Payload: documentoID, usuarioID, timestamp

### Audit Context (Transversal)

**OperaciónRegistrada**
- Disparador: Cualquier operación en otros contextos
- Consumidores: Audit BD (append-only)
- Payload: timestamp, usuarioID, acción, entidad, cambios (antes/después)

## Patrones de flujo de eventos

### Escenario 1: Crear ficha de formación

```
Usuario → FichaCreada 
         → Audit (registra)
         → Scheduling (prepara matriz)
         → Notifications (alerta coordinador)
```

### Escenario 2: Ejecutar motor de asignación

```
Sistema → MotorAsignaciónEjecutado
        → Audit (registra sugerencias)
        → Notifications (muestra recomendaciones)
        → Si conflictos:
           → ConflictoDetectado
           → Notifications (alerta a director)
```

### Escenario 3: Finalizar ficha

```
Sistema → FichaFinalizada
        → Documents (genera certificados)
        → Monitoring (KPI final)
        → Audit (registra cierre)
        → Notifications (notifica egresados)
```

