CREATE VIEW book_data AS
SELECT *
FROM   book;SELECT *
FROM   book;SELECT *
FROM   author;DROP VIEW book_data
---create view Book_info as select b.name,a.name  from Book b inner join Author a on b.AuthorName =a.name;CREATE VIEW author_data AS
SELECT *
FROM   author;SELECT     b.NAME,
           a.NAME
FROM       book_data b
INNER JOIN author_data a
ON         b.authorname =a.NAME;CREATE VIEW viewalldetails AS
SELECT b.isbn,
       b.NAME ,
       a.url
FROM   book b
JOIN   author a
ON     b.authorname = a.NAME
select *
FROM   viewalldetails;