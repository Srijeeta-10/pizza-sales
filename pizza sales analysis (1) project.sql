DROP DATABASE insagram;
USE instagram;
DROP DATABASE insagram;
create database pizzahut;
drop database pizzahut;
create database pizzahut;
use pizzahut;
create table orders(
order_id int not null,
order_date date not null,
order_time time not null,
primary key(order_id));
select* from pizzahut.orders;
SHOW TABLES;
SET GLOBAL local_infile = 1;

USE pizzahut;
LOAD DATA LOCAL INFILE 'C:/Users/choti/OneDrive/Desktop/Pizza sales project/pizza_sales/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(order_id, order_date, order_time);
SHOW VARIABLES LIKE 'secure_file_priv';
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(order_id, order_date, order_time);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders.csv'
IGNORE INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(order_id, order_date, order_time);
SELECT COUNT(*) FROM orders;
SELECT * FROM orders LIMIT 10;
USE pizzahut;

CREATE TABLE order_details (
    order_details_id INT NOT NULL,
    order_id INT NOT NULL,
    pizza_id VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_details_id)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/order_details.csv'
INTO TABLE order_details
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(order_details_id, order_id, pizza_id, quantity);
SELECT COUNT(*) FROM order_details;
SELECT * FROM order_details LIMIT 10;
-- Retrieve the total number of orders placed.
select count(order_id) as total_order from orders;
-- Calculate the total revenue generated from pizza sales.? 
use pizzahut;
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;
-- Identify the highest-priced pizza.
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
    order by  pizzas.price desc limit 1;
-- Identify the most common pizza size ordered.
select pizzas.size, count(order_details.order_details_id) as order_count
from pizzas join order_details
on pizzas.pizza_id=order_details.pizza_id
group by pizzas.size order by order_count desc limit 1;
-- List the top 5 most ordered pizza types along with their quantities.
select pizza_types.name,
sum(order_details.quantity) as quantity
 from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id 
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name order by quantity desc limit 5;
-- Join the necessary tables to find the total quantity of each pizza category ordered.
select pizza_types.category,
sum(order_details.quantity)as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category order by quantity desc;
-- Determine the distribution of orders by hour of the day.
select hour(order_time) as hour, count(order_id) as order_count from orders
group by hour(order_time);




