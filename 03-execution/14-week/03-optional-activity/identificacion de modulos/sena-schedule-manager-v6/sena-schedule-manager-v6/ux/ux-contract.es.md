```yaml
ux_contract:
  ux_flows_document: |
    # Flujos UX

    El MVP utiliza un dashboard operativo compacto para coordinadores. La
    navegación principal expone secciones de Classroom, Student Group, Instructor, Schedule y
    Observation. Cada sección de catálogo sigue el mismo flujo: cargar lista,
    mostrar estado vacío si no existen registros, abrir un formulario de creación, validar campos requeridos,
    enviar mediante el servicio API, mostrar retroalimentación de éxito y refrescar
    la lista. La creación de schedule es el flujo crítico: el coordinador selecciona
    classroom, student_group, instructor, day, start_time y end_time; la UI
    impide el envío cuando faltan campos requeridos o cuando la hora final no es
    posterior a la inicial. La creación de observation parte de un schedule seleccionado
    y conserva el contexto del horario.

    Los estados de error son explícitos y recuperables: timeout de API, error de validación,
    dependencia de catálogo vacía y error inesperado del servidor. Los estados de carga son
    en línea y no desplazan el layout. Los estados de éxito usan banners compactos
    de confirmación. Los textos visibles pueden estar en español para el usuario, mientras que los nombres de componentes, rutas,
    servicios y pruebas permanecen en inglés.
  ui_spec_document: |
    # Especificación de UI

    La primera pantalla es el workspace real de gestión de horarios, no una landing
    page. Usar un encabezado superior fijo con el nombre del producto, una barra de navegación izquierda en
    escritorio y un menú compacto de pestañas/navegación en móvil. El área principal
    contiene una sola vista de funcionalidad activa a la vez con una tabla/lista densa y un
    formulario de creación adyacente o modal según el ancho del viewport. Las tarjetas se usan
    solo para registros repetidos o superficies modales; las secciones de página quedan sin marco.

    Pantallas requeridas: resumen del dashboard, listado/creación de classroom, student group,
    instructor, schedule y observation. La composición de la app vive en `src/app/App.jsx`; las pantallas
    de features viven bajo `src/features`; el acceso API vive solo en `src/services`; los
    controles reutilizables viven en `src/components`; los hooks reutilizables de estado asíncrono viven en
    `src/hooks`. `App.jsx` no debe llamar `fetch`, `localStorage` ni `sessionStorage`.
  design_tokens_document: |
    # Tokens de Diseño

    Usar una paleta operativa sobria con superficies neutras, texto oscuro legible,
    un color primario de acción, un color de advertencia y un color de peligro. Evitar una
    paleta monocorde púrpura, beige, azul oscuro o marrón. El radio del borde es de 8px o
    menos. La tipografía usa tamaños estables, no texto escalado al viewport. Tablas,
    formularios, botones y banners de estado deben mantener restricciones responsivas fijas para que
    las etiquetas no se superpongan. Los botones primarios usan icono más etiqueta cuando la acción
    se beneficia del reconocimiento; las acciones destructivas requieren un estado de peligro claro.
  screens:
    - dashboard_summary
    - classroom_list_create
    - student_group_list_create
    - instructor_list_create
    - schedule_list_create
    - observation_list_create
  critical_flows:
    - "crear classroom y luego usarlo como dependencia de schedule"
    - "crear student_group y luego usarlo como dependencia de schedule"
    - "crear instructor con tipo staff o contractor"
    - "crear schedule con día y rango horario válidos"
    - "rechazar schedule cuando faltan campos requeridos"
    - "adjuntar observation a un schedule seleccionado"
  accessibility_requirements:
    - "todos los controles del formulario tienen etiquetas y texto de validación"
    - "la navegación por teclado alcanza listas, formularios y acciones de envío"
    - "el estado de foco es visible en los controles interactivos"
    - "los mensajes de estado usan texto y color, no solo color"
    - "el contenido de tabla/lista sigue siendo legible en ancho móvil"
  responsive_targets:
    - "escritorio 1440px"
    - "portátil 1024px"
    - "tableta 768px"
    - "móvil 390px"
  quality_score: 0.9
```
