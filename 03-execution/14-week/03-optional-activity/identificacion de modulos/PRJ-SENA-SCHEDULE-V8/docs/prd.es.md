# PRD - SENA Schedule Manager v8

## Contexto del Producto

SENA Schedule Manager es un producto interno de programación para las operaciones del centro de formación. El producto debe ayudar a los coordinadores a gestionar entornos de aprendizaje, horarios, grupos de formación, instructores, tipo de contrato de instructor y observaciones operativas. El objetivo de esta prueba de fuego v8 no es solo crear un MVP funcional, sino verificar que el Agentic SDLC OS haga cumplir mecánicamente la arquitectura, la calidad, la seguridad y la preparación para el lanzamiento.

## Stack Requerido

- Backend: Go
- Frontend: React
- Base de datos: MongoDB
- Runtime: Docker y Docker Compose

## Restricción de Salida del Runtime

Cuando un agente deba emitir datos estructurados para el runtime del Agentic SDLC OS, debe preferir JSON estricto sobre YAML. No usar formato de código Markdown dentro de valores escalares estructurados. Todo valor de cadena debe ir entre comillas cuando se use JSON o YAML. Esta restricción existe solo para mantener determinista el parseo del runtime durante la prueba de fuego v8.

## Reglas de Ingeniería No Negociables

- El MVP reduce el alcance funcional, nunca la arquitectura, la seguridad, las pruebas, la observabilidad ni los estándares de lanzamiento.
- El workspace debe dividirse en tres proyectos independientes: `database/`, `backend/` y `frontend/`.
- Cada componente debe tener su propio límite de contenedor y su Dockerfile.
- La inicialización de base de datos, índices, validación, datos semilla o migraciones deben vivir en `database/`, nunca dentro de `backend/`.
- El código técnico, identificadores de base de datos, contratos API, nombres de archivo, pruebas, comentarios, diagramas y contratos de arquitectura deben estar en inglés.
- Las etiquetas visibles al usuario y la documentación del producto pueden estar en español.
- Los nombres y atributos de colecciones en la base de datos deben estar en inglés, en singular y ser consistentes.
- El backend debe respetar la inversión de dependencias y los límites de clean architecture.
- El frontend debe evitar páginas/componentes monolíticos y mantener los clientes API fuera de los componentes.
- La evidencia de QA, AppSec y release debe citar comandos reales, archivos, códigos de salida y artefactos.

## Alcance Funcional

El MVP debe soportar:

- Gestionar entornos de aprendizaje.
- Gestionar horarios.
- Gestionar grupos de formación.
- Gestionar instructores.
- Distinguir entre instructores de planta y contratistas.
- Registrar observaciones operativas vinculadas a horarios o instructores.
- Exponer flujos CRUD básicos necesarios para los coordinadores.

## Roles de Usuario

- Coordinador académico: gestiona horarios, entornos, grupos, instructores y observaciones.
- Instructor: visualiza los horarios asignados y observaciones relacionadas.
- Administrador: valida datos operativos y preparación del sistema.

## Requisitos Funcionales

1. El sistema debe permitir a los coordinadores crear, actualizar, listar y desactivar entornos de aprendizaje.
2. El sistema debe permitir a los coordinadores crear, actualizar, listar y desactivar grupos de formación.
3. El sistema debe permitir a los coordinadores crear, actualizar, listar y desactivar instructores.
4. El sistema debe clasificar a los instructores por tipo de contrato: planta o contratista.
5. El sistema debe permitir a los coordinadores crear y actualizar horarios vinculando entorno, grupo de formación, instructor, día, rango horario y notas.
6. El sistema debe prevenir horarios obviamente inválidos, como instructor faltante, entorno faltante o rango horario inválido.
7. El sistema debe permitir registrar observaciones y asociarlas a un horario, instructor o contexto operativo.
8. El frontend debe proporcionar flujos utilizables para las entidades base sin depender de comportamiento solo con mocks.
9. El backend debe exponer APIs HTTP con validación, normalización de errores y abstracciones de repositorio.
10. El proyecto de base de datos debe definir colecciones MongoDB, índices, reglas de validación y datos semilla independientemente del arranque del backend.

## Requisitos No Funcionales

- El build debe ser reproducible desde un checkout limpio.
- Las pruebas del backend deben ejecutarse mediante un comando documentado.
- Las pruebas del frontend y el build de producción deben ejecutarse mediante comandos documentados.
- Docker Compose debe iniciar base de datos, backend y frontend como servicios separados.
- Los servicios deben incluir healthchecks o verificaciones equivalentes de readiness.
- El servidor HTTP del backend debe usar timeouts.
- Los clientes API deben usar timeouts.
- CORS no debe estar abierto por defecto.
- Las respuestas de error no deben filtrar errores internos sin procesar.
- La evidencia AppSec debe referenciar controles y archivos concretos.
- La preparación para release debe incluir comandos de despliegue y rollback.

## Criterios de Aceptación

- El workspace generado contiene `database/`, `backend/` y `frontend/`.
- `database/` contiene artefactos de inicialización de MongoDB, índices, validación y datos semilla usando nombres singulares en inglés.
- `backend/` contiene código Go organizado por dominio, aplicación/casos de uso, transporte HTTP, interfaces/implementaciones de repositorio y configuración.
- `frontend/` contiene código React organizado por composición de app, features, components, services, hooks y pruebas.
- Ningún archivo fuente que implemente lógica de aplicación supera 300 líneas.
- `main.go` contiene solo bootstrap y wiring.
- `App.jsx` o el entrypoint equivalente contiene solo composición/routing.
- Existen pruebas y los comandos están registrados con códigos de salida.
- Las puertas de QA, AppSec y release no pueden aprobar con evidencia solo narrativa.
- El estado final solo puede marcarse como completado después de pasar la preparación para release.
