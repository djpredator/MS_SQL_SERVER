-- ------ VIEWS 
----------CREATE VIEWS
CREATE VIEW sales.product_info
AS
SELECT
    product_name, 
    brand_name, 
    list_price
FROM
    production.products p
INNER JOIN production.brands b 
        ON b.brand_id = p.brand_id;



------------RENAME VIEW
EXEC sp_rename @objname = 'sales.product_info', @newname = 'product_list';



------------DISPLAY VIEW
SELECT  *
FROM sales.product_info;



------------UPDATE VIEWS
DROP VIEW IF EXISTS sales.product_info



-----------DISPLAY SYSTEM VIEWS
SELECT *
FROM   sys.views 




-- --------CREATE INDEX
----------------CLUSTERED INDEX
CREATE CLUSTERED INDEX ix_parts_id
  ON production.parts (part_id); 

----------------NON-CLUSTERED INDEX
CREATE INDEX ix_customers_city
  ON sales.customers(city)

--------RENAME INDEX
EXEC sp_rename N'sales.customers.ix_customers_city', N'ix_cust_city' , N'INDEX';
------UNIQUE INDEX
SELECT  customer_id
       ,email
FROM sales.customers
WHERE email = 'caren.stephens@msn.com';

SELECT  email
       ,COUNT(email)
FROM sales.customers
GROUP BY  email
HAVING COUNT(email) > 1;

CREATE UNIQUE INDEX ix_cust_email
ON sales.customers(email);
----Multiple unique index

CREATE TABLE t1 ( a INT, b INT );

CREATE UNIQUE INDEX ix_uniq_ab
ON t1(a, b);

INSERT INTO t1(a, b) VALUES(1, 1);

INSERT INTO t1(a, b) VALUES(1, 2);

INSERT INTO t1(a, b) VALUES(1, 2); truncate TABLE t1



-----Disable Index ALTER INDEX ix_cust_city
ON sales.customers DISABLE;


----Disable all indexes ALTER INDEX ALL
ON sales.customers DISABLE;






-- -------TRIGGER CREATION
CREATE TRIGGER production.trg_product_audit

ON production.products AFTER INSERT,
DELETE AS BEGIN

SET NOCOUNT ON;

INSERT INTO production.product_audits( product_id, product_name, brand_id, category_id, model_year, list_price, updated_at, operation )
SELECT  i.product_id
       ,product_name
       ,brand_id
       ,category_id
       ,model_year
       ,i.list_price
       ,GETDATE()
       ,'INS'

FROM inserted i
UNION ALL
SELECT  d.product_id
       ,product_name
       ,brand_id
       ,category_id
       ,model_year
       ,d.list_price
       ,GETDATE()
       ,'DEL'
FROM deleted d; END



------------------DELETE TRIGGER-------------------
DROP TRIGGER IF EXISTS production.product_audits;






-- --------STORED PROCEDURES

-----CREATE  STORED PROCEDURES
CREATE PROCEDURE uspProductList AS BEGIN
SELECT  product_name
       ,list_price
FROM production.products
ORDER BY product_name; END;
-------EXECUTE STORED PROCEDURES
EXEC uspProductList;



---------CREATE PARAMETERIZED STORED PROCEDURES
CREATE PROCEDURE uspFindProducts(@min_list_price AS DECIMAL) AS BEGIN
SELECT  product_name
       ,list_price
FROM production.products
WHERE list_price >= @min_list_price
ORDER BY list_price; END;




-------EXECUTE PARAMETERIZED STORED PROCEDURES
EXEC uspFindProducts 100

--------------ALTER STORED PROCEDURES
ALTER PROCEDURE Uspfind(@a AS VARCHAR(100), @b AS VARCHAR(100)) AS BEGIN
SELECT  product_name
       ,list_price
FROM production.products
WHERE product_name IN ( @a, @b ) END EXEC uspFind @a ='Trek 820 - 2016', @b='Ritchey Timberwolf Frameset - 2016'//EXECUTE





-------------VARIABLES
DECLARE @CAT VARCHAR(MAX)

SET @CAT='Mountain Bikes'
SELECT  category
FROM sales.sales_summary
WHERE category=@CAT Alter PROC uspGetProductList( @model_year SMALLINT ) AS BEGIN DECLARE @product_list VARCHAR(MAX);

SET @product_list = '';

SELECT  @product_list = @product_list + product_name + CHAR(10)
FROM production.products
WHERE model_year = @model_year
ORDER BY product_name; PRINT @product_list; END; 





--------BEGIN END IF-----------
BEGIN
SELECT  product_id
       ,product_name
FROM production.products
WHERE list_price > 1000; IF @@ROWCOUNT = 0 PRINT 'No product WITH price greater than 100000 found'; END 