-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-03-2026 a las 00:10:36
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `coffee_shop`
--

DELIMITER $$
--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_can_change_order_status` (`p_current_status` VARCHAR(40), `p_new_status` VARCHAR(40)) RETURNS TINYINT(1) DETERMINISTIC BEGIN
    DECLARE v_result BOOLEAN DEFAULT FALSE;

    IF p_current_status = 'RECIBIDO' AND p_new_status = 'EN_PREPARACION' THEN
        SET v_result = TRUE;
    ELSEIF p_current_status = 'EN_PREPARACION' AND p_new_status = 'LISTO' THEN
        SET v_result = TRUE;
    ELSEIF p_current_status = 'LISTO' AND p_new_status = 'ENTREGADO' THEN
        SET v_result = TRUE;
    END IF;

    RETURN v_result;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cart`
--

CREATE TABLE `cart` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `customer_id` char(36) NOT NULL,
  `cart_status` varchar(30) NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cart`
--

INSERT INTO `cart` (`id`, `customer_id`, `cart_status`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
('2f892763-1e68-11f1-be96-98eecb02157a', '2f226045-1e68-11f1-be96-98eecb02157a', 'ACTIVE', '2026-03-12 23:07:04', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cart_item`
--

CREATE TABLE `cart_item` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `cart_id` char(36) NOT NULL,
  `product_id` char(36) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `unit_price` decimal(12,2) NOT NULL DEFAULT 0.00,
  `subtotal` decimal(12,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cart_item`
--

INSERT INTO `cart_item` (`id`, `cart_id`, `product_id`, `quantity`, `unit_price`, `subtotal`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
('2f9f8d4c-1e68-11f1-be96-98eecb02157a', '2f892763-1e68-11f1-be96-98eecb02157a', '2f00fc0e-1e68-11f1-be96-98eecb02157a', 2, 2500.00, 5000.00, '2026-03-12 23:07:04', NULL, NULL, 1),
('2fa90278-1e68-11f1-be96-98eecb02157a', '2f892763-1e68-11f1-be96-98eecb02157a', '2f12373d-1e68-11f1-be96-98eecb02157a', 1, 3500.00, 3500.00, '2026-03-12 23:07:05', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `category`
--

CREATE TABLE `category` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `code` varchar(40) NOT NULL,
  `name` varchar(120) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `category`
--

INSERT INTO `category` (`id`, `code`, `name`, `description`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
('2efcd0c0-1e68-11f1-be96-98eecb02157a', 'CAF', 'Cafe', 'Bebidas calientes', '2026-03-12 23:07:03', NULL, NULL, 1),
('2efce301-1e68-11f1-be96-98eecb02157a', 'PAN', 'Panaderia', 'Productos de panaderia', '2026-03-12 23:07:03', NULL, NULL, 1),
('2efce53a-1e68-11f1-be96-98eecb02157a', 'JUG', 'Jugos', 'Bebidas frias', '2026-03-12 23:07:03', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `customer`
--

CREATE TABLE `customer` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `person_id` char(36) NOT NULL,
  `customer_code` varchar(60) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `customer`
--

INSERT INTO `customer` (`id`, `person_id`, `customer_code`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
('2f226045-1e68-11f1-be96-98eecb02157a', '2e6573a9-1e68-11f1-be96-98eecb02157a', 'CLI001', '2026-03-12 23:07:04', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `method_payment`
--

CREATE TABLE `method_payment` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `code` varchar(40) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `method_payment`
--

INSERT INTO `method_payment` (`id`, `code`, `name`, `description`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
('2fe1861b-1e68-11f1-be96-98eecb02157a', 'CASH', 'Efectivo', 'Pago en efectivo', '2026-03-12 23:07:05', NULL, NULL, 1),
('2fe18886-1e68-11f1-be96-98eecb02157a', 'CARD', 'Tarjeta', 'Pago con tarjeta', '2026-03-12 23:07:05', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `module`
--

CREATE TABLE `module` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `route` varchar(255) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `module`
--

INSERT INTO `module` (`id`, `code`, `name`, `description`, `route`, `icon`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
('2e8dfe45-1e68-11f1-be96-98eecb02157a', 'PAR', 'Parameter', 'Parametros generales', '/parameter', 'settings', '2026-03-12 23:07:03', NULL, NULL, 1),
('2e8e0519-1e68-11f1-be96-98eecb02157a', 'CAT', 'Catalogo', 'Catalogo de productos', '/catalogo', 'book', '2026-03-12 23:07:03', NULL, NULL, 1),
('2e8e0590-1e68-11f1-be96-98eecb02157a', 'CAR', 'Carrito', 'Gestion del carrito', '/carrito', 'shopping-cart', '2026-03-12 23:07:03', NULL, NULL, 1),
('2e8e0641-1e68-11f1-be96-98eecb02157a', 'PED', 'Pedidos', 'Gestion de pedidos', '/pedidos', 'clipboard', '2026-03-12 23:07:03', NULL, NULL, 1),
('2e8e0688-1e68-11f1-be96-98eecb02157a', 'SEC', 'Security', 'Seguridad del sistema', '/security', 'shield', '2026-03-12 23:07:03', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `module_view`
--

CREATE TABLE `module_view` (
  `module_id` char(36) NOT NULL,
  `view_id` char(36) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `module_view`
--

INSERT INTO `module_view` (`module_id`, `view_id`, `created_at`, `status`) VALUES
('2e8e0519-1e68-11f1-be96-98eecb02157a', '2e9c2796-1e68-11f1-be96-98eecb02157a', '2026-03-12 23:07:03', 1),
('2e8e0590-1e68-11f1-be96-98eecb02157a', '2ea00ebe-1e68-11f1-be96-98eecb02157a', '2026-03-12 23:07:03', 1),
('2e8e0641-1e68-11f1-be96-98eecb02157a', '2ea5054e-1e68-11f1-be96-98eecb02157a', '2026-03-12 23:07:03', 1),
('2e8e0641-1e68-11f1-be96-98eecb02157a', '2ea8ed7c-1e68-11f1-be96-98eecb02157a', '2026-03-12 23:07:03', 1),
('2e8e0641-1e68-11f1-be96-98eecb02157a', '2eadf044-1e68-11f1-be96-98eecb02157a', '2026-03-12 23:07:03', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `order`
--

CREATE TABLE `order` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `order_number` varchar(60) NOT NULL,
  `customer_id` char(36) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status_order` varchar(40) NOT NULL DEFAULT 'RECIBIDO',
  `subtotal` decimal(12,2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `order`
--

INSERT INTO `order` (`id`, `order_number`, `customer_id`, `order_date`, `status_order`, `subtotal`, `total_amount`, `notes`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
('2fb0e81c-1e68-11f1-be96-98eecb02157a', 'PED001', '2f226045-1e68-11f1-be96-98eecb02157a', '2026-03-12 23:07:05', 'RECIBIDO', 8500.00, 8500.00, 'Pedido inicial del MVP', '2026-03-12 23:07:05', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `order_item`
--

CREATE TABLE `order_item` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `order_id` char(36) NOT NULL,
  `product_id` char(36) NOT NULL,
  `quantity` int(11) NOT NULL CHECK (`quantity` > 0),
  `unit_price` decimal(12,2) NOT NULL CHECK (`unit_price` >= 0),
  `subtotal` decimal(12,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `order_item`
--

INSERT INTO `order_item` (`id`, `order_id`, `product_id`, `quantity`, `unit_price`, `subtotal`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
('2fc904d8-1e68-11f1-be96-98eecb02157a', '2fb0e81c-1e68-11f1-be96-98eecb02157a', '2f00fc0e-1e68-11f1-be96-98eecb02157a', 2, 2500.00, 5000.00, '2026-03-12 23:07:05', NULL, NULL, 1),
('2fd2d6f6-1e68-11f1-be96-98eecb02157a', '2fb0e81c-1e68-11f1-be96-98eecb02157a', '2f12373d-1e68-11f1-be96-98eecb02157a', 1, 3500.00, 3500.00, '2026-03-12 23:07:05', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `payment`
--

CREATE TABLE `payment` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `order_id` char(36) NOT NULL,
  `method_payment_id` char(36) NOT NULL,
  `amount_paid` decimal(12,2) NOT NULL,
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status_payment` varchar(30) NOT NULL DEFAULT 'PENDIENTE',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `payment`
--

INSERT INTO `payment` (`id`, `order_id`, `method_payment_id`, `amount_paid`, `payment_date`, `status_payment`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
('2fe6ffaa-1e68-11f1-be96-98eecb02157a', '2fb0e81c-1e68-11f1-be96-98eecb02157a', '2fe1861b-1e68-11f1-be96-98eecb02157a', 8500.00, '2026-03-12 23:07:05', 'PENDIENTE', '2026-03-12 23:07:05', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `person`
--

CREATE TABLE `person` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `type_document_id` char(36) NOT NULL,
  `document_number` varchar(50) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `person`
--

INSERT INTO `person` (`id`, `type_document_id`, `document_number`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
('2e6573a9-1e68-11f1-be96-98eecb02157a', '2e5055dd-1e68-11f1-be96-98eecb02157a', '100000001', 'Juan', 'Perez', 'juan@email.com', '300000001', '2026-03-12 23:07:02', NULL, NULL, 1),
('2e694f4d-1e68-11f1-be96-98eecb02157a', '2e5055dd-1e68-11f1-be96-98eecb02157a', '100000002', 'Maria', 'Gomez', 'maria@email.com', '300000002', '2026-03-12 23:07:02', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `product`
--

CREATE TABLE `product` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `category_id` char(36) DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `sku` varchar(100) DEFAULT NULL,
  `price` decimal(12,2) NOT NULL DEFAULT 0.00,
  `available` tinyint(1) NOT NULL DEFAULT 1,
  `image_url` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `product`
--

INSERT INTO `product` (`id`, `category_id`, `name`, `description`, `sku`, `price`, `available`, `image_url`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
('2f00fc0e-1e68-11f1-be96-98eecb02157a', '2efcd0c0-1e68-11f1-be96-98eecb02157a', 'Cafe tinto', 'Cafe tinto tradicional', 'PROD001', 2500.00, 1, '/img/cafe_tinto.png', '2026-03-12 23:07:03', NULL, NULL, 1),
('2f05ad1c-1e68-11f1-be96-98eecb02157a', '2efcd0c0-1e68-11f1-be96-98eecb02157a', 'Capuccino', 'Cafe con leche espumosa', 'PROD002', 5000.00, 1, '/img/capuccino.png', '2026-03-12 23:07:03', NULL, NULL, 1),
('2f12373d-1e68-11f1-be96-98eecb02157a', '2efce301-1e68-11f1-be96-98eecb02157a', 'Croissant', 'Croissant de mantequilla', 'PROD003', 3500.00, 1, '/img/croissant.png', '2026-03-12 23:07:03', NULL, NULL, 1),
('2f174be9-1e68-11f1-be96-98eecb02157a', '2efce53a-1e68-11f1-be96-98eecb02157a', 'Jugo natural', 'Jugo de fruta del dia', 'PROD004', 4500.00, 0, '/img/jugo.png', '2026-03-12 23:07:04', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role`
--

CREATE TABLE `role` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `role`
--

INSERT INTO `role` (`id`, `name`, `description`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
('2e785c68-1e68-11f1-be96-98eecb02157a', 'ADMIN', 'Administrador del sistema', '2026-03-12 23:07:02', NULL, NULL, 1),
('2e7c27e7-1e68-11f1-be96-98eecb02157a', 'CLIENTE', 'Cliente del cafetin', '2026-03-12 23:07:02', NULL, NULL, 1),
('2e7c288f-1e68-11f1-be96-98eecb02157a', 'CAFETIN', 'Operador del cafetin', '2026-03-12 23:07:02', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_module`
--

CREATE TABLE `role_module` (
  `role_id` char(36) NOT NULL,
  `module_id` char(36) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `role_module`
--

INSERT INTO `role_module` (`role_id`, `module_id`, `created_at`, `status`) VALUES
('2e7c27e7-1e68-11f1-be96-98eecb02157a', '2e8e0519-1e68-11f1-be96-98eecb02157a', '2026-03-12 23:07:03', 1),
('2e7c27e7-1e68-11f1-be96-98eecb02157a', '2e8e0590-1e68-11f1-be96-98eecb02157a', '2026-03-12 23:07:03', 1),
('2e7c27e7-1e68-11f1-be96-98eecb02157a', '2e8e0641-1e68-11f1-be96-98eecb02157a', '2026-03-12 23:07:03', 1),
('2e7c288f-1e68-11f1-be96-98eecb02157a', '2e8dfe45-1e68-11f1-be96-98eecb02157a', '2026-03-12 23:07:03', 1),
('2e7c288f-1e68-11f1-be96-98eecb02157a', '2e8e0641-1e68-11f1-be96-98eecb02157a', '2026-03-12 23:07:03', 1),
('2e7c288f-1e68-11f1-be96-98eecb02157a', '2e8e0688-1e68-11f1-be96-98eecb02157a', '2026-03-12 23:07:03', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `type_document`
--

CREATE TABLE `type_document` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `code` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `type_document`
--

INSERT INTO `type_document` (`id`, `code`, `name`, `description`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
('2e5055dd-1e68-11f1-be96-98eecb02157a', 'CC', 'Cedula de Ciudadania', 'Documento nacional', '2026-03-12 23:07:02', NULL, NULL, 1),
('2e5289a6-1e68-11f1-be96-98eecb02157a', 'TI', 'Tarjeta de Identidad', 'Documento para menores', '2026-03-12 23:07:02', NULL, NULL, 1),
('2e528c4f-1e68-11f1-be96-98eecb02157a', 'CE', 'Cedula de Extranjeria', 'Documento para extranjeros', '2026-03-12 23:07:02', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `username` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` text NOT NULL,
  `person_id` char(36) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password_hash`, `person_id`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
('2eb34805-1e68-11f1-be96-98eecb02157a', 'cliente1', 'cliente1@coffee.com', 'hash_cliente_123', '2e6573a9-1e68-11f1-be96-98eecb02157a', '2026-03-12 23:07:03', NULL, NULL, 1),
('2eb9f7c3-1e68-11f1-be96-98eecb02157a', 'operador1', 'operador1@coffee.com', 'hash_operador_123', '2e694f4d-1e68-11f1-be96-98eecb02157a', '2026-03-12 23:07:03', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_role`
--

CREATE TABLE `user_role` (
  `user_id` char(36) NOT NULL,
  `role_id` char(36) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `user_role`
--

INSERT INTO `user_role` (`user_id`, `role_id`, `created_at`, `status`) VALUES
('2eb34805-1e68-11f1-be96-98eecb02157a', '2e7c27e7-1e68-11f1-be96-98eecb02157a', '2026-03-12 23:07:03', 1),
('2eb9f7c3-1e68-11f1-be96-98eecb02157a', '2e7c288f-1e68-11f1-be96-98eecb02157a', '2026-03-12 23:07:03', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `view`
--

CREATE TABLE `view` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `module_id` char(36) DEFAULT NULL,
  `code` varchar(80) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `route` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `view`
--

INSERT INTO `view` (`id`, `module_id`, `code`, `name`, `description`, `route`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
('2e9c2796-1e68-11f1-be96-98eecb02157a', '2e8e0519-1e68-11f1-be96-98eecb02157a', 'PRODUCT_LIST', 'Catalogo productos', 'Listado de productos', '/catalogo/productos', '2026-03-12 23:07:03', NULL, NULL, 1),
('2ea00ebe-1e68-11f1-be96-98eecb02157a', '2e8e0590-1e68-11f1-be96-98eecb02157a', 'CART_VIEW', 'Ver carrito', 'Resumen del carrito', '/carrito', '2026-03-12 23:07:03', NULL, NULL, 1),
('2ea5054e-1e68-11f1-be96-98eecb02157a', '2e8e0641-1e68-11f1-be96-98eecb02157a', 'ORDER_CONFIRM', 'Confirmar pedido', 'Confirmacion del pedido', '/pedido/confirmar', '2026-03-12 23:07:03', NULL, NULL, 1),
('2ea8ed7c-1e68-11f1-be96-98eecb02157a', '2e8e0641-1e68-11f1-be96-98eecb02157a', 'ORDER_STATUS', 'Estado pedido', 'Seguimiento del pedido', '/pedido/estado', '2026-03-12 23:07:03', NULL, NULL, 1),
('2eadf044-1e68-11f1-be96-98eecb02157a', '2e8e0641-1e68-11f1-be96-98eecb02157a', 'CAFETIN_BOARD', 'Panel cafetin', 'Ver y cambiar estados', '/cafetin/pedidos', '2026-03-12 23:07:03', NULL, NULL, 1);

-- --------------------------------------------------------

--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_view`
-- Permite asignar permisos especificos por vista a cada rol.
--

CREATE TABLE `role_view` (
  `role_id` char(36) NOT NULL,
  `view_id` char(36) NOT NULL,
  `can_create` tinyint(1) NOT NULL DEFAULT 0,
  `can_read` tinyint(1) NOT NULL DEFAULT 1,
  `can_update` tinyint(1) NOT NULL DEFAULT 0,
  `can_delete` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audit_log`
-- Registra acciones realizadas por usuarios dentro de modulos y vistas.
--

CREATE TABLE `audit_log` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `user_id` char(36) DEFAULT NULL,
  `module_id` char(36) DEFAULT NULL,
  `view_id` char(36) DEFAULT NULL,
  `action` varchar(80) NOT NULL,
  `table_name` varchar(120) DEFAULT NULL,
  `record_id` char(36) DEFAULT NULL,
  `old_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_value`)),
  `new_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_value`)),
  `ip_address` varchar(60) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para modulos agregados: usuario, rol, vistas y auditoria
--

INSERT INTO `module` (`id`, `code`, `name`, `description`, `route`, `icon`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
('11111111-1111-1111-1111-111111111111', 'USR', 'Usuarios', 'Gestion de usuarios del sistema', '/usuarios', 'users', current_timestamp(), NULL, NULL, 1),
('22222222-2222-2222-2222-222222222222', 'ROL', 'Roles', 'Gestion de roles y perfiles', '/roles', 'key', current_timestamp(), NULL, NULL, 1),
('33333333-3333-3333-3333-333333333333', 'VIS', 'Vistas', 'Gestion de vistas y rutas del sistema', '/vistas', 'eye', current_timestamp(), NULL, NULL, 1),
('44444444-4444-4444-4444-444444444444', 'AUD', 'Auditoria', 'Consulta de trazabilidad y movimientos del sistema', '/auditoria', 'history', current_timestamp(), NULL, NULL, 1);

--
-- Volcado de datos para vistas agregadas
--

INSERT INTO `view` (`id`, `module_id`, `code`, `name`, `description`, `route`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '11111111-1111-1111-1111-111111111111', 'USER_LIST', 'Listado de usuarios', 'Permite consultar usuarios del sistema', '/usuarios/listar', current_timestamp(), NULL, NULL, 1),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa2', '11111111-1111-1111-1111-111111111111', 'USER_FORM', 'Formulario de usuarios', 'Permite crear y editar usuarios', '/usuarios/formulario', current_timestamp(), NULL, NULL, 1),
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb1', '22222222-2222-2222-2222-222222222222', 'ROLE_LIST', 'Listado de roles', 'Permite consultar roles del sistema', '/roles/listar', current_timestamp(), NULL, NULL, 1),
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb2', '22222222-2222-2222-2222-222222222222', 'ROLE_FORM', 'Formulario de roles', 'Permite crear y editar roles', '/roles/formulario', current_timestamp(), NULL, NULL, 1),
('cccccccc-cccc-cccc-cccc-ccccccccccc1', '33333333-3333-3333-3333-333333333333', 'VIEW_LIST', 'Listado de vistas', 'Permite consultar vistas registradas', '/vistas/listar', current_timestamp(), NULL, NULL, 1),
('cccccccc-cccc-cccc-cccc-ccccccccccc2', '33333333-3333-3333-3333-333333333333', 'VIEW_FORM', 'Formulario de vistas', 'Permite crear y editar vistas', '/vistas/formulario', current_timestamp(), NULL, NULL, 1),
('dddddddd-dddd-dddd-dddd-ddddddddddd1', '44444444-4444-4444-4444-444444444444', 'AUDIT_LIST', 'Consulta de auditoria', 'Permite consultar trazabilidad del sistema', '/auditoria/listar', current_timestamp(), NULL, NULL, 1),
('dddddddd-dddd-dddd-dddd-ddddddddddd2', '44444444-4444-4444-4444-444444444444', 'AUDIT_DETAIL', 'Detalle de auditoria', 'Permite revisar el detalle de un registro auditado', '/auditoria/detalle', current_timestamp(), NULL, NULL, 1);

--
-- Asociacion de modulos y vistas agregadas
--

INSERT INTO `module_view` (`module_id`, `view_id`, `created_at`, `status`) VALUES
('11111111-1111-1111-1111-111111111111', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1', current_timestamp(), 1),
('11111111-1111-1111-1111-111111111111', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa2', current_timestamp(), 1),
('22222222-2222-2222-2222-222222222222', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb1', current_timestamp(), 1),
('22222222-2222-2222-2222-222222222222', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb2', current_timestamp(), 1),
('33333333-3333-3333-3333-333333333333', 'cccccccc-cccc-cccc-cccc-ccccccccccc1', current_timestamp(), 1),
('33333333-3333-3333-3333-333333333333', 'cccccccc-cccc-cccc-cccc-ccccccccccc2', current_timestamp(), 1),
('44444444-4444-4444-4444-444444444444', 'dddddddd-dddd-dddd-dddd-ddddddddddd1', current_timestamp(), 1),
('44444444-4444-4444-4444-444444444444', 'dddddddd-dddd-dddd-dddd-ddddddddddd2', current_timestamp(), 1);

--
-- Usuario administrador para gestionar usuarios, roles, vistas y auditoria
--

INSERT INTO `person` (`id`, `type_document_id`, `document_number`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
('55555555-5555-5555-5555-555555555555', '2e5055dd-1e68-11f1-be96-98eecb02157a', '100000000', 'Administrador', 'Sistema', 'admin@coffee.com', '300000000', current_timestamp(), NULL, NULL, 1);

INSERT INTO `user` (`id`, `username`, `email`, `password_hash`, `person_id`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
('66666666-6666-6666-6666-666666666666', 'admin', 'admin@coffee.com', 'hash_admin_123', '55555555-5555-5555-5555-555555555555', current_timestamp(), NULL, NULL, 1);

INSERT INTO `user_role` (`user_id`, `role_id`, `created_at`, `status`) VALUES
('66666666-6666-6666-6666-666666666666', '2e785c68-1e68-11f1-be96-98eecb02157a', current_timestamp(), 1);

--
-- Permisos de modulos agregados para el rol ADMIN
--

INSERT INTO `role_module` (`role_id`, `module_id`, `created_at`, `status`) VALUES
('2e785c68-1e68-11f1-be96-98eecb02157a', '2e8dfe45-1e68-11f1-be96-98eecb02157a', current_timestamp(), 1),
('2e785c68-1e68-11f1-be96-98eecb02157a', '2e8e0519-1e68-11f1-be96-98eecb02157a', current_timestamp(), 1),
('2e785c68-1e68-11f1-be96-98eecb02157a', '2e8e0590-1e68-11f1-be96-98eecb02157a', current_timestamp(), 1),
('2e785c68-1e68-11f1-be96-98eecb02157a', '2e8e0641-1e68-11f1-be96-98eecb02157a', current_timestamp(), 1),
('2e785c68-1e68-11f1-be96-98eecb02157a', '2e8e0688-1e68-11f1-be96-98eecb02157a', current_timestamp(), 1),
('2e785c68-1e68-11f1-be96-98eecb02157a', '11111111-1111-1111-1111-111111111111', current_timestamp(), 1),
('2e785c68-1e68-11f1-be96-98eecb02157a', '22222222-2222-2222-2222-222222222222', current_timestamp(), 1),
('2e785c68-1e68-11f1-be96-98eecb02157a', '33333333-3333-3333-3333-333333333333', current_timestamp(), 1),
('2e785c68-1e68-11f1-be96-98eecb02157a', '44444444-4444-4444-4444-444444444444', current_timestamp(), 1);

--
-- Permisos por vista para el rol ADMIN
--

INSERT INTO `role_view` (`role_id`, `view_id`, `can_create`, `can_read`, `can_update`, `can_delete`, `created_at`, `updated_at`, `status`) VALUES
('2e785c68-1e68-11f1-be96-98eecb02157a', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1', 1, 1, 1, 1, current_timestamp(), NULL, 1),
('2e785c68-1e68-11f1-be96-98eecb02157a', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa2', 1, 1, 1, 1, current_timestamp(), NULL, 1),
('2e785c68-1e68-11f1-be96-98eecb02157a', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb1', 1, 1, 1, 1, current_timestamp(), NULL, 1),
('2e785c68-1e68-11f1-be96-98eecb02157a', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb2', 1, 1, 1, 1, current_timestamp(), NULL, 1),
('2e785c68-1e68-11f1-be96-98eecb02157a', 'cccccccc-cccc-cccc-cccc-ccccccccccc1', 1, 1, 1, 1, current_timestamp(), NULL, 1),
('2e785c68-1e68-11f1-be96-98eecb02157a', 'cccccccc-cccc-cccc-cccc-ccccccccccc2', 1, 1, 1, 1, current_timestamp(), NULL, 1),
('2e785c68-1e68-11f1-be96-98eecb02157a', 'dddddddd-dddd-dddd-dddd-ddddddddddd1', 0, 1, 0, 0, current_timestamp(), NULL, 1),
('2e785c68-1e68-11f1-be96-98eecb02157a', 'dddddddd-dddd-dddd-dddd-ddddddddddd2', 0, 1, 0, 0, current_timestamp(), NULL, 1);

--
-- Ejemplo de auditoria inicial
--

INSERT INTO `audit_log` (`id`, `user_id`, `module_id`, `view_id`, `action`, `table_name`, `record_id`, `old_value`, `new_value`, `ip_address`, `user_agent`, `created_at`) VALUES
('77777777-7777-7777-7777-777777777777', '66666666-6666-6666-6666-666666666666', '44444444-4444-4444-4444-444444444444', 'dddddddd-dddd-dddd-dddd-ddddddddddd1', 'CREATE_DATABASE_SECURITY_MODULES', 'module', NULL, NULL, JSON_OBJECT('descripcion', 'Se agregan modulos de usuarios, roles, vistas y auditoria'), '127.0.0.1', 'seed', current_timestamp());

-- Estructura Stand-in para la vista `vw_order_status_summary`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vw_order_status_summary` (
`order_id` char(36)
,`order_number` varchar(60)
,`order_date` timestamp
,`status_order` varchar(40)
,`customer_name` varchar(201)
,`subtotal` decimal(12,2)
,`total_amount` decimal(12,2)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_order_status_summary`
--
DROP TABLE IF EXISTS `vw_order_status_summary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_order_status_summary`  AS SELECT `o`.`id` AS `order_id`, `o`.`order_number` AS `order_number`, `o`.`order_date` AS `order_date`, `o`.`status_order` AS `status_order`, concat(`p`.`first_name`,' ',`p`.`last_name`) AS `customer_name`, `o`.`subtotal` AS `subtotal`, `o`.`total_amount` AS `total_amount` FROM ((`order` `o` join `customer` `c` on(`c`.`id` = `o`.`customer_id`)) join `person` `p` on(`p`.`id` = `c`.`person_id`)) WHERE `o`.`status` = 1 ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cart_customer` (`customer_id`);

--
-- Indices de la tabla `cart_item`
--
ALTER TABLE `cart_item`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_cart_item` (`cart_id`,`product_id`),
  ADD KEY `fk_cart_item_product` (`product_id`);

--
-- Indices de la tabla `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `person_id` (`person_id`),
  ADD UNIQUE KEY `customer_code` (`customer_code`);

--
-- Indices de la tabla `method_payment`
--
ALTER TABLE `method_payment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `module`
--
ALTER TABLE `module`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `module_view`
--
ALTER TABLE `module_view`
  ADD PRIMARY KEY (`module_id`,`view_id`),
  ADD KEY `fk_module_view_view` (`view_id`);

--
-- Indices de la tabla `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `fk_order_customer` (`customer_id`);

--
-- Indices de la tabla `order_item`
--
ALTER TABLE `order_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_order_item_order` (`order_id`),
  ADD KEY `fk_order_item_product` (`product_id`);

--
-- Indices de la tabla `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_payment_order` (`order_id`),
  ADD KEY `fk_payment_method` (`method_payment_id`);

--
-- Indices de la tabla `person`
--
ALTER TABLE `person`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_person_document` (`type_document_id`,`document_number`);

--
-- Indices de la tabla `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sku` (`sku`),
  ADD KEY `fk_product_category` (`category_id`);

--
-- Indices de la tabla `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `role_module`
--
ALTER TABLE `role_module`
  ADD PRIMARY KEY (`role_id`,`module_id`),
  ADD KEY `fk_role_module_module` (`module_id`);

--
-- Indices de la tabla `type_document`
--
ALTER TABLE `type_document`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `person_id` (`person_id`);

--
-- Indices de la tabla `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `fk_user_role_role` (`role_id`);

--
-- Indices de la tabla `view`
--
ALTER TABLE `view`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_view_module_code` (`module_id`,`code`);

--
--
-- Indices de la tabla `role_view`
--
ALTER TABLE `role_view`
  ADD PRIMARY KEY (`role_id`,`view_id`),
  ADD KEY `fk_role_view_view` (`view_id`);

--
-- Indices de la tabla `audit_log`
--
ALTER TABLE `audit_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_audit_user` (`user_id`),
  ADD KEY `fk_audit_module` (`module_id`),
  ADD KEY `fk_audit_view` (`view_id`),
  ADD KEY `idx_audit_action` (`action`),
  ADD KEY `idx_audit_table_record` (`table_name`,`record_id`),
  ADD KEY `idx_audit_created_at` (`created_at`);


-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `fk_cart_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`);

--
-- Filtros para la tabla `cart_item`
--
ALTER TABLE `cart_item`
  ADD CONSTRAINT `fk_cart_item_cart` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_cart_item_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Filtros para la tabla `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `fk_customer_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`);

--
-- Filtros para la tabla `module_view`
--
ALTER TABLE `module_view`
  ADD CONSTRAINT `fk_module_view_module` FOREIGN KEY (`module_id`) REFERENCES `module` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_module_view_view` FOREIGN KEY (`view_id`) REFERENCES `view` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `fk_order_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`);

--
-- Filtros para la tabla `order_item`
--
ALTER TABLE `order_item`
  ADD CONSTRAINT `fk_order_item_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_order_item_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Filtros para la tabla `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `fk_payment_method` FOREIGN KEY (`method_payment_id`) REFERENCES `method_payment` (`id`),
  ADD CONSTRAINT `fk_payment_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`);

--
-- Filtros para la tabla `person`
--
ALTER TABLE `person`
  ADD CONSTRAINT `fk_person_type_document` FOREIGN KEY (`type_document_id`) REFERENCES `type_document` (`id`);

--
-- Filtros para la tabla `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);

--
-- Filtros para la tabla `role_module`
--
ALTER TABLE `role_module`
  ADD CONSTRAINT `fk_role_module_module` FOREIGN KEY (`module_id`) REFERENCES `module` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_role_module_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `fk_user_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`);

--
-- Filtros para la tabla `user_role`
--
ALTER TABLE `user_role`
  ADD CONSTRAINT `fk_user_role_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_user_role_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `view`
--
ALTER TABLE `view`
  ADD CONSTRAINT `fk_view_module` FOREIGN KEY (`module_id`) REFERENCES `module` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `role_view`
--
ALTER TABLE `role_view`
  ADD CONSTRAINT `fk_role_view_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_role_view_view` FOREIGN KEY (`view_id`) REFERENCES `view` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `audit_log`
--
ALTER TABLE `audit_log`
  ADD CONSTRAINT `fk_audit_module` FOREIGN KEY (`module_id`) REFERENCES `module` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_audit_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_audit_view` FOREIGN KEY (`view_id`) REFERENCES `view` (`id`) ON DELETE SET NULL;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
