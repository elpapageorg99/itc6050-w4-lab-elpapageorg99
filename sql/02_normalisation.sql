-- sql/02_normalisation.sql
CREATE SCHEMA IF NOT EXISTS bad;
SET search_path TO bad;

CREATE TABLE sales_record (
    sale_id BIGINT,
    sale_date DATE,
    customer_name VARCHAR(160),
    customer_email VARCHAR(255),
    customer_phones VARCHAR(255), -- 1NF violation: comma-separated! e.g. '555-1212,555-3434'
    customer_city VARCHAR(80),
    customer_country VARCHAR(60),
    product_name VARCHAR(120),
    product_category VARCHAR(60),
    product_price NUMERIC(10,2),
    quantity INT,
    line_total NUMERIC(10,2)
);

-- 4a: Violations
-- 1NF violation: customer_phones stores multiple values in one column (comma-separated)
-- Functional dependency 1: product_name -> product_category, product_price
--   breaks 3NF because these attributes depend on product_name, not on sale_id
-- Functional dependency 2: customer_email -> customer_name, customer_city, customer_country
--   breaks 3NF because these attributes depend on customer_email, not on sale_id
-- Update anomaly: if a product's price changes, we must update every row that
--   contains that product — missing one row leaves the data inconsistent

-- 4b: Decomposed 3NF schema
CREATE TABLE customer (
    customer_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(160) NOT NULL,
    city VARCHAR(80),
    country VARCHAR(60)
);

CREATE TABLE customer_phone (
    customer_id BIGINT NOT NULL REFERENCES customer ON DELETE CASCADE,
    phone VARCHAR(20) NOT NULL,
    PRIMARY KEY (customer_id, phone)
);

CREATE TABLE product (
    product_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    category VARCHAR(60) NOT NULL,
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0)
);

CREATE TABLE sale (
    sale_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id BIGINT NOT NULL REFERENCES customer ON DELETE RESTRICT,
    sale_date DATE NOT NULL
);

CREATE TABLE sale_item (
    sale_id BIGINT NOT NULL REFERENCES sale ON DELETE RESTRICT,
    product_id BIGINT NOT NULL REFERENCES product ON DELETE RESTRICT,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price_at_sale NUMERIC(10,2) NOT NULL CHECK (unit_price_at_sale >= 0),
    line_total NUMERIC(10,2) NOT NULL CHECK (line_total >= 0),
    PRIMARY KEY (sale_id, product_id)
);