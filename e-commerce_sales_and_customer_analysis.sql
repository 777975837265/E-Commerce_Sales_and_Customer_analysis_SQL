select * from customers;
select * from order_items;
select * from orders;
select * from products;

select count(*) from customers;
select count(*) from products;
select count(*) from orders;
select count(*) from order_items;

SELECT MIN(order_date) AS first_order, MAX(order_date) AS last_order FROM orders;

-- Identify and remove duplicate customer records:
SELECT customer_id, COUNT(*) 
FROM customers 
GROUP BY customer_id 
HAVING COUNT(*) > 1;


 -- Calculate total revenue generated from all orders.
SELECT round(SUM(total_amount),2) AS total_revenue
FROM orders;

-- The most popular products based on sales volume.
SELECT 
p.name AS product_name, 
SUM(oi.quantity) AS total_quantity_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- Monthly Revenue over Time
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month, 
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY month
ORDER BY month;

-- The top-5 customers by total spending
SELECT c.customer_id, 
c.name,
SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 5;

-- Count of Repeat Customers
SELECT 
    customer_id, 
    COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1
order by order_count desc
limit 10;

-- The Average Order Value.
SELECT 
    round(AVG(total_amount),2) AS avg_order_value
FROM orders;

-- Identify peak sales month
SELECT 
    EXTRACT(MONTH FROM order_date) AS month, 
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY month
ORDER BY total_orders DESC;

-- The products with the highest revenue
SELECT 
    p.name AS product_name, 
    round(SUM(oi.quantity * oi.price),2) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY total_revenue DESC
LIMIT 5;







