INSERT INTO roles (name, description) VALUES
('ADMIN', 'Administrador del sistema'),
('ABOGADO', 'Usuario operativo del sistema');

INSERT INTO client_types (name, description) VALUES
('PERSONA_NATURAL', 'Cliente persona natural'),
('PERSONA_JURIDICA', 'Cliente persona jurídica');

INSERT INTO client_statuses (name, description) VALUES
('ACTIVO', 'Cliente activo'),
('INACTIVO', 'Cliente inactivo'),
('PROSPECTO', 'Cliente prospecto');

INSERT INTO law_areas (name, description) VALUES
('LABORAL', 'Derecho laboral'),
('CIVIL', 'Derecho civil'),
('FAMILIA', 'Derecho de familia'),
('COMERCIAL', 'Derecho comercial'),
('ADMINISTRATIVO', 'Derecho administrativo'),
('TRIBUTARIO', 'Derecho tributario');

INSERT INTO case_statuses (name, description) VALUES
('ABIERTO', 'Caso abierto'),
('EN_PROCESO', 'Caso en proceso'),
('SUSPENDIDO', 'Caso suspendido'),
('CERRADO', 'Caso cerrado');

INSERT INTO case_priorities (name, level_number, color_hex, description) VALUES
('BAJA', 1, '#22C55E', 'Prioridad baja'),
('MEDIA', 2, '#F59E0B', 'Prioridad media'),
('ALTA', 3, '#EF4444', 'Prioridad alta');

INSERT INTO case_role_types (name, description) VALUES
('RESPONSABLE', 'Responsable principal del caso'),
('APOYO', 'Abogado de apoyo');

INSERT INTO hearing_statuses (name, description) VALUES
('PROGRAMADA', 'Audiencia programada'),
('REALIZADA', 'Audiencia realizada'),
('CANCELADA', 'Audiencia cancelada'),
('REPROGRAMADA', 'Audiencia reprogramada');

INSERT INTO hearing_types (name, description, estimated_duration_minutes) VALUES
('INICIAL', 'Audiencia inicial', 60),
('CONCILIACION', 'Audiencia de conciliación', 90),
('JUICIO', 'Audiencia de juicio', 180);

INSERT INTO activity_types (name, description, is_billable_default) VALUES
('REUNION_CLIENTE', 'Reunión con cliente', 1),
('REVISION_EXPEDIENTE', 'Revisión de expediente', 1),
('REDACCION_DOCUMENTO', 'Redacción de documento', 1),
('GESTION_INTERNA', 'Gestión interna', 0);

INSERT INTO procedural_term_types (name, description, default_days) VALUES
('CONTESTACION', 'Término de contestación', 10),
('RECURSO', 'Término para recurso', 3),
('APORTAR_PRUEBAS', 'Término para aportar pruebas', 5);

INSERT INTO procedural_action_types (name, description, category) VALUES
('RADICACION', 'Radicación de documento', 'SECRETARIA'),
('AUTO', 'Auto judicial', 'DESPACHO'),
('NOTIFICACION', 'Notificación', 'COMUNICACION'),
('MEMORIAL', 'Memorial presentado', 'PARTE');

INSERT INTO participant_types (name, description) VALUES
('DEMANDANTE', 'Parte demandante'),
('DEMANDADO', 'Parte demandada'),
('TESTIGO', 'Testigo'),
('APODERADO', 'Apoderado');

INSERT INTO client_document_types (name, description, category) VALUES
('CEDULA', 'Documento de identidad', 'IDENTIFICACION'),
('PODER', 'Poder firmado por el cliente', 'MANDATO'),
('CONTRATO', 'Contrato asociado', 'SOPORTE');

INSERT INTO case_document_types (name, description, category) VALUES
('DEMANDA', 'Documento de demanda', 'PROCESAL'),
('CONTESTACION', 'Contestación de demanda', 'PROCESAL'),
('PODER', 'Poder del proceso', 'SOPORTE'),
('SENTENCIA', 'Sentencia del proceso', 'DECISION');

INSERT INTO legal_reference_types (name, description) VALUES
('LEY', 'Ley'),
('DECRETO', 'Decreto'),
('RESOLUCION', 'Resolución'),
('JURISPRUDENCIA', 'Jurisprudencia');

INSERT INTO legal_reference_statuses (name, description) VALUES
('VIGENTE', 'Norma vigente'),
('DEROGADA', 'Norma derogada'),
('MODIFICADA', 'Norma modificada');

INSERT INTO legal_constant_categories (name, description) VALUES
('LABORAL', 'Constantes laborales'),
('TRIBUTARIA', 'Constantes tributarias'),
('GENERAL', 'Constantes generales');

-- Permisos base sugeridos
INSERT INTO permissions (name, code, description, module_name, action_name, resource_name) VALUES
('Ver dashboard', 'DASHBOARD_VIEW', 'Permite ver dashboard', 'dashboard', 'view', 'dashboard'),
('Gestionar usuarios', 'USERS_MANAGE', 'Permite administrar usuarios', 'usuarios', 'manage', 'users'),
('Gestionar clientes', 'CLIENTS_MANAGE', 'Permite administrar clientes', 'clientes', 'manage', 'clients'),
('Gestionar casos', 'CASES_MANAGE', 'Permite administrar casos', 'casos', 'manage', 'cases'),
('Gestionar documentos', 'DOCUMENTS_MANAGE', 'Permite administrar documentos', 'documentos', 'manage', 'documents'),
('Gestionar audiencias', 'HEARINGS_MANAGE', 'Permite administrar audiencias', 'audiencias', 'manage', 'hearings'),
('Gestionar actividades', 'ACTIVITIES_MANAGE', 'Permite administrar actividades', 'actividades', 'manage', 'activities'),
('Usar calculadora', 'CALCULATOR_USE', 'Permite usar calculadora laboral', 'calculadora', 'use', 'calculations'),
('Gestionar constantes legales', 'LEGAL_CONSTANTS_MANAGE', 'Permite administrar constantes legales', 'constantes', 'manage', 'legal_constants'),
('Ver reportes', 'REPORTS_VIEW', 'Permite ver reportes operativos', 'reportes', 'view', 'reports');

INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r
JOIN permissions p
WHERE r.name = 'ADMIN';

INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r
JOIN permissions p
WHERE r.name = 'ABOGADO'
  AND p.code IN (
    'DASHBOARD_VIEW',
    'CLIENTS_MANAGE',
    'CASES_MANAGE',
    'DOCUMENTS_MANAGE',
    'HEARINGS_MANAGE',
    'ACTIVITIES_MANAGE',
    'CALCULATOR_USE',
    'REPORTS_VIEW'
  );
