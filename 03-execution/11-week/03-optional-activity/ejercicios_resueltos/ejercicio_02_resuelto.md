# Ejercicio 02 - Control de pagos y trazabilidad de transacciones financieras

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
El área financiera necesita auditar el estado de los pagos de una venta, identificar sus transacciones asociadas y controlar la generación de devoluciones cuando se registre una reversión o evento posterior definido por el estudiante.

---

## 7. Dominios involucrados en este ejercicio
### SALES, RESERVATION, TICKETING
**Entidades:** `sale`, `reservation`  
**Propósito:** Relacionar la venta con el contexto comercial de la reserva.

### PAYMENT
**Entidades:** `payment`, `payment_status`, `payment_method`, `payment_transaction`, `refund`  
**Propósito:** Gestionar pagos, transacciones y devoluciones.

### BILLING
**Entidades:** `invoice`  
**Propósito:** Relacionar el pago con el documento facturable asociado, si existe.

### GEOGRAPHY AND REFERENCE DATA
**Entidades:** `currency`  
**Propósito:** Normalizar la moneda usada en la venta y el pago.

---

## 8. Planteamiento del problema
La organización requiere una vista consolidada del ciclo de pago de una venta y necesita automatizar un efecto posterior sobre las devoluciones a partir de un evento registrado en el flujo de pagos.

---

## 9. Objetivo del ejercicio
Plantear una solución que permita consultar el flujo venta-pago-transacción, automatizar una acción posterior sobre devoluciones y encapsular el registro de una transacción de pago mediante un procedimiento almacenado.

---

## 10. Requerimiento 1 - Consulta con `INNER JOIN` de al menos 5 tablas

### Enunciado
Construya una consulta SQL que consolide información de venta, pago, estado del pago, método, transacción financiera y moneda de la operación.

### Restricciones obligatorias
- Debe usar **`INNER JOIN`**
- Debe involucrar **mínimo 5 tablas**
- Debe usar únicamente entidades y atributos existentes en el modelo base
- No se permite cambiar nombres de tablas ni columnas
- La consulta debe ser coherente con las relaciones reales del modelo

### Tablas mínimas sugeridas
El estudiante deberá incluir, como mínimo, una combinación válida de tablas como:
- `sale`
- `reservation`
- `payment`
- `payment_status`
- `payment_method`
- `payment_transaction`
- `currency`

### Resultado esperado a nivel funcional
La consulta debe permitir responder una necesidad como esta: “Mostrar por cada venta sus pagos registrados, método utilizado, estado actual, transacciones financieras procesadas y moneda de la operación”.

### Campos esperados en el resultado
Como mínimo, el resultado debe exponer columnas equivalentes a:
- código de venta
- código de reserva
- referencia de pago
- estado del pago
- método de pago
- referencia de transacción
- tipo de transacción
- monto procesado
- moneda

> El estudiante define la consulta exacta, pero debe respetar estrictamente el modelo base.

---

## 11. Requerimiento 2 - Trigger `AFTER`

### Enunciado
Diseñe un trigger `AFTER INSERT` o `AFTER UPDATE` sobre una tabla del dominio PAYMENT que automatice una acción relacionada con la tabla `refund`.

### Condición funcional del trigger
Ante el evento seleccionado por el estudiante dentro del flujo de pago, el trigger deberá generar o actualizar evidencia en `refund` de forma consistente con la lógica del negocio definida en el ejercicio.

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
Diseñe un procedimiento almacenado que registre una transacción financiera sobre un pago existente y deje trazabilidad verificable del proceso.

### Propósito del procedimiento
Centralizar el registro de una transacción de pago y dejar la operación lista para activar el comportamiento posterior definido en el trigger.

### Alcance funcional mínimo
El procedimiento debe permitir trabajar con información relacionada con:
- pago existente
- tipo de transacción
- monto procesado
- fecha y hora de procesamiento
- mensaje del proveedor, si aplica

### Restricciones obligatorias
- Debe implementarse como **procedimiento almacenado**
- Debe trabajar sobre tablas y atributos existentes
- No puede cambiar la estructura del modelo base
- Debe ser reutilizable
- Debe poder invocarse desde un script SQL independiente

### Integración esperada
La transacción registrada por el procedimiento debe poder interactuar con la lógica del trigger planteado, de forma que exista evidencia posterior verificable sobre devoluciones o eventos derivados.

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

# Solución corregida del ejercicio 02

Esta versión integra el script SQL definitivo correspondiente al ejercicio 02. Está organizada en dos partes:

1. **Setup:** crea o reemplaza la función, el trigger, el procedimiento almacenado y deja la consulta principal del ejercicio.
2. **Demo:** ejecuta una prueba mínima sobre datos existentes de la base para disparar el procedimiento/trigger y verificar el resultado.

## Archivo `ejercicio_02_setup.sql`

