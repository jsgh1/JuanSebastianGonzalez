# Ejercicio 06 - Retrasos operativos y análisis de impacto por segmento de vuelo

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
La gerencia de operaciones necesita auditar los retrasos registrados por segmento de vuelo y automatizar una respuesta posterior sobre el flujo operativo cuando se reporte una demora.

---

## 7. Dominios involucrados en este ejercicio
### FLIGHT OPERATIONS
**Entidades:** `flight`, `flight_segment`, `flight_status`, `flight_delay`, `delay_reason_type`  
**Propósito:** Gestionar vuelos, segmentos, estados y retrasos.

### AIRPORT
**Entidades:** `airport`  
**Propósito:** Identificar aeropuertos de origen y destino de cada segmento.

### AIRLINE
**Entidades:** `airline`  
**Propósito:** Relacionar el vuelo con la aerolínea.

---

## 8. Planteamiento del problema
Se necesita consultar los retrasos por segmento de vuelo, entender el contexto del vuelo y automatizar un efecto posterior cuando se registra una demora operacional.

---

## 9. Objetivo del ejercicio
Plantear un ejercicio de análisis operativo con consulta multi-tabla, trigger posterior y procedimiento almacenado para el registro de retrasos.

---

## 10. Requerimiento 1 - Consulta con `INNER JOIN` de al menos 5 tablas

### Enunciado
Construya una consulta SQL que relacione aerolínea, vuelo, estado del vuelo, segmento, aeropuerto origen, aeropuerto destino y demora reportada.

### Restricciones obligatorias
- Debe usar **`INNER JOIN`**
- Debe involucrar **mínimo 5 tablas**
- Debe usar únicamente entidades y atributos existentes en el modelo base
- No se permite cambiar nombres de tablas ni columnas
- La consulta debe ser coherente con las relaciones reales del modelo

### Tablas mínimas sugeridas
El estudiante deberá incluir, como mínimo, una combinación válida de tablas como:
- `airline`
- `flight`
- `flight_status`
- `flight_segment`
- `airport` (para origen)
- `airport` (para destino)
- `flight_delay`
- `delay_reason_type`

### Resultado esperado a nivel funcional
La consulta debe permitir responder una necesidad como esta: “Mostrar por vuelo y segmento los retrasos registrados, el motivo y el contexto operacional del trayecto”.

### Campos esperados en el resultado
Como mínimo, el resultado debe exponer columnas equivalentes a:
- aerolínea
- número de vuelo
- fecha de servicio
- estado del vuelo
- segmento
- aeropuerto origen
- aeropuerto destino
- minutos de demora
- motivo de retraso

> El estudiante define la consulta exacta, pero debe respetar estrictamente el modelo base.

---

## 11. Requerimiento 2 - Trigger `AFTER`

### Enunciado
Diseñe un trigger `AFTER INSERT` sobre `flight_delay` que automatice una acción posterior asociada al vuelo o segmento impactado.

### Condición funcional del trigger
Cada vez que se registre una demora, el trigger deberá ejecutar una consecuencia verificable coherente con la trazabilidad operacional definida por el estudiante.

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
Diseñe un procedimiento almacenado que registre una demora para un `flight_segment` existente.

### Propósito del procedimiento
Encapsular el registro de un retraso operativo y dejar preparada la ejecución de la lógica posterior.

### Alcance funcional mínimo
El procedimiento debe permitir trabajar con información relacionada con:
- segmento de vuelo
- motivo de retraso
- fecha y hora del reporte
- minutos de demora
- notas, si aplica

### Restricciones obligatorias
- Debe implementarse como **procedimiento almacenado**
- Debe trabajar sobre tablas y atributos existentes
- No puede cambiar la estructura del modelo base
- Debe ser reutilizable
- Debe poder invocarse desde un script SQL independiente

### Integración esperada
La inserción efectuada por el procedimiento debe activar el trigger y permitir verificar el efecto posterior definido.

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

# Solución corregida del ejercicio 06

Esta versión integra el script SQL definitivo correspondiente al ejercicio 06. Está organizada en dos partes:

