-- JQPA Fase 1 - Esquema MySQL propuesto
-- Baseado en la documentación del proyecto y ajustado al alcance Fase 1.

CREATE DATABASE IF NOT EXISTS jqpa_fase1
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE jqpa_fase1;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS calculation_legal_constants;
DROP TABLE IF EXISTS calculations;
DROP TABLE IF EXISTS legal_constants;
DROP TABLE IF EXISTS legal_references;
DROP TABLE IF EXISTS legal_constant_categories;
DROP TABLE IF EXISTS legal_reference_statuses;
DROP TABLE IF EXISTS legal_reference_types;
DROP TABLE IF EXISTS case_participants;
DROP TABLE IF EXISTS participant_types;
DROP TABLE IF EXISTS procedural_actions;
DROP TABLE IF EXISTS procedural_action_types;
DROP TABLE IF EXISTS procedural_terms;
DROP TABLE IF EXISTS procedural_term_types;
DROP TABLE IF EXISTS case_activities;
DROP TABLE IF EXISTS activity_types;
DROP TABLE IF EXISTS hearings;
DROP TABLE IF EXISTS hearing_statuses;
DROP TABLE IF EXISTS hearing_types;
DROP TABLE IF EXISTS case_documents;
DROP TABLE IF EXISTS case_document_types;
DROP TABLE IF EXISTS client_documents;
DROP TABLE IF EXISTS client_document_types;
DROP TABLE IF EXISTS case_users;
DROP TABLE IF EXISTS case_role_types;
DROP TABLE IF EXISTS case_clients;
DROP TABLE IF EXISTS cases;
DROP TABLE IF EXISTS case_priorities;
DROP TABLE IF EXISTS case_statuses;
DROP TABLE IF EXISTS law_areas;
DROP TABLE IF EXISTS clients;
DROP TABLE IF EXISTS client_statuses;
DROP TABLE IF EXISTS client_types;
DROP TABLE IF EXISTS user_sessions;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS role_permissions;
DROP TABLE IF EXISTS permissions;
DROP TABLE IF EXISTS roles;

SET FOREIGN_KEY_CHECKS = 1;

-- ==============================
-- SEGURIDAD
-- ==============================

