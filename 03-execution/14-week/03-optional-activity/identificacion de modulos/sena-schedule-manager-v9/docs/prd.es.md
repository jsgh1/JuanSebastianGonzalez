# Documento de Requisitos del Producto

## Proyecto

SENA Schedule Manager

## Objetivo del Producto

Construir un MVP con forma de producción para gestionar horarios académicos del SENA. MVP significa alcance funcional reducido, no reducción de calidad de ingeniería.

El producto debe soportar la programación de salas, grupos de formación, instructores, bloques de horario y observaciones. La UI visible al usuario y la documentación para usuarios deben estar en español. Todo el código técnico, nombres de carpetas, nombres de objetos de base de datos, nombres de entidades, atributos, diagramas, contratos API, pruebas, comentarios y documentación para desarrolladores deben estar en inglés.

## Stack Obligatorio

- Backend: Go
- Frontend: React
- Base de datos: MongoDB
- Runtime: Docker y Docker Compose

Cualquier backend generado con Node/Express, base de datos PostgreSQL/MySQL, frontend Angular/Vue o desviación del stack debe rechazarse.

## Límites de Componentes

El workspace debe entregarse como tres proyectos independientes más una orquestación raíz:

- `database/`: init de MongoDB, seed, índices, validación, Dockerfile o configuración de imagen y documentación específica de base de datos.
- `backend/`: solo API en Go. No debe incluir init de base de datos, seed, migraciones ni scripts Mongo.
- `frontend/`: solo UI en React.
- root: `docker-compose.yml`, `.env.example`, `.gitignore` y documentación transversal de ejecución.

Cada componente debe tener su propio límite de contenedor. Base de datos, backend y frontend no deben compartir contenedor.

## Alcance Funcional

### Rooms

- Crear, listar, actualizar y deshabilitar salas.
- Almacenar código, nombre, capacidad, ubicación y estado activo.
- Detectar conflictos de horario por sala y rango horario.

### Training Groups

- Crear, listar, actualizar y deshabilitar grupos de formación.
- Almacenar código de grupo, nombre del programa, fecha de inicio, fecha de fin y estado activo.
- Detectar conflictos de horario por grupo y rango horario.

### Instructors

- Crear, listar, actualizar y deshabilitar instructores.
- Almacenar nombre completo, correo, tipo de contrato, especialización y estado activo.
- El tipo de contrato debe soportar instructores permanentes y contratistas.
- Detectar conflictos de horario por instructor y rango horario.

### Schedule Blocks

- Crear, listar, actualizar y cancelar bloques de horario.
- Almacenar fecha, hora de inicio, hora de fin, sala, grupo de formación, instructor y actividad de aprendizaje.
- Validar que la hora de fin sea posterior a la hora de inicio.
- Prevenir conflictos para sala, grupo de formación e instructor.

### Observations

- Agregar observaciones a los bloques de horario.
- Almacenar texto, autor, fecha de creación y severidad.
- La severidad debe soportar `info`, `warning` y `critical`.

## Requisitos de Arquitectura

### Backend

El backend en Go debe usar arquitectura por capas:

- `cmd/api` solo para bootstrap y wiring.
- `internal/config` para carga de configuración.
- `internal/domain` para entidades, value objects y reglas de dominio.
- `internal/application` para casos de uso y orquestación de servicios.
- `internal/http` para handlers, routes, request DTOs y response DTOs.
- `internal/repository` para interfaces o contratos de persistencia.
- `internal/infrastructure` para adaptadores de MongoDB y detalles externos.

Reglas:

- `main.go` solo debe componer dependencias e iniciar el servidor.
- Los handlers HTTP no deben acceder a MongoDB directamente.
- Los servicios/casos de uso deben depender de interfaces de repositorio, no de adaptadores concretos de MongoDB.
- El código de dominio no debe importar paquetes HTTP, MongoDB, Docker, environment o frameworks.
- Los repositorios/adaptadores no deben contener lógica HTTP.
- El servidor debe incluir timeouts de lectura, escritura, idle y shutdown.
- CORS no debe ser wildcard en modo producción.
- Las respuestas 500 no deben exponer errores internos crudos.
- Los archivos fuente deben mantenerse por debajo de 300 líneas.

### Frontend

El frontend en React debe usar arquitectura orientada a funcionalidades:

- `src/app` para composición de app y routing.
- `src/features` para módulos funcionales.
- `src/components` para componentes UI compartidos.
- `src/services` para clientes API.
- `src/hooks` para hooks reutilizables.
- `src/types` para contratos compartidos.

Reglas:

- `App.jsx` o `App.tsx` solo debe componer routing/layout.
- Las llamadas API deben vivir fuera de los componentes React.
- El cliente API debe definir timeout y manejo estructurado de errores.
- La persistencia local/demo no debe vivir en `App.jsx` ni en páginas de features.
- Páginas, componentes y archivos CSS deben mantenerse por debajo de 300 líneas.
- Los textos de la UI deben estar en español, pero los nombres de implementación en inglés.

### Database

Las colecciones y atributos de MongoDB deben usar nombres singulares en inglés.

Ejemplos permitidos:

- `room`
- `trainingGroup`
- `instructor`
- `scheduleBlock`
- `observation`

Ejemplos rechazados:

- `rooms`
- `ambientes`
- `fichas`
- `instructores`
- `horarios`
- `observaciones`

Requisitos del proyecto de base de datos:

- Carpeta propia `database/`.
- Scripts propios de init, índices, reglas de validación, seed y README.
- Los datos seed deben usar nombres de campos en inglés.
- Ningún script de init o seed puede almacenarse bajo `backend/`.

## Requisitos de Calidad

- Incluir pruebas unitarias de backend para reglas de dominio y detección de conflictos.
- Incluir pruebas de repositorio o adaptadores de backend donde sea práctico.
- Incluir pruebas frontend para el comportamiento del cliente API e interacciones clave de UI.
- Incluir comandos ejecutables de build/test con `cwd`, `run`, `purpose` y `expected_exit_code`.
- Persistir resultados de comandos en el runtime ledger.
- Los reportes QA deben citar comandos, códigos de salida y archivos reales.
- Los reportes AppSec deben citar archivos, líneas o controles concretos, no prosa genérica.
- La preparación para release debe verificar Docker Compose, Dockerfiles, healthchecks, `.env.example`, despliegue, rollback y startup reproducible.

## Criterios de Aceptación

- `docker compose up --build` inicia base de datos, backend y frontend.
- El healthcheck del backend devuelve healthy solo cuando las dependencias son alcanzables.
- El frontend puede listar y crear rooms, instructors, training groups, schedule blocks y observations a través de la API backend.
- Las reglas de conflicto evitan doble asignación de sala, instructor o grupo de formación.
- Los comandos de pruebas/build son ejecutables desde un checkout limpio.
- Ningún componente se entrega como archivo monolítico.
- Ningún código técnico ni objeto de esquema usa nombres en español.
- El estado final no debe ser `completed` a menos que QA, AppSec y release gates aprueben con evidencia verificable.
