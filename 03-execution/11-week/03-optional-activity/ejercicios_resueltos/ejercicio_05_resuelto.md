# Ejercicio 05 - Mantenimiento de aeronaves y habilitación operativa

# Modelo de datos base del sistema

## 1. Descripción general del modelo
El modelo de datos corresponde a un sistema integral de aerolínea, diseñado para soportar de forma relacional los procesos principales del negocio: gestión geográfica, identidad de personas, seguridad, clientes, fidelización, aeropuertos, aeronaves, operación de vuelos, reservas, tiquetes, abordaje, pagos y facturación.

Se trata de un modelo amplio y normalizado, en el que las entidades están separadas por dominios funcionales y conectadas mediante llaves foráneas para garantizar trazabilidad, integridad y consistencia en todo el flujo operativo y comercial.

---

## 2. Resumen previo del análisis realizado
Como base de trabajo, previamente se identificó y organizó el script en dominios funcionales. A partir de esa revisión, se determinó que el modelo no corresponde a un caso pequeño o aislado, sino a una solución empresarial con múltiples áreas del negocio conectadas entre sí.

También se verificó que:
- el modelo contiene más de 60 entidades,
- las relaciones entre tablas siguen una estructura consistente,
- existen restricciones de integridad mediante `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE` y `CHECK`,
- el diseño soporta trazabilidad end-to-end desde la reserva hasta el pago, abordaje y facturación.

---

## 3. Dominios del modelo y propósito general

### GEOGRAPHY AND REFERENCE DATA
**Entidades:** `time_zone`, `continent`, `country`, `state_province`, `city`, `district`, `address`, `currency`  
**Resumen:** Centraliza información geográfica y de referencia para ubicar aeropuertos, personas, proveedores y definir monedas operativas del sistema.

### AIRLINE
**Entidades:** `airline`  
**Resumen:** Representa la aerolínea operadora del sistema, incluyendo sus códigos y país base.

### IDENTITY
**Entidades:** `person_type`, `document_type`, `contact_type`, `person`, `person_document`, `person_contact`  
**Resumen:** Permite modelar la identidad de las personas, sus documentos y medios de contacto.

### SECURITY
**Entidades:** `user_status`, `security_role`, `security_permission`, `user_account`, `user_role`, `role_permission`  
**Resumen:** Administra autenticación, autorización y control de acceso al sistema.

### CUSTOMER AND LOYALTY
**Entidades:** `customer_category`, `benefit_type`, `loyalty_program`, `loyalty_tier`, `customer`, `loyalty_account`, `loyalty_account_tier`, `miles_transaction`, `customer_benefit`  
**Resumen:** Gestiona clientes, programas de fidelización, acumulación de millas, beneficios y niveles.

### AIRPORT
**Entidades:** `airport`, `terminal`, `boarding_gate`, `runway`, `airport_regulation`  
**Resumen:** Modela la infraestructura aeroportuaria y las condiciones regulatorias asociadas a cada aeropuerto.

### AIRCRAFT
**Entidades:** `aircraft_manufacturer`, `aircraft_model`, `cabin_class`, `aircraft`, `aircraft_cabin`, `aircraft_seat`, `maintenance_provider`, `maintenance_type`, `maintenance_event`  
**Resumen:** Gestiona aeronaves, fabricantes, configuración interna y procesos de mantenimiento.

### FLIGHT OPERATIONS
**Entidades:** `flight_status`, `delay_reason_type`, `flight`, `flight_segment`, `flight_delay`  
**Resumen:** Controla la operación de vuelos, sus segmentos, estados y retrasos.

### SALES, RESERVATION, TICKETING
**Entidades:** `reservation_status`, `sale_channel`, `fare_class`, `fare`, `ticket_status`, `reservation`, `reservation_passenger`, `sale`, `ticket`, `ticket_segment`, `seat_assignment`, `baggage`  
**Resumen:** Gestiona el flujo comercial principal: reserva, pasajero, venta, emisión de tiquetes, asignación de asiento y equipaje.

### BOARDING
**Entidades:** `boarding_group`, `check_in_status`, `check_in`, `boarding_pass`, `boarding_validation`  
**Resumen:** Soporta el proceso de check-in, emisión de pase de abordar y validación final de embarque.

### PAYMENT
**Entidades:** `payment_status`, `payment_method`, `payment`, `payment_transaction`, `refund`  
**Resumen:** Administra pagos, transacciones y devoluciones asociadas a las ventas.