CREATE TABLE roles (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE,
  description VARCHAR(255) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE permissions (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  code VARCHAR(80) NOT NULL UNIQUE,
  description VARCHAR(255) NULL,
  module_name VARCHAR(80) NOT NULL,
  action_name VARCHAR(80) NOT NULL,
  resource_name VARCHAR(100) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uq_permissions_name (name)
) ENGINE=InnoDB;

CREATE TABLE role_permissions (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  role_id BIGINT UNSIGNED NOT NULL,
  permission_id BIGINT UNSIGNED NOT NULL,
  assigned_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  CONSTRAINT fk_role_permissions_role FOREIGN KEY (role_id) REFERENCES roles(id),
  CONSTRAINT fk_role_permissions_permission FOREIGN KEY (permission_id) REFERENCES permissions(id),
  UNIQUE KEY uq_role_permission (role_id, permission_id)
) ENGINE=InnoDB;

CREATE TABLE users (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  role_id BIGINT UNSIGNED NOT NULL,
  full_name VARCHAR(120) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  document_number VARCHAR(30) NULL,
  phone VARCHAR(20) NULL,
  address TEXT NULL,
  specialties_json JSON NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  email_verified_at TIMESTAMP NULL,
  last_login_at TIMESTAMP NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_users_role FOREIGN KEY (role_id) REFERENCES roles(id)
) ENGINE=InnoDB;

CREATE TABLE user_sessions (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  token_hash VARCHAR(255) NOT NULL,
  ip_address VARCHAR(45) NULL,
  user_agent TEXT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  expires_at TIMESTAMP NULL,
  last_used_at TIMESTAMP NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  CONSTRAINT fk_user_sessions_user FOREIGN KEY (user_id) REFERENCES users(id),
  INDEX idx_user_sessions_user (user_id),
  INDEX idx_user_sessions_active (is_active)
) ENGINE=InnoDB;

-- ==============================
-- CLIENTES
-- ==============================

CREATE TABLE client_types (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(60) NOT NULL UNIQUE,
  description VARCHAR(255) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE client_statuses (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(60) NOT NULL UNIQUE,
  description VARCHAR(255) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE clients (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  responsible_user_id BIGINT UNSIGNED NOT NULL,
  client_type_id BIGINT UNSIGNED NOT NULL,
  status_id BIGINT UNSIGNED NOT NULL,
  full_name VARCHAR(150) NOT NULL,
  document_type VARCHAR(20) NOT NULL,
  document_number VARCHAR(30) NOT NULL,
  email VARCHAR(150) NULL,
  phone VARCHAR(20) NULL,
  address TEXT NULL,
  birth_date DATE NULL,
  profession VARCHAR(100) NULL,
  notes TEXT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_clients_responsible_user FOREIGN KEY (responsible_user_id) REFERENCES users(id),
  CONSTRAINT fk_clients_type FOREIGN KEY (client_type_id) REFERENCES client_types(id),
  CONSTRAINT fk_clients_status FOREIGN KEY (status_id) REFERENCES client_statuses(id),
  UNIQUE KEY uq_clients_document (document_type, document_number),
  INDEX idx_clients_name (full_name),
  INDEX idx_clients_email (email)
) ENGINE=InnoDB;

CREATE TABLE client_document_types (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  description VARCHAR(255) NULL,
  category VARCHAR(50) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE client_documents (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  client_id BIGINT UNSIGNED NOT NULL,
  document_type_id BIGINT UNSIGNED NOT NULL,
  uploaded_by_user_id BIGINT UNSIGNED NOT NULL,
  file_name VARCHAR(255) NOT NULL,
  original_name VARCHAR(255) NOT NULL,
  storage_path VARCHAR(500) NOT NULL,
  file_extension VARCHAR(10) NOT NULL,
  file_size BIGINT UNSIGNED NOT NULL,
  file_hash VARCHAR(64) NULL,
  version_number INT UNSIGNED NOT NULL DEFAULT 1,
  description TEXT NULL,
  is_confidential TINYINT(1) NOT NULL DEFAULT 0,
  expiration_date DATE NULL,
  uploaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_client_documents_client FOREIGN KEY (client_id) REFERENCES clients(id),
  CONSTRAINT fk_client_documents_type FOREIGN KEY (document_type_id) REFERENCES client_document_types(id),
  CONSTRAINT fk_client_documents_uploaded_by FOREIGN KEY (uploaded_by_user_id) REFERENCES users(id),
  INDEX idx_client_documents_client (client_id)
) ENGINE=InnoDB;

-- ==============================
-- CASOS
-- ==============================

CREATE TABLE law_areas (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  description VARCHAR(255) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE case_statuses (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(60) NOT NULL UNIQUE,
  description VARCHAR(255) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE case_priorities (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(60) NOT NULL UNIQUE,
  level_number INT NOT NULL,
  color_hex VARCHAR(7) NULL,
  description VARCHAR(255) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE cases (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  responsible_user_id BIGINT UNSIGNED NOT NULL,
  area_id BIGINT UNSIGNED NOT NULL,
  status_id BIGINT UNSIGNED NOT NULL,
  priority_id BIGINT UNSIGNED NOT NULL,
  title VARCHAR(200) NOT NULL,
  description TEXT NULL,
  process_number VARCHAR(80) NULL,
  court_name VARCHAR(150) NULL,
  amount DECIMAL(15,2) NULL,
  start_date DATE NOT NULL,
  estimated_close_date DATE NULL,
  close_date DATE NULL,
  notes TEXT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_cases_responsible_user FOREIGN KEY (responsible_user_id) REFERENCES users(id),
  CONSTRAINT fk_cases_area FOREIGN KEY (area_id) REFERENCES law_areas(id),
  CONSTRAINT fk_cases_status FOREIGN KEY (status_id) REFERENCES case_statuses(id),
  CONSTRAINT fk_cases_priority FOREIGN KEY (priority_id) REFERENCES case_priorities(id),
  UNIQUE KEY uq_cases_process_number (process_number),
  INDEX idx_cases_title (title),
  INDEX idx_cases_start_date (start_date)
) ENGINE=InnoDB;

CREATE TABLE case_clients (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  case_id BIGINT UNSIGNED NOT NULL,
  client_id BIGINT UNSIGNED NOT NULL,
  is_primary_client TINYINT(1) NOT NULL DEFAULT 0,
  assigned_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  CONSTRAINT fk_case_clients_case FOREIGN KEY (case_id) REFERENCES cases(id),
  CONSTRAINT fk_case_clients_client FOREIGN KEY (client_id) REFERENCES clients(id),
  UNIQUE KEY uq_case_clients (case_id, client_id)
) ENGINE=InnoDB;

CREATE TABLE case_role_types (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(60) NOT NULL UNIQUE,
  description VARCHAR(255) NULL,
  permissions_json JSON NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE case_users (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  case_id BIGINT UNSIGNED NOT NULL,
  user_id BIGINT UNSIGNED NOT NULL,
  case_role_type_id BIGINT UNSIGNED NOT NULL,
  assigned_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  CONSTRAINT fk_case_users_case FOREIGN KEY (case_id) REFERENCES cases(id),
  CONSTRAINT fk_case_users_user FOREIGN KEY (user_id) REFERENCES users(id),
  CONSTRAINT fk_case_users_role FOREIGN KEY (case_role_type_id) REFERENCES case_role_types(id),
  UNIQUE KEY uq_case_users (case_id, user_id)
) ENGINE=InnoDB;

CREATE TABLE case_document_types (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  description VARCHAR(255) NULL,
  category VARCHAR(50) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE case_documents (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  case_id BIGINT UNSIGNED NOT NULL,
  document_type_id BIGINT UNSIGNED NOT NULL,
  uploaded_by_user_id BIGINT UNSIGNED NOT NULL,
  file_name VARCHAR(255) NOT NULL,
  original_name VARCHAR(255) NOT NULL,
  storage_path VARCHAR(500) NOT NULL,
  file_extension VARCHAR(10) NOT NULL,
  file_size BIGINT UNSIGNED NOT NULL,
  file_hash VARCHAR(64) NULL,
  version_number INT UNSIGNED NOT NULL DEFAULT 1,
  description TEXT NULL,
  is_confidential TINYINT(1) NOT NULL DEFAULT 0,
  expiration_date DATE NULL,
  uploaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_case_documents_case FOREIGN KEY (case_id) REFERENCES cases(id),
  CONSTRAINT fk_case_documents_type FOREIGN KEY (document_type_id) REFERENCES case_document_types(id),
  CONSTRAINT fk_case_documents_uploaded_by FOREIGN KEY (uploaded_by_user_id) REFERENCES users(id),
  INDEX idx_case_documents_case (case_id)
) ENGINE=InnoDB;

-- ==============================
-- AUDIENCIAS / ACTIVIDADES / SEGUIMIENTO
-- ==============================

CREATE TABLE hearing_types (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  description VARCHAR(255) NULL,
  estimated_duration_minutes INT NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE hearing_statuses (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(60) NOT NULL UNIQUE,
  description VARCHAR(255) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE hearings (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  case_id BIGINT UNSIGNED NOT NULL,
  hearing_type_id BIGINT UNSIGNED NOT NULL,
  status_id BIGINT UNSIGNED NOT NULL,
  title VARCHAR(200) NOT NULL,
  description TEXT NULL,
  hearing_datetime DATETIME NOT NULL,
  estimated_duration_minutes INT NULL,
  place VARCHAR(200) NULL,
  result_text TEXT NULL,
  notes TEXT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_hearings_case FOREIGN KEY (case_id) REFERENCES cases(id),
  CONSTRAINT fk_hearings_type FOREIGN KEY (hearing_type_id) REFERENCES hearing_types(id),
  CONSTRAINT fk_hearings_status FOREIGN KEY (status_id) REFERENCES hearing_statuses(id),
  INDEX idx_hearings_datetime (hearing_datetime)
) ENGINE=InnoDB;

CREATE TABLE activity_types (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  description VARCHAR(255) NULL,
  is_billable_default TINYINT(1) NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE case_activities (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  case_id BIGINT UNSIGNED NOT NULL,
  activity_type_id BIGINT UNSIGNED NOT NULL,
  user_id BIGINT UNSIGNED NOT NULL,
  title VARCHAR(200) NOT NULL,
  description TEXT NULL,
  activity_datetime DATETIME NOT NULL,
  duration_hours DECIMAL(5,2) NOT NULL,
  is_billable TINYINT(1) NOT NULL DEFAULT 0,
  hourly_rate DECIMAL(10,2) NULL,
  notes TEXT NULL,
  attachments_json JSON NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_case_activities_case FOREIGN KEY (case_id) REFERENCES cases(id),
  CONSTRAINT fk_case_activities_type FOREIGN KEY (activity_type_id) REFERENCES activity_types(id),
  CONSTRAINT fk_case_activities_user FOREIGN KEY (user_id) REFERENCES users(id),
  INDEX idx_case_activities_case (case_id),
  INDEX idx_case_activities_datetime (activity_datetime)
) ENGINE=InnoDB;

CREATE TABLE procedural_term_types (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  description VARCHAR(255) NULL,
  default_days INT NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE procedural_terms (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  case_id BIGINT UNSIGNED NOT NULL,
  term_type_id BIGINT UNSIGNED NOT NULL,
  description VARCHAR(300) NOT NULL,
  start_date DATE NOT NULL,
  due_date DATE NOT NULL,
  business_days INT NULL,
  status_name VARCHAR(60) NOT NULL,
  is_notified TINYINT(1) NOT NULL DEFAULT 0,
  notes TEXT NULL,
  completion_date DATE NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_procedural_terms_case FOREIGN KEY (case_id) REFERENCES cases(id),
  CONSTRAINT fk_procedural_terms_type FOREIGN KEY (term_type_id) REFERENCES procedural_term_types(id),
  INDEX idx_procedural_terms_due_date (due_date)
) ENGINE=InnoDB;

CREATE TABLE procedural_action_types (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  description VARCHAR(255) NULL,
  category VARCHAR(60) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE procedural_actions (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  case_id BIGINT UNSIGNED NOT NULL,
  action_type_id BIGINT UNSIGNED NOT NULL,
  registered_by_user_id BIGINT UNSIGNED NOT NULL,
  action_date DATE NOT NULL,
  description TEXT NOT NULL,
  court_name VARCHAR(150) NULL,
  filing_number VARCHAR(80) NULL,
  source_name VARCHAR(60) NULL,
  support_document_path VARCHAR(500) NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_procedural_actions_case FOREIGN KEY (case_id) REFERENCES cases(id),
  CONSTRAINT fk_procedural_actions_type FOREIGN KEY (action_type_id) REFERENCES procedural_action_types(id),
  CONSTRAINT fk_procedural_actions_user FOREIGN KEY (registered_by_user_id) REFERENCES users(id),
  INDEX idx_procedural_actions_case (case_id),
  INDEX idx_procedural_actions_date (action_date)
) ENGINE=InnoDB;

CREATE TABLE participant_types (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(60) NOT NULL UNIQUE,
  description VARCHAR(255) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE case_participants (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  case_id BIGINT UNSIGNED NOT NULL,
  participant_type_id BIGINT UNSIGNED NOT NULL,
  full_name VARCHAR(200) NOT NULL,
  document_number VARCHAR(30) NULL,
  phone VARCHAR(20) NULL,
  email VARCHAR(150) NULL,
  address TEXT NULL,
  legal_representative VARCHAR(200) NULL,
  notes TEXT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_case_participants_case FOREIGN KEY (case_id) REFERENCES cases(id),
  CONSTRAINT fk_case_participants_type FOREIGN KEY (participant_type_id) REFERENCES participant_types(id),
  INDEX idx_case_participants_case (case_id)
) ENGINE=InnoDB;

-- ==============================
-- NORMATIVIDAD Y CALCULADORA
-- ==============================

CREATE TABLE legal_reference_types (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  description VARCHAR(255) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE legal_reference_statuses (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(60) NOT NULL UNIQUE,
  description VARCHAR(255) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE legal_references (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  reference_type_id BIGINT UNSIGNED NOT NULL,
  status_id BIGINT UNSIGNED NOT NULL,
  rule_number VARCHAR(50) NOT NULL,
  year_number INT NULL,
  title VARCHAR(300) NOT NULL,
  description TEXT NULL,
  official_url VARCHAR(500) NULL,
  publication_date DATE NULL,
  effective_date DATE NULL,
  repeal_date DATE NULL,
  issuing_entity VARCHAR(200) NULL,
  verification_hash VARCHAR(64) NULL,
  last_verified_at TIMESTAMP NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_legal_references_type FOREIGN KEY (reference_type_id) REFERENCES legal_reference_types(id),
  CONSTRAINT fk_legal_references_status FOREIGN KEY (status_id) REFERENCES legal_reference_statuses(id),
  INDEX idx_legal_references_title (title)
) ENGINE=InnoDB;

CREATE TABLE legal_constant_categories (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  description VARCHAR(255) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE legal_constants (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  legal_reference_id BIGINT UNSIGNED NOT NULL,
  category_id BIGINT UNSIGNED NOT NULL,
  name VARCHAR(200) NOT NULL,
  description TEXT NULL,
  numeric_value DECIMAL(20,6) NULL,
  text_value VARCHAR(500) NULL,
  unit_of_measure VARCHAR(50) NULL,
  article_reference VARCHAR(100) NULL,
  paragraph_reference VARCHAR(100) NULL,
  literal_reference VARCHAR(100) NULL,
  effective_from DATE NOT NULL,
  effective_until DATE NULL,
  notes TEXT NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_legal_constants_reference FOREIGN KEY (legal_reference_id) REFERENCES legal_references(id),
  CONSTRAINT fk_legal_constants_category FOREIGN KEY (category_id) REFERENCES legal_constant_categories(id),
  INDEX idx_legal_constants_name (name),
  INDEX idx_legal_constants_effective (effective_from, effective_until)
) ENGINE=InnoDB;

CREATE TABLE calculations (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  case_id BIGINT UNSIGNED NOT NULL,
  calculated_by_user_id BIGINT UNSIGNED NOT NULL,
  validated_by_user_id BIGINT UNSIGNED NULL,
  calculation_type_code VARCHAR(50) NOT NULL DEFAULT 'LABORAL',
  parameters_json JSON NOT NULL,
  result_json JSON NOT NULL,
  total_value DECIMAL(15,2) NOT NULL,
  legal_version VARCHAR(50) NULL,
  notes TEXT NULL,
  legal_basis_text TEXT NULL,
  base_article VARCHAR(200) NULL,
  is_validated TINYINT(1) NOT NULL DEFAULT 0,
  validated_at TIMESTAMP NULL,
  calculated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_calculations_case FOREIGN KEY (case_id) REFERENCES cases(id),
  CONSTRAINT fk_calculations_calculated_by FOREIGN KEY (calculated_by_user_id) REFERENCES users(id),
  CONSTRAINT fk_calculations_validated_by FOREIGN KEY (validated_by_user_id) REFERENCES users(id),
  INDEX idx_calculations_case (case_id),
  INDEX idx_calculations_type (calculation_type_code)
) ENGINE=InnoDB;

CREATE TABLE calculation_legal_constants (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  calculation_id BIGINT UNSIGNED NOT NULL,
  legal_constant_id BIGINT UNSIGNED NOT NULL,
  used_value DECIMAL(20,6) NOT NULL,
  is_base_value TINYINT(1) NOT NULL DEFAULT 0,
  application_order INT NOT NULL DEFAULT 1,
  applied_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  notes TEXT NULL,
  CONSTRAINT fk_calc_legal_constants_calculation FOREIGN KEY (calculation_id) REFERENCES calculations(id),
  CONSTRAINT fk_calc_legal_constants_constant FOREIGN KEY (legal_constant_id) REFERENCES legal_constants(id),
  UNIQUE KEY uq_calc_constant_order (calculation_id, legal_constant_id, application_order)
) ENGINE=InnoDB;

-- ==============================
-- DATOS SEMILLA MÍNIMOS
-- ==============================
