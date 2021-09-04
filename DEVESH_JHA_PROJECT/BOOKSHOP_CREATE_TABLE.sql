

-- DB_Name:- BookShop
CREATE DATABASE bookshop

USE bookshop;

CREATE TABLE author
  (
     NAME    VARCHAR(255),
          CONSTRAINT unique_name UNIQUE (NAME),
          address VARCHAR(255),
          CONSTRAINT unique_address UNIQUE (address),
     url     VARCHAR(255)
  );

CREATE TABLE publisher
  (
     NAME    VARCHAR(255),
          CONSTRAINT unique_pname UNIQUE (NAME),
     address VARCHAR(255),
     phone   VARCHAR(255),
     url     VARCHAR(255)
  );

CREATE TABLE book
  (
     isbn           VARCHAR(255),
     NAME           VARCHAR(255),
          CONSTRAINT unique_isbn UNIQUE (isbn),
          publisher_name VARCHAR(255)
          CONSTRAINT fk_book FOREIGN KEY (publisher_name) REFERENCES publisher(
     NAME),
          authorname     VARCHAR(255)
          CONSTRAINT fk_author FOREIGN KEY (authorname) REFERENCES author(NAME),
          authoradress   VARCHAR(255)
          CONSTRAINT fk_adress FOREIGN KEY (authoradress) REFERENCES author(
     address),
     year           INT,
     title          VARCHAR(255),
     price          NUMERIC(19, 0)
  );

CREATE TABLE warehouse
  (
     code   INT PRIMARY KEY IDENTITY (1, 1),
     phone  VARCHAR(255),
     adress VARCHAR(255)
  );

CREATE TABLE warehouse_book
  (
     warehouse_code INT
          CONSTRAINT fk_code FOREIGN KEY (warehouse_code) REFERENCES warehouse(
     code),
          bookisbn       VARCHAR(255)
          CONSTRAINT fk_bookisbn FOREIGN KEY (bookisbn) REFERENCES book(isbn),
     count          INT
  );

CREATE TABLE customer
  (
     email   VARCHAR(255),
          CONSTRAINT unique_email UNIQUE (email),
     NAME    VARCHAR(255),
     phone   VARCHAR(255),
     address VARCHAR(255)
  );

CREATE TABLE shoppingbasket
  (
     id            INT PRIMARY KEY IDENTITY (1, 1),
     customeremail VARCHAR(255)
     CONSTRAINT fk_customeremail FOREIGN KEY (customeremail) REFERENCES customer
     (email),
  );

CREATE TABLE shoppingbasket_book
  (
     shoppingbasket_id INT
          CONSTRAINT fk_shoppingbook FOREIGN KEY (shoppingbasket_id) REFERENCES
          shoppingbasket(id),
          bookisbn          VARCHAR(255)
          CONSTRAINT fk_bookbasket FOREIGN KEY (bookisbn) REFERENCES book(isbn),
     count             INT
  ); 