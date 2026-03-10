# Carrito de compras — Cafetín SENA (Industria)

## 1) Planteamiento del problema
En el cafetín se presentan filas, demoras y errores al tomar pedidos. Se requiere un sistema que permita a los usuarios seleccionar productos, armar un carrito y confirmar el pedido, mientras el cafetín recibe, prepara y entrega con control básico del proceso.

## 2) Objetivos

### Objetivo general
Diseñar una solución tipo carrito de compras para gestionar pedidos del cafetín de manera ágil y ordenada, reduciendo tiempos y errores.

### Objetivos específicos (3)
1. Levantar y documentar requerimientos (RF/RNF) y reglas de negocio.
2. Definir el MVP y prototipar pantallas mínimas (mockup baja fidelidad).
3. Planear el trabajo mediante backlog (historias + criterios + estimación) y proponer el modelo de datos.

## 3) Alcance

### Incluye
- Catálogo de productos
- Carrito (agregar/quitar/actualizar cantidades)
- Confirmación de pedido
- Gestión básica cafetín: ver pedidos y cambiar estado

### No incluye (por ahora)
- Pagos en línea
- Integración con inventario real
- Facturación electrónica
- App móvil nativa (si aplica)

---

## 4) Requerimientos

### 4.1 Requerimientos funcionales (RF)
**RF-01** Ver catálogo de productos (nombre, precio, disponibilidad).  
**RF-02** Buscar/filtrar productos por categoría (opcional).  
**RF-03** Agregar producto al carrito.  
**RF-04** Ver carrito (lista, cantidades, subtotal y total).  
**RF-05** Modificar cantidad / eliminar ítem del carrito.  
**RF-06** Confirmar pedido (crear orden con detalle).  
**RF-07** Ver estado del pedido (ej. Recibido/En preparación/Listo/Entregado).  
**RF-08** (Cafetín) Ver lista de pedidos recibidos.  
**RF-09** (Cafetín) Cambiar estado de un pedido.

### 4.2 Requerimientos no funcionales (RNF)
**RNF-01** Usabilidad: flujo simple en pocas pantallas.  
**RNF-02** Rendimiento: cargar catálogo y carrito con tiempos razonables.  
**RNF-03** Seguridad básica: validación de entradas; control de acceso si hay roles.  
**RNF-04** Disponibilidad: el sistema debe funcionar en la jornada del cafetín.  
**RNF-05** Trazabilidad: pedidos deben quedar registrados.

### 4.3 Reglas de negocio (RN)
**RN-01** No se puede confirmar un pedido con carrito vacío.  
**RN-02** Un pedido confirmado inicia en estado **“Recibido”**.  
**RN-03** Flujo de estados permitido: Recibido → En preparación → Listo → Entregado.  
**RN-04** No se puede pasar de “Recibido” a “Listo” saltando estados.  
**RN-05** Si un producto está “no disponible”, no debe poder agregarse al carrito.

---

## 5) Priorización MoSCoW (MVP)

### Must (MVP)
- Catálogo → Carrito → Confirmación del pedido
- (Cafetín) Ver pedidos → Cambiar estado
- Registro de pedido con detalle (qué compró y cuánto)

### Should
- Filtros por categoría
- Ver total y subtotales claramente
- Confirmación visual (pantalla “Pedido creado”)

### Could
- Historial de pedidos del usuario
- Notificación cuando esté “Listo”
- Edición del pedido antes de preparar (ventana corta)

### Won’t (por ahora)
- Pagos en línea
- Integración con inventario/ERP
- App nativa

> Nota: El MVP se considera viable si define el flujo **catálogo → carrito → confirmación** y la gestión básica del cafetín **ver pedidos → cambiar estado**.

---

## 6) Mockup inicial (baja fidelidad) — Pantallas mínimas del MVP
**Link Figma:** <https://www.figma.com/design/q2kzyCNFTc6rd8Z7MfbjqX/Cafetín-SENA?t=nzwn3ltjuWvNEACw-1>

---

## 7) Backlog / Plan de trabajo (Historias + criterios + estimación)

> Escala: 1 (pequeño), 2 (medio), 3 (grande)

### Historias de usuario (MVP primero)
**HU-01 (Must)** Como usuario, quiero ver el catálogo para elegir productos.  
**Criterios de aceptación**
- Se muestra lista con nombre y precio
- Si un producto no está disponible, se indica

**HU-02 (Must)** Como usuario, quiero agregar productos al carrito para armar mi pedido.  
**Criterios**
- Al agregar, aumenta cantidad del ítem
- No permite agregar si no disponible

**HU-03 (Must)** Como usuario, quiero ver y editar mi carrito para ajustar el pedido.  
**Criterios**
- Puedo aumentar/disminuir cantidad
- Puedo eliminar ítems
- Se recalcula total

**HU-04 (Must)** Como usuario, quiero confirmar el pedido para que el cafetín lo reciba.  
**Criterios**
- No permite confirmar carrito vacío
- Al confirmar crea pedido con estado “Recibido”
- Muestra confirmación con número de pedido

**HU-05 (Must)** Como cafetín, quiero ver pedidos para prepararlos en orden.  
**Criterios**
- Lista pedidos con fecha/hora, total y estado
- Ordenados por más antiguos primero (o por estado)

**HU-06 (Must)** Como cafetín, quiero cambiar el estado del pedido para reflejar el avance.  
**Criterios**
- Solo permite transiciones válidas (RN-03)
- Al cambiar estado se ve actualizado

### Tabla rápida (ejemplo)
| ID | Prioridad | Estimación | Estado |
|---|---|---:|---|
| HU-01 | Must | 1 | Pendiente |
| HU-02 | Must | 1 | Pendiente |
| HU-03 | Must | 2 | Pendiente |
| HU-04 | Must | 2 | Pendiente |
| HU-05 | Must | 3 | Pendiente |
| HU-06 | Must | 3 | Pendiente |

---

## 8) Modelo de datos (propuesto)

### Entidades
**Producto**
- producto_id (PK)
- nombre
- precio
- disponible (bool)
- categoria (opcional)

**Pedido**
- pedido_id (PK)
- fecha_hora
- estado (Recibido/En preparación/Listo/Entregado)
- total

**DetallePedido**
- detalle_id (PK)
- pedido_id (FK → Pedido)
- producto_id (FK → Producto)
- cantidad
- precio_unitario
- subtotal

### Relaciones
- Pedido 1 — N DetallePedido
- Producto 1 — N DetallePedido

---

## VIDEO 
**Link:** <https://youtu.be/NJiEIs3jqPs?feature=shared>

## PRESENTACION 
**Link:** <https://gamma.app/docs/De-Design-Thinking-MoSCoW-Scrum-al-MVP-9kgxi56kzarrn12>

## PRESENTACION 2
**Link:** <https://gamma.app/docs/Scrum-Design-Thinking-y-MoSCoW-03yx9kud5ixbhik?mode=doc> 