use interstellar;
DROP TABLE IF EXISTS 	retail_sales_table;
create table retail_sales_table(
transactions_id INT,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(15),
age INT,
category VARCHAR(15),
quantity INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);
select count(*) from retail_sales_analysis_new;
-- DATA WRANGLING
select*from retail_sales_analysis_new
WHERE 
ï»¿transactions_id is NULL
OR
sale_date is NULL
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or 
category is null
or
quantity is null
or 
price_per_unit is null
or
cogs is null
or
total_sale is null;
-- DATA EXPLORATION
-- What is the total sales achieved?
SELECT COUNT(*) AS total_sale from retail_sales_analysis_new;
-- How many unique customers we have?
SELECT COUNT(DISTINCT customer_id) as total_sale from retail_sales_analysis_new;
-- How many catgories are there?

-- DATA ANALYSIS & BUSINESS KEY PROBLEMS & SOLUTIONS
-- Q1.Write an SQL query to retrieve all columns for sales made on '2022-11-05'
select*from retail_sales_analysis_new
where sale_date = '2022-11-05';
-- Q2.Write an SQL query to retrieve all transactions where the category is 'clothing' 
-- and the quantity sold is more than 1 in the month of Nov-2022.
select * from retail_sales_analysis_new
where 
      category='Clothing'
      and 
      quantity>1
      and 
      date_format(sale_date,'%Y-%m')='2022-11';
 -- Q3.Write an SQL query to calculate total_sale for each category
 select sum(total_sale),category
 from retail_sales_analysis_new
 group by category;
 -- Q4.Write an SQL query to calculate average age of customers who purchased items from the 'beauty' category
 select avg(age),category
 from retail_sales_analysis_new
 where category='beauty'
 group by category;
 -- Q5.Write an SQL query to find all transactions where total sale is > 1000
 select *  from retail_sales_analysis_new
 where total_sale>1000;
 -- Q6.Write an SQL query to find the total number of transactions(transaction_id) made by each gender in each category
 select category,gender,count(ï»¿transactions_id) as total_transactions
 from retail_sales_analysis_new
 group by category,gender
 order by category;
  -- Q7.Write an SQL query to calculate the avg sale for each month.Find out best selling month in each year
  SELECT* FROM
  (
  
         SELECT year(sale_date) as year_name,month(sale_date) as monthname,
             avg(total_sale),
             rank() over(partition by year(sale_date) order by avg(total_sale) desc) as Rank_number
		from retail_sales_analysis_new
		group by year_name,monthname
 ) as t1
 where Rank_number = 1;

-- Q8.Write an SQL query to find the top 5 customers based on the highest total sales.

         SELECT 
               customer_id,sum(total_sale) as Total_sales
			   from retail_sales_analysis_new
               group by customer_id
               order by Total_sales desc
               limit 5;
               
-- Q9.Write an SQL query to find the number of unique customers who purchased items from each category.
select category,COUNT(DISTINCT(customer_id))
FROM retail_sales_analysis_new
GROUP BY category;
-- END OF PROJECT