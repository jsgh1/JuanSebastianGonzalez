# Ejercicio 01 - Flujo de check-in y trazabilidad comercial del pasajero

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
La aerolínea requiere fortalecer la trazabilidad operativa del proceso de abordaje, desde la reserva del pasajero hasta la emisión del pase de abordar. Para ello, se necesita consultar información consolidada del flujo comercial y, además, automatizar parte del proceso de check-in mediante lógica en base de datos.

---

## 7. Dominios involucrados en este ejercicio
### SALES, RESERVATION, TICKETING
**Entidades:** `reservation`, `reservation_passenger`, `sale`, `ticket`, `ticket_segment`  
**Propósito:** Gestionar el flujo comercial principal del sistema y la relación entre reserva, pasajero y tiquete.

### FLIGHT OPERATIONS
**Entidades:** `flight`, `flight_segment`, `flight_status`  
**Propósito:** Relacionar los tiquetes con la operación real del vuelo y sus segmentos.

### IDENTITY
**Entidades:** `person`  
**Propósito:** Identificar al pasajero asociado a la reserva.

### BOARDING
**Entidades:** `check_in`, `check_in_status`, `boarding_group`, `boarding_pass`  
**Propósito:** Gestionar el proceso de registro previo al abordaje y la emisión del pase de abordar.

### SECURITY
**Entidades:** `user_account`  
**Propósito:** Identificar el usuario que registra el check-in.

---

## 8. Planteamiento del problema
La aerolínea desea consultar qué pasajeros ya se encuentran asociados a reservas y tiquetes válidos para un vuelo determinado, y adicionalmente automatizar la creación del pase de abordar cuando se registra un check-in.

---

## 9. Objetivo del ejercicio
Diseñar una solución en PostgreSQL que permita consultar información consolidada del flujo comercial y operativo de un pasajero, automatizar una acción posterior al registro de check-in y encapsular el proceso en un procedimiento almacenado reutilizable.

---

## 10. Requerimiento 1 - Consulta con `INNER JOIN` de al menos 5 tablas

### Enunciado
Construya una consulta SQL que liste la trazabilidad básica de pasajeros por vuelo, vinculando información de reserva, pasajero, tiquete, segmento y vuelo.

### Restricciones obligatorias
- Debe usar **`INNER JOIN`**
- Debe involucrar **mínimo 5 tablas**
- Debe usar únicamente entidades y atributos existentes en el modelo base
- No se permite cambiar nombres de tablas ni columnas
- La consulta debe ser coherente con las relaciones reales del modelo

### Tablas mínimas sugeridas
El estudiante deberá incluir, como mínimo, una combinación válida de tablas como:
- `reservation`
- `reservation_passenger`
- `person`
- `ticket`
- `ticket_segment`
- `flight_segment`
- `flight`

### Resultado esperado a nivel funcional
La consulta debe permitir responder una necesidad como esta: “Mostrar los pasajeros asociados a un vuelo, indicando la reserva, el tiquete, el segmento y la fecha del servicio”.

### Campos esperados en el resultado
Como mínimo, el resultado debe exponer columnas equivalentes a:
- código de reserva
- número de vuelo
- fecha de servicio
- número de tiquete
- secuencia del pasajero en la reserva
- nombre del pasajero
- segmento del vuelo
- hora programada de salida

> El estudiante define la consulta exacta, pero debe respetar estrictamente el modelo base.

---

## 11. Requerimiento 2 - Trigger `AFTER`

### Enunciado
Diseñe un trigger `AFTER INSERT` sobre la tabla `check_in` que automatice una acción posterior relacionada con el proceso de abordaje.

### Condición funcional del trigger
Cuando se inserte un nuevo registro en `check_in`, el trigger deberá generar o completar la evidencia operativa correspondiente en la tabla `boarding_pass`.

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
Diseñe un procedimiento almacenado que encapsule el proceso de registro de un check-in para un pasajero ya asociado a un `ticket_segment`.

### Propósito del procedimiento
Centralizar en una sola unidad lógica el registro del check-in, asegurando que el flujo quede listo para el proceso de abordaje.

### Alcance funcional mínimo
El procedimiento debe permitir registrar información relacionada con:
- segmento ticketed
- estado del check-in
- grupo de abordaje, si aplica
- usuario que ejecuta la operación
- fecha y hora del check-in

### Restricciones obligatorias
- Debe implementarse como **procedimiento almacenado**
- Debe trabajar sobre tablas y atributos existentes
- No puede cambiar la estructura del modelo base
- Debe ser reutilizable
- Debe poder invocarse desde un script SQL independiente

### Integración esperada
La operación realizada por el procedimiento debe ser compatible con el trigger solicitado, de modo que al registrar el check-in también sea posible evidenciar la generación posterior del pase de abordar.

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

# Solución corregida del ejercicio 01

Esta versión integra el script SQL definitivo correspondiente al ejercicio 01. Está organizada en dos partes:

1. **Setup:** crea o reemplaza la función, el trigger, el procedimiento almacenado y deja la consulta principal del ejercicio.
2. **Demo:** ejecuta una prueba mínima sobre datos existentes de la base para disparar el procedimiento/trigger y verificar el resultado.

## Archivo `ejercicio_01_setup.sql`

