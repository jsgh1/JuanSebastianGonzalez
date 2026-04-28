# Diccionario de datos

## roles

Catálogo de roles del sistema.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| name | VARCHAR(50) | NO |  |  |  | Nombre del registro. |
| description | VARCHAR(255) | YES |  |  |  | Descripción del registro. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |
| created_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Fecha y hora de creación. |
| updated_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de última actualización. |

## permissions

Catálogo de permisos por módulo, acción y recurso.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| name | VARCHAR(100) | NO |  |  |  | Nombre del registro. |
| code | VARCHAR(80) | NO |  |  |  | Catálogo de permisos por módulo, acción y recurso. |
| description | VARCHAR(255) | YES |  |  |  | Descripción del registro. |
| module_name | VARCHAR(80) | NO |  |  |  | Catálogo de permisos por módulo, acción y recurso. |
| action_name | VARCHAR(80) | NO |  |  |  | Catálogo de permisos por módulo, acción y recurso. |
| resource_name | VARCHAR(100) | YES |  |  |  | Catálogo de permisos por módulo, acción y recurso. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |
| created_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Fecha y hora de creación. |
| updated_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de última actualización. |

## role_permissions

Tabla puente que asigna permisos a roles.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| role_id | BIGINT UNSIGNED | NO |  | roles(id) |  | Referencia a roles(id). |
| permission_id | BIGINT UNSIGNED | NO |  | permissions(id) |  | Referencia a permissions(id). |
| assigned_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Marca de tiempo asociada al evento. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |

## users

Usuarios del sistema, abogados y administradores.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| role_id | BIGINT UNSIGNED | NO |  | roles(id) |  | Referencia a roles(id). |
| full_name | VARCHAR(120) | NO |  |  |  | Usuarios del sistema, abogados y administradores. |
| email | VARCHAR(150) | NO |  |  |  | Correo electrónico. |
| password_hash | VARCHAR(255) | NO |  |  |  | Usuarios del sistema, abogados y administradores. |
| document_number | VARCHAR(30) | YES |  |  |  | Información relacionada con documento o identificación. |
| phone | VARCHAR(20) | YES |  |  |  | Número de teléfono. |
| address | TEXT | YES |  |  |  | Usuarios del sistema, abogados y administradores. |
| specialties_json | JSON | YES |  |  |  | Datos estructurados en formato JSON. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |
| email_verified_at | TIMESTAMP | YES |  |  |  | Marca de tiempo asociada al evento. |
| last_login_at | TIMESTAMP | YES |  |  |  | Marca de tiempo asociada al evento. |
| created_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Fecha y hora de creación. |
| updated_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de última actualización. |

## user_sessions

Sesiones/tokens de usuarios.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| user_id | BIGINT UNSIGNED | NO |  | users(id) |  | Referencia a users(id). |
| token_hash | VARCHAR(255) | NO |  |  |  | Sesiones/tokens de usuarios. |
| ip_address | VARCHAR(45) | YES |  |  |  | Sesiones/tokens de usuarios. |
| user_agent | TEXT | YES |  |  |  | Sesiones/tokens de usuarios. |
| created_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Fecha y hora de creación. |
| expires_at | TIMESTAMP | YES |  |  |  | Marca de tiempo asociada al evento. |
| last_used_at | TIMESTAMP | YES |  |  |  | Marca de tiempo asociada al evento. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |

## client_types

Tipos de cliente.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| name | VARCHAR(60) | NO |  |  |  | Nombre del registro. |
| description | VARCHAR(255) | YES |  |  |  | Descripción del registro. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |

## client_statuses

Estados del cliente.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| name | VARCHAR(60) | NO |  |  |  | Nombre del registro. |
| description | VARCHAR(255) | YES |  |  |  | Descripción del registro. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |

## clients