### BILLING
**Entidades:** `tax`, `exchange_rate`, `invoice_status`, `invoice`, `invoice_line`  
**Resumen:** Gestiona impuestos, tasas de cambio, facturas y detalle facturable.

---

## 4. Enfoque de los ejercicios
Los ejercicios planteados sobre este modelo tendrán como propósito que el estudiante analice relaciones reales entre entidades y construya soluciones en PostgreSQL sin alterar la estructura base del sistema.

Cada ejercicio se formulará para que el estudiante:
- interprete correctamente los dominios involucrados,
- construya consultas con múltiples relaciones,
- diseñe automatizaciones con triggers,
- implemente lógica reutilizable mediante procedimientos almacenados,
- y demuestre técnicamente el funcionamiento con scripts de prueba.

---

## 5. Restricción general para todos los ejercicios
Todos los ejercicios deben resolverse respetando estrictamente el modelo entregado.

No está permitido:
- cambiar atributos existentes,
- renombrar tablas o columnas,
- alterar relaciones,
- inventar entidades fuera del script base,
- ni modificar la estructura general del modelo.

La solución deberá construirse únicamente sobre las entidades y relaciones reales definidas en el script.

---

## 6. Contexto del ejercicio
El área técnica desea consultar el historial de mantenimiento de las aeronaves y automatizar efectos posteriores cuando un evento de mantenimiento cambie de estado o se complete.

---

## 7. Dominios involucrados en este ejercicio
### AIRCRAFT
**Entidades:** `aircraft`, `aircraft_model`, `aircraft_manufacturer`, `maintenance_event`, `maintenance_type`, `maintenance_provider`  
**Propósito:** Gestionar aeronaves, modelo, fabricante, tipos de mantenimiento y proveedores.

### AIRLINE
**Entidades:** `airline`  
**Propósito:** Relacionar cada aeronave con la aerolínea operadora.

### GEOGRAPHY AND REFERENCE DATA
**Entidades:** `address`  
**Propósito:** Relacionar la ubicación del proveedor de mantenimiento, cuando exista.

---

## 8. Planteamiento del problema
La organización necesita una visión consolidada de eventos de mantenimiento y un mecanismo automatizado que evidencie cambios posteriores cuando se registra o actualiza un mantenimiento técnico.

---

## 9. Objetivo del ejercicio
Diseñar un ejercicio de análisis técnico sobre mantenimiento que conecte aeronave, proveedor y eventos de mantenimiento, incorporando trigger posterior y procedimiento almacenado.

---

## 10. Requerimiento 1 - Consulta con `INNER JOIN` de al menos 5 tablas

### Enunciado
Construya una consulta SQL que relacione aeronave, aerolínea, modelo, fabricante, tipo de mantenimiento, proveedor y estado del evento de mantenimiento.

### Restricciones obligatorias
- Debe usar **`INNER JOIN`**
- Debe involucrar **mínimo 5 tablas**
- Debe usar únicamente entidades y atributos existentes en el modelo base
- No se permite cambiar nombres de tablas ni columnas
- La consulta debe ser coherente con las relaciones reales del modelo

### Tablas mínimas sugeridas
El estudiante deberá incluir, como mínimo, una combinación válida de tablas como:
- `aircraft`
- `airline`
- `aircraft_model`
- `aircraft_manufacturer`
- `maintenance_event`
- `maintenance_type`
- `maintenance_provider`

### Resultado esperado a nivel funcional
La consulta debe permitir responder una necesidad como esta: “Mostrar para cada aeronave sus eventos de mantenimiento, el proveedor responsable, el tipo de intervención y el estado actual del evento”.

### Campos esperados en el resultado
Como mínimo, el resultado debe exponer columnas equivalentes a:
- matrícula o registro de aeronave
- aerolínea
- modelo
- fabricante
- tipo de mantenimiento
- proveedor
- estado del evento
- fecha de inicio
- fecha de finalización

> El estudiante define la consulta exacta, pero debe respetar estrictamente el modelo base.

---

## 11. Requerimiento 2 - Trigger `AFTER`

### Enunciado
Diseñe un trigger `AFTER INSERT` o `AFTER UPDATE` sobre `maintenance_event` que automatice una acción verificable asociada a la aeronave intervenida.

