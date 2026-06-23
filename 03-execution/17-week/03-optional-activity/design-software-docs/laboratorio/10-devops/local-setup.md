# Setup local

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: DevOps

## Requisitos

- Git.
- Runtime del backend definido por el equipo.
- Docker o motor equivalente para bases de datos locales.
- Cliente HTTP para probar APIs.

## Pasos

1. Clonar el repositorio.
2. Crear archivo de variables de entorno desde plantilla.
3. Levantar dependencias locales: bases de datos, broker y cache si aplica.
4. Ejecutar migraciones por servicio.
5. Cargar datos semilla.
6. Iniciar APIs y workers requeridos.

## Validacion

- /health responde en cada API.
- /ready confirma dependencias minimas.
- Se puede autenticar un usuario de prueba.
- Se puede consultar catalogos y crear una ficha de prueba.