Información principal de clientes.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| responsible_user_id | BIGINT UNSIGNED | NO |  | users(id) |  | Referencia a users(id). |
| client_type_id | BIGINT UNSIGNED | NO |  | client_types(id) |  | Referencia a client_types(id). |
| status_id | BIGINT UNSIGNED | NO |  | client_statuses(id) |  | Referencia a client_statuses(id). |
| full_name | VARCHAR(150) | NO |  |  |  | Información principal de clientes. |
| document_type | VARCHAR(20) | NO |  |  |  | Información relacionada con documento o identificación. |
| document_number | VARCHAR(30) | NO |  |  |  | Información relacionada con documento o identificación. |
| email | VARCHAR(150) | YES |  |  |  | Correo electrónico. |
| phone | VARCHAR(20) | YES |  |  |  | Número de teléfono. |
| address | TEXT | YES |  |  |  | Información principal de clientes. |
| birth_date | DATE | YES |  |  |  | Fecha asociada al evento o registro. |
| profession | VARCHAR(100) | YES |  |  |  | Información principal de clientes. |
| notes | TEXT | YES |  |  |  | Notas adicionales. |
| created_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Fecha y hora de creación. |
| updated_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de última actualización. |

## client_document_types

Tipos de documentos de cliente.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| name | VARCHAR(100) | NO |  |  |  | Nombre del registro. |
| description | VARCHAR(255) | YES |  |  |  | Descripción del registro. |
| category | VARCHAR(50) | YES |  |  |  | Tipos de documentos de cliente. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |

## client_documents

Documentos asociados a clientes.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| client_id | BIGINT UNSIGNED | NO |  | clients(id) |  | Referencia a clients(id). |
| document_type_id | BIGINT UNSIGNED | NO |  | client_document_types(id) |  | Referencia a client_document_types(id). |
| uploaded_by_user_id | BIGINT UNSIGNED | NO |  | users(id) |  | Referencia a users(id). |
| file_name | VARCHAR(255) | NO |  |  |  | Documentos asociados a clientes. |
| original_name | VARCHAR(255) | NO |  |  |  | Documentos asociados a clientes. |
| storage_path | VARCHAR(500) | NO |  |  |  | Documentos asociados a clientes. |
| file_extension | VARCHAR(10) | NO |  |  |  | Documentos asociados a clientes. |
| file_size | BIGINT UNSIGNED | NO |  |  |  | Documentos asociados a clientes. |
| file_hash | VARCHAR(64) | YES |  |  |  | Documentos asociados a clientes. |
| version_number | INT UNSIGNED | NO |  |  | 1 | Documentos asociados a clientes. |
| description | TEXT | YES |  |  |  | Descripción del registro. |
| is_confidential | TINYINT(1) | NO |  |  | 0 | Documentos asociados a clientes. |
| expiration_date | DATE | YES |  |  |  | Fecha asociada al evento o registro. |
| uploaded_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Marca de tiempo asociada al evento. |
| created_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Fecha y hora de creación. |
| updated_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de última actualización. |

## law_areas

Áreas del derecho.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| name | VARCHAR(100) | NO |  |  |  | Nombre del registro. |
| description | VARCHAR(255) | YES |  |  |  | Descripción del registro. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |

## case_statuses

Estados de los casos.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| name | VARCHAR(60) | NO |  |  |  | Nombre del registro. |
| description | VARCHAR(255) | YES |  |  |  | Descripción del registro. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |

## case_priorities

Prioridades de los casos.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| name | VARCHAR(60) | NO |  |  |  | Nombre del registro. |
| level_number | INT | NO |  |  |  | Prioridades de los casos. |
| color_hex | VARCHAR(7) | YES |  |  |  | Prioridades de los casos. |
| description | VARCHAR(255) | YES |  |  |  | Descripción del registro. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |

## cases

Expedientes o casos jurídicos.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| responsible_user_id | BIGINT UNSIGNED | NO |  | users(id) |  | Referencia a users(id). |
| area_id | BIGINT UNSIGNED | NO |  | law_areas(id) |  | Referencia a law_areas(id). |
| status_id | BIGINT UNSIGNED | NO |  | case_statuses(id) |  | Referencia a case_statuses(id). |
| priority_id | BIGINT UNSIGNED | NO |  | case_priorities(id) |  | Referencia a case_priorities(id). |
| title | VARCHAR(200) | NO |  |  |  | Expedientes o casos jurídicos. |
| description | TEXT | YES |  |  |  | Descripción del registro. |
| process_number | VARCHAR(80) | YES |  |  |  | Expedientes o casos jurídicos. |
| court_name | VARCHAR(150) | YES |  |  |  | Expedientes o casos jurídicos. |
| amount | DECIMAL(15,2) | YES |  |  |  | Expedientes o casos jurídicos. |
| start_date | DATE | NO |  |  |  | Fecha asociada al evento o registro. |
| estimated_close_date | DATE | YES |  |  |  | Fecha asociada al evento o registro. |
| close_date | DATE | YES |  |  |  | Fecha asociada al evento o registro. |
| notes | TEXT | YES |  |  |  | Notas adicionales. |
| created_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Fecha y hora de creación. |
| updated_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de última actualización. |

