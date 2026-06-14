```yaml
ux_contract:
  ux_flows_document: |
    Flujos principales: Gestión de Salas (listar, crear, editar, deshabilitar con confirmación y advertencia de conflictos futuros). Gestión de Grupos de Formación. Gestión de Instructores (incluyendo tipo permanente/contratista). Gestión de Bloques de Horario (crear con selección de sala, grupo, instructor, fecha/hora; validar fin > inicio y detectar conflictos; mostrar advertencia antes de guardar). Cancelación de bloques como cambio de estado, no eliminación. Agregar Observaciones a bloques existentes con texto, autor, fecha y severidad. Flujos de error: mostrar mensajes amigables en español al enviar formularios inválidos o cuando se detecten conflictos. Estados: carga, vacío, error y éxito.
  ui_spec_document: |
    Pantalla principal (Dashboard) con resumen de próximos bloques y enlaces rápidos. Cada entidad tiene una página de listado con tabla responsive, búsqueda/filtro y botón "Agregar". Los formularios de creación/edición se muestran en modal con validación del cliente. Al crear un Bloque, se muestran selectores de fecha/hora; si hay conflicto, se marca en rojo y se muestra mensaje específico. Las Observaciones aparecen en un panel expandible dentro del detalle del Bloque. Las acciones de deshabilitar/eliminar requieren confirmación. El botón de cancelación de bloque cambia estado a "Cancelado" con fondo gris.
  design_tokens_document: |
    Color primario: #0D6EFD (azul), secundario: #6C757D (gris). Éxito: #198754, advertencia: #FFC107, error: #DC3545, info: #0DCAF0. Fondo claro: #F8F9FA, texto principal: #212529. Tipografía: 'Inter', sans-serif. Espaciado: 4, 8, 12, 16, 24, 32, 48px. Bordes: 4px en inputs, 8px en tarjetas, 16px en modales. Sombras suaves para tarjetas y más elevadas para modales. Breakpoints: sm 576px, md 768px, lg 992px, xl 1200px.
  screens:
    - Dashboard
    - RoomsList
    - RoomDetail
    - RoomForm
    - TrainingGroupsList
    - TrainingGroupDetail
    - TrainingGroupForm
    - InstructorsList
    - InstructorDetail
    - InstructorForm
    - ScheduleBlocksList
    - ScheduleBlockForm
    - ObservationsPanel
  critical_flows:
    - "Crear bloque con detección de conflictos simultánea en sala, grupo e instructor"
    - "Deshabilitar entidad con advertencia de bloques futuros afectados"
    - "Agregar observación crítica a bloque existente"
    - "Cancelar bloque con cambio de estado y notificación"
  accessibility_requirements:
    - "Cumplir WCAG 2.1 AA con contraste mínimo 4.5:1"
    - "Navegación completa por teclado"
    - "Mensajes de error asociados a campos mediante aria-describedby"
    - "Anunciar cambios dinámicos con aria-live polite"
    - "Botones y enlaces con texto descriptivo"
    - "Tamaño táctil mínimo 44x44 px"
  responsive_targets:
    - "Ancho mínimo soportado: 320px"
    - "Tableta: 768px"
    - "Escritorio: >=1024px"
    - "Sidebar colapsable en móvil"
    - "Tablas con scroll horizontal en pantallas pequeñas"
  quality_score: 8
```
