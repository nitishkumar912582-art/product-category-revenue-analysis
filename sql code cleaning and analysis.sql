create database sales_storages;
use sales_storages;

CREATE TABLE sales_storages(
transaction_id VARCHAR(15),
customer_id VARCHAR(15),
customer_name VARCHAR(30),
customer_age INT,
gender VARCHAR(15),
product_id VARCHAR(15),
product_name VARCHAR(15),
product_category VARCHAR(15),
quantiy INT,
prce FLOAT,
payment_mode VARCHAR(15),
purchase_date DATE,
time_of_purchase TIME,
status VARCHAR(15)
);

SELECT * FROM sales_storages;

SHOW TABLES;

-- Data Cleaning

SELECT * FROM sales_storages;

-- Data Cleaning

-- Step 1:- To check for Duplicate 

SELECT transaction_id,COUNT(*)
FROM sales_storages
GROUP BY transaction_id
HAVING COUNT(transaction_id) >1;

SELECT transaction_id, COUNT(*) AS duplicate_count
FROM sales_storages
WHERE transaction_id IN ('TXN240646','TXN342128','TXN855235','TXN981773')
GROUP BY transaction_id
HAVING COUNT(*) > 1;


WITH cte AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY transaction_id ORDER BY transaction_id) AS row_num
  FROM sales_storages
)
SELECT *
FROM cte
WHERE row_num > 1;


WITH CTE AS (
SELECT *,
	ROW_NUMBER() OVER (PARTITION BY transaction_id ORDER BY transaction_id) AS Row_Num
FROM sales_storages
)
SELECT * FROM CTE
WHERE transaction_id IN ('TXN240646','TXN342128','TXN855235','TXN981773');

-- ** Delete dublicate **

SELECT *,
       ROW_NUMBER() OVER (PARTITION BY transaction_id ORDER BY transaction_id) AS row_num
FROM sales_storages;

WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY transaction_id ORDER BY transaction_id) AS row_num   
    FROM sales_storages
)
SELECT *
FROM cte
WHERE row_num = 2;

ALTER TABLE sales_storages                          
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY FIRST;

DELETE s
FROM sales_storages s
JOIN (
    SELECT id
    FROM (                                                                                
        SELECT id,
               ROW_NUMBER() OVER (PARTITION BY transaction_id ORDER BY transaction_id) AS row_num
        FROM sales_storages
    ) t
    WHERE row_num = 2
) dup
ON s.id = dup.id;

-- Step 2 :- Correction of Headers

select*from sales_storages;

ALTER TABLE sales_storages
CHANGE COLUMN quantiy quantity INT;

ALTER TABLE sales_storages
CHANGE COLUMN prce price FLOAT;

-- Step 3 :- To check Datatype

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='sales_storages';

-- Step 4 :- To Check Null Values 

-- to check null count

SELECT
    SUM(CASE WHEN transaction_id IS NULL THEN 1 ELSE 0 END) AS transaction_id_nulls,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS customer_id_nulls,
    SUM(CASE WHEN customer_name IS NULL THEN 1 ELSE 0 END) AS customer_name_nulls,
    SUM(CASE WHEN customer_age IS NULL THEN 1 ELSE 0 END) AS customer_age_nulls,
    SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS gender_nulls,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS product_id_nulls,
    SUM(CASE WHEN product_name IS NULL THEN 1 ELSE 0 END) AS product_name_nulls,       
    SUM(CASE WHEN product_category IS NULL THEN 1 ELSE 0 END) AS product_category_nulls,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS quantity_nulls,
    SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS price_nulls,
    SUM(CASE WHEN payment_mode IS NULL THEN 1 ELSE 0 END) AS payment_mode_nulls,
    SUM(CASE WHEN purchase_date IS NULL THEN 1 ELSE 0 END) AS purchase_date_nulls,
    SUM(CASE WHEN time_of_purchase IS NULL THEN 1 ELSE 0 END) AS time_of_purchase_nulls,
    SUM(CASE WHEN status IS NULL THEN 1 ELSE 0 END) AS status_nulls
FROM sales_storages;
-- or 

SELECT
    SUM(CASE WHEN transaction_id IS NULL OR transaction_id = '' THEN 1 ELSE 0 END) AS transaction_id_nulls,
    SUM(CASE WHEN customer_id IS NULL OR customer_id = '' THEN 1 ELSE 0 END) AS customer_id_nulls,
    SUM(CASE WHEN customer_name IS NULL OR customer_name = '' THEN 1 ELSE 0 END) AS customer_name_nulls,
    SUM(CASE WHEN customer_age IS NULL THEN 1 ELSE 0 END) AS customer_age_nulls,
    SUM(CASE WHEN gender IS NULL OR gender = '' THEN 1 ELSE 0 END) AS gender_nulls,
    SUM(CASE WHEN product_id IS NULL OR product_id = '' THEN 1 ELSE 0 END) AS product_id_nulls,
    SUM(CASE WHEN product_name IS NULL OR product_name = '' THEN 1 ELSE 0 END) AS product_name_nulls,       
    SUM(CASE WHEN product_category IS NULL OR product_category = '' THEN 1 ELSE 0 END) AS product_category_nulls,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS quantity_nulls,
    SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS price_nulls,
    SUM(CASE WHEN payment_mode IS NULL OR payment_mode = '' THEN 1 ELSE 0 END) AS payment_mode_nulls,
    SUM(CASE WHEN purchase_date IS NULL THEN 1 ELSE 0 END) AS purchase_date_nulls,
    SUM(CASE WHEN time_of_purchase IS NULL THEN 1 ELSE 0 END) AS time_of_purchase_nulls,
    SUM(CASE WHEN status IS NULL OR status = '' THEN 1 ELSE 0 END) AS status_nulls