## case_clients

Relación muchos a muchos entre casos y clientes.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| case_id | BIGINT UNSIGNED | NO |  | cases(id) |  | Referencia a cases(id). |
| client_id | BIGINT UNSIGNED | NO |  | clients(id) |  | Referencia a clients(id). |
| is_primary_client | TINYINT(1) | NO |  |  | 0 | Relación muchos a muchos entre casos y clientes. |
| assigned_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Marca de tiempo asociada al evento. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |

## case_role_types

Tipos de rol de usuario dentro de un caso.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| name | VARCHAR(60) | NO |  |  |  | Nombre del registro. |
| description | VARCHAR(255) | YES |  |  |  | Descripción del registro. |
| permissions_json | JSON | YES |  |  |  | Datos estructurados en formato JSON. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |

## case_users

Usuarios asignados a casos.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| case_id | BIGINT UNSIGNED | NO |  | cases(id) |  | Referencia a cases(id). |
| user_id | BIGINT UNSIGNED | NO |  | users(id) |  | Referencia a users(id). |
| case_role_type_id | BIGINT UNSIGNED | NO |  | case_role_types(id) |  | Referencia a case_role_types(id). |
| assigned_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Marca de tiempo asociada al evento. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |

## case_document_types

Tipos de documentos del caso.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| name | VARCHAR(100) | NO |  |  |  | Nombre del registro. |
| description | VARCHAR(255) | YES |  |  |  | Descripción del registro. |
| category | VARCHAR(50) | YES |  |  |  | Tipos de documentos del caso. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |

## case_documents

Documentos asociados a casos.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| case_id | BIGINT UNSIGNED | NO |  | cases(id) |  | Referencia a cases(id). |
| document_type_id | BIGINT UNSIGNED | NO |  | case_document_types(id) |  | Referencia a case_document_types(id). |
| uploaded_by_user_id | BIGINT UNSIGNED | NO |  | users(id) |  | Referencia a users(id). |
| file_name | VARCHAR(255) | NO |  |  |  | Documentos asociados a casos. |
| original_name | VARCHAR(255) | NO |  |  |  | Documentos asociados a casos. |
| storage_path | VARCHAR(500) | NO |  |  |  | Documentos asociados a casos. |
| file_extension | VARCHAR(10) | NO |  |  |  | Documentos asociados a casos. |
| file_size | BIGINT UNSIGNED | NO |  |  |  | Documentos asociados a casos. |
| file_hash | VARCHAR(64) | YES |  |  |  | Documentos asociados a casos. |
| version_number | INT UNSIGNED | NO |  |  | 1 | Documentos asociados a casos. |
| description | TEXT | YES |  |  |  | Descripción del registro. |
| is_confidential | TINYINT(1) | NO |  |  | 0 | Documentos asociados a casos. |
| expiration_date | DATE | YES |  |  |  | Fecha asociada al evento o registro. |
| uploaded_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Marca de tiempo asociada al evento. |
| created_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Fecha y hora de creación. |
| updated_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de última actualización. |

## hearing_types

Tipos de audiencias.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| name | VARCHAR(100) | NO |  |  |  | Nombre del registro. |
| description | VARCHAR(255) | YES |  |  |  | Descripción del registro. |
| estimated_duration_minutes | INT | YES |  |  |  | Tipos de audiencias. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |

## hearing_statuses

Estados de audiencias.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| name | VARCHAR(60) | NO |  |  |  | Nombre del registro. |
| description | VARCHAR(255) | YES |  |  |  | Descripción del registro. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |

## hearings

