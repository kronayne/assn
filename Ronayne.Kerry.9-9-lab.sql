#1. Write a query to get Product name and quantity/unit.
SELECT product_name
, quantity_per_unit as quantity
FROM northwind.products;

#2. Write a query to get current Product list (Product ID and name).
SELECT id AS product_id
, product_name
FROM northwind.products;

#3. Write a query to get discontinued Product list (Product ID and name).
SELECT id AS product_id
, product_name
FROM northwind.products
WHERE discontinued = '1';

#4. Write a query to get most expense and least expensive Product list (name and unit price).  
SELECT product_name
, list_price
FROM northwind.products
WHERE list_price IN (SELECT MIN(list_price) FROM northwind.products)
OR list_price IN (SELECT MAX(list_price) FROM northwind.products);


#5. Write a query to get Product list (id, name, unit price) where current products cost less than $20.  
SELECT id AS product_id
, product_name
, list_price
FROM northwind.products
WHERE list_price < 20.000;

#6. Write a query to get Product list (id, name, unit price) where products cost between $15 and $25.
SELECT id AS product_id
, product_name
, list_price
FROM northwind.products
WHERE list_price BETWEEN 15.000 AND 25.000;

#7. Write a query to get Product list (name, unit price) of above average price.
SELECT product_name
, list_price
FROM northwind.products
WHERE list_price  > (SELECT avg(list_price) FROM northwind.products);

#8. Write a query to get Product list (name, unit price) of ten most expensive products.  
SELECT product_name
, list_price
FROM northwind.products
ORDER BY list_price DESC
LIMIT 10;

#9. Write a query to count current and discontinued products.
SELECT (
SELECT COUNT(*)
FROM northwind.products
WHERE discontinued = 0)
AS total_current 
,( SELECT COUNT(*)
FROM northwind.products
WHERE discontinued = 1) 
AS total_discont;

#10. Write a query to get Product list (name, units on order, units in stock) of stock is less than the quantity on order.
SELECT p.product_name AS name
, o.quantity AS ordered
, i.quantity AS stock
FROM products AS p
, order_details AS o
, inventory_transactions AS i
WHERE o.quantity>i.quantity
 
