DB_Name:BikeStore




1.MS SQL Server Installation
2.SSMS Installation
3.Loading Sample Database Bike Stores-BikeStore
--------------Queries



-- -------Database Create
CREATE DATABASE bikestores 




-- -------SELECT 
SELECT  *
FROM sales.customers




---------OFFSET an FETCH
SELECT  *
FROM sales.customers
ORDER BY customer_id offset 5 rowsFETCH next 10 rows only

-- --------TOP
SELECT TOP 10 *
FROM   sales.customers
ORDER  BY customer_id DESC 




-- -------Using TOP to return a percentage of rows
SELECT  TOP 3 PERCENT *
FROM sales.customers;




-- ----Using TOP WITH TIES to include rows that match the values IN the last row
SELECT  TOP 3 WITH ties product_name
       ,list_price
FROM production.products
ORDER BY list_price DESC


-- --------SELECT  DISTINCT
SELECT  DISTINCT city
FROM sales.customers
ORDER BY city

-- ----------MUTIPLE COLUMN DISTINCT
SELECT  DISTINCT city
       ,state
FROM sales.customers
ORDER BY city, state
WHERE CLAUSE
SELECT  brand_name
FROM production.brands
WHERE brand_id = 5 


-- ---------CHECK IS NULL
SELECT first_name,
       last_name
FROM   sales.customers
WHERE  phone IS NULL; 



-- --------CHECK IS NOT NULL
SELECT  first_name
       ,last_name
FROM sales.customers
WHERE phone IS NOT NULL; 



-- -------AND
SELECT  *
FROM sales.customers
WHERE first_name = 'Wes'
AND phone IS NULL 



-- --------OR
SELECT  *
FROM sales.customers
WHERE first_name = 'Wes' OR phone IS NULL



-- --------BETWEEN
SELECT  product_id
       ,product_name
       ,list_price
FROM production.products
WHERE list_price BETWEEN 149.99 AND 199.99
ORDER BY list_price;




-- ------IN
SELECT  product_name
       ,list_price
FROM production.products
WHERE list_price IN (89.99, 109.99, 159.99)




-- ----------NOT IN
SELECT  product_name
       ,list_price
FROM production.products
WHERE list_price NOT IN (89.99, 109.99, 159.99)






-- ---------LIKE
SELECT from * sales.customers
WHERE  last_name LIKE '%a'




-- --------Alias USING AS
SELECT  first_name + ' ' + last_name AS full_name
FROM sales.customers



-- ---------JOINS




-----------INNER JOIN---------------
SELECT  product_name
       ,category_name
       ,list_price
FROM production.products p
INNER JOIN production.categories c
ON c.category_id = p.category_id





-----------LEFT JOIN/RIGHT OUTER JOIN---------------
SELECT  product_name
       ,order_id
FROM production.products p
LEFT JOIN sales.order_items o
ON o.product_id = p.product_id
SELECT  p.product_name
       ,o.order_id
       ,i.item_id
       ,o.order_date
FROM production.products p
LEFT JOIN sales.order_items i
ON i.product_id = p.product_id
LEFT JOIN sales.orders o
ON o.order_id = i.order_id





-------------RIGHT JOIN/RIGHT OUTER JOIN----------------
SELECT  product_name
       ,order_id
FROM sales.order_items o
RIGHT JOIN production.products p
ON o.product_id = p.product_id







-------------FULL JOIN/FULL OUTER JOIN----------
SELECT  m.name member
       ,p.title project
FROM pm.members m
FULL OUTER JOIN pm.projects p
ON p.id = m.project_id;





-------------CROSS JOIN-----------------
SELECT  *
FROM production.products
CROSS JOIN sales.stores



-- -----------GROUP BY
SELECT  Year (order_date)
FROM sales.orders
WHERE customer_id IN ( 1, 2 )
GROUP BY  Year (order_date)





-- ---------HAVING CLAUSE
SELECT  customer_id
       ,YEAR (order_date)
       ,COUNT (order_id) order_count
FROM sales.orders
GROUP BY  YEAR (order_date)
HAVING COUNT (order_id) >= 2




-- -------TOPIC_GROUPING SETS

SELECT  brand
       ,category
       ,SUM (sales) sales
FROM sales.sales_summary
GROUP BY
GROUPING SETS ( (brand, category), (brand), (category), () )







-- --------CUBE
SELECT  brand
       ,category
       ,SUM (sales) sales
FROM sales.sales_summary
GROUP BY  CUBE(brand,category);




-- ------ROLLUP
SELECT  brand
       ,category
       ,SUM (sales) sales
FROM sales.sales_summary
GROUP BY  ROLLUP(brand,category);





-- -------SUBQUERIES
SELECT  category_name
FROM production.categories
WHERE category_id IN ( SELECT category_id FROM production.products WHERE model_year = 2016); 




-----------------SUBQUERIES ON EMP TABLE
SELECT  NAME
FROM emp
WHERE salary = (
SELECT  MAX(salary)
FROM emp)
SELECT  NAME
FROM emp
WHERE id IN ( SELECT id FROM project) 





--   ---------CORELATED SUBQUERIES 
SELECT  product_name
       ,list_price
       ,category_id
FROM production.products p1
WHERE list_price IN ( SELECT MAX (p2.list_price) FROM production.products p2 WHERE p2.category_id = p1.category_id GROUP BY p2.category_id ) 




--   --------EXISTS 
SELECT  *
FROM sales.customers
WHERE EXISTS (
SELECT  NULL)




--  -------ANY  
SELECT  product_name
       ,list_price
FROM production.products
WHERE product_id = ANY (
SELECT  product_id
FROM sales.order_items
WHERE quantity >= 2 ) 



--  -------EXCEPT 
SELECT  product_id
FROM production.products EXCEPT
SELECT  product_id
FROM sales.order_items;





--   ----CTE (Common Table Expression)  
WITH cte_sales_amounts
(staff, sales, year
) AS (
SELECT  first_name + ' ' + last_name
       ,SUM(quantity * list_price * (1 - discount))
       ,YEAR(order_date)
FROM sales.orders o
INNER JOIN sales.order_items i
ON i.order_id = o.order_id
INNER JOIN sales.staffs s
ON s.staff_id = o.staff_id
GROUP BY  first_name + ' ' + last_name
         ,year(order_date) )
SELECT  staff
       ,sales
FROM cte_sales_amounts
WHERE year = 2018;





-- ---------RECURSIVE CTE
WITH cte_numbers
(n, weekday
) AS (
SELECT  0
       ,DATENAME(DW,0)
UNION ALL
SELECT  n + 1
       ,DATENAME(DW,n + 1)
FROM cte_numbers
WHERE n < 6 )
SELECT  weekday
FROM cte_numbers;






-- -------PIVOT 
SELECT  *
FROM
(
	SELECT  category_name
	       ,product_id
	FROM production.products p
	INNER JOIN production.categories c
	ON c.category_id = p.category_id
) t PIVOT( COUNT(product_id) FOR category_name IN ( [Children Bicycles], [Comfort Bicycles], [Cruisers Bicycles], [Cyclocross Bicycles], [Electric Bikes], [Mountain Bikes], [Road Bikes]) ) AS pivot_table;