Audiencias programadas o realizadas en casos.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| case_id | BIGINT UNSIGNED | NO |  | cases(id) |  | Referencia a cases(id). |
| hearing_type_id | BIGINT UNSIGNED | NO |  | hearing_types(id) |  | Referencia a hearing_types(id). |
| status_id | BIGINT UNSIGNED | NO |  | hearing_statuses(id) |  | Referencia a hearing_statuses(id). |
| title | VARCHAR(200) | NO |  |  |  | Audiencias programadas o realizadas en casos. |
| description | TEXT | YES |  |  |  | Descripción del registro. |
| hearing_datetime | DATETIME | NO |  |  |  | Audiencias programadas o realizadas en casos. |
| estimated_duration_minutes | INT | YES |  |  |  | Audiencias programadas o realizadas en casos. |
| place | VARCHAR(200) | YES |  |  |  | Audiencias programadas o realizadas en casos. |
| result_text | TEXT | YES |  |  |  | Audiencias programadas o realizadas en casos. |
| notes | TEXT | YES |  |  |  | Notas adicionales. |
| created_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Fecha y hora de creación. |
| updated_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de última actualización. |

## activity_types

Tipos de actividades del caso.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| name | VARCHAR(100) | NO |  |  |  | Nombre del registro. |
| description | VARCHAR(255) | YES |  |  |  | Descripción del registro. |
| is_billable_default | TINYINT(1) | NO |  |  | 0 | Tipos de actividades del caso. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |

## case_activities

Actividades realizadas por usuarios sobre casos.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| case_id | BIGINT UNSIGNED | NO |  | cases(id) |  | Referencia a cases(id). |
| activity_type_id | BIGINT UNSIGNED | NO |  | activity_types(id) |  | Referencia a activity_types(id). |
| user_id | BIGINT UNSIGNED | NO |  | users(id) |  | Referencia a users(id). |
| title | VARCHAR(200) | NO |  |  |  | Actividades realizadas por usuarios sobre casos. |
| description | TEXT | YES |  |  |  | Descripción del registro. |
| activity_datetime | DATETIME | NO |  |  |  | Actividades realizadas por usuarios sobre casos. |
| duration_hours | DECIMAL(5,2) | NO |  |  |  | Actividades realizadas por usuarios sobre casos. |
| is_billable | TINYINT(1) | NO |  |  | 0 | Actividades realizadas por usuarios sobre casos. |
| hourly_rate | DECIMAL(10,2) | YES |  |  |  | Actividades realizadas por usuarios sobre casos. |
| notes | TEXT | YES |  |  |  | Notas adicionales. |
| attachments_json | JSON | YES |  |  |  | Datos estructurados en formato JSON. |
| created_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Fecha y hora de creación. |
| updated_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de última actualización. |

## procedural_term_types

Tipos de términos/plazos procesales.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| name | VARCHAR(100) | NO |  |  |  | Nombre del registro. |
| description | VARCHAR(255) | YES |  |  |  | Descripción del registro. |
| default_days | INT | YES |  |  |  | Tipos de términos/plazos procesales. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |

## procedural_terms

Términos procesales asociados a casos.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| case_id | BIGINT UNSIGNED | NO |  | cases(id) |  | Referencia a cases(id). |
| term_type_id | BIGINT UNSIGNED | NO |  | procedural_term_types(id) |  | Referencia a procedural_term_types(id). |
| description | VARCHAR(300) | NO |  |  |  | Descripción del registro. |
| start_date | DATE | NO |  |  |  | Fecha asociada al evento o registro. |
| due_date | DATE | NO |  |  |  | Fecha asociada al evento o registro. |
| business_days | INT | YES |  |  |  | Términos procesales asociados a casos. |
| status_name | VARCHAR(60) | NO |  |  |  | Estado asociado al registro. |
| is_notified | TINYINT(1) | NO |  |  | 0 | Términos procesales asociados a casos. |
| notes | TEXT | YES |  |  |  | Notas adicionales. |
| completion_date | DATE | YES |  |  |  | Fecha asociada al evento o registro. |
| created_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Fecha y hora de creación. |
| updated_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de última actualización. |

## procedural_action_types

Tipos de actuaciones procesales.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| name | VARCHAR(100) | NO |  |  |  | Nombre del registro. |
| description | VARCHAR(255) | YES |  |  |  | Descripción del registro. |
| category | VARCHAR(60) | YES |  |  |  | Tipos de actuaciones procesales. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |

## procedural_actions

