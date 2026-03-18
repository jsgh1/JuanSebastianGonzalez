# Repaso Liquibase Ambientes

Este repositorio fue creado como práctica para entender de forma básica cómo trabajar con **Docker**, **MySQL**, **Liquibase** y el manejo de cambios por **ambientes**.

El repositorio donde se encuentra todo el trabajo es este:

**Repositorio:** https://github.com/jsgh1/Repaso-Liquibase-Ambientes

---

## Objetivo

La idea de esta práctica fue aprender a:

- levantar una base de datos MySQL en Docker
- aplicar cambios a la base de datos con Liquibase
- validar que los cambios sí se ejecutaran correctamente
- manejar el trabajo por ambientes usando ramas

---

## Qué se hizo con Docker

Se usó **Docker** para levantar una base de datos **MySQL** en un contenedor.

Esto permitió trabajar sin instalar MySQL directamente en el equipo, y facilitó tener un entorno más ordenado y fácil de ejecutar.

Con Docker se logró:

- descargar la imagen de MySQL
- crear el contenedor
- exponer el puerto para conectarse
- mantener la base lista para que Liquibase aplicara los cambios

---

## Qué se hizo con Liquibase

Se usó **Liquibase** para manejar los cambios de la base de datos como si fueran código.

En vez de crear todo manualmente en MySQL, se fueron creando archivos de cambios para que Liquibase los ejecutara.

### Cambios realizados

Se hicieron tres cambios principales:

1. **Crear la tabla `productos`**
2. **Insertar datos iniciales**
3. **Agregar la columna `activo`**

Liquibase aplicó los cambios y también creó sus tablas internas para llevar control de lo ejecutado:

- `DATABASECHANGELOG`
- `DATABASECHANGELOGLOCK`

Con eso se pudo comprobar que los cambios quedaron registrados correctamente.

---

## Validación del trabajo

Después de ejecutar Liquibase, se revisó directamente en MySQL que todo hubiera quedado bien.

Se validó que:

- la tabla `productos` existiera
- los datos iniciales estuvieran insertados
- la columna `activo` se hubiera agregado
- Liquibase hubiera registrado los changesets ejecutados

---

## Manejo por ambientes

También se trabajó el flujo por ambientes usando ramas en GitHub.

Se manejaron estas ramas principales:

- `dev`
- `qa`
- `main`

Y también se crearon ramas hijas para la historia de usuario:

- `HU-01-dev`
- `HU-01-qa`
- `HU-01-main`

### Flujo realizado

El proceso se hizo así:

- primero se trabajó en `HU-01-dev` y luego se hizo merge a `dev`
- después se creó `HU-01-qa` y se hizo merge a `qa`
- finalmente se creó `HU-01-main` y se hizo merge a `main`

La idea de esto fue practicar cómo un cambio puede pasar de desarrollo a pruebas y luego a la rama principal.

---

## Lo aprendido

Con esta práctica aprendí de forma básica que:

- Docker ayuda a levantar servicios como MySQL de forma rápida
- Liquibase sirve para versionar los cambios de una base de datos
- los cambios no se hacen manualmente, sino con archivos controlados
- es importante validar los cambios después de ejecutarlos
- trabajar por ambientes ayuda a organizar mejor el proceso

---

## Conclusión

Esta práctica me ayudó a entender mejor cómo se puede trabajar una base de datos de forma más ordenada usando Docker y Liquibase.

También me ayudó a ver que los cambios de base de datos se pueden manejar por ambientes, igual que el código, pasando por `dev`, `qa` y `main`.

Fue una práctica sencilla, pero útil para entender la lógica general de estas herramientas.
