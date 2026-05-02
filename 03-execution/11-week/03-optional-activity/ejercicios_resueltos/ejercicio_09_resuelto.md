# Ejercicio 09 - Publicación de tarifas y análisis de reservas comercializadas

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
El área comercial necesita analizar las tarifas disponibles por ruta y validar cómo esas tarifas se relacionan con reservas, ventas y tiquetes emitidos. Además, se busca automatizar una acción posterior cuando se registre una tarifa o cuando se concrete una venta asociada a una tarifa.

---

## 7. Dominios involucrados en este ejercicio
### SALES, RESERVATION, TICKETING
**Entidades:** `reservation`, `sale`, `ticket`, `fare`, `fare_class`, `ticket_status`, `sale_channel`  
**Propósito:** Relacionar reservas, ventas y tiquetes con la estructura tarifaria.

### AIRPORT
**Entidades:** `airport`  
**Propósito:** Representar origen y destino tarifario.

### AIRLINE
**Entidades:** `airline`  
**Propósito:** Identificar la aerolínea propietaria de la tarifa.

### GEOGRAPHY AND REFERENCE DATA
**Entidades:** `currency`  
**Propósito:** Normalizar la moneda de la tarifa.

---

## 8. Planteamiento del problema
La organización desea analizar qué tarifas se ofrecen por ruta y cómo terminan siendo utilizadas dentro del flujo de venta y emisión de tiquetes.

---

## 9. Objetivo del ejercicio
Definir un caso comercial que conecte tarifas, rutas, reservas, ventas y tiquetes, incluyendo consulta multi-tabla, trigger posterior y procedimiento almacenado.

---

## 10. Requerimiento 1 - Consulta con `INNER JOIN` de al menos 5 tablas

### Enunciado
Construya una consulta SQL que relacione aerolínea, tarifa, clase tarifaria, aeropuertos origen y destino, moneda, reserva, venta y tiquete asociado.

### Restricciones obligatorias
- Debe usar **`INNER JOIN`**
- Debe involucrar **mínimo 5 tablas**
- Debe usar únicamente entidades y atributos existentes en el modelo base
- No se permite cambiar nombres de tablas ni columnas
- La consulta debe ser coherente con las relaciones reales del modelo

### Tablas mínimas sugeridas
El estudiante deberá incluir, como mínimo, una combinación válida de tablas como:
- `airline`
- `fare`
- `fare_class`
- `airport` (para origen)
- `airport` (para destino)
- `currency`
- `ticket`
- `sale`
- `reservation`

### Resultado esperado a nivel funcional
La consulta debe permitir responder una necesidad como esta: “Mostrar qué tarifas están siendo utilizadas por las reservas y ventas efectivamente emitidas en forma de tiquete”.

### Campos esperados en el resultado
Como mínimo, el resultado debe exponer columnas equivalentes a:
- aerolínea
- código de tarifa
- clase tarifaria
- aeropuerto origen
- aeropuerto destino
- moneda
- reserva
- venta
- tiquete

> El estudiante define la consulta exacta, pero debe respetar estrictamente el modelo base.

---

## 11. Requerimiento 2 - Trigger `AFTER`

### Enunciado
Diseñe un trigger `AFTER INSERT` o `AFTER UPDATE` sobre `fare` o sobre una tabla del flujo comercial que automatice una acción posterior verificable dentro del mismo dominio.

### Condición funcional del trigger
El trigger deberá responder a un evento definido por el estudiante y generar una consecuencia verificable sobre otra tabla real del flujo comercial o tarifario.

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
Diseñe un procedimiento almacenado que registre o publique una tarifa para una ruta y clase específica.

### Propósito del procedimiento
Encapsular la creación de tarifas para que pueda reutilizarse de forma controlada desde base de datos.

### Alcance funcional mínimo
El procedimiento debe permitir trabajar con información relacionada con:
- aerolínea
- aeropuerto origen
- aeropuerto destino
- clase tarifaria
- moneda
- monto base
- vigencia

### Restricciones obligatorias
- Debe implementarse como **procedimiento almacenado**
- Debe trabajar sobre tablas y atributos existentes
- No puede cambiar la estructura del modelo base
- Debe ser reutilizable
- Debe poder invocarse desde un script SQL independiente

### Integración esperada
La operación efectuada por el procedimiento debe permitir activar o dejar lista la lógica posterior definida en el trigger.

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

# Solución corregida del ejercicio 09

Esta versión integra el script SQL definitivo correspondiente al ejercicio 09. Está organizada en dos partes:

1. **Setup:** crea o reemplaza la función, el trigger, el procedimiento almacenado y deja la consulta principal del ejercicio.
2. **Demo:** ejecuta una prueba mínima sobre datos existentes de la base para disparar el procedimiento/trigger y verificar el resultado.

## Archivo `ejercicio_09_setup.sql`