```sql
DROP TRIGGER IF EXISTS trg_ai_check_in_create_boarding_pass ON check_in;
DROP FUNCTION IF EXISTS fn_ai_check_in_create_boarding_pass();
DROP PROCEDURE IF EXISTS sp_register_check_in(uuid, uuid, uuid, uuid, timestamptz);

-- 1. Trigger AFTER sobre check_in
-- Automatiza la creación del pase de abordar (boarding_pass) al registrar un check-in
CREATE OR REPLACE FUNCTION fn_ai_check_in_create_boarding_pass()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_boarding_pass_code varchar(20);
BEGIN
    -- Generar un código de pase de abordar ficticio para la demostración
    v_boarding_pass_code := 'BP-' || upper(replace(left(NEW.check_in_id::text, 8), '-', ''));
    
    INSERT INTO boarding_pass (
        check_in_id,
        boarding_pass_code,
        barcode_value,
        issued_at
    )
    VALUES (
        NEW.check_in_id,
        v_boarding_pass_code,
        'BARCODE-' || gen_random_uuid()::text,
        now()
    );

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_check_in_create_boarding_pass
AFTER INSERT ON check_in
FOR EACH ROW
EXECUTE FUNCTION fn_ai_check_in_create_boarding_pass();

-- 2. Procedimiento Almacenado
-- Encapsula el registro del check-in
CREATE OR REPLACE PROCEDURE sp_register_check_in(
    p_ticket_segment_id uuid,
    p_check_in_status_id uuid,
    p_boarding_group_id uuid,
    p_checked_in_by_user_id uuid,
    p_checked_in_at timestamptz
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO check_in (
        ticket_segment_id,
        check_in_status_id,
        boarding_group_id,
        checked_in_by_user_id,
        checked_in_at
    )
    VALUES (
        p_ticket_segment_id,
        p_check_in_status_id,
        p_boarding_group_id,
        p_checked_in_by_user_id,
        p_checked_in_at
    );
END;
$$;

-- 3. Consulta con INNER JOIN (mínimo 5 tablas)
-- Requerimiento MD: reserva, pasajero, persona, tiquete, segmento_tiquete, segmento_vuelo, vuelo.
SELECT
    r.reservation_code AS codigo_reserva,
    f.flight_number AS numero_vuelo,
    f.service_date AS fecha_servicio,
    t.ticket_number AS numero_tiquete,
    rp.passenger_sequence_no AS secuencia_pasajero,
    p.first_name || ' ' || p.last_name AS nombre_pasajero,
    fs.segment_number AS segmento_vuelo,
    fs.scheduled_departure_at AS hora_programada_salida
FROM reservation r
INNER JOIN reservation_passenger rp ON rp.reservation_id = r.reservation_id
INNER JOIN person p ON p.person_id = rp.person_id
INNER JOIN ticket t ON t.reservation_passenger_id = rp.reservation_passenger_id
INNER JOIN ticket_segment ts ON ts.ticket_id = t.ticket_id
INNER JOIN flight_segment fs ON fs.flight_segment_id = ts.flight_segment_id
INNER JOIN flight f ON f.flight_id = fs.flight_id
ORDER BY f.service_date DESC, r.reservation_code;
```

## Archivo `ejercicio_01_demo.sql`

```sql
DO $$
DECLARE
    v_ticket_segment_id uuid;
    v_check_in_status_id uuid;
    v_boarding_group_id uuid;
    v_user_account_id uuid;
BEGIN
    -- 1. Buscar un segmento de tiquete que NO tenga check-in
    SELECT ts.ticket_segment_id
    INTO v_ticket_segment_id
    FROM ticket_segment ts
    LEFT JOIN check_in ci ON ci.ticket_segment_id = ts.ticket_segment_id
    WHERE ci.check_in_id IS NULL
    LIMIT 1;

    IF v_ticket_segment_id IS NULL THEN
        RAISE EXCEPTION 'No se encontraron segmentos de tiquete disponibles para la prueba de check-in.';
    END IF;

    -- 2. Obtener datos auxiliares
    SELECT check_in_status_id INTO v_check_in_status_id FROM check_in_status LIMIT 1;
    SELECT boarding_group_id INTO v_boarding_group_id FROM boarding_group LIMIT 1;
    SELECT user_account_id INTO v_user_account_id FROM user_account LIMIT 1;

    -- 3. Invocar procedimiento (esto disparará el trigger que crea el boarding_pass)
    CALL sp_register_check_in(
        v_ticket_segment_id,
        v_check_in_status_id,
        v_boarding_group_id,
        v_user_account_id,
        now()
    );

    RAISE NOTICE 'Check-in registrado exitosamente para el segmento %', v_ticket_segment_id;
END;
$$;

-- 4. Verificación del Check-in y el Pase de Abordar (creado por el trigger)
SELECT 
    ci.checked_in_at,
    ts.segment_sequence_no,
    bp.boarding_pass_code,
    bp.barcode_value,
    bp.issued_at
FROM check_in ci
INNER JOIN ticket_segment ts ON ts.ticket_segment_id = ci.ticket_segment_id
INNER JOIN boarding_pass bp ON bp.check_in_id = ci.check_in_id
ORDER BY ci.created_at DESC
LIMIT 1;
```

## Ejecución recomendada en PostgreSQL

```sql
\i ejercicio_01_setup.sql
\i ejercicio_01_demo.sql
```
