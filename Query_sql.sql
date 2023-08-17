create database pizza_sales;

use pizza_sales;

select * from pizza_sales;

-- 1. Total revenue = sum of total price of all pizzas.
select round(sum(total_price),0) as Revenue from pizza_sales;

-- 2. Average order value =  total revenue/ total orders.
select sum(total_price)/count(distinct order_id) as Average_order_value from pizza_sales;

-- 3. Total pizzas sold = Sum of quantities of all pizzas sold.
select sum(quantity) as Total_pizzas_sold from pizza_sales;

-- 4. Total orders 
select count(distinct order_id) as Total_order from pizza_sales;

-- 5. Average pizzas per order = total pizza sold / total order
select sum(quantity)/count(distinct order_id) as Average_pizza_per_order from pizza_sales;

-- B. Daily trend for orders
-- Monday to sunday daily total pizzas sold will give the fluctuation
select dayname(cast(order_date as date)) as Days,count(distinct order_id) as Orders
from pizza_sales
group by  days
order by Orders desc;

-- C. Monthly trend
-- Per month pizza sales
select monthname(cast(order_date as date)) as Months, count(distinct order_id) as Orders
from pizza_sales
group by Months
order by Orders desc;

-- D. Percent of sales by Pizza category
-- Sales per pizza category /  total sales
select pizza_category, round(sum(total_price),2) as Revenue, round((sum(total_price)/(select sum(total_price) from pizza_sales))*100,2) as Percentage
from pizza_sales
group by pizza_category;

select pizza_category, round(sum(total_price),2) as Revenue, round((sum(total_price)/(select sum(total_price) from pizza_sales))*100,2) as Percentage
from pizza_sales
where monthname(cast(order_date as date)) = "January"
group by pizza_category;

select pizza_category, round(sum(total_price),2) as Revenue, round((sum(total_price)/(select sum(total_price) from pizza_sales))*100,2) as Percentage
from pizza_sales
where quarter(cast(order_date as date)) = 2
group by pizza_category;

-- E. Percent of sales by Pizza category
-- Sales per pizza size /  total sales
select pizza_size, round(sum(total_price),2) as Revenue, round((sum(total_price)/(select sum(total_price) from pizza_sales))*100,2) as Percentage
from pizza_sales
group by pizza_size;

-- F. Top 5 pizza based on Revenue
select pizza_name, sum(total_price) as Revenue
from pizza_sales
group by pizza_name
order by revenue desc
limit 5;

-- G. Top 5 pizza based on Quantity
select pizza_name, sum(quantity) as Quantity
from pizza_sales
group by pizza_name
order by Quantity desc
limit 5;

-- H. Top 5 pizza based on Orders
select pizza_name, count(distinct order_id) as Orders
from pizza_sales
group by pizza_name
order by Orders desc
limit 5;

-- I. Bottom 5 pizza based on Revenue,
select pizza_name, round(sum(total_price),2) as Revenue
from pizza_sales
group by pizza_name
order by revenue
limit 5;

-- J. Bottom 5 pizza based on Quantity
select pizza_name, sum(quantity) as Quantity
from pizza_sales
group by pizza_name
order by Quantity
limit 5;

-- K. Bottom 5 pizza based on Orders
select pizza_name, count(distinct order_id) as Orders
from pizza_sales
group by pizza_name
order by Orders
limit 5;

