#Kerry Ronayne (kpr6aj), Lab Assignment 2, 2/13/22

####################################################################
# 1 CREATING SCHEMA
####################################################################

CREATE DATABASE `northwind_dw` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE northwind_dW;

################################
# 1.1 Creating Dimension Tables
################################

CREATE TABLE `dim_customers` (
  `customer_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  `business_phone` varchar(25) DEFAULT NULL,
  `fax_number` varchar(25) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`customer_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `dim_employees` (
  `employee_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `email_address` varchar(50) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  `business_phone` varchar(25) DEFAULT NULL,
  `home_phone` varchar(25) DEFAULT NULL,
  `fax_number` varchar(25) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`employee_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `dim_products` (
  `product_key` int NOT NULL AUTO_INCREMENT,
  `product_code` varchar(25) DEFAULT NULL,
  `product_name` varchar(50) DEFAULT NULL,
  `standard_cost` decimal(19,4) DEFAULT '0.0000',
  `list_price` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `reorder_level` int DEFAULT NULL,
  `target_level` int DEFAULT NULL,
  `quantity_per_unit` varchar(50) DEFAULT NULL,
  `discontinued` tinyint(1) NOT NULL DEFAULT '0',
  `minimum_reorder_quantity` int DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`product_key`),
  KEY `product_code` (`product_code`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `dim_shippers` (
  `shipper_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`shipper_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

################################
# 1.2 Creating Fact Table
################################

CREATE TABLE `fact_orders` (
  `order_key` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `employee_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `product_id`int DEFAULT NULL,
  `shipper_id` int DEFAULT NULL,
  `ship_name` varchar(50) DEFAULT NULL,
  `ship_address` longtext,
  `ship_city` varchar(50) DEFAULT NULL,
  `ship_state_province` varchar(50) DEFAULT NULL,
  `ship_zip_postal_code` varchar(50) DEFAULT NULL,
  `ship_country_region` varchar(50) DEFAULT NULL,
  `quantity` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `order_date` datetime DEFAULT NULL,
  `shipped_date` datetime DEFAULT NULL,
  `unit_price` decimal(19,4) DEFAULT '0.0000',
  `discount` double NOT NULL DEFAULT '0',
  `shipping_fee` decimal(19,4) DEFAULT '0.0000',
  `taxes` decimal(19,4) DEFAULT '0.0000',
  `payment_type` varchar(50) DEFAULT NULL,
  `paid_date` datetime DEFAULT NULL,
  `tax_rate` double DEFAULT '0',
  `order_status` varchar(50) NOT NULL,
  `order_details_status` varchar(50) NOT NULL,
  PRIMARY KEY (`order_key`),
  KEY `order_id` (`order_id`),
  KEY `customer_id` (`customer_id`),
  KEY `employee_id` (`employee_id`),
  KEY `product_id` (`product_id`),
  KEY `shipper_id` (`shipper_id`),
  KEY `ship_zip_postal_code` (`ship_zip_postal_code`)
 )ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4;

####################################################################
# 2 POPULATING SCHEMA
####################################################################

################################
# 2.1 Loading Dimension Tables
################################

INSERT INTO `northwind_dw`.`dim_customers`
(`customer_key`,
`company`,
`last_name`,
`first_name`,
`job_title`,
`business_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`)
SELECT `id`,
`company`,
`last_name`,
`first_name`,
`job_title`,
`business_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`
FROM northwind.customers;
SELECT * FROM northwind_dw.dim_customers;

INSERT INTO `northwind_dw`.`dim_employees`
(`employee_key`,
`company`,
`last_name`,
`first_name`,
`email_address`,
`job_title`,
`business_phone`,
`home_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`)
SELECT
`id`,
`company`,
`last_name`,
`first_name`,
`email_address`,
`job_title`,
`business_phone`,
`home_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`
FROM northwind.employees;
SELECT * FROM northwind_dw.dim_employees;

INSERT INTO `northwind_dw`.`dim_products`
(`product_key`,
`product_code`,
`product_name`,
`standard_cost`,
`list_price`,
`reorder_level`,
`target_level`,
`quantity_per_unit`,
`discontinued`,
`minimum_reorder_quantity`,
`category`)
SELECT
`id`,
`product_code`,
`product_name`,
`standard_cost`,
`list_price`,
`reorder_level`,
`target_level`,
`quantity_per_unit`,
`discontinued`,
`minimum_reorder_quantity`,
`category`
FROM northwind.products;
SELECT * FROM northwind_dw.dim_products;


#shippers
INSERT INTO `northwind_dw`.`dim_shippers`
(`shipper_key`,
`company`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`)
SELECT
`id`,
`company`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`
FROM northwind.shippers;
SELECT * FROM northwind_dw.dim_shippers;

################################
# 2.2 Loading Fact Table
################################

INSERT INTO `northwind_dw`.`fact_orders`
(`order_id`,
`employee_id`,
`customer_id`,
`product_id`,
`shipper_id`,
`ship_name`,
`ship_address`,
`ship_city`,
`ship_state_province`,
`ship_zip_postal_code`,
`ship_country_region`,
`quantity`,
`order_date`,
`shipped_date`,
`unit_price`,
`discount`,
`shipping_fee`,
`taxes`,
`payment_type`,
`paid_date`,
`tax_rate`,
`order_status`,
`order_details_status`)
SELECT o.`id` AS order_id,
    o.`employee_id`,
    o.`customer_id`,
	od.`product_id`,
	o.`shipper_id`,
	o.`ship_name`,
    o.`ship_address`,
    o.`ship_city`,
    o.`ship_state_province`,
    o.`ship_zip_postal_code`,
    o.`ship_country_region`,
	od.`quantity`,
	o.`order_date`,
	o.`shipped_date`,
	od.`unit_price`,
	od.`discount`,
    o.`shipping_fee`,
    o.`taxes`,
    o.`payment_type`,
    o.`paid_date`,
    o.`tax_rate`,
	os.`status_name` AS order_status,
	ods.`status_name`AS order_details_status
FROM northwind.orders AS o
INNER JOIN northwind.orders_status AS os
ON o.status_id = os.id
RIGHT OUTER JOIN northwind.order_details AS od
ON od.order_id = o.id
INNER JOIN northwind.order_details_status as ods
ON od.status_id = ods.id;

SELECT * FROM northwind_dw.fact_orders;

####################################################################
# 3 REPORT
####################################################################
SELECT dc.last_name AS customer_name,
sum(fact.quantity) AS total_quantity,
sum(fact.unit_price) AS total_unit_price
FROM northwind_dw.dim_customers AS dc
INNER JOIN northwind_dw.fact_orders as fact
ON dc.customer_key = fact.customer_id
GROUP BY dc.last_name;

 
 