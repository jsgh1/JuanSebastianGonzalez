# Ejercicio 10 - Identidad de pasajeros, documentos y medios de contacto

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
El área de servicio al cliente necesita consultar la identidad completa del pasajero, sus documentos y datos de contacto, y automatizar una acción posterior cuando se registre un nuevo documento o un nuevo contacto prioritario.

---

## 7. Dominios involucrados en este ejercicio
### IDENTITY
**Entidades:** `person`, `person_type`, `person_document`, `document_type`, `person_contact`, `contact_type`  
**Propósito:** Gestionar identidad, documentos y medios de contacto.

### CUSTOMER AND LOYALTY
**Entidades:** `customer`  
**Propósito:** Relacionar la persona con su rol como cliente.

### SALES, RESERVATION, TICKETING
**Entidades:** `reservation_passenger`, `reservation`  
**Propósito:** Relacionar la identidad con la actividad comercial del pasajero.

---

## 8. Planteamiento del problema
La organización necesita una visión integrada de los pasajeros registrados y requiere automatizar un efecto posterior cuando cambie su información documental o de contacto.

---

## 9. Objetivo del ejercicio
Formular un ejercicio centrado en identidad del pasajero, con consulta multi-tabla, trigger posterior y procedimiento almacenado.

---

## 10. Requerimiento 1 - Consulta con `INNER JOIN` de al menos 5 tablas

### Enunciado
Construya una consulta SQL que relacione persona, tipo de persona, documento, tipo de documento, contacto, tipo de contacto y participación en una reserva.

### Restricciones obligatorias
- Debe usar **`INNER JOIN`**
- Debe involucrar **mínimo 5 tablas**
- Debe usar únicamente entidades y atributos existentes en el modelo base
- No se permite cambiar nombres de tablas ni columnas
- La consulta debe ser coherente con las relaciones reales del modelo

### Tablas mínimas sugeridas
El estudiante deberá incluir, como mínimo, una combinación válida de tablas como:
- `person`
- `person_type`
- `person_document`
- `document_type`
- `person_contact`
- `contact_type`
- `reservation_passenger`
- `reservation`

### Resultado esperado a nivel funcional
La consulta debe permitir responder una necesidad como esta: “Mostrar por pasajero su identidad, documentos registrados, medios de contacto y relación con reservas del sistema”.

### Campos esperados en el resultado
Como mínimo, el resultado debe exponer columnas equivalentes a:
- persona
- tipo de persona
- tipo de documento
- número de documento
- tipo de contacto
- valor del contacto
- reserva relacionada
- secuencia del pasajero en la reserva

> El estudiante define la consulta exacta, pero debe respetar estrictamente el modelo base.

---

## 11. Requerimiento 2 - Trigger `AFTER`

### Enunciado
Diseñe un trigger `AFTER INSERT` o `AFTER UPDATE` sobre `person_document` o `person_contact` que automatice una acción posterior verificable sobre otra tabla real del dominio IDENTITY.

### Condición funcional del trigger
Cuando se registre o actualice el dato seleccionado por el estudiante, el trigger deberá ejecutar una consecuencia verificable que mantenga coherencia con la trazabilidad de identidad definida en el ejercicio.

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
Diseñe un procedimiento almacenado que registre un nuevo documento o un nuevo contacto para una persona existente.

### Propósito del procedimiento
Encapsular una operación de mantenimiento de identidad para que sea reutilizable y controlada desde la base de datos.

### Alcance funcional mínimo
El procedimiento debe permitir trabajar con información relacionada con:
- persona
- tipo de documento o de contacto
- valor documental o de contacto
- país emisor, si aplica
- fechas de emisión o vencimiento, si aplica

### Restricciones obligatorias
- Debe implementarse como **procedimiento almacenado**
- Debe trabajar sobre tablas y atributos existentes
- No puede cambiar la estructura del modelo base
- Debe ser reutilizable
- Debe poder invocarse desde un script SQL independiente

### Integración esperada
La operación ejecutada por el procedimiento debe activar o dejar lista la lógica posterior definida en el trigger.

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

# Solución del ejercicio 10

## Consulta con INNER JOIN
```sql
SELECT
    p.first_name || ' ' || p.last_name AS passenger_name,
    pt.type_name AS person_type,
    dt.type_name AS document_type,
    pd.document_number,
    ct.type_name AS contact_type,
    pc.contact_value,
    r.reservation_code,
    rp.passenger_sequence_no
FROM person p
INNER JOIN person_type pt ON pt.person_type_id = p.person_type_id
INNER JOIN person_document pd ON pd.person_id = p.person_id
INNER JOIN document_type dt ON dt.document_type_id = pd.document_type_id
INNER JOIN person_contact pc ON pc.person_id = p.person_id
INNER JOIN contact_type ct ON ct.contact_type_id = pc.contact_type_id
INNER JOIN reservation_passenger rp ON rp.person_id = p.person_id
INNER JOIN reservation r ON r.reservation_id = rp.reservation_id
ORDER BY r.booked_at DESC, rp.passenger_sequence_no;
```

## Trigger AFTER INSERT OR UPDATE sobre person_contact
```sql
DROP TRIGGER IF EXISTS trg_aiu_person_contact_touch_person ON person_contact;
DROP FUNCTION IF EXISTS fn_aiu_person_contact_touch_person();

CREATE OR REPLACE FUNCTION fn_aiu_person_contact_touch_person()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE person
    SET updated_at = now()
    WHERE person_id = NEW.person_id;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_aiu_person_contact_touch_person
AFTER INSERT OR UPDATE ON person_contact
FOR EACH ROW
EXECUTE FUNCTION fn_aiu_person_contact_touch_person();
```

## Procedimiento almacenado
```sql
CREATE OR REPLACE PROCEDURE sp_register_person_contact(
    p_person_id uuid,
    p_contact_type_id uuid,
    p_contact_value varchar,
    p_is_primary boolean DEFAULT false
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_is_primary THEN
        UPDATE person_contact
        SET is_primary = false, updated_at = now()
        WHERE person_id = p_person_id
          AND contact_type_id = p_contact_type_id;
    END IF;

    INSERT INTO person_contact (person_id, contact_type_id, contact_value, is_primary)
    VALUES (p_person_id, p_contact_type_id, p_contact_value, p_is_primary);
END;
$$;
```

## Script de demostración
```sql
DO $$
DECLARE
    v_person_id uuid;
    v_contact_type_id uuid;
BEGIN
    SELECT person_id INTO v_person_id FROM person ORDER BY created_at LIMIT 1;
    SELECT contact_type_id INTO v_contact_type_id FROM contact_type ORDER BY created_at LIMIT 1;

    CALL sp_register_person_contact(v_person_id, v_contact_type_id,
        'demo-' || left(replace(gen_random_uuid()::text, '-', ''), 12) || '@correo.test', true);
END;
$$;

SELECT p.first_name, p.last_name, p.updated_at, ct.type_name, pc.contact_value, pc.is_primary
FROM person p
INNER JOIN person_contact pc ON pc.person_id = p.person_id
INNER JOIN contact_type ct ON ct.contact_type_id = pc.contact_type_id
ORDER BY pc.created_at DESC
LIMIT 5;
```