FROM sales_storages;


-- treating null values 

SELECT *
FROM sales_storages
WHERE transaction_id IS NULL
OR
customer_id IS NULL
OR
customer_name IS NULL
OR
customer_age IS NULL
OR
gender IS NULL
OR
product_id IS NULL
OR
product_name IS NULL
OR
product_category IS NULL
OR
quantity IS NULL
or
payment_mode is null
or
purchase_date is null
or 
status is null
or 
price is null;

DELETE FROM sales_storages
WHERE  transaction_id IS NULL;

SET SQL_SAFE_UPDATES = 0;

SELECT * FROM sales_storages
WHERE Customer_name='Ehsaan Ram';

UPDATE sales_storages
SET customer_id = 'CUST9494'
WHERE id = 204;  
-- or
UPDATE sales_storages
SET customer_id='CUST9494'     
WHERE transaction_id='TXN977900';

SELECT * FROM sales_storages
Where Customer_name='Damini Raju';

UPDATE sales_storages
SET customer_id = 'CUST1401'
WHERE id = 773;  
-- or 
UPDATE sales_storages
SET customer_id='CUST1401'   
WHERE transaction_id='TXN985663';


select*from sales_storages
Where Customer_id='CUST1003';

UPDATE sales_storages
SET customer_name='Mahika Saini',customer_age=35,gender='Male'
WHERE id=36;


SELECT * FROM sales_storages;

-- Step 5:- Data Cleaning
select*from sales_storages;

SELECT DISTINCT gender
FROM sales_storages;

SET SQL_SAFE_UPDATES = 0; 
 
UPDATE sales_storages
SET gender='M'
WHERE gender='Male';

UPDATE sales_storages
SET gender='F'
WHERE gender='Female';


SELECT DISTINCT payment_mode
FROM sales_storages;

UPDATE sales_storages
SET payment_mode='Credit Card'
WHERE payment_mode='CC';

commit;
---------------------------- -------------------------------------------------------------------------------
-- Data Analysis --

-- 1. What are the top 5 most selling products by quantity..?

select * from sales_storages;


SELECT DISTINCT status
from sales_storages;

SELECT  product_name, SUM(quantity) AS total_quantity_sold
FROM sales_storages
WHERE status='delivered'
GROUP BY product_name
ORDER BY total_quantity_sold DESC
limit 5;

-- Business Problem: We don't know which products are most in demand.

-- Business Impact: Helps prioritize stock and boost sales through targeted promotions.

-----------------------------------------------------------------------------------------------------------

-- 2. Which products are most frequently cancelled?

SELECT  product_name, COUNT(*) AS total_cancelled
FROM sales_storages
WHERE status='cancelled'
GROUP BY product_name
ORDER BY total_cancelled DESC
limit 5;

-- Business Problem: Frequent cancellations affect revenue and customer trust.

-- Business Impact: Identify poor-performing products to improve quality or remove from catalog.

-----------------------------------------------------------------------------------------------------------


-- 3. What time of the day has the highest number of purchases?

select * from sales_storages;
	
	SELECT 
		CASE 
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 0 AND 5 THEN 'NIGHT'
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 6 AND 11 THEN 'MORNING'
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 12 AND 17 THEN 'AFTERNOON'
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 18 AND 23 THEN 'EVENING'
		END AS time_of_day,
		COUNT(*) AS total_orders
	FROM sales_storages
	GROUP BY 
		CASE 
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 0 AND 5 THEN 'NIGHT'
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 6 AND 11 THEN 'MORNING'
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 12 AND 17 THEN 'AFTERNOON'
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 18 AND 23 THEN 'EVENING'
		END
ORDER BY total_orders DESC;

---------------------------------------------------------------------------------------------


SELECT 
    HOUR(time_of_purchase) AS Peak_time,
    COUNT(*) AS Total_orders
FROM sales_storages
GROUP BY HOUR(time_of_purchase)
ORDER BY Peak_time;

-- Business Problem Solved: Find peak sales times.

-- Business Impact: Optimize staffing, promotions, and server loads.
-----------------------------------------------------------------------------------------------------------

-- 4. Who are the top 5 highest spending customers?

SELECT * FROM sales_storages;

SELECT customer_name,
	FORMAT(SUM(price*quantity),'en-IN') AS total_spend
FROM sales_storages
GROUP BY customer_name
ORDER BY SUM(price*quantity) DESC
limit 5;

-- Business Problem Solved: Identify VIP customers.

-- Business Impact: Personalized offers, loyalty rewards, and retention.

