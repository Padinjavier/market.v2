-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         9.1.0 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.14.0.7165
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Volcando estructura para tabla market.cart_items
CREATE TABLE IF NOT EXISTS `cart_items` (
  `cart_item_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `unit_price` decimal(11,2) NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`cart_item_id`),
  UNIQUE KEY `uq_cart_user_product` (`user_id`,`product_id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `FK_cart_items_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `FK_cart_items_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla market.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `category_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_swedish_ci NOT NULL,
  `description` text COLLATE utf8mb4_swedish_ci NOT NULL,
  `image_name` varchar(100) COLLATE utf8mb4_swedish_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla market.countries
CREATE TABLE IF NOT EXISTS `countries` (
  `country_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla market.departments
CREATE TABLE IF NOT EXISTS `departments` (
  `department_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `country_id` bigint NOT NULL,
  PRIMARY KEY (`department_id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `FK_departments_countries` FOREIGN KEY (`country_id`) REFERENCES `countries` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla market.districts
CREATE TABLE IF NOT EXISTS `districts` (
  `district_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `province_id` bigint NOT NULL,
  PRIMARY KEY (`district_id`),
  KEY `province_id` (`province_id`),
  CONSTRAINT `FK_districts_provinces` FOREIGN KEY (`province_id`) REFERENCES `provinces` (`province_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla market.modules
CREATE TABLE IF NOT EXISTS `modules` (
  `module_id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(50) COLLATE utf8mb4_swedish_ci NOT NULL,
  `description` text COLLATE utf8mb4_swedish_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla market.order_items
CREATE TABLE IF NOT EXISTS `order_items` (
  `order_item_id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `price` decimal(11,2) NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `product_id` (`product_id`),
  KEY `FK_order_items_orders` (`order_id`),
  CONSTRAINT `FK_order_items_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `FK_order_items_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla market.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `order_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `payment_method_id` bigint NOT NULL,
  `payment_reference` varchar(255) DEFAULT NULL,
  `payment_data` text,
  `subtotal` decimal(11,2) NOT NULL,
  `shipping_cost` decimal(10,2) DEFAULT '0.00',
  `total` decimal(11,2) NOT NULL,
  `status` enum('paid','delivered','partially_refunded','refunded','cancelled') NOT NULL DEFAULT 'paid',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  KEY `user_id` (`user_id`),
  KEY `payment_method_id` (`payment_method_id`),
  CONSTRAINT `FK_orders_payment_types` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_types` (`payment_type_id`),
  CONSTRAINT `FK_orders_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla market.pages
CREATE TABLE IF NOT EXISTS `pages` (
  `page_id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `featured_image` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `status` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla market.payment_types
CREATE TABLE IF NOT EXISTS `payment_types` (
  `payment_type_id` bigint NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(100) COLLATE utf8mb4_swedish_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`payment_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla market.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `permission_id` bigint NOT NULL AUTO_INCREMENT,
  `role_id` bigint NOT NULL,
  `module_id` bigint NOT NULL,
  `can_read` tinyint NOT NULL DEFAULT '0',
  `can_write` tinyint NOT NULL DEFAULT '0',
  `can_update` tinyint NOT NULL DEFAULT '0',
  `can_delete` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`permission_id`),
  KEY `role_id` (`role_id`),
  KEY `module_id` (`module_id`),
  CONSTRAINT `FK_permissions_modules` FOREIGN KEY (`module_id`) REFERENCES `modules` (`module_id`),
  CONSTRAINT `FK_permissions_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla market.product_stock_movements
CREATE TABLE IF NOT EXISTS `product_stock_movements` (
  `movement_id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `type` enum('sale','refund') NOT NULL,
  `quantity` int NOT NULL,
  `order_id` bigint DEFAULT NULL,
  `refund_id` bigint DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`movement_id`),
  KEY `product_id` (`product_id`),
  KEY `idx_psm_order_id` (`order_id`),
  KEY `idx_psm_refund_id` (`refund_id`),
  CONSTRAINT `FK_product_stock_movements_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `FK_psm_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `FK_psm_refunds` FOREIGN KEY (`refund_id`) REFERENCES `refunds` (`refund_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla market.products
CREATE TABLE IF NOT EXISTS `products` (
  `product_id` bigint NOT NULL AUTO_INCREMENT,
  `category_id` bigint NOT NULL,
  `sku` varchar(30) COLLATE utf8mb4_swedish_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_swedish_ci NOT NULL,
  `description` text COLLATE utf8mb4_swedish_ci NOT NULL,
  `price` decimal(11,2) NOT NULL,
  `stock` int NOT NULL,
  `expiration_date` date NOT NULL,
  `image_name` varchar(100) COLLATE utf8mb4_swedish_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`product_id`) USING BTREE,
  KEY `category_id` (`category_id`),
  CONSTRAINT `FK_products_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla market.provinces
CREATE TABLE IF NOT EXISTS `provinces` (
  `province_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `department_id` bigint NOT NULL,
  PRIMARY KEY (`province_id`),
  KEY `FK_provinces_departments` (`department_id`),
  CONSTRAINT `FK_provinces_departments` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla market.refund_items
CREATE TABLE IF NOT EXISTS `refund_items` (
  `refund_item_id` bigint NOT NULL AUTO_INCREMENT,
  `refund_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `price` decimal(11,2) NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`refund_item_id`),
  KEY `FK_refund_items_refunds` (`refund_id`),
  CONSTRAINT `FK_refund_items_refunds` FOREIGN KEY (`refund_id`) REFERENCES `refunds` (`refund_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla market.refunds
CREATE TABLE IF NOT EXISTS `refunds` (
  `refund_id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL,
  `refund_reference` varchar(255) DEFAULT NULL,
  `refund_data` text,
  `total_refund` decimal(11,2) NOT NULL,
  `reason` text,
  `status` enum('pending','completed','rejected') DEFAULT 'completed',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`refund_id`),
  KEY `FK_refunds_orders` (`order_id`),
  CONSTRAINT `FK_refunds_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla market.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `role_id` bigint NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) COLLATE utf8mb4_swedish_ci NOT NULL,
  `description` text COLLATE utf8mb4_swedish_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla market.users
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `identification` varchar(30) COLLATE utf8mb4_swedish_ci DEFAULT NULL,
  `first_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `middle_name` varchar(50) COLLATE utf8mb4_swedish_ci DEFAULT NULL,
  `last_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `second_last_name` varchar(50) COLLATE utf8mb4_swedish_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_swedish_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_swedish_ci NOT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_swedish_ci DEFAULT NULL,
  `role_id` bigint NOT NULL,
  `address` varchar(100) COLLATE utf8mb4_swedish_ci DEFAULT NULL,
  `district_id` bigint DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`),
  KEY `rolid` (`role_id`),
  KEY `district_id` (`district_id`),
  CONSTRAINT `FK_users_districts` FOREIGN KEY (`district_id`) REFERENCES `districts` (`district_id`),
  CONSTRAINT `FK_users_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

-- La exportación de datos fue deseleccionada.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
