# Ejercicio 04 - Acumulación de millas y actualización del historial de nivel

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
El programa de fidelización de la aerolínea requiere consultar el comportamiento comercial del cliente y automatizar el registro de acumulación de millas o movimientos de nivel a partir de eventos definidos en la base de datos.

---

## 7. Dominios involucrados en este ejercicio
### CUSTOMER AND LOYALTY
**Entidades:** `customer`, `loyalty_account`, `loyalty_program`, `loyalty_tier`, `loyalty_account_tier`, `miles_transaction`, `customer_category`  
**Propósito:** Gestionar clientes, cuentas de fidelización, niveles y acumulación de millas.

### AIRLINE
**Entidades:** `airline`  
**Propósito:** Identificar la aerolínea propietaria del programa.

### IDENTITY
**Entidades:** `person`  
**Propósito:** Relacionar el cliente con la persona real.

### SALES, RESERVATION, TICKETING
**Entidades:** `reservation`, `sale`  
**Propósito:** Relacionar la actividad comercial con el cliente.

---

## 8. Planteamiento del problema
La aerolínea necesita analizar la relación entre clientes, ventas y cuentas de fidelización, y además automatizar un movimiento posterior en el programa de millas o en el historial de nivel.

---

## 9. Objetivo del ejercicio
Formular un ejercicio que conecte el flujo comercial con el programa de fidelización, mediante consulta multi-tabla, trigger posterior y procedimiento almacenado.

---

## 10. Requerimiento 1 - Consulta con `INNER JOIN` de al menos 5 tablas

### Enunciado
Construya una consulta SQL que relacione cliente, persona, cuenta de fidelización, programa, nivel actual o histórico y ventas asociadas.

### Restricciones obligatorias
- Debe usar **`INNER JOIN`**
- Debe involucrar **mínimo 5 tablas**
- Debe usar únicamente entidades y atributos existentes en el modelo base
- No se permite cambiar nombres de tablas ni columnas
- La consulta debe ser coherente con las relaciones reales del modelo

### Tablas mínimas sugeridas
El estudiante deberá incluir, como mínimo, una combinación válida de tablas como:
- `customer`
- `person`
- `loyalty_account`
- `loyalty_program`
- `loyalty_account_tier`
- `loyalty_tier`
- `sale`

### Resultado esperado a nivel funcional
La consulta debe permitir responder una necesidad como esta: “Mostrar qué clientes tienen cuenta de fidelización, a qué programa pertenecen, qué nivel registran y qué actividad comercial tienen asociada”.

### Campos esperados en el resultado
Como mínimo, el resultado debe exponer columnas equivalentes a:
- cliente
- persona asociada
- cuenta de fidelización
- programa
- nivel
- fecha de asignación del nivel
- venta relacionada o referencia comercial

> El estudiante define la consulta exacta, pero debe respetar estrictamente el modelo base.

---

## 11. Requerimiento 2 - Trigger `AFTER`

### Enunciado
Diseñe un trigger `AFTER INSERT` sobre `miles_transaction` o sobre otra tabla del dominio de fidelización que automatice una acción verificable en `loyalty_account_tier` o en la trazabilidad del programa.

### Condición funcional del trigger
Al registrarse un evento de acumulación o ajuste de millas, el trigger deberá ejecutar una acción posterior coherente con el comportamiento del programa definido por el estudiante.

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
Diseñe un procedimiento almacenado que registre una transacción de millas para una cuenta de fidelización existente.

### Propósito del procedimiento
Encapsular la acumulación o ajuste de millas sobre una cuenta determinada y dejar el proceso listo para aplicar la lógica posterior del trigger.

### Alcance funcional mínimo
El procedimiento debe permitir trabajar con información relacionada con:
- cuenta de fidelización
- tipo de transacción
- cantidad de millas
- fecha del evento
- referencia o nota de soporte

### Restricciones obligatorias
- Debe implementarse como **procedimiento almacenado**
- Debe trabajar sobre tablas y atributos existentes
- No puede cambiar la estructura del modelo base
- Debe ser reutilizable
- Debe poder invocarse desde un script SQL independiente

### Integración esperada
La operación registrada por el procedimiento debe interactuar con el trigger y permitir verificar el efecto posterior sobre el historial de niveles o la lógica definida.

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

# Solución corregida del ejercicio 04

Esta versión integra el script SQL definitivo correspondiente al ejercicio 04. Está organizada en dos partes:

1. **Setup:** crea o reemplaza la función, el trigger, el procedimiento almacenado y deja la consulta principal del ejercicio.
2. **Demo:** ejecuta una prueba mínima sobre datos existentes de la base para disparar el procedimiento/trigger y verificar el resultado.

## Archivo `ejercicio_04_setup.sql`

