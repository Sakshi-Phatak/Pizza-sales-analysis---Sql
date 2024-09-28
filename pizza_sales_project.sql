use pizzahut;
-- Retrieving the total number of orders placed.
SELECT * FROM order_details ; 
SELECT 
COUNT(order_id) as ORDERS_PLACED
FROM
orders;

-- Calculating the total revenue generated from pizza sales.
SELECT 
SUM(order_details.quantity * pizzas.price) AS total_sales
FROM
 order_details
 JOIN
 pizzas ON pizzas.pizza_id = order_details.pizza_id
 
-- Calculating the total revenue generated from pizza sales.
SELECT
 SUM(order_details.quantity * pizzas.price) AS total_sales
FROM
 order_details
 JOIN
 pizzas ON pizzas.pizza_id = order_details.pizza_id
 
-- Identifying the highest-priced pizza. 
SELECT 
 pizza_types.name, pizzas.price
FROM
 pizza_types
 JOIN
 pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id;
ORDER BY pizzas.price desc limit 1;

-- Identifying the most common pizza size ordered.
SELECT 
 quantity, COUNT(order_details_id)
FROM
 order_details
GROUP BY quantity;
SELECT 
 pizzas.size, COUNT(order_details_id)
FROM
 pizzas
 JOIN
 order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY COUNT(order_details_id) DESC;

-- Listing the top 5 most ordered pizza types along with their quantities.
SELECT 
 pizza_types.name, SUM(order_details.quantity)
FROM
 pizza_types
 JOIN
 pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
 JOIN
 order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY SUM(order_details.quantity) DESC
LIMIT 5;

-- Joining the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
 pizza_types.category,
 SUM(order_details.quantity) AS quantity
FROM
 pizza_types
 JOIN
 pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
 JOIN
 order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;

-- Determining the distribution of orders by hour of the day.
SELECT 
 HOUR(time), COUNT(order_id)
FROM
 orders
GROUP BY HOUR(time)

-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
 category, 
COUNT(name)
FROM
 pizza_types
GROUP BY category;

-- Grouping the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
 ROUND(AVG(quantity),0)
FROM
 (SELECT 
 orders.date, SUM(order_details.quantity) AS quantity
 FROM
 orders
 JOIN order_details ON orders.order_id = order_details.order_id
 GROUP BY orders.date) AS order_quantity;
 
-- Determining the top 3 most ordered pizza types based on revenue.
SELECT 
 pizza_types.name,
 SUM(order_details.quantity * pizzas.price) AS revenue
FROM
 pizza_types
 JOIN
 pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
 JOIN
 order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;