-----------------------------------------------------------------------------------------------------------

-- 5. Which product categories generate the highest revenue?

SELECT * FROM sales_storages;

SELECT 
	product_category,
	FORMAT(SUM(price*quantity),'en-IN') AS Revenue
FROM sales_storages
GROUP BY product_category
ORDER BY SUM(price*quantity) DESC;

-- Business Problem Solved: Identify top-performing product categories.

-- Business Impact: Refine product strategy, supply chain, and promotions.
-- Following the business to invest more in high-margin or high-demand categories.

-----------------------------------------------------------------------------------------------------------

-- 6. What is the return/cancellation rate per product category?

SELECT * FROM sales_storages;

-- cancellation

SELECT 
    product_category,
    CONCAT(
        FORMAT(COUNT(CASE WHEN status='cancelled' THEN 1 END) * 100.0 / COUNT(*), 2),
        ' %'
    ) AS cancelled_percent
FROM sales_storages
GROUP BY product_category
ORDER BY (COUNT(CASE WHEN status='cancelled' THEN 1 END) * 100.0 / COUNT(*)) DESC;

-- Return

SELECT 
    product_category,
    CONCAT(
        FORMAT(COUNT(CASE WHEN status = 'returned' THEN 1 END) * 100.0 / COUNT(*), 2),
        ' %'
    ) AS returned_percent
FROM sales_storages
GROUP BY product_category
ORDER BY (COUNT(CASE WHEN status = 'returned' THEN 1 END) * 100.0 / COUNT(*)) DESC;

-- Business Problem Solved: Monitor dissatisfaction trends per category.


-- Business Impact: Reduce returns, improve product descriptions/expectations.
-- Helps identify and fix product or logistics issues.

-----------------------------------------------------------------------------------------------------------
-- 7. What is the most preferred payment mode?

SELECT * FROM sales_storages;

SELECT payment_mode, COUNT(payment_mode) AS total_count
FROM sales_storages
GROUP BY payment_mode
ORDER BY total_count desc;


-- Business Problem Solved: Know which payment options customers prefer.

-- Business Impact: Streamline payment processing, prioritize popular modes.

-----------------------------------------------------------------------------------------------------------

-- 8. How does age group affect purchasing behavior?

SELECT * FROM sales_storages;

-- SELECT MIN(customer_age) ,MAX(customer_age)
-- from sales_storages

SELECT 
	CASE	
		WHEN customer_age BETWEEN 18 AND 25 THEN '18-25'
		WHEN customer_age BETWEEN 26 AND 35 THEN '26-35'
		WHEN customer_age BETWEEN 36 AND 50 THEN '36-50'
		ELSE '51+'
	END AS customer_age,
	FORMAT(SUM(price*quantity),'C0','en-IN') AS total_purchase
FROM sales_storages
GROUP BY CASE	
		WHEN customer_age BETWEEN 18 AND 25 THEN '18-25'
		WHEN customer_age BETWEEN 26 AND 35 THEN '26-35'
		WHEN customer_age BETWEEN 36 AND 50 THEN '36-50'
		ELSE '51+'
	END
ORDER BY SUM(price*quantity) DESC;

-- Business Problem Solved: Understand customer demographics.

-- Business Impact: Targeted marketing and product recommendations by age group.

-----------------------------------------------------------------------------------------------------------
-- 9. What’s the monthly sales trend?

SELECT * FROM sales_storages;

-- Method 1

SELECT 
    DATE_FORMAT(purchase_date, '%Y-%m') AS Month_Year,
    FORMAT(SUM(price * quantity), 2) AS total_sales,
    SUM(quantity) AS total_quantity
FROM sales_storages
GROUP BY DATE_FORMAT(purchase_date, '%Y-%m')
ORDER BY Month_Year;

-- Method 2

SELECT * FROM sales_storages;

SELECT 
    YEAR(purchase_date) AS Years,
    MONTH(purchase_date) AS Months,
    SUM(price * quantity) AS total_sales,
    SUM(quantity) AS total_quantity
FROM sales_storages
GROUP BY YEAR(purchase_date), MONTH(purchase_date)
ORDER BY Years, Months;

-- 2023	1	₹ 46,28,608
-- 2024	1	₹ 3,39,442

SELECT(4628608+339442); -- = 4968050

-- Business Problem: Sales fluctuations go unnoticed.

-- Business Impact: Plan inventory and marketing according to seasonal trends.


-----------------------------------------------------------------------------------------------------------


-- 10. Are certain genders buying more specific product categories?

SELECT * from sales_storages;

-- Method 1

SELECT 
    gender,
    product_category,
    COUNT(product_category) AS total_purchase
FROM sales_storages
GROUP BY gender, product_category
ORDER BY gender;

-- Method 2

SELECT 
    product_category,
    COUNT(CASE WHEN gender = 'M' THEN 1 END) AS Male,
    COUNT(CASE WHEN gender = 'F' THEN 1 END) AS Female
FROM sales_storages
GROUP BY product_category
ORDER BY product_category;

-- Business Problem Solved: Gender-based product preferences.

-- Business Impact: Personalized ads, gender-focused campaigns.