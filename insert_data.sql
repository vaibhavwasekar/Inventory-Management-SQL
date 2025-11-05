ALTER TABLE countries DISABLE CONSTRAINT fk_countries_regions;

ALTER TABLE locations DISABLE CONSTRAINT fk_locations_countries;

-- Disable warehouse_locations FK
ALTER TABLE warehouses DISABLE CONSTRAINT fk_warehouse_locations;

-- Disable employees_manager FK
ALTER TABLE employees DISABLE CONSTRAINT fk_employees_manager;

-- Disable product_categories FK
ALTER TABLE products DISABLE CONSTRAINT fk_product_categories;

-- Disable contacts_customers FK
ALTER TABLE contacts DISABLE CONSTRAINT fk_contacts_customers;

-- Disable orders_customers FK
ALTER TABLE orders DISABLE CONSTRAINT fk_orders_customers;

-- Disable orders_employees FK
ALTER TABLE orders DISABLE CONSTRAINT fk_orders_employees;

-- Disable order_items FK constraints
ALTER TABLE order_items DISABLE CONSTRAINT fk_orders_items_products;
ALTER TABLE order_items DISABLE CONSTRAINT fk_orders_items_orders;

-- Disable inventories FK constraints
ALTER TABLE inventories DISABLE CONSTRAINT fk_inventories_products;
ALTER TABLE inventories DISABLE CONSTRAINT fk_inventories_warehouses;


--------------------
set define off;

INSERT INTO regions(region_id, region_name) VALUES (1, 'North America');

INSERT INTO regions(region_id, region_name) VALUES (2, 'Europe');  

INSERT INTO regions(region_id, region_name) VALUES (3, 'Asia');
----------
set define off;
INSERT INTO countries(country_id, country_name, region_id) VALUES ('US', 'United States of America', 1);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('CA', 'Canada', 1);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('MX', 'Mexico', 1);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('UK', 'United Kingdom', 2);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('FR', 'France', 2);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('DE', 'Germany', 2);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('IN', 'India', 3);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('CN', 'China', 3);
INSERT INTO countries(country_id, country_name, region_id) VALUES ('JP', 'Japan', 3);
----------------
set define off;
INSERT INTO locations(location_id, address, postal_code, city, state, country_id) VALUES (1, '123 Main Street', '10001', 'New York', 'NY', 'US');
INSERT INTO locations(location_id, address, postal_code, city, state, country_id) VALUES (2, '456 Oak Avenue', 'M5H 2N2', 'Toronto', 'Ontario', 'CA');
INSERT INTO locations(location_id, address, postal_code, city, state, country_id) VALUES (3, '789 Pine Road', '11000', 'Mexico City', 'CDMX', 'MX');
INSERT INTO locations(location_id, address, postal_code, city, state, country_id) VALUES (4, '321 Baker Street', 'W1U 6BE', 'London', 'England', 'UK');
INSERT INTO locations(location_id, address, postal_code, city, state, country_id) VALUES (5, '654 Champs-Élysées', '75008', 'Paris', 'Île-de-France', 'FR');
INSERT INTO locations(location_id, address, postal_code, city, state, country_id) VALUES (6, '987 Brandenburg Str', '10117', 'Berlin', 'Berlin', 'DE');
INSERT INTO locations(location_id, address, postal_code, city, state, country_id) VALUES (7, '159 Connaught Place', '110001', 'New Delhi', 'Delhi', 'IN');
INSERT INTO locations(location_id, address, postal_code, city, state, country_id) VALUES (8, '753 Wangfujing Street', '100006', 'Beijing', 'Beijing', 'CN');
INSERT INTO locations(location_id, address, postal_code, city, state, country_id) VALUES (9, '486 Shibuya Crossing', '150-0043', 'Tokyo', 'Tokyo', 'JP');
-------------------

set define off;
INSERT INTO warehouses(warehouse_id, warehouse_name, location_id) VALUES (1, 'New York Main Warehouse', 1);
INSERT INTO warehouses(warehouse_id, warehouse_name, location_id) VALUES (2, 'Toronto Storage Center', 2);
INSERT INTO warehouses(warehouse_id, warehouse_name, location_id) VALUES (3, 'Mexico City Distribution', 3);
INSERT INTO warehouses(warehouse_id, warehouse_name, location_id) VALUES (4, 'London UK Warehouse', 4);
INSERT INTO warehouses(warehouse_id, warehouse_name, location_id) VALUES (5, 'Paris EU Hub', 5);
INSERT INTO warehouses(warehouse_id, warehouse_name, location_id) VALUES (6, 'Berlin Central Storage', 6);
INSERT INTO warehouses(warehouse_id, warehouse_name, location_id) VALUES (7, 'Delhi India Warehouse', 7);
INSERT INTO warehouses(warehouse_id, warehouse_name, location_id) VALUES (8, 'Beijing China Center', 8);
INSERT INTO warehouses(warehouse_id, warehouse_name, location_id) VALUES (9, 'Tokyo Japan Facility', 9);
----------

set define off;
INSERT INTO employees(employee_id, first_name, last_name, email, phone, hire_date, manager_id, job_title) VALUES (1, 'John', 'Smith', 'john.smith@email.com', '1234567890', TO_DATE('2020-01-15', 'YYYY-MM-DD'), NULL, 'President');
INSERT INTO employees(employee_id, first_name, last_name, email, phone, hire_date, manager_id, job_title) VALUES (2, 'Sarah', 'Johnson', 'sarah.j@email.com', '2345678901', TO_DATE('2020-03-20', 'YYYY-MM-DD'), 1, 'Director');
INSERT INTO employees(employee_id, first_name, last_name, email, phone, hire_date, manager_id, job_title) VALUES (3, 'Michael', 'Brown', 'michael.b@email.com', '3456789012', TO_DATE('2021-02-10', 'YYYY-MM-DD'), 2, 'Manager');
INSERT INTO employees(employee_id, first_name, last_name, email, phone, hire_date, manager_id, job_title) VALUES (4, 'Emily', 'Davis', 'emily.d@email.com', '4567890123', TO_DATE('2021-06-15', 'YYYY-MM-DD'), 3, 'Salesman');
INSERT INTO employees(employee_id, first_name, last_name, email, phone, hire_date, manager_id, job_title) VALUES (5, 'David', 'Wilson', 'david.w@email.com', '5678901234', TO_DATE('2021-08-22', 'YYYY-MM-DD'), 3, 'Salesman');
INSERT INTO employees(employee_id, first_name, last_name, email, phone, hire_date, manager_id, job_title) VALUES (6, 'Jennifer', 'Miller', 'jennifer.m@email.com', '6789012345', TO_DATE('2022-01-30', 'YYYY-MM-DD'), 3, 'Salesman');
INSERT INTO employees(employee_id, first_name, last_name, email, phone, hire_date, manager_id, job_title) VALUES (7, 'Robert', 'Taylor', 'robert.t@email.com', '7890123456', TO_DATE('2022-04-18', 'YYYY-MM-DD'), 2, 'Manager');
INSERT INTO employees(employee_id, first_name, last_name, email, phone, hire_date, manager_id, job_title) VALUES (8, 'Lisa', 'Anderson', 'lisa.a@email.com', '8901234567', TO_DATE('2022-07-05', 'YYYY-MM-DD'), 7, 'Salesman');
INSERT INTO employees(employee_id, first_name, last_name, email, phone, hire_date, manager_id, job_title) VALUES (9, 'James', 'Thomas', 'james.t@email.com', '9012345678', TO_DATE('2023-03-12', 'YYYY-MM-DD'), 7, 'Salesman');

