# PRD de Prueba de Fuego - SENA Schedule Manager V6

## Objetivo

Construir un MVP para la gestión de horarios del SENA usando:

- Backend: Go
- Frontend: React
- Base de datos: MongoDB
- Runtime: Docker y Docker Compose

Esta es una prueba de fuego para el ecosistema agéntico. El producto debe ser lo suficientemente funcional como para ejercer todo el runtime del SDLC, pero MVP significa alcance funcional reducido, no una reducción de arquitectura, pruebas, seguridad, nomenclatura ni calidad de lanzamiento.

## Alcance Funcional

El MVP debe soportar:

- Gestión de aulas.
- Gestión de horarios.
- Gestión de grupos de estudiantes.
- Gestión de instructores de planta y contratistas.
- Observaciones vinculadas a los horarios.

## Reglas Técnicas

- Los textos visibles en la UI y la documentación para usuarios pueden estar en español.
- El código fuente, diagramas, contratos API, nombres de contenedores, objetos de base de datos, atributos de base de datos e identificadores técnicos deben estar en inglés.
- Las colecciones y atributos de la base de datos deben estar en inglés, en singular y en `lower_snake_case` cuando aplique.
- El workspace debe separar `database/`, `backend/` y `frontend/` como componentes independientes.
- La base de datos no debe estar embebida dentro del backend.
- Cada componente debe tener su propio límite de contenedor.
- El código de dominio/core no debe contener metadatos de persistencia o transporte como `bson`, `gorm`, `db`, `sql`, JPA, Mongoose, Prisma, TypeORM o imports de controladores de BD.
- Los modelos/documentos/registros de persistencia deben vivir en repository/infrastructure con mapeadores explícitos desde/hacia dominio.
- Ningún archivo fuente puede exceder 300 líneas.
- No debe existir un `main.go`, `App.jsx`, página, repositorio, handler o archivo CSS monolítico.
- El backend debe incluir pruebas reales.
- El frontend debe incluir pruebas reales y metadatos reproducibles de build.
- La evidencia de QA, AppSec y release debe ser real, no solo narrativa.

## Historias de Usuario del MVP

1. Como coordinador, puedo crear y listar aulas para que los horarios se asignen a un entorno físico.
2. Como coordinador, puedo crear y listar grupos de estudiantes para que los horarios se asocien a un grupo de formación.
3. Como coordinador, puedo crear y listar instructores, incluyendo tipo planta y contratista.
4. Como coordinador, puedo crear horarios seleccionando aula, grupo, instructor, día, hora de inicio y hora de fin.
5. Como coordinador, puedo agregar observaciones a un horario para seguimiento.
6. Como coordinador, puedo ver errores de validación cuando faltan campos requeridos o los rangos de tiempo del horario son inválidos.

## Criterios de Aceptación

- La app puede iniciarse localmente con Docker Compose.
- El backend expone endpoints de salud y CRUD para las entidades del MVP.
- El frontend puede listar y crear entidades del MVP mediante un cliente API.
- La inicialización de MongoDB, índices y datos semilla viven en `database/`.
- Las pruebas del backend pueden ejecutarse con el comando declarado del stack.
- Las pruebas/build del frontend pueden ejecutarse con el comando declarado del stack.
- A09 produce evidencia de QA.
- A12 produce evidencia de AppSec.
- A11 produce evidencia de preparación para lanzamiento, despliegue y reversión.

## Fuera de Alcance

- Autenticación y gestión de roles.
- Arrastrar y soltar en calendario.
- Reportería masiva.
- Importación/exportación.
- Despliegue productivo en nube.