Actuaciones procesales registradas en casos.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| case_id | BIGINT UNSIGNED | NO |  | cases(id) |  | Referencia a cases(id). |
| action_type_id | BIGINT UNSIGNED | NO |  | procedural_action_types(id) |  | Referencia a procedural_action_types(id). |
| registered_by_user_id | BIGINT UNSIGNED | NO |  | users(id) |  | Referencia a users(id). |
| action_date | DATE | NO |  |  |  | Fecha asociada al evento o registro. |
| description | TEXT | NO |  |  |  | Descripción del registro. |
| court_name | VARCHAR(150) | YES |  |  |  | Actuaciones procesales registradas en casos. |
| filing_number | VARCHAR(80) | YES |  |  |  | Actuaciones procesales registradas en casos. |
| source_name | VARCHAR(60) | YES |  |  |  | Actuaciones procesales registradas en casos. |
| support_document_path | VARCHAR(500) | YES |  |  |  | Información relacionada con documento o identificación. |
| created_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Fecha y hora de creación. |
| updated_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de última actualización. |

## participant_types

Tipos de participantes externos del caso.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| name | VARCHAR(60) | NO |  |  |  | Nombre del registro. |
| description | VARCHAR(255) | YES |  |  |  | Descripción del registro. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |

## case_participants

Participantes externos relacionados con casos.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| case_id | BIGINT UNSIGNED | NO |  | cases(id) |  | Referencia a cases(id). |
| participant_type_id | BIGINT UNSIGNED | NO |  | participant_types(id) |  | Referencia a participant_types(id). |
| full_name | VARCHAR(200) | NO |  |  |  | Participantes externos relacionados con casos. |
| document_number | VARCHAR(30) | YES |  |  |  | Información relacionada con documento o identificación. |
| phone | VARCHAR(20) | YES |  |  |  | Número de teléfono. |
| email | VARCHAR(150) | YES |  |  |  | Correo electrónico. |
| address | TEXT | YES |  |  |  | Participantes externos relacionados con casos. |
| legal_representative | VARCHAR(200) | YES |  |  |  | Participantes externos relacionados con casos. |
| notes | TEXT | YES |  |  |  | Notas adicionales. |
| created_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Fecha y hora de creación. |
| updated_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de última actualización. |

## legal_reference_types

Tipos de referencias normativas.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| name | VARCHAR(100) | NO |  |  |  | Nombre del registro. |
| description | VARCHAR(255) | YES |  |  |  | Descripción del registro. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |

## legal_reference_statuses

Estados de referencias legales.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| name | VARCHAR(60) | NO |  |  |  | Nombre del registro. |
| description | VARCHAR(255) | YES |  |  |  | Descripción del registro. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |

## legal_references

Normas, leyes o fuentes jurídicas referenciadas.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| reference_type_id | BIGINT UNSIGNED | NO |  | legal_reference_types(id) |  | Referencia a legal_reference_types(id). |
| status_id | BIGINT UNSIGNED | NO |  | legal_reference_statuses(id) |  | Referencia a legal_reference_statuses(id). |
| rule_number | VARCHAR(50) | NO |  |  |  | Normas, leyes o fuentes jurídicas referenciadas. |
| year_number | INT | YES |  |  |  | Normas, leyes o fuentes jurídicas referenciadas. |
| title | VARCHAR(300) | NO |  |  |  | Normas, leyes o fuentes jurídicas referenciadas. |
| description | TEXT | YES |  |  |  | Descripción del registro. |
| official_url | VARCHAR(500) | YES |  |  |  | Normas, leyes o fuentes jurídicas referenciadas. |
| publication_date | DATE | YES |  |  |  | Fecha asociada al evento o registro. |
| effective_date | DATE | YES |  |  |  | Fecha asociada al evento o registro. |
| repeal_date | DATE | YES |  |  |  | Fecha asociada al evento o registro. |
| issuing_entity | VARCHAR(200) | YES |  |  |  | Normas, leyes o fuentes jurídicas referenciadas. |
| verification_hash | VARCHAR(64) | YES |  |  |  | Normas, leyes o fuentes jurídicas referenciadas. |
| last_verified_at | TIMESTAMP | YES |  |  |  | Marca de tiempo asociada al evento. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |
| created_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Fecha y hora de creación. |
| updated_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de última actualización. |

## legal_constant_categories

Categorías de constantes legales.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| name | VARCHAR(100) | NO |  |  |  | Nombre del registro. |
| description | VARCHAR(255) | YES |  |  |  | Descripción del registro. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |

## legal_constants