--------------------------
set define off;
INSERT INTO product_categories(category_id, category_name) VALUES (1, 'Electronics');
INSERT INTO product_categories(category_id, category_name) VALUES (2, 'Clothing');
INSERT INTO product_categories(category_id, category_name) VALUES (3, 'Home Appliances');
INSERT INTO product_categories(category_id, category_name) VALUES (4, 'Books');
INSERT INTO product_categories(category_id, category_name) VALUES (5, 'Sports Equipment');
INSERT INTO product_categories(category_id, category_name) VALUES (6, 'Furniture');
INSERT INTO product_categories(category_id, category_name) VALUES (7, 'Toys');
INSERT INTO product_categories(category_id, category_name) VALUES (8, 'Beauty Products');
INSERT INTO product_categories(category_id, category_name) VALUES (9, 'Automotive');
----------------------
set define off;
INSERT INTO products(product_id, product_name, description, standard_cost, list_price, category_id) VALUES (1, 'Smartphone X', 'Latest smartphone with advanced features', 450.00, 699.99, 1);
INSERT INTO products(product_id, product_name, description, standard_cost, list_price, category_id) VALUES (2, 'Laptop Pro', 'High-performance laptop for professionals', 800.00, 1299.99, 1);
INSERT INTO products(product_id, product_name, description, standard_cost, list_price, category_id) VALUES (3, 'Wireless Earbuds', 'Noise cancelling wireless earbuds', 75.00, 149.99, 1);
INSERT INTO products(product_id, product_name, description, standard_cost, list_price, category_id) VALUES (4, 'Cotton T-Shirt', '100% cotton comfortable t-shirt', 8.00, 19.99, 2);
INSERT INTO products(product_id, product_name, description, standard_cost, list_price, category_id) VALUES (5, 'Denim Jeans', 'Classic blue denim jeans', 25.00, 59.99, 2);
INSERT INTO products(product_id, product_name, description, standard_cost, list_price, category_id) VALUES (6, 'Winter Jacket', 'Warm waterproof winter jacket', 45.00, 99.99, 2);
INSERT INTO products(product_id, product_name, description, standard_cost, list_price, category_id) VALUES (7, 'Blender', 'High-speed kitchen blender', 35.00, 79.99, 3);
INSERT INTO products(product_id, product_name, description, standard_cost, list_price, category_id) VALUES (8, 'Microwave Oven', 'Digital microwave with multiple settings', 80.00, 149.99, 3);
INSERT INTO products(product_id, product_name, description, standard_cost, list_price, category_id) VALUES (9, 'Vacuum Cleaner', 'Powerful bagless vacuum cleaner', 90.00, 179.99, 3);
--------------------
set define off;
INSERT INTO inventories(product_id, warehouse_id, quantity) VALUES (1, 1, 150);
INSERT INTO inventories(product_id, warehouse_id, quantity) VALUES (2, 1, 75);
INSERT INTO inventories(product_id, warehouse_id, quantity) VALUES (3, 1, 200);
INSERT INTO inventories(product_id, warehouse_id, quantity) VALUES (4, 2, 300);
INSERT INTO inventories(product_id, warehouse_id, quantity) VALUES (5, 2, 250);
INSERT INTO inventories(product_id, warehouse_id, quantity) VALUES (6, 2, 100);
INSERT INTO inventories(product_id, warehouse_id, quantity) VALUES (7, 3, 180);
INSERT INTO inventories(product_id, warehouse_id, quantity) VALUES (8, 3, 90);
INSERT INTO inventories(product_id, warehouse_id, quantity) VALUES (9, 3, 120);
-------------
set define off;
INSERT INTO customers(customer_id, name, address, website, credit_limit) VALUES (1, 'Tech Solutions Inc', '123 Business Park Dr', 'www.techsolutions.com', 50000.00);
INSERT INTO customers(customer_id, name, address, website, credit_limit) VALUES (2, 'Global Retail Corp', '456 Commerce Ave', 'www.globalretail.com', 75000.00);
INSERT INTO customers(customer_id, name, address, website, credit_limit) VALUES (3, 'Premium Services Ltd', '789 Corporate Blvd', 'www.premiumservices.com', 30000.00);
INSERT INTO customers(customer_id, name, address, website, credit_limit) VALUES (4, 'Elite Distributors', '321 Trade Center Rd', 'www.elitedist.com', 60000.00);
INSERT INTO customers(customer_id, name, address, website, credit_limit) VALUES (5, 'Prime Suppliers Co', '654 Industrial Way', 'www.primesuppliers.com', 45000.00);
INSERT INTO customers(customer_id, name, address, website, credit_limit) VALUES (6, 'Quality Merchants', '987 Market Street', 'www.qualitymerch.com', 35000.00);
INSERT INTO customers(customer_id, name, address, website, credit_limit) VALUES (7, 'Superior Goods LLC', '159 Retail Plaza', 'www.superiorgoods.com', 40000.00);
INSERT INTO customers(customer_id, name, address, website, credit_limit) VALUES (8, 'First Choice Trading', '753 Wholesale Dr', 'www.firstchoicetrade.com', 55000.00);
INSERT INTO customers(customer_id, name, address, website, credit_limit) VALUES (9, 'Apex Business Group', '486 Enterprise Ave', 'www.apexbusiness.com', 65000.00);
--------
set define off;
INSERT INTO contacts(contact_id, first_name, last_name, email, phone, customer_id) VALUES (1001, 'James', 'Wilson', 'jwilson@tech.com', '1112223333', 1);
INSERT INTO contacts(contact_id, first_name, last_name, email, phone, customer_id) VALUES (1002, 'Patricia', 'Moore', 'pmoore@tech.com', '1112223334', 1);
INSERT INTO contacts(contact_id, first_name, last_name, email, phone, customer_id) VALUES (1003, 'Robert', 'Taylor', 'rtaylor@global.com', '2223334444', 2);
INSERT INTO contacts(contact_id, first_name, last_name, email, phone, customer_id) VALUES (1004, 'Linda', 'Anderson', 'landerson@global.com', '2223334445', 2);
INSERT INTO contacts(contact_id, first_name, last_name, email, phone, customer_id) VALUES (1005, 'Michael', 'Thomas', 'mthomas@premium.com', '3334445555', 3);
INSERT INTO contacts(contact_id, first_name, last_name, email, phone, customer_id) VALUES (1006, 'Barbara', 'Jackson', 'bjackson@premium.com', '3334445556', 3);
INSERT INTO contacts(contact_id, first_name, last_name, email, phone, customer_id) VALUES (1007, 'William', 'White', 'wwhite@elite.com', '4445556666', 4);
INSERT INTO contacts(contact_id, first_name, last_name, email, phone, customer_id) VALUES (1008, 'Elizabeth', 'Harris', 'eharris@elite.com', '4445556667', 4);
INSERT INTO contacts(contact_id, first_name, last_name, email, phone, customer_id) VALUES (1009, 'David', 'Martin', 'dmartin@prime.com', '5556667777', 5);
----------
set define off;
INSERT INTO orders(order_id, customer_id, status, salesman_id, order_date) VALUES (1001, 1, 'Shipped', 4, TO_DATE('2024-01-15', 'YYYY-MM-DD'));
INSERT INTO orders(order_id, customer_id, status, salesman_id, order_date) VALUES (1002, 2, 'Pending', 5, TO_DATE('2024-01-18', 'YYYY-MM-DD'));
INSERT INTO orders(order_id, customer_id, status, salesman_id, order_date) VALUES (1003, 3, 'Delivered', 6, TO_DATE('2024-01-20', 'YYYY-MM-DD'));
INSERT INTO orders(order_id, customer_id, status, salesman_id, order_date) VALUES (1004, 4, 'Shipped', 8, TO_DATE('2024-01-22', 'YYYY-MM-DD'));
INSERT INTO orders(order_id, customer_id, status, salesman_id, order_date) VALUES (1005, 5, 'Pending', 9, TO_DATE('2024-01-25', 'YYYY-MM-DD'));
INSERT INTO orders(order_id, customer_id, status, salesman_id, order_date) VALUES (1006, 6, 'Delivered', 4, TO_DATE('2024-01-28', 'YYYY-MM-DD'));
INSERT INTO orders(order_id, customer_id, status, salesman_id, order_date) VALUES (1007, 7, 'Shipped', 5, TO_DATE('2024-02-01', 'YYYY-MM-DD'));
INSERT INTO orders(order_id, customer_id, status, salesman_id, order_date) VALUES (1008, 8, 'Pending', 6, TO_DATE('2024-02-05', 'YYYY-MM-DD'));
INSERT INTO orders(order_id, customer_id, status, salesman_id, order_date) VALUES (1009, 9, 'Delivered', 8, TO_DATE('2024-02-10', 'YYYY-MM-DD'));
---------
set define off;
INSERT INTO order_items(order_id, item_id, product_id, quantity, unit_price) VALUES (1001, 1, 1, 2, 699.99);
INSERT INTO order_items(order_id, item_id, product_id, quantity, unit_price) VALUES (1001, 2, 3, 1, 149.99);
INSERT INTO order_items(order_id, item_id, product_id, quantity, unit_price) VALUES (1002, 1, 2, 1, 1299.99);
INSERT INTO order_items(order_id, item_id, product_id, quantity, unit_price) VALUES (1003, 1, 4, 5, 19.99);
INSERT INTO order_items(order_id, item_id, product_id, quantity, unit_price) VALUES (1003, 2, 5, 3, 59.99);
INSERT INTO order_items(order_id, item_id, product_id, quantity, unit_price) VALUES (1004, 1, 6, 2, 99.99);
INSERT INTO order_items(order_id, item_id, product_id, quantity, unit_price) VALUES (1005, 1, 7, 1, 79.99);
INSERT INTO order_items(order_id, item_id, product_id, quantity, unit_price) VALUES (1005, 2, 8, 1, 149.99);
INSERT INTO order_items(order_id, item_id, product_id, quantity, unit_price) VALUES (1006, 1, 9, 1, 179.99);
----------
