# Retail Sales Analysis SQL Project

## 📌 Project Overview

* **Title**: Retail Sales Analysis
* **Level**: Beginner
* **Database**: `p1_retail_db`

This project demonstrates SQL skills used by data analysts to explore, clean, and analyze retail sales data. It includes setting up a database, performing EDA, and solving business problems using SQL.

---

## 🎯 Objectives

* Set up a retail sales database with provided data
* Clean data by removing missing/null records
* Perform exploratory data analysis (EDA)
* Answer business questions using SQL

---

## 🏗️ Project Structure

### 1. Database Setup

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

```sql
-- Total Records
SELECT COUNT(*) FROM retail_sales;

-- Unique Customers
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- Unique Categories
SELECT DISTINCT category FROM retail_sales;

-- Check for NULLs
SELECT * FROM retail_sales
WHERE
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR
    gender IS NULL OR age IS NULL OR category IS NULL OR
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

-- Delete NULL records
DELETE FROM retail_sales
WHERE
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR
    gender IS NULL OR age IS NULL OR category IS NULL OR
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

```sql
-- Sales on 2022-11-05
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Clothing Category with Quantity > 4 in Nov-2022
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND quantity >= 4;

-- Total Sales by Category
SELECT category, SUM(total_sale) AS net_sale, COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;

-- Average Age of Customers in 'Beauty' Category
SELECT ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- Transactions > 1000 in Total Sale
SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- Transactions by Gender and Category
SELECT category, gender, COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY category;

-- Best Selling Month by Year
SELECT year, month, avg_sale
FROM (
  SELECT
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(total_sale) AS avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
  FROM retail_sales
  GROUP BY 1, 2
) AS t1
WHERE rank = 1;

-- Top 5 Customers by Total Sales
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Unique Customers per Category
SELECT category, COUNT(DISTINCT customer_id) AS cnt_unique_cs
FROM retail_sales
GROUP BY category;

-- Shift-based Sales Summary
WITH hourly_sale AS (
  SELECT *,
    CASE
      WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
      WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
      ELSE 'Evening'
    END AS shift
  FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;
```

---

## 📊 Findings

* **Customer Demographics**: Wide age range, categories like Clothing and Beauty dominate.
* **High-Value Transactions**: Several above 1000 in total sale.
* **Sales Trends**: Monthly sales variation reveals seasonal spikes.
* **Customer Insights**: Identifies top customers and product interests.

---

## 📑 Reports

* **Sales Summary**: Total sales, category performance, demographics
* **Trend Analysis**: Best-selling months and shifts
* **Customer Insights**: Top spenders, unique customers by category

---

## ✅ Conclusion

This beginner-friendly SQL project demonstrates full-cycle data analysis: database setup, cleaning, EDA, and insights. 
---


---

## 👨‍💻 Author – NISHANTH.M

This project showcases essential SQL skills. For feedback, questions, or collaboration:

Thanks for your support! 🙏
