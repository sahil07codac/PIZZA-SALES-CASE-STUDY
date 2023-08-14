

select * from dbo.pizza_sales


--total revenue
select round(sum(total_price),2) as total_revenue from pizza_sales


--average order value
select round(sum(total_price)/count(distinct order_id),2) as average_order_value 
from pizza_sales




--total pizza sold
select sum(quantity) as total_pizza from pizza_sales

--total order place
select count(distinct order_id) as total_order_place from pizza_sales

--average pizza per order
select cast(cast(sum(quantity) as decimal(10,2))/cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) average_pizza_per_order from pizza_sales

-- daily trend for  total order
select datename(dw,order_date)as order_day,count(distinct order_id) as total_order 
from pizza_sales
group by datename(dw,order_date)

---montly trend for total ordcer
select datename(month,order_date) as order_day,count(distinct order_id) as total_order
from pizza_sales
group by datename(month,order_date)
order by total_order desc

--percentage of sale by pizza category
select pizza_category,sum(total_price) as toal_sales ,round(sum(total_price)*100/(select sum(total_price) from pizza_sales),2)as PCT_of_sale
from pizza_sales
group by pizza_category
order by sum(total_price)desc

--	% of Sales by Pizza Size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size





--percentage of sale of pizza category by month
select pizza_category,sum(total_price)as total_sales,sum(total_price)*100/(select sum(total_price)from pizza_sales where month(order_date)=1) as pct_of_sales
from pizza_sales
where month(order_date)=1
group by pizza_category
order by sum(total_price) desc

-- Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC


--percentage of sale by pizza category(SIZE)
select pizza_size,sum(total_price)as total_sales,sum(total_price)*100/(select sum(total_price) from pizza_sales) as PCT_of_sales
from pizza_sales
group by pizza_size
order by sum(total_price)desc





----percentage of sale of pizza category by quarter
select pizza_size,sum(total_price)as total_sales,sum(total_price)*100/(select sum(total_price) from pizza_sales) as PCT_of_sales
from pizza_sales
where datepart(quarter ,order_date)=1
group by pizza_size
order by sum(total_price)desc



--top 5 best seller by revenue, total quantity,total order
--top 5 best seller by revenue
select top 5 pizza_name,sum(total_price)as total_sales from pizza_sales
group by pizza_name
order by total_sales desc



--bottom 5  seller by revenue
select top 5 pizza_name,sum(total_price)as total_sales from pizza_sales
group by pizza_name
order by total_sales asc





--top 5 best seller by total quantity
select top 5 pizza_name,sum(quantity)as total_quantity from pizza_sales
group by pizza_name
order by total_quantity desc




--bottom 5  seller by total quantity
select top 5 pizza_name,sum(quantity)as total_quantity from pizza_sales
group by pizza_name
order by total_quantity asc




--top 5 best seller by total order
select top 5 pizza_name,count(distinct(order_id))as total_order from pizza_sales
group by pizza_name
order by total_order desc



--bottom 5 best seller by total order
select top 5 pizza_name,count(distinct(order_id))as total_order from pizza_sales
group by pizza_name
order by total_order asc


--top 5 pizza of classic total order
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
WHERE pizza_category = 'Classic'
GROUP BY pizza_name
ORDER BY Total_Orders ASC
