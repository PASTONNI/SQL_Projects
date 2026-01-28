-- Creating a database novamart_analytics
CREATE DATABASE novamart_analytics;

-- creating schemas core and sales
CREATE SCHEMA core;
CREATE SCHEMA sales;

-- creating Tables in the core schema

CREATE TABLE core.customer(
customer_id TEXT PRIMARY KEY UNIQUE ,
first_name varchar(64)NOT NULL,
last_name varchar(64) NOT NULL
)

CREATE TABLE core.stores(
store_id TEXT UNIQUE,
store_location TEXT,
Country TEXT DEFAULT('United Kingdom')
)

DROP TABLE IF EXISTS core.products;

CREATE TABLE core.products(
product_id text UNIQUE,
product_name varchar(250) NOT NULL,
product_category varchar(250) NOT NULL
);

-- creating orders table in the core schema
CREATE TABLE sales.orders(
order_id SERIAL UNIQUE,
created_on DATE,
amount NUMERIC(18,2) NOT NULL CHECK (amount > 0),
quantity INT NOT NULL CHECK (quantity > 0)
)

-- inserting values into the individual tables
INSERT INTO core.customer(customer_id, first_name, last_name) 
Values 
('001', 'John', 'Doe'),
('002', 'Sadie', 'Sink'),
('003', 'Mike', 'Wazowski'),
('004', 'Lucas', 'Flynn'),
('005', 'Dustin', 'Harrignton');

INSERT INTO core.stores(store_id, store_location) VALUES
('01', 'London'),
('02', 'Birmingham'),
('03', 'Abeerdeen');

INSERT INTO core.products(product_id,product_name, product_category) VALUES
('1', 'Airpods', 'Accessories'),
('2', 'Charger', 'Accessories'),
('3', 'Samsung', 'Devices'),
('4', 'Apple', 'Devices'),
('5', 'Redmi', 'Devices'),
('6', 'Coffee', 'Beverages'),
('7', 'Milk', 'Beverages'),
('8', 'Milo', 'Beverages'),
('9', 'Chocolate', 'Beverages');


INSERT INTO sales.orders(created_on, amount, quantity) VALUES
('2026-01-02',  19.99, 1),
('2026-01-03', 120.50, 3),
('2026-01-04',  45.00, 2),
('2026-01-05', 999.99, 1),
('2026-01-06',  12.75, 5),
('2026-01-07', 250.00, 4),
('2026-01-08',  78.30, 2),
('2026-01-09',  33.33, 3),
('2026-01-10',  10.00, 1),
('2026-01-11', 560.40, 7);



-- Check the Tables for data

SELECT * 
FROM sales.orders;

SELECT * 
FROM core.customer;

SELECT * 
FROM core.stores;

SELECT * 
FROM core.products;