```sql
DROP TRIGGER IF EXISTS trg_ai_payment_transaction_refund ON payment_transaction;
DROP TRIGGER IF EXISTS trg_ai_payment_transaction_create_refund ON payment_transaction;
DROP FUNCTION IF EXISTS fn_ai_payment_transaction_refund();
DROP FUNCTION IF EXISTS fn_ai_payment_transaction_create_refund();
DROP PROCEDURE IF EXISTS sp_register_payment_transaction(uuid, varchar, numeric, timestamptz, text);

-- 1. Trigger AFTER INSERT sobre payment_transaction
-- Si la transacción es REFUND o REVERSAL, genera automáticamente el registro en refund.
CREATE OR REPLACE FUNCTION fn_ai_payment_transaction_refund()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.transaction_type IN ('REFUND', 'REVERSAL') THEN
        INSERT INTO refund (
            payment_id,
            refund_reference,
            amount,
            requested_at,
            processed_at,
            refund_reason
        )
        VALUES (
            NEW.payment_id,
            left('REF-' || replace(NEW.payment_transaction_id::text, '-', ''), 40),
            NEW.transaction_amount,
            NEW.processed_at,
            NEW.processed_at,
            'Generado automáticamente por transacción ' || NEW.transaction_type || COALESCE(': ' || NEW.provider_message, '')
        );
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_payment_transaction_refund
AFTER INSERT ON payment_transaction
FOR EACH ROW
EXECUTE FUNCTION fn_ai_payment_transaction_refund();

-- 2. Procedimiento almacenado
CREATE OR REPLACE PROCEDURE sp_register_payment_transaction(
    p_payment_id uuid,
    p_transaction_type varchar,
    p_transaction_amount numeric,
    p_processed_at timestamptz DEFAULT now(),
    p_provider_message text DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_transaction_reference varchar(60);
BEGIN
    IF NOT EXISTS (SELECT 1 FROM payment WHERE payment_id = p_payment_id) THEN
        RAISE EXCEPTION 'No existe el pago %', p_payment_id;
    END IF;

    IF p_transaction_type NOT IN ('AUTH', 'CAPTURE', 'VOID', 'REFUND', 'REVERSAL') THEN
        RAISE EXCEPTION 'Tipo de transacción inválido: %', p_transaction_type;
    END IF;

    IF p_transaction_amount <= 0 THEN
        RAISE EXCEPTION 'El monto de la transacción debe ser mayor a cero.';
    END IF;

    v_transaction_reference := left('TXN-' || replace(gen_random_uuid()::text, '-', ''), 60);

    INSERT INTO payment_transaction (
        payment_id,
        transaction_reference,
        transaction_type,
        transaction_amount,
        processed_at,
        provider_message
    )
    VALUES (
        p_payment_id,
        v_transaction_reference,
        p_transaction_type,
        p_transaction_amount,
        p_processed_at,
        p_provider_message
    );
END;
$$;

-- 3. Consulta con INNER JOIN (mínimo 5 tablas)
SELECT
    s.sale_code,
    r.reservation_code,
    p.payment_reference,
    ps.status_name AS payment_status,
    pm.method_name AS payment_method,
    pt.transaction_reference,
    pt.transaction_type,
    pt.transaction_amount,
    c.iso_currency_code
FROM sale s
INNER JOIN reservation r ON r.reservation_id = s.reservation_id
INNER JOIN payment p ON p.sale_id = s.sale_id
INNER JOIN payment_status ps ON ps.payment_status_id = p.payment_status_id
INNER JOIN payment_method pm ON pm.payment_method_id = p.payment_method_id
INNER JOIN payment_transaction pt ON pt.payment_id = p.payment_id
INNER JOIN currency c ON c.currency_id = p.currency_id
ORDER BY pt.processed_at DESC;
```

## Archivo `ejercicio_02_demo.sql`

```sql
DO $$
DECLARE
    v_payment_id uuid;
BEGIN
    -- 1. Buscar un pago existente
    SELECT payment_id
    INTO v_payment_id
    FROM payment
    LIMIT 1;

    IF v_payment_id IS NULL THEN
        RAISE EXCEPTION 'No se encontró un pago para la prueba.';
    END IF;

    -- 2. Invocar el procedimiento simulando una transacción de DEVOLUCIÓN ('REFUND')
    -- Esto disparará el trigger y creará un registro en la tabla refund
    CALL sp_register_payment_transaction(
        v_payment_id,
        'REFUND',  -- Tipo de transacción que activa el trigger
        150.00,    -- Monto
        now(),
        'Devolución parcial solicitada por el cliente'
    );

    RAISE NOTICE 'Transacción de tipo REFUND registrada para el pago %', v_payment_id;
END;
$$;

-- 3. Verificación de la Transacción y la Devolución (creada por el trigger)
SELECT 
    pt.transaction_reference,
    pt.transaction_type,
    pt.transaction_amount,
    r.refund_reference,
    r.amount,
    r.refund_reason
FROM payment_transaction pt
INNER JOIN refund r ON r.payment_id = pt.payment_id
-- Relacionamos por fecha de procesamiento y monto para encontrar la que acabamos de crear
WHERE pt.transaction_type = 'REFUND'
ORDER BY pt.created_at DESC
LIMIT 1;
```

## Ejecución recomendada en PostgreSQL

```sql
\i ejercicio_02_setup.sql
\i ejercicio_02_demo.sql
```