```sql
DROP TRIGGER IF EXISTS trg_ai_miles_transaction_assign_tier ON miles_transaction;
DROP TRIGGER IF EXISTS trg_ai_miles_transaction_touch_account ON miles_transaction;
DROP FUNCTION IF EXISTS fn_ai_miles_transaction_assign_tier();
DROP FUNCTION IF EXISTS fn_ai_miles_transaction_touch_account();
DROP PROCEDURE IF EXISTS sp_register_miles_transaction(uuid, varchar, integer, timestamptz, varchar, text);
DROP PROCEDURE IF EXISTS sp_add_miles_transaction(uuid, varchar, integer, varchar, text);

-- 1. Trigger AFTER INSERT sobre miles_transaction
-- Recalcula el nivel de fidelización según el total acumulado de millas.
CREATE OR REPLACE FUNCTION fn_ai_miles_transaction_assign_tier()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_total_miles integer;
    v_tier_id uuid;
BEGIN
    SELECT coalesce(sum(mt.miles_delta), 0)
    INTO v_total_miles
    FROM miles_transaction mt
    WHERE mt.loyalty_account_id = NEW.loyalty_account_id;

    SELECT lt.loyalty_tier_id
    INTO v_tier_id
    FROM loyalty_account la
    INNER JOIN loyalty_tier lt ON lt.loyalty_program_id = la.loyalty_program_id
    WHERE la.loyalty_account_id = NEW.loyalty_account_id
      AND lt.required_miles <= v_total_miles
    ORDER BY lt.required_miles DESC, lt.priority_level DESC
    LIMIT 1;

    UPDATE loyalty_account
    SET updated_at = now()
    WHERE loyalty_account_id = NEW.loyalty_account_id;

    IF v_tier_id IS NOT NULL AND NOT EXISTS (
        SELECT 1
        FROM loyalty_account_tier lat
        WHERE lat.loyalty_account_id = NEW.loyalty_account_id
          AND lat.loyalty_tier_id = v_tier_id
          AND lat.expires_at IS NULL
    ) THEN
        INSERT INTO loyalty_account_tier (loyalty_account_id, loyalty_tier_id, assigned_at, expires_at)
        VALUES (NEW.loyalty_account_id, v_tier_id, NEW.occurred_at, NULL);
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_miles_transaction_assign_tier
AFTER INSERT ON miles_transaction
FOR EACH ROW
EXECUTE FUNCTION fn_ai_miles_transaction_assign_tier();

-- 2. Procedimiento almacenado
CREATE OR REPLACE PROCEDURE sp_register_miles_transaction(
    p_loyalty_account_id uuid,
    p_transaction_type varchar,
    p_miles_delta integer,
    p_occurred_at timestamptz DEFAULT now(),
    p_reference_code varchar DEFAULT NULL,
    p_notes text DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM loyalty_account WHERE loyalty_account_id = p_loyalty_account_id) THEN
        RAISE EXCEPTION 'No existe la cuenta de fidelización %', p_loyalty_account_id;
    END IF;

    IF p_transaction_type NOT IN ('EARN', 'REDEEM', 'ADJUST') THEN
        RAISE EXCEPTION 'Tipo de transacción inválido: %', p_transaction_type;
    END IF;

    IF p_miles_delta = 0 THEN
        RAISE EXCEPTION 'La cantidad de millas no puede ser cero.';
    END IF;

    INSERT INTO miles_transaction (loyalty_account_id, transaction_type, miles_delta, occurred_at, reference_code, notes)
    VALUES (p_loyalty_account_id, p_transaction_type, p_miles_delta, p_occurred_at, p_reference_code, p_notes);
END;
$$;

-- 3. Consulta con INNER JOIN (mínimo 5 tablas)
SELECT
    p.first_name || ' ' || p.last_name AS customer_name,
    c.customer_since,
    lp.program_name,
    la.account_number,
    lt.tier_name,
    lat.assigned_at,
    s.sale_code,
    s.sold_at
FROM customer c
INNER JOIN person p ON p.person_id = c.person_id
INNER JOIN loyalty_account la ON la.customer_id = c.customer_id
INNER JOIN loyalty_program lp ON lp.loyalty_program_id = la.loyalty_program_id
INNER JOIN loyalty_account_tier lat ON lat.loyalty_account_id = la.loyalty_account_id
INNER JOIN loyalty_tier lt ON lt.loyalty_tier_id = lat.loyalty_tier_id
INNER JOIN reservation r ON r.booked_by_customer_id = c.customer_id
INNER JOIN sale s ON s.reservation_id = r.reservation_id
ORDER BY s.sold_at DESC;
```

## Archivo `ejercicio_04_demo.sql`

```sql
DO $$
DECLARE
    v_loyalty_account_id uuid;
    v_reference_code varchar(60);
BEGIN
    SELECT loyalty_account_id
    INTO v_loyalty_account_id
    FROM loyalty_account
    ORDER BY created_at
    LIMIT 1;

    IF v_loyalty_account_id IS NULL THEN
        RAISE EXCEPTION 'No se encontró una cuenta de fidelización para la prueba.';
    END IF;

    v_reference_code := left('DEMO-MILES-' || replace(gen_random_uuid()::text, '-', ''), 60);

    CALL sp_register_miles_transaction(
        v_loyalty_account_id,
        'EARN',
        1500,
        now(),
        v_reference_code,
        'Acumulación de prueba'
    );
END;
$$;

SELECT la.account_number, mt.transaction_type, mt.miles_delta, lt.tier_name, lat.assigned_at
FROM loyalty_account la
INNER JOIN miles_transaction mt ON mt.loyalty_account_id = la.loyalty_account_id
LEFT JOIN loyalty_account_tier lat ON lat.loyalty_account_id = la.loyalty_account_id
LEFT JOIN loyalty_tier lt ON lt.loyalty_tier_id = lat.loyalty_tier_id
ORDER BY mt.created_at DESC, lat.assigned_at DESC
LIMIT 5;
```

## Ejecución recomendada en PostgreSQL

```sql
\i ejercicio_04_setup.sql
\i ejercicio_04_demo.sql
```
