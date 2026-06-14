```yaml
security_threat_model:
  abuse_cases:
  - description: Un usuario no autorizado intenta crear, actualizar o eliminar horarios, instructores, entornos o grupos de formación.
    mitigation_strategy: "Implementar autenticación y autorización en el API Gateway. La capa `transport` del backend debe aplicar control de acceso basado en roles (RBAC) en todos los endpoints según los `user_roles` definidos en el PRD."
    name: Manipulación No Autorizada de Datos
  - description: Un instructor intenta ver horarios u observaciones no asignados a él, o modificar sus propios horarios.
    mitigation_strategy: "Implementar control de acceso granular basado en atributos (ABAC) o por recurso. La capa `application/usecase` debe verificar que el `instructor_id` autenticado coincida con el `instructor_id` del horario u observación solicitados."
    name: Escalada de Privilegios / Violación de Acceso a Datos (Instructor)
  - description: Un usuario malicioso inyecta scripts o comandos SQL/NoSQL en campos de entrada.
    mitigation_strategy: "Implementar validación y sanitización robusta en la capa `infrastructure/transport` y dentro de `domain/entity`. Usar consultas parametrizadas y validación JSON Schema en MongoDB."
    name: Ataque de Inyección
  - description: Un atacante crea solicitudes para explotar vulnerabilidades en la creación de entornos u horarios, causando agotamiento de recursos o DoS.
    mitigation_strategy: "Implementar rate limiting en endpoints API, especialmente de creación/actualización. Aplicar validación estricta a entradas numéricas y rangos de fechas. Implementar timeouts HTTP y de consultas a base de datos."
    name: Agotamiento de Recursos / DoS
  - description: Acceso a campos PII (`instructor.name`, `instructor.email`, `observation.observed_by`) por usuarios no autorizados o canales inseguros.
    mitigation_strategy: "Aplicar controles estrictos de acceso sobre campos PII mediante RBAC/ABAC. Cifrar PII en reposo en MongoDB. Enmascarar PII en logs. Usar comunicación segura (HTTPS)."
    name: Exposición de PII
  attack_surfaces:
  - description: Aplicación frontend ejecutándose en el navegador del usuario e interactuando con la API backend.
    name: Frontend (React UI)
  - description: Endpoints de la API backend (`infrastructure/transport`) expuestos al frontend y posiblemente a otros servicios internos.
    name: Backend API Gateway / Capa de Transporte
  - description: Base de datos MongoDB, incluidas colecciones y sistema de archivos subyacente. Accesible solo por el backend.
    name: Base de Datos (MongoDB)
  - description: Daemon de Docker y orquestación de contenedores (Docker Compose).
    name: Runtime / Orquestación de Contenedores
  quality_score: 95
  required_controls:
  - control: Asegurar que todos los datos de entrada se validen y saneen en el límite de la API y dentro de la capa de dominio.
    owner: Backend Team
    verification: "Implementar validación de DTOs en `infrastructure/transport`. Las entidades de dominio deben tener métodos de validación. Aplicar validación JSON Schema en MongoDB. Pruebas unitarias e integración para escenarios de validación."
  - control: Implementar autenticación para todos los endpoints de la API.
    owner: Backend Team
    verification: "Todos los handlers de `infrastructure/transport` deben requerir un token de autenticación. Pruebas automatizadas para acceso no autorizado (`401 Unauthorized`)."
  - control: Implementar control de acceso basado en roles (RBAC) para todas las operaciones sensibles.
    owner: Backend Team
    verification: "La lógica de autorización debe verificar roles en `application/usecase` y `infrastructure/transport`. Pruebas automatizadas para accesos prohibidos (`403 Forbidden`)."
  - control: Cifrar los datos PII en reposo en MongoDB.
    owner: Database Team / Backend Team
    verification: "Field-level encryption para `instructor.name` e `instructor.email`. Las claves de cifrado deben gestionarse de forma segura."
  - control: Enmascarar PII en todos los logs de la aplicación.
    owner: Backend Team
    verification: "El middleware de logging debe detectar y enmascarar `instructor.name` e `instructor.email` antes de registrar."
  - control: Usar HTTPS para toda la comunicación entre frontend y backend.
    owner: Infrastructure Team
    verification: "La configuración de despliegue debe forzar HTTPS. Verificar validez del certificado."
  - control: Implementar encabezados HTTP seguros (por ejemplo, HSTS, CSP, X-Frame-Options).
    owner: Backend Team
    verification: "Las respuestas de `infrastructure/transport` deben incluir encabezados de seguridad. Validar con escáner automatizado."
  - control: Aplicar políticas estrictas de CORS.
    owner: Backend Team
    verification: "CORS debe restringirse a orígenes conocidos del frontend. Probar solicitudes cross-origin desde dominios no autorizados."
  - control: Implementar rate limiting en endpoints API para prevenir abuso.
    owner: Backend Team
    verification: "Middleware en `infrastructure/transport` para limitar solicitudes por IP/usuario. Pruebas de carga."
  - control: Asegurar que las conexiones a base de datos usen mínimos privilegios y autenticación fuerte.
    owner: Database Team / Backend Team
    verification: "El usuario de MongoDB debe tener solo los permisos necesarios. La cadena de conexión no debe exponerse."
  - control: El backend debe ejecutarse en un contenedor sin privilegios root.
    owner: DevOps Team
    verification: "El Dockerfile del backend debe especificar un usuario no root. Validar con `docker inspect`."
  - control: El frontend debe evitar almacenamiento inseguro del lado cliente para datos sensibles.
    owner: Frontend Team
    verification: "No usar `localStorage` ni `sessionStorage` para PII o tokens."
  - control: Implementar timeouts para todas las llamadas externas (HTTP, DB).
    owner: Backend Team
    verification: "El `http.Client` de Go y el cliente MongoDB deben tener timeouts configurados."
  - control: Asegurar que los mensajes de error expuestos a clientes sean genéricos y no filtren información sensible.
    owner: Backend Team
    verification: "El manejo de errores debe devolver mensajes genéricos. Validar mediante pruebas."
  - control: Restringir que la lógica core del dominio conozca detalles de persistencia o transporte.
    owner: Backend Team
    verification: "Revisión de código y análisis estático para impedir imports no permitidos."
  - control: Implementar logging y monitoreo para eventos de seguridad y anomalías.
    owner: DevOps Team / Backend Team
    verification: "Logging centralizado y alertas por fallos de autenticación, autorización o tráfico inusual."
  stride_threats:
  - description: Un atacante podría hacerse pasar por un Coordinador Académico para realizar acciones no autorizadas.
    name: Suplantación de Identidad (S)
    mitigation_guidance: "Autenticación fuerte y verificación de identidad. Implementar JWTs y validar firma y expiración en cada solicitud."
  - description: Un atacante podría alterar horas programadas, asignaciones de instructores o descripciones de observaciones.
    name: Manipulación de Datos (T)
    mitigation_guidance: "Validación y sanitización de entradas. Controles robustos de autorización. Validación JSON Schema en MongoDB."
  - description: Usuarios no autorizados podrían acceder a PII o a observaciones sensibles.
    name: Divulgación de Información (I)
    mitigation_guidance: "Cifrado en reposo y en tránsito. Control estricto de acceso. Enmascaramiento de PII en logs."
  - description: Un atacante podría modificar código o configuración, o inyectar código malicioso.
    name: Repudio (R)
    mitigation_guidance: "Logging completo de acciones críticas con ID de usuario, timestamp y detalles de acción."
  - description: Un atacante podría dejar el servicio no disponible saturándolo con solicitudes.
    name: Denegación de Servicio (D)
    mitigation_guidance: "Rate limiting, validación de entradas, timeouts y límites de recursos en contenedores."
  - description: Un atacante podría elevar privilegios, por ejemplo, haciendo que una cuenta de Instructor obtenga acceso de Coordinador.
    name: Elevación de Privilegios (E)
    mitigation_guidance: "Control de acceso granular (RBAC/ABAC) aplicado estrictamente en `application/usecase`."
  threat_model_document: "El sistema SENA Schedule Manager v8, construido con Clean Architecture en Go (backend), React (frontend) y MongoDB (base de datos), requiere un modelo de seguridad robusto. Las principales superficies de ataque incluyen el frontend, la API backend, la base de datos y el runtime de contenedores. Las amenazas STRIDE se evalúan para garantizar confidencialidad, integridad y disponibilidad. Los controles se centran en autenticación, autorización granular, validación de entradas, cifrado de PII, enmascaramiento en logs, CORS estricto, rate limiting, gestión de secretos, ejecución sin privilegios y auditoría."
```
