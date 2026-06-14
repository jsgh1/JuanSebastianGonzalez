```yaml
ux_contract:
  accessibility_requirements:
    - Uso de etiquetas ARIA y roles semánticos para todos los elementos interactivos.
    - Contraste mínimo de color de 4.5:1 para texto e imágenes de texto.
    - Soporte completo para navegación por teclado en todos los flujos.
    - Alternativas de texto descriptivas para todas las imágenes y elementos no textuales.
    - Manejo de estados de foco visible para todos los elementos interactivos.
    - Notificaciones claras para estados de éxito/error/carga usando Live Regions (`aria-live`).
  critical_flows:
    - CRU1: Crear/Editar/Eliminar Entorno de Aprendizaje.
    - CRU2: Crear/Editar/Eliminar Horario (vinculando Instructor, Grupo, Entorno).
    - CRU3: Crear/Editar/Eliminar Grupo de Formación.
    - CRU4: Crear/Editar/Eliminar Instructor (diferenciando staff/contratista).
    - CRU5: Registrar Observación Operativa (vinculándola a Horario o Instructor).
    - CRU6: Visualización de Horarios Asignados para Instructor (solo lectura).
  design_tokens_document: |
    ### Tokens Base de Diseño (Ejemplos)

    **Colores:**
    - `color-primary-500`: #007BFF (Azul principal)
    - `color-primary-600`: #0056B3 (Azul oscuro para hover/active)
    - `color-secondary-500`: #6C757D (Gris secundario)
    - `color-success-500`: #28A745 (Verde para éxito)
    - `color-danger-500`: #DC3545 (Rojo para error)
    - `color-warning-500`: #FFC107 (Amarillo para advertencia)
    - `color-info-500`: #17A2B8 (Cian para información)
    - `color-text-dark`: #212529 (Texto oscuro)
    - `color-text-light`: #F8F9FA (Texto claro sobre fondos oscuros)
    - `color-background-light`: #FFFFFF (Fondo principal claro)
    - `color-background-dark`: #F4F6F9 (Fondo secundario claro)
    - `color-border`: #CED4DA (Color de borde)

    **Tipografía:**
    - `font-family-base`: 'Arial', sans-serif
    - `font-size-base`: 16px
    - `font-size-h1`: 32px
    - `font-size-h2`: 24px
    - `font-size-small`: 14px
    - `line-height-base`: 1.5
    - `font-weight-regular`: 400
    - `font-weight-bold`: 700

    **Espaciado:**
    - `space-xs`: 4px
    - `space-sm`: 8px
    - `space-md`: 16px
    - `space-lg`: 24px
    - `space-xl`: 32px

    **Bordes y Sombras:**
    - `border-radius-sm`: 4px
    - `border-radius-md`: 8px
    - `box-shadow-sm`: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075)

    Estos tokens deben estar disponibles mediante variables CSS o un sistema de tematización en React, garantizando consistencia y facilidad de mantenimiento.
  quality_score: 5
  responsive_targets:
    - Desktop (1280px y superior)
    - Tablet (768px - 1279px)
    - Mobile (320px - 767px)
  screens:
    - Nombre: Dashboard (Academic Coordinator)
      Props: Vista general de estadísticas y accesos directos a la gestión de entidades.
    - Nombre: ScheduleList
      Props: Listado paginado de horarios con filtros y acciones CRUD.
    - Nombre: ScheduleForm
      Props: Formulario para crear/editar un horario, incluyendo selectores de instructor, grupo y entorno.
    - Nombre: InstructorList
      Props: Listado paginado de instructores con filtros por tipo y acciones CRUD.
    - Nombre: InstructorForm
      Props: Formulario para crear/editar un instructor, incluyendo tipo de contrato.
    - Nombre: EnvironmentList
      Props: Listado paginado de entornos con filtros y acciones CRUD.
    - Nombre: EnvironmentForm
      Props: Formulario para crear/editar un entorno.
    - Nombre: GroupList
      Props: Listado paginado de grupos con filtros y acciones CRUD.
    - Nombre: GroupForm
      Props: Formulario para crear/editar un grupo.
    - Nombre: ObservationList
      Props: Listado paginado de observaciones con filtros por horario/instructor y acciones CRUD.
    - Nombre: ObservationForm
      Props: Formulario para registrar una observación, con selectores para asociarla a horario o instructor.
    - Nombre: InstructorDashboard (Instructor)
      Props: Vista solo lectura para instructores con horarios asignados y observaciones relacionadas.
    - Nombre: LoginScreen
      Props: Pantalla de autenticación.
    - Nombre: NotFoundScreen
      Props: Pantalla 404.
    - Nombre: UnauthorizedScreen
      Props: Pantalla 403.
  ui_spec_document: |
    ### Especificación General de UI

    **Principios de Diseño:**
    - **Consistencia:** Tipografía, colores, espaciado y elementos de UI deben ser consistentes en toda la aplicación.
    - **Claridad:** La información y las acciones deben ser claras y fáciles de entender.
    - **Eficiencia:** Optimizar los flujos de trabajo del coordinador, minimizando pasos innecesarios.
    - **Retroalimentación:** Proporcionar retroalimentación clara y oportuna para cada acción.

    **Componentes Reutilizables (`shared/components`):**
    - Navegación.
    - Tablas con paginación, ordenamiento, filtrado y acciones por fila.
    - Formularios con inputs, selects, date pickers y validación.
    - Modales/alertas.
    - Indicadores de carga.
    - Estados vacíos.

    **Patrones de Pantalla:**
    - Listados CRUD con título, botón crear, filtros, tabla, paginación y estados de loading/empty/error.
    - Formularios CRUD con título, campos, validación en tiempo real, botones guardar/cancelar y estados loading/error/success.

    **Vistas de solo lectura:**
    - `InstructorDashboard`: presenta horarios asignados y observaciones relacionadas sin acciones de edición.
  ux_flows_document: |
    ### Flujos de Usuario (MVP)

    **1. Autenticación y Acceso Inicial**
    - Inicio en `LoginScreen`.
    - El usuario ingresa credenciales y hace clic en "Iniciar Sesión".
    - Estados: loading, error y success con redirección.

    **2. Gestión de Entidades (CRUD - Coordinador Académico)**
    - Ver lista desde el Dashboard.
    - Crear nuevo registro desde la lista.
    - Editar registro existente.
    - Eliminar mediante modal de confirmación.

    **3. Gestión de Horarios**
    - En `ScheduleForm` se seleccionan Instructor, Training Group y Learning Environment.
    - El sistema debe prevenir solapamientos y mostrar mensajes claros de conflicto.

    **4. Registro de Observaciones Operativas**
    - Desde `ObservationList`, abrir `ObservationForm`.
    - El formulario permite asociar la observación a un horario o instructor.

    **5. Vista de Horarios (Instructor)**
    - Tras iniciar sesión, el Instructor es redirigido a `InstructorDashboard`.
    - Visualiza horarios y observaciones relacionadas en modo solo lectura.
```
