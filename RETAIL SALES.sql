
select*from retailsales ;

select count(*)from retailsales;

select count( distinct customer_id) from retailsales;

select distinct category from retailsales;


--- data analysis and finding---
select * from retailsales
where sale_date ='05-11-2022' ;

SELECT *
FROM retailsales
WHERE category = 'Clothing'
  AND quantiy > 4
  AND (sale_date between '01-11-2022'AND '01-12-2022');


SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retailsales
GROUP BY 1
 
 SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retailsales
WHERE category = 'Beauty';


select total_sale from retailsales where total_sale >1000

select category,gender,count(*)as total_trans from retailsales 
group by category,gender
order by 1


SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retailsales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5


SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retailsales
GROUP BY category

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retailsales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift