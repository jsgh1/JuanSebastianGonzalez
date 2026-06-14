# Documento de Requisitos del Producto

## Visión
Brindar una experiencia de programación confiable y libre de conflictos para los instructores del SENA.

## Objetivos
- Eliminar los conflictos de horario.
- Reducir el tiempo dedicado a la creación de horarios.

## Alcance
- Gestión de instructores
- Gestión de aulas
- Definición de franjas horarias
- Generación de horarios y validación de conflictos

## Requisitos
- El sistema DEBE evitar la doble asignación de un instructor.
- El sistema DEBE evitar la doble asignación de un aula.
- El sistema DEBE permitir registrar observaciones para una entrada del horario.

## EPC y HU
- **EPC-1**: Gestión de entidades principales
  - **FEA-1.1**: CRUD de instructores
    - HU-001: Como administrador, quiero crear un instructor.
  - **FEA-1.2**: CRUD de aulas
    - HU-002: Como administrador, quiero crear un aula.
- **EPC-2**: Programación
  - **FEA-2.1**: Asignación de horarios
    - HU-003: Como administrador, quiero asignar un instructor a un aula y a una franja horaria.
