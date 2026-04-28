# ☕ Cafetería Trabajo

![Proyecto](https://img.shields.io/badge/Proyecto-Cafeter%C3%ADa-brown)
![Backend](https://img.shields.io/badge/Backend-PHP-777BB4)
![Frontend](https://img.shields.io/badge/Frontend-HTML%20%7C%20CSS%20%7C%20JS-orange)
![DB](https://img.shields.io/badge/DB-PostgreSQL-336791)
![Liquibase](https://img.shields.io/badge/Liquibase-Migrations-blue)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED)

Proyecto académico basado en una **cafetería**, desarrollado con arquitectura separada en **base de datos**, **backend** y **frontend**.

---

## 📌 Repositorios del proyecto

| Repositorio | Descripción | Enlace |
|---|---|---|
| ☕ Proyecto completo | Contiene todo el sistema unido: base de datos, backend y frontend. Ideal para levantar todo con Docker Compose. | [Cafeteria-trabajo](https://github.com/jsgh1/Cafeteria-trabajo) |
| 🗄️ Base de datos | Contiene PostgreSQL, Liquibase, scripts SQL, inserts, rollbacks y GitHub Actions para validar migraciones. | [Cafeteria-DB](https://github.com/jsgh1/Cafeteria-DB) |
| ⚙️ Backend | API REST en PHP con CRUD completo, conexión a PostgreSQL y documentación Swagger. | [Cafeteria-Backend](https://github.com/jsgh1/Cafeteria-Backend) |
| 🎨 Frontend | Interfaz web en HTML, CSS, JavaScript y Axios para consumir el backend y manejar el CRUD visual. | [Cafeteria-Frontend](https://github.com/jsgh1/Cafeteria-Frontend) |

---

## 🧩 Arquitectura general

```text
Frontend  →  Backend  →  Base de datos
HTML/CSS     PHP API      PostgreSQL
JS/Axios     Swagger      Liquibase
```

Flujo general:

```text
Usuario
  ↓
Frontend con Axios
  ↓
Backend PHP REST API
  ↓
PostgreSQL
  ↓
Respuesta JSON
  ↓
Frontend actualiza la vista
```

---

## 🗄️ Base de datos

La base de datos está hecha en **PostgreSQL** y se administra con **Liquibase**.

Liquibase permite versionar la base de datos por medio de archivos XML y SQL. Esto evita crear tablas manualmente y permite validar errores automáticamente en GitHub Actions.

### Entidades

```text
categorias
productos
clientes
pedidos
pedido_items
```

### Relaciones principales

```text
productos.categoria_id   → categorias.id
pedidos.cliente_id       → clientes.id
pedido_items.pedido_id   → pedidos.id
pedido_items.producto_id → productos.id
```

Esto permite mantener integridad referencial. Por ejemplo, no se puede crear un producto con una categoría que no existe.

---

## ⚙️ Backend

El backend está desarrollado en **PHP** y expone una **API REST**.

Cada entidad tiene 6 operaciones:

```text
Crear
Consultar todos
Consultar por ID
Actualizar
Eliminar
Filtrar
```

Como son 5 entidades:

```text
5 entidades x 6 operaciones = 30 endpoints
```

### Ejemplo de endpoints

```text
GET    /api/productos
GET    /api/productos/{id}
GET    /api/productos/filter
POST   /api/productos
PUT    /api/productos/{id}
DELETE /api/productos/{id}
```

El backend también incluye documentación con **Swagger**, para probar los servicios directamente desde el navegador:

```text
http://localhost:8080/docs
```

---

## 🎨 Frontend

El frontend está hecho con:

```text
HTML
CSS
JavaScript
Axios
```

Su función es permitir que el usuario use el CRUD visualmente, sin necesidad de probar todo manualmente desde Swagger.

Desde la interfaz se puede:

```text
Crear registros
Consultar registros
Filtrar registros
Actualizar registros
Eliminar registros
Navegar entre entidades
```

También incluye una landing page donde se documenta visualmente el proyecto.

---

## 🐳 Docker

El proyecto completo puede levantarse con Docker Compose.

Desde el repositorio completo:

```bash
docker compose up --build
```

Para apagar los contenedores:

```bash
docker compose down
```

Para apagar y borrar los datos de PostgreSQL:

```bash
docker compose down -v
```

Después de levantar el proyecto, se pueden usar estos enlaces:

```text
Frontend:   http://localhost:3000
Backend:    http://localhost:8080
Swagger:    http://localhost:8080/docs
PostgreSQL: localhost:5432
```

---

## 🔄 Liquibase

Liquibase se encarga de crear y versionar la base de datos.

Estructura principal del repo DB:

```text
01_tables/
09_inserts/
11_rollbacks/
liquibase/
  changelog-master.xml
  liquibase.properties
  changelogs/
```

Comandos útiles:

```bash
docker compose run --rm liquibase validate
docker compose run --rm liquibase update
docker compose run --rm liquibase status
docker compose run --rm liquibase rollbackCount 1
```

---

## ✅ GitHub Actions

El repositorio de base de datos incluye GitHub Actions para validar que Liquibase funcione correctamente.

El workflow realiza tareas como:

```text
Levantar PostgreSQL temporal
Validar changelog de Liquibase
Ejecutar migraciones
Revisar estructura de carpetas
Verificar archivos SQL principales
```

Esto ayuda a evitar que se haga merge de cambios dañados. Si Liquibase falla, el check de GitHub Actions falla y se puede bloquear el merge mediante reglas de protección de rama.

---

## 📁 Repositorios separados

### 1. Repositorio completo

Repositorio principal para levantar todo junto.

🔗 [https://github.com/jsgh1/Cafeteria-trabajo](https://github.com/jsgh1/Cafeteria-trabajo)

---

### 2. Repositorio de base de datos

Contiene:

```text
PostgreSQL
Liquibase
Scripts SQL
Datos iniciales
Rollbacks
GitHub Actions
Docker Compose
```

🔗 [https://github.com/jsgh1/Cafeteria-DB](https://github.com/jsgh1/Cafeteria-DB)

---

### 3. Repositorio de backend

Contiene:

```text
API REST en PHP
CRUD por entidad
Conexión con PostgreSQL
Swagger
Dockerfile
```

🔗 [https://github.com/jsgh1/Cafeteria-Backend](https://github.com/jsgh1/Cafeteria-Backend)

---

### 4. Repositorio de frontend

Contiene:

```text
HTML
CSS
JavaScript
Axios
CRUD visual
Landing page
Dockerfile con Nginx
```

🔗 [https://github.com/jsgh1/Cafeteria-Frontend](https://github.com/jsgh1/Cafeteria-Frontend)

---

## 🚀 Orden recomendado para probar

Primero se recomienda probar el proyecto completo:

```bash
git clone https://github.com/jsgh1/Cafeteria-trabajo.git
cd Cafeteria-trabajo
docker compose up --build
```

Luego abrir:

```text
http://localhost:3000
http://localhost:8080/docs
```

Después se pueden revisar los repositorios separados:

```text
Cafeteria-DB
Cafeteria-Backend
Cafeteria-Frontend
```

---

## 🧪 Pruebas recomendadas

### Desde Swagger

Entrar a:

```text
http://localhost:8080/docs
```

Probar:

```text
GET
POST
PUT
DELETE
FILTER
GET BY ID
```

### Desde el frontend

Entrar a:

```text
http://localhost:3000
```

Probar:

```text
Crear una categoría
Crear un producto asociado a esa categoría
Crear un cliente
Crear un pedido
Crear un item de pedido
Editar registros
Eliminar registros
Filtrar información
```

---

## ⚠️ Nota sobre relaciones

Algunas entidades dependen de otras.

```text
Un producto necesita una categoría existente.
Un pedido necesita un cliente existente.
Un item de pedido necesita un pedido y un producto existentes.
```

Si se intenta crear un registro con un ID relacionado que no existe, PostgreSQL devolverá un error de llave foránea. Eso es correcto porque protege la integridad de los datos.

---

## 🧠 Resumen del proyecto

Este proyecto implementa una aplicación completa para una cafetería usando una arquitectura dividida en base de datos, backend y frontend.

La base de datos usa PostgreSQL y Liquibase para mantener controlados los cambios. El backend expone servicios REST en PHP y documenta sus endpoints con Swagger. El frontend consume la API usando Axios y permite manejar el CRUD desde una interfaz visual. Docker permite ejecutar todo el sistema de forma sencilla y GitHub Actions valida automáticamente los cambios de la base de datos.

---

## 👨‍💻 Autor

Proyecto realizado por:

**Juan Sebastian Gonzalez**

GitHub:

[https://github.com/jsgh1](https://github.com/jsgh1)

---

## ✅ Estado

```text
Base de datos: funcional
Backend: funcional
Frontend: funcional
Docker: funcional
Liquibase: funcional
GitHub Actions: funcional
```