1. **Setup:** crea o reemplaza la función, el trigger, el procedimiento almacenado y deja la consulta principal del ejercicio.
2. **Demo:** ejecuta una prueba mínima sobre datos existentes de la base para disparar el procedimiento/trigger y verificar el resultado.

## Archivo `ejercicio_06_setup.sql`

```sql
DROP TRIGGER IF EXISTS trg_ai_flight_delay_touch_segment ON flight_delay;
DROP TRIGGER IF EXISTS trg_ai_flight_delay_update_segment ON flight_delay;
DROP FUNCTION IF EXISTS fn_ai_flight_delay_touch_segment();
DROP FUNCTION IF EXISTS fn_ai_flight_delay_update_segment();
DROP PROCEDURE IF EXISTS sp_register_flight_delay(uuid, uuid, integer, text);

-- 1. Trigger AFTER INSERT sobre flight_delay
CREATE OR REPLACE FUNCTION fn_ai_flight_delay_touch_segment()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE flight_segment
    SET updated_at = now()
    WHERE flight_segment_id = NEW.flight_segment_id;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_flight_delay_touch_segment
AFTER INSERT ON flight_delay
FOR EACH ROW
EXECUTE FUNCTION fn_ai_flight_delay_touch_segment();

-- 2. Procedimiento almacenado
CREATE OR REPLACE PROCEDURE sp_register_flight_delay(
    p_flight_segment_id uuid,
    p_delay_reason_type_id uuid,
    p_delay_minutes integer,
    p_notes text DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_delay_minutes <= 0 THEN
        RAISE EXCEPTION 'Los minutos de retraso deben ser mayores a cero.';
    END IF;

    INSERT INTO flight_delay (flight_segment_id, delay_reason_type_id, reported_at, delay_minutes, notes)
    VALUES (p_flight_segment_id, p_delay_reason_type_id, now(), p_delay_minutes, p_notes);
END;
$$;

-- 3. Consulta con INNER JOIN (mínimo 5 tablas)
SELECT
    al.airline_name,
    f.flight_number,
    fst.status_name AS flight_status,
    f.service_date,
    fs.segment_number,
    ao.iata_code AS origin_airport,
    ad.iata_code AS destination_airport,
    drt.reason_name AS delay_reason,
    fd.delay_minutes,
    fd.reported_at
FROM airline al
INNER JOIN flight f ON f.airline_id = al.airline_id
INNER JOIN flight_status fst ON fst.flight_status_id = f.flight_status_id
INNER JOIN flight_segment fs ON fs.flight_id = f.flight_id
INNER JOIN airport ao ON ao.airport_id = fs.origin_airport_id
INNER JOIN airport ad ON ad.airport_id = fs.destination_airport_id
INNER JOIN flight_delay fd ON fd.flight_segment_id = fs.flight_segment_id
INNER JOIN delay_reason_type drt ON drt.delay_reason_type_id = fd.delay_reason_type_id
ORDER BY fd.reported_at DESC;
```

## Archivo `ejercicio_06_demo.sql`

```sql
DO $$
DECLARE
    v_flight_segment_id uuid;
    v_delay_reason_type_id uuid;
BEGIN
    SELECT flight_segment_id INTO v_flight_segment_id FROM flight_segment ORDER BY created_at LIMIT 1;
    SELECT delay_reason_type_id INTO v_delay_reason_type_id FROM delay_reason_type ORDER BY created_at LIMIT 1;

    IF v_flight_segment_id IS NULL OR v_delay_reason_type_id IS NULL THEN
        RAISE EXCEPTION 'No se encontraron datos base para la prueba de retrasos.';
    END IF;

    CALL sp_register_flight_delay(
        v_flight_segment_id,
        v_delay_reason_type_id,
        45,
        'Retraso por condiciones climáticas en origen (Demo)'
    );
END;
$$;

SELECT fs.flight_segment_id, fs.updated_at, fd.delay_minutes, fd.notes
FROM flight_segment fs
INNER JOIN flight_delay fd ON fd.flight_segment_id = fs.flight_segment_id
ORDER BY fd.created_at DESC
LIMIT 5;
```

## Ejecución recomendada en PostgreSQL

```sql
\i ejercicio_06_setup.sql
\i ejercicio_06_demo.sql
```