### Condición funcional del trigger
Cuando ocurra el evento definido por el estudiante sobre `maintenance_event`, el trigger deberá reflejar una consecuencia verificable sobre la trazabilidad operativa de la aeronave o sobre la lógica técnica seleccionada.

### Restricciones del trigger
- Debe ser un trigger **`AFTER`**
- Debe operar sobre tablas reales del modelo
- No puede modificar atributos existentes del modelo base
- No puede cambiar la definición de las tablas originales
- La solución debe ser coherente con las relaciones reales entre las tablas involucradas

### Demostración obligatoria
El estudiante deberá entregar un **script de prueba** que dispare el trigger.

### Condición mínima de la demostración
El script de prueba debe:
1. Identificar o preparar los datos necesarios del modelo base
2. Ejecutar la operación que dispare el trigger
3. Verificar el efecto posterior generado por el trigger

> El estudiante deberá decidir cómo validar el resultado, siempre sobre entidades reales del modelo.

---

## 12. Requerimiento 3 - Procedimiento almacenado

### Enunciado
Diseñe un procedimiento almacenado que registre un nuevo evento de mantenimiento para una aeronave existente.

### Propósito del procedimiento
Centralizar el registro del mantenimiento para garantizar consistencia en la información técnica.

### Alcance funcional mínimo
El procedimiento debe permitir trabajar con información relacionada con:
- aeronave
- tipo de mantenimiento
- proveedor
- estado inicial
- fecha de inicio
- notas, si aplica

### Restricciones obligatorias
- Debe implementarse como **procedimiento almacenado**
- Debe trabajar sobre tablas y atributos existentes
- No puede cambiar la estructura del modelo base
- Debe ser reutilizable
- Debe poder invocarse desde un script SQL independiente

### Integración esperada
La operación realizada por el procedimiento debe poder activar el trigger o dejar lista la condición para su validación posterior.

---

## 13. Script de uso del procedimiento

### Enunciado
El estudiante deberá entregar un script SQL que invoque el procedimiento almacenado desarrollado.

### Propósito del script
Demostrar que el procedimiento:
1. recibe los parámetros necesarios,
2. ejecuta la operación principal del ejercicio,
3. activa el trigger definido previamente o deja lista la evidencia para validarlo,
4. deja evidencia verificable del proceso.

### Contenido mínimo esperado
El script debe incluir:
- búsqueda o selección previa de identificadores necesarios
- invocación del procedimiento
- consulta posterior de validación

---

## 14. Entregables del estudiante
El estudiante deberá entregar:

1. **Consulta SQL** con `INNER JOIN` de mínimo 5 tablas  
2. **Trigger `AFTER`**  
3. **Función u objeto auxiliar necesario para el trigger**, si su diseño lo requiere  
4. **Procedimiento almacenado**  
5. **Script que dispare el trigger**  
6. **Script que invoque el procedimiento**  
7. **Consultas de validación** que demuestren el funcionamiento

---

## 15. Criterios de aceptación
La solución propuesta por el estudiante será válida si cumple con todo lo siguiente:

- La consulta utiliza `INNER JOIN`
- La consulta relaciona al menos 5 tablas reales del modelo
- El trigger es coherente con la necesidad del negocio
- El trigger produce un efecto verificable sobre tablas reales
- Existe un script que demuestra su ejecución
- El procedimiento almacenado encapsula una operación útil del negocio
- Existe un script que invoca el procedimiento
- La invocación del procedimiento permite evidenciar también el funcionamiento del trigger o del flujo solicitado
- No se alteró la estructura base del modelo

---

## 16. Observación final
Este ejercicio no solicita la solución final enunciada en el documento. El estudiante deberá diseñarla e implementarla respetando las restricciones técnicas del modelo base.

---

---

# Solución corregida del ejercicio 05

Esta versión integra el script SQL definitivo correspondiente al ejercicio 05. Está organizada en dos partes:

1. **Setup:** crea o reemplaza la función, el trigger, el procedimiento almacenado y deja la consulta principal del ejercicio.
2. **Demo:** ejecuta una prueba mínima sobre datos existentes de la base para disparar el procedimiento/trigger y verificar el resultado.

## Archivo `ejercicio_05_setup.sql`

