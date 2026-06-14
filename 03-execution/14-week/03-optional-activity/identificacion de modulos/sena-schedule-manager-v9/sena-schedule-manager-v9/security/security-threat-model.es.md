```yaml
security_threat_model:
  threat_model_document: >
    SENA Schedule Manager sigue Clean Architecture con backend Go, frontend React y MongoDB. El sistema maneja PII bajo la Ley 1581 de Colombia. La amenaza principal es el acceso o modificación no autorizados mediante inyección en la API, autenticación rota o configuración insegura de MongoDB. El frontend está restringido para reducir filtraciones del lado cliente. Las capas del backend aplican inversión estricta de dependencias y las entidades de dominio son structs Go puros. Todos los endpoints HTTP deben validar y sanear entradas. El despliegue Docker debe ejecutarse con contenedores no root y red restringida.
  attack_surfaces:
    - name: Endpoints HTTP API (handlers Go)
      description: Handlers CRUD para rooms, groups, instructors, schedule blocks y observations.
    - name: Acceso directo a MongoDB
      description: La base de datos está expuesta internamente; si se compromete, hay acceso completo a los datos.
    - name: Aplicación React frontend
      description: Código cliente servido al navegador; riesgo XSS si se renderiza entrada no saneada.
    - name: Red Docker Compose
      description: Comunicación entre servicios; si un contenedor es comprometido, puede haber movimiento lateral.
    - name: Almacenamiento de backups/archivos
      description: Dumps diarios y archivo en frío de 5 años; controles débiles podrían filtrar PII.
  stride_threats:
    - threat: Spoofing
      category: Spoofing
      component: HTTP API
      description: "No se especifica mecanismo de autenticación; un atacante podría hacerse pasar por un usuario válido."
    - threat: Tampering
      category: Tampering
      component: API Input Validation
      description: "Entradas no saneadas en consultas de detección de conflictos podrían causar inyección NoSQL y corrupción de datos."
    - threat: Repudiation
      category: Repudiation
      component: Audit Logging
      description: "La falta de logs de auditoría para operaciones CRUD permite negar acciones realizadas."
    - threat: Information Disclosure
      category: Information Disclosure
      component: Instructor/Observation data
      description: "Campos PII almacenados sin cifrado en reposo podrían exponerse en respuestas API si no se filtran."
    - threat: Denial of Service
      category: Denial of Service
      component: Conflict Detection Queries
      description: "Consultas complejas de solapamiento sin rate limiting ni timeout podrían agotar conexiones."
    - threat: Elevation of Privilege
      category: Elevation of Privilege
      component: API Authorization
      description: "Suponer que todos los consumidores API tienen los mismos permisos habilita escalada de privilegios."
  required_controls:
    - control: Autenticar todas las solicitudes API
      owner: backend/http (middleware)
      verification: "Prueba de integración que devuelva 401 para solicitudes no autenticadas."
    - control: Autorizar según rol
      owner: backend/http (middleware)
      verification: "Prueba que un usuario viewer no pueda hacer DELETE o UPDATE."
    - control: Cifrar PII en reposo
      owner: backend/infrastructure
      verification: "Prueba unitaria que valide cifrado antes de persistir y descifrado al leer."
    - control: Validación y sanitización de entradas
      owner: backend/http y backend/application
      verification: "Pruebas con payloads de inyección."
    - control: Rate limiting en endpoints API
      owner: backend/http
      verification: "Prueba de carga que retorne 429 tras superar umbral."
    - control: Logging de auditoría para create/update/delete/cancel/deactivate
      owner: backend/infrastructure y application
      verification: "Prueba que registre timestamp, usuario, acción e ID de entidad."
    - control: TLS para conexiones MongoDB
      owner: backend/infrastructure y database
      verification: "Inspección de configuración y prueba de fallo sin TLS."
    - control: Sanitizar mensajes de error
      owner: backend/http
      verification: "Prueba que un 500 devuelva mensaje genérico."
    - control: Restringir CORS a orígenes confiables
      owner: backend/http
      verification: "Prueba desde origen no permitido."
    - control: Configurar timeouts para handlers HTTP y consultas DB
      owner: backend/http y backend/infrastructure
      verification: "Prueba de deadline excedido."
    - control: Ejecutar contenedores como usuario no root
      owner: DevOps
      verification: "Inspección de Dockerfile con directiva USER."
    - control: Asegurar que domain/core no dependa de metadata de transporte/persistencia
      owner: backend/domain
      verification: "Análisis estático de imports."
  abuse_cases:
    - case: "Un atacante enumera schedule blocks variando start_time para inferir horarios futuros."
    - case: "Un ex empleado solicita eliminación de PII, pero el sistema no tiene flujo de borrado."
    - case: "Un atacante crea un schedule block con end_time anterior a start_time para forzar fallos."
    - case: "Texto de observation sin límites provoca documentos demasiado grandes."
    - case: "Exportación masiva de instructors vía solicitudes GET repetidas sin límites de paginación."
  quality_score: 0.85
```