```sql
DROP TRIGGER IF EXISTS trg_aiu_fare_touch_airline ON fare;
DROP TRIGGER IF EXISTS trg_ai_fare_touch_airline ON fare;
DROP FUNCTION IF EXISTS fn_aiu_fare_touch_airline();
DROP FUNCTION IF EXISTS fn_ai_fare_touch_airline();
DROP PROCEDURE IF EXISTS sp_publish_fare(uuid, uuid, uuid, uuid, uuid, varchar, numeric, date, date, integer, numeric, numeric);
DROP PROCEDURE IF EXISTS sp_publish_fare(uuid, uuid, uuid, uuid, uuid, varchar, numeric, date, date);

-- 1. Trigger AFTER INSERT OR UPDATE sobre fare
CREATE OR REPLACE FUNCTION fn_aiu_fare_touch_airline()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE airline
    SET updated_at = now()
    WHERE airline_id = NEW.airline_id;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_aiu_fare_touch_airline
AFTER INSERT OR UPDATE ON fare
FOR EACH ROW
EXECUTE FUNCTION fn_aiu_fare_touch_airline();

-- 2. Procedimiento almacenado
CREATE OR REPLACE PROCEDURE sp_publish_fare(
    p_airline_id uuid,
    p_origin_airport_id uuid,
    p_destination_airport_id uuid,
    p_fare_class_id uuid,
    p_currency_id uuid,
    p_fare_code varchar,
    p_base_amount numeric,
    p_valid_from date,
    p_valid_to date DEFAULT NULL,
    p_baggage_allowance_qty integer DEFAULT 0,
    p_change_penalty_amount numeric DEFAULT NULL,
    p_refund_penalty_amount numeric DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_origin_airport_id = p_destination_airport_id THEN
        RAISE EXCEPTION 'El aeropuerto de origen y destino no pueden ser el mismo.';
    END IF;

    IF p_base_amount < 0 THEN
        RAISE EXCEPTION 'El monto base no puede ser negativo.';
    END IF;

    IF p_baggage_allowance_qty < 0 THEN
        RAISE EXCEPTION 'La franquicia de equipaje no puede ser negativa.';
    END IF;

    IF p_valid_to IS NOT NULL AND p_valid_to < p_valid_from THEN
        RAISE EXCEPTION 'La fecha final de validez no puede ser anterior a la inicial.';
    END IF;

    INSERT INTO fare (
        airline_id, origin_airport_id, destination_airport_id, fare_class_id, currency_id,
        fare_code, base_amount, valid_from, valid_to, baggage_allowance_qty,
        change_penalty_amount, refund_penalty_amount
    ) VALUES (
        p_airline_id, p_origin_airport_id, p_destination_airport_id, p_fare_class_id, p_currency_id,
        p_fare_code, p_base_amount, p_valid_from, p_valid_to, p_baggage_allowance_qty,
        p_change_penalty_amount, p_refund_penalty_amount
    );
END;
$$;

-- 3. Consulta con INNER JOIN (mínimo 5 tablas)
SELECT
    al.airline_name,
    f.fare_code,
    fc.class_code,
    ao.iata_code AS origin_airport,
    ad.iata_code AS destination_airport,
    c.iso_currency_code,
    f.base_amount,
    r.reservation_code,
    s.sale_code,
    t.ticket_number
FROM airline al
INNER JOIN fare f ON f.airline_id = al.airline_id
INNER JOIN fare_class fc ON fc.fare_class_id = f.fare_class_id
INNER JOIN airport ao ON ao.airport_id = f.origin_airport_id
INNER JOIN airport ad ON ad.airport_id = f.destination_airport_id
INNER JOIN currency c ON c.currency_id = f.currency_id
INNER JOIN ticket t ON t.fare_id = f.fare_id
INNER JOIN sale s ON s.sale_id = t.sale_id
INNER JOIN reservation r ON r.reservation_id = s.reservation_id
ORDER BY f.valid_from DESC, f.fare_code;
```

## Archivo `ejercicio_09_demo.sql`

```sql
DO $$
DECLARE
    v_airline_id uuid;
    v_origin_id uuid;
    v_destination_id uuid;
    v_class_id uuid;
    v_currency_id uuid;
    v_fare_code varchar(30);
BEGIN
    SELECT airline_id INTO v_airline_id FROM airline ORDER BY created_at LIMIT 1;
    SELECT airport_id INTO v_origin_id FROM airport ORDER BY created_at LIMIT 1;
    SELECT airport_id INTO v_destination_id FROM airport WHERE airport_id <> v_origin_id ORDER BY created_at LIMIT 1;
    SELECT fare_class_id INTO v_class_id FROM fare_class ORDER BY created_at LIMIT 1;
    SELECT currency_id INTO v_currency_id FROM currency ORDER BY created_at LIMIT 1;

    IF v_airline_id IS NULL OR v_origin_id IS NULL OR v_destination_id IS NULL OR v_class_id IS NULL OR v_currency_id IS NULL THEN
        RAISE EXCEPTION 'No se encontraron datos base suficientes para la prueba de tarifas.';
    END IF;

    v_fare_code := left('FARE-' || replace(gen_random_uuid()::text, '-', ''), 30);

    CALL sp_publish_fare(
        v_airline_id,
        v_origin_id,
        v_destination_id,
        v_class_id,
        v_currency_id,
        v_fare_code,
        199.99,
        current_date,
        current_date + 90,
        1,
        40.00,
        60.00
    );
END;
$$;

SELECT al.airline_name, al.updated_at, f.fare_code, f.base_amount, f.valid_from, f.valid_to
FROM fare f
INNER JOIN airline al ON al.airline_id = f.airline_id
ORDER BY f.created_at DESC
LIMIT 5;
```

## Ejecución recomendada en PostgreSQL

```sql
\i ejercicio_09_setup.sql
\i ejercicio_09_demo.sql
```