```sql
DROP TRIGGER IF EXISTS trg_aiu_maintenance_event_touch_aircraft ON maintenance_event;
DROP TRIGGER IF EXISTS trg_ai_maintenance_event_touch_aircraft ON maintenance_event;
DROP FUNCTION IF EXISTS fn_aiu_maintenance_event_touch_aircraft();
DROP FUNCTION IF EXISTS fn_ai_maintenance_event_touch_aircraft();
DROP PROCEDURE IF EXISTS sp_register_maintenance_event(uuid, uuid, uuid, varchar, timestamptz, timestamptz, text);
DROP PROCEDURE IF EXISTS sp_register_maintenance_event(uuid, uuid, uuid, varchar, timestamptz, text);

-- 1. Trigger AFTER INSERT OR UPDATE sobre maintenance_event
CREATE OR REPLACE FUNCTION fn_aiu_maintenance_event_touch_aircraft()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE aircraft
    SET updated_at = now()
    WHERE aircraft_id = NEW.aircraft_id;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_aiu_maintenance_event_touch_aircraft
AFTER INSERT OR UPDATE ON maintenance_event
FOR EACH ROW
EXECUTE FUNCTION fn_aiu_maintenance_event_touch_aircraft();

-- 2. Procedimiento almacenado
CREATE OR REPLACE PROCEDURE sp_register_maintenance_event(
    p_aircraft_id uuid,
    p_maintenance_type_id uuid,
    p_maintenance_provider_id uuid,
    p_status_code varchar,
    p_started_at timestamptz,
    p_completed_at timestamptz DEFAULT NULL,
    p_notes text DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_status_code NOT IN ('PLANNED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED') THEN
        RAISE EXCEPTION 'Estado de mantenimiento inválido: %', p_status_code;
    END IF;

    IF p_completed_at IS NOT NULL AND p_completed_at < p_started_at THEN
        RAISE EXCEPTION 'La fecha de finalización no puede ser anterior al inicio.';
    END IF;

    INSERT INTO maintenance_event (
        aircraft_id, maintenance_type_id, maintenance_provider_id,
        status_code, started_at, completed_at, notes
    )
    VALUES (
        p_aircraft_id, p_maintenance_type_id, p_maintenance_provider_id,
        p_status_code, p_started_at, p_completed_at, p_notes
    );
END;
$$;

-- 3. Consulta con INNER JOIN (mínimo 5 tablas)
SELECT
    al.airline_name,
    a.registration_number,
    amf.manufacturer_name,
    am.model_name,
    mt.type_name AS maintenance_type,
    mp.provider_name,
    me.status_code,
    me.started_at,
    me.completed_at
FROM aircraft a
INNER JOIN airline al ON al.airline_id = a.airline_id
INNER JOIN aircraft_model am ON am.aircraft_model_id = a.aircraft_model_id
INNER JOIN aircraft_manufacturer amf ON amf.aircraft_manufacturer_id = am.aircraft_manufacturer_id
INNER JOIN maintenance_event me ON me.aircraft_id = a.aircraft_id
INNER JOIN maintenance_type mt ON mt.maintenance_type_id = me.maintenance_type_id
INNER JOIN maintenance_provider mp ON mp.maintenance_provider_id = me.maintenance_provider_id
ORDER BY me.started_at DESC;
```

## Archivo `ejercicio_05_demo.sql`

```sql
DO $$
DECLARE
    v_aircraft_id uuid;
    v_type_id uuid;
    v_provider_id uuid;
BEGIN
    SELECT aircraft_id INTO v_aircraft_id FROM aircraft ORDER BY created_at LIMIT 1;
    SELECT maintenance_type_id INTO v_type_id FROM maintenance_type ORDER BY created_at LIMIT 1;
    SELECT maintenance_provider_id INTO v_provider_id FROM maintenance_provider ORDER BY created_at LIMIT 1;

    IF v_aircraft_id IS NULL OR v_type_id IS NULL OR v_provider_id IS NULL THEN
        RAISE EXCEPTION 'No se encontraron datos base para la prueba de mantenimiento.';
    END IF;

    CALL sp_register_maintenance_event(
        v_aircraft_id,
        v_type_id,
        v_provider_id,
        'PLANNED',
        now(),
        NULL,
        'Mantenimiento de prueba'
    );
END;
$$;

SELECT a.registration_number, a.updated_at, me.status_code, me.started_at, me.notes
FROM aircraft a
INNER JOIN maintenance_event me ON me.aircraft_id = a.aircraft_id
ORDER BY me.created_at DESC
LIMIT 5;
```

## Ejecución recomendada en PostgreSQL

```sql
\i ejercicio_05_setup.sql
\i ejercicio_05_demo.sql
```
