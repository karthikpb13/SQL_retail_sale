# SQL Retail Sales Analysis

## Project Overview
This project involves analyzing retail sales data using SQL queries. The dataset includes information about transactions, customers, sales categories, and timestamps. The SQL scripts help in data cleaning, exploratory data analysis, and deriving business insights.

## Database and Table Setup

```sql
-- Create Database
CREATE DATABASE SQLProjectP1;

-- Use Database
USE SQLProjectP1;

-- Create Table
CREATE TABLE salesList (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(20),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

## Data Import and Cleanup

```sql
-- Renaming the transaction_id column
ALTER TABLE sales  
CHANGE COLUMN `ï»¿transactions_id` transaction_id INT;

-- Dropping the salesList table as data is imported via Import Wizard
DROP TABLE salesList;

-- Counting total rows
SELECT COUNT(*) FROM sales;

-- Setting transaction_id as Primary Key
ALTER TABLE sales ADD PRIMARY KEY(transaction_id);

-- Checking for null values
SELECT * FROM sales WHERE transaction_id IS NULL;
SELECT * FROM sales WHERE (sale_date OR sale_time OR customer_id OR gender OR age OR category OR quantiy OR price_per_unit OR total_sale) IS NULL;
```

## Exploratory Data Analysis (EDA)

```sql
-- Total number of sales
SELECT COUNT(*) AS total_sales FROM sales;

-- Number of unique customers
SELECT COUNT(DISTINCT customer_id) AS total_customer FROM sales;

-- Unique categories
SELECT DISTINCT(category) FROM sales;
```

## SQL Queries for Analysis

### Q1: Retrieve all sales on a specific date
```sql
SELECT * FROM sales WHERE sale_date = '2022-11-05';
```

### Q2: Retrieve transactions for 'Clothing' with quantity > 4 in Nov 2022
```sql
SELECT * FROM sales
WHERE category = 'Clothing' AND quantiy >= 4 AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
```

### Q3: Total sales for each category
```sql
SELECT category, SUM(total_sale) AS total_sales, COUNT(*) AS total_orders FROM sales GROUP BY category;
```

### Q4: Average age of customers who purchased 'Beauty' products
```sql
SELECT ROUND(AVG(age), 2) AS avg_age_cust_beauty FROM sales WHERE category = 'Beauty';
```

### Q5: Transactions where total_sale > 1000
```sql
SELECT * FROM sales WHERE total_sale > 1000;
```

### Q6: Total transactions by gender for each category
```sql
SELECT category, gender, COUNT(transaction_id) AS total_transaction FROM sales GROUP BY category, gender ORDER BY category;
```

### Q7: Average sales per month and best-selling month per year
```sql
SELECT YEAR(sale_date) AS sale_year, MONTH(sale_date) AS sale_month, AVG(total_sale) AS avg_sale
FROM sales
GROUP BY sale_year, sale_month
ORDER BY avg_sale DESC;
```

### Q8: Top 5 customers by total sales
```sql
SELECT customer_id, SUM(total_sale) AS total_sale FROM sales GROUP BY customer_id ORDER BY total_sale DESC LIMIT 5;
```

### Q9: Number of unique customers per category
```sql
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers FROM sales GROUP BY category;
```

### Q10: Sales distribution by shift (Morning, Afternoon, Evening)
```sql
SELECT
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS total_orders
FROM sales
GROUP BY shift
ORDER BY total_orders;
```

## Conclusion
This project showcases SQL queries used for analyzing retail sales data, identifying trends, and deriving business insights. The queries help in understanding sales performance, customer behavior, and product category trends.

---

**Author:** [Karthik P Bhadange]  
**Date:** [01-04-2025] 
**Technology Used:** MySQL