Valores legales parametrizados vigentes por fecha.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| legal_reference_id | BIGINT UNSIGNED | NO |  | legal_references(id) |  | Referencia a legal_references(id). |
| category_id | BIGINT UNSIGNED | NO |  | legal_constant_categories(id) |  | Referencia a legal_constant_categories(id). |
| name | VARCHAR(200) | NO |  |  |  | Nombre del registro. |
| description | TEXT | YES |  |  |  | Descripción del registro. |
| numeric_value | DECIMAL(20,6) | YES |  |  |  | Valores legales parametrizados vigentes por fecha. |
| text_value | VARCHAR(500) | YES |  |  |  | Valores legales parametrizados vigentes por fecha. |
| unit_of_measure | VARCHAR(50) | YES |  |  |  | Valores legales parametrizados vigentes por fecha. |
| article_reference | VARCHAR(100) | YES |  |  |  | Valores legales parametrizados vigentes por fecha. |
| paragraph_reference | VARCHAR(100) | YES |  |  |  | Valores legales parametrizados vigentes por fecha. |
| literal_reference | VARCHAR(100) | YES |  |  |  | Valores legales parametrizados vigentes por fecha. |
| effective_from | DATE | NO |  |  |  | Valores legales parametrizados vigentes por fecha. |
| effective_until | DATE | YES |  |  |  | Valores legales parametrizados vigentes por fecha. |
| notes | TEXT | YES |  |  |  | Notas adicionales. |
| is_active | TINYINT(1) | NO |  |  | 1 | Indica si el registro está activo. |
| created_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Fecha y hora de creación. |
| updated_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de última actualización. |

## calculations

Cálculos jurídicos/laborales realizados por caso.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| case_id | BIGINT UNSIGNED | NO |  | cases(id) |  | Referencia a cases(id). |
| calculated_by_user_id | BIGINT UNSIGNED | NO |  | users(id) |  | Referencia a users(id). |
| validated_by_user_id | BIGINT UNSIGNED | YES |  | users(id) |  | Referencia a users(id). |
| calculation_type_code | VARCHAR(50) | NO |  |  | 'LABORAL' | Tipo o clasificación asociada. |
| parameters_json | JSON | NO |  |  |  | Datos estructurados en formato JSON. |
| result_json | JSON | NO |  |  |  | Datos estructurados en formato JSON. |
| total_value | DECIMAL(15,2) | NO |  |  |  | Cálculos jurídicos/laborales realizados por caso. |
| legal_version | VARCHAR(50) | YES |  |  |  | Cálculos jurídicos/laborales realizados por caso. |
| notes | TEXT | YES |  |  |  | Notas adicionales. |
| legal_basis_text | TEXT | YES |  |  |  | Cálculos jurídicos/laborales realizados por caso. |
| base_article | VARCHAR(200) | YES |  |  |  | Cálculos jurídicos/laborales realizados por caso. |
| is_validated | TINYINT(1) | NO |  |  | 0 | Cálculos jurídicos/laborales realizados por caso. |
| validated_at | TIMESTAMP | YES |  |  |  | Marca de tiempo asociada al evento. |
| calculated_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Marca de tiempo asociada al evento. |
| created_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Fecha y hora de creación. |
| updated_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Fecha y hora de última actualización. |

## calculation_legal_constants

Constantes legales usadas en cada cálculo.

| Campo | Tipo | Nulo | PK | FK | Default | Descripción |
|---|---|---|---|---|---|---|
| id | BIGINT UNSIGNED | NO | SI |  |  | Identificador único del registro. |
| calculation_id | BIGINT UNSIGNED | NO |  | calculations(id) |  | Referencia a calculations(id). |
| legal_constant_id | BIGINT UNSIGNED | NO |  | legal_constants(id) |  | Referencia a legal_constants(id). |
| used_value | DECIMAL(20,6) | NO |  |  |  | Constantes legales usadas en cada cálculo. |
| is_base_value | TINYINT(1) | NO |  |  | 0 | Constantes legales usadas en cada cálculo. |
| application_order | INT | NO |  |  | 1 | Constantes legales usadas en cada cálculo. |
| applied_at | TIMESTAMP | NO |  |  | CURRENT_TIMESTAMP | Marca de tiempo asociada al evento. |
| notes | TEXT | YES |  |  |  | Notas adicionales. |
