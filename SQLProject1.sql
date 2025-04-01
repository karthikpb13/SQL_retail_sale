-- SQL Retail Sales Analysis
create database SQLProjectP1;

use SQLProjectP1;

-- Create Table
create table salesList
(
	transactions_id	int primary key,
	sale_date	date,
	sale_time	time,
	customer_id	int,
    gender	varchar(10),
	age	int,
    category	varchar(20),
	quantiy	int,
	price_per_unit float,	
	cogs	float,
	total_sale float
);

select * from sales;

-- Renaming the transaction id table
ALTER TABLE sales  
CHANGE COLUMN `ï»¿transactions_id` transaction_id INT;  

-- Droped table saleslist because it is no longer requoired
-- Because data is directly imported using Import Wizzard
drop table salesList;

-- Counting total number of rows 

select count(*) from sales;

-- making transactions id primary key
alter table sales
add primary key(transaction_id);

select * from sales
limit 5;

-- Checking for null values i.e data cleaning 
select * from sales
where transaction_id=null;

select * from sales
where (sale_date or sale_time or customer_id or gender  or age or category or quantiy or price_per_unit or quantiy or total_sale)=null;

-- How many sales we have
select count(*) as total_sales from sales;

-- how many customers we have 	
select count(distinct(customer_id)) as total_customer from sales;

-- how many category we have 
select distinct(category) from sales;

-- Q1) Retrive all columns for sales made on 2022-11-05
select * from sales 
where sale_date='2022-11-05';

-- Q2) Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select * from sales
where category='Clothing' 
				and quantiy >= 4 
				and DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
                
-- Q3 Write a SQL query to calculate the total sales (total_sale) for each category.:
select category,
		sum(total_sale),
        count(*) as total_orders -- using count to finding the order count for each category
from sales 
group by category;

-- Q4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select round(avg(age),2) as avg_age_cust_beauty from sales -- using round function to lessen the decimal point
where category='Beauty';

-- Q5) Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select * from sales 
where total_sale > 1000;

--  Q 6) Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category, gender,count(transaction_id) AS total_transaction from  sales 
group by category,gender
order by category;

-- Q7) Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
select 
	year(sale_date) as sale_year,
    month(sale_date) as sale_month,
    avg(total_sale) as avg_sale
from sales
group by sale_year,sale_month
order by avg_sale desc
;

-- Q8) *Write a SQL query to find the top 5 customers based on the highest total sales **:
select customer_id, sum(total_sale) as total_sale
from sales
group by customer_id
order by total_sale desc
limit 5;

select * from sales;

-- Q9) Write a SQL query to find the number of unique customers who purchased items from each category
select category, count(distinct(customer_id))
from sales
group by category;

-- Q 10) Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
select 
case 
	when hour(sale_time) < 12 then 'morning'
    when hour(sale_time) between 12 and 17 then 'afternoon'
    else 'evening'
end as shift,
count(*) as total_orders
from sales
group by shift
order by total_orders;

