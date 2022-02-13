#Kerry Ronayne (kpr6aj), Lab Assignment 2, 2/12/22

USE Northwind_DW;

####################################################################
#JOINING ORDER TABLES
####################################################################
SELECT o.`id` AS order_id,
    o.`employee_id`,
    o.`customer_id`,
	od.`product_id`,
	o.`shipper_id`,
	od.`id` AS order_detail_id,
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
INNER JOIN northwind.order_details AS od
ON od.order_id = o.id
INNER JOIN northwind.order_details_status as ods
ON od.status_id = ods.id;


####################################################################
#CREATING TABLE#
####################################################################

CREATE TABLE `fact_orders` (
  `order_details_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
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
  PRIMARY KEY (`order_details_id`)
 )ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4;
 
####################################################################
#INSERTING INFORMATION
####################################################################

INSERT INTO `Northwind_DW`.`fact_orders`
(`order_details_id`,
`order_id`,
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
SELECT 
	od.`id` AS order_detail_id,
    o.`id` AS order_id,
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
INNER JOIN northwind.order_details AS od
ON od.order_id = o.id
INNER JOIN northwind.order_details_status as ods
ON od.status_id = ods.id;

#checking everything inserted
SELECT * FROM Northwind_DW.fact_orders

 
 