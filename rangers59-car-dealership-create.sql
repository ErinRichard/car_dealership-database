-- Create Tables for car_dealership Database --
CREATE TABLE customer (
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	billing_info VARCHAR(150),
	address VARCHAR(150)
);


CREATE TABLE dealer_car (
	dealer_id SERIAL PRIMARY KEY,
	make VARCHAR(100),
	model VARCHAR(100),
	car_year INTEGER,
	color VARCHAR(100),
	price NUMERIC(8,2),
	status VARCHAR(15)
);


CREATE TABLE "salesperson" (
	sales_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);


CREATE TABLE mechanic (
  mechanic_id SERIAL PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100)
);


CREATE TABLE parts (
  parts_id SERIAL PRIMARY KEY,
  part_type VARCHAR(150),
  part_cost NUMERIC(6,2)
);


CREATE TABLE invoice (
	invoice_id SERIAL PRIMARY KEY,
	date DATE DEFAULT CURRENT_DATE,
	sales_id INTEGER NOT NULL,
	dealer_id INTEGER NOT NULL,
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(sales_id) REFERENCES salesperson(sales_id),
	FOREIGN KEY(dealer_id) REFERENCES dealer_car(dealer_id),
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);


ALTER TABLE invoice
RENAME COLUMN date TO invoice_date;

SELECT *
FROM invoice;


CREATE TABLE c_car (
	car_id SERIAL PRIMARY KEY,
	make VARCHAR(100),
	model VARCHAR(100),
	c_caryear INTEGER,
	color VARCHAR(100),
	mileage INTEGER,
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);


CREATE TABLE service_ticket (
	service_id SERIAL PRIMARY KEY,
	service_cost NUMERIC(6,2),
	status VARCHAR(100),
	ticket_date DATE DEFAULT CURRENT_DATE,
	car_id INTEGER,
	mechanic_id INTEGER NOT NULL,
	parts_id INTEGER NOT NULL,
	FOREIGN KEY(car_id) REFERENCES c_car(car_id),
	FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id),
	FOREIGN KEY(parts_id) REFERENCES parts(parts_id)
);

-- Add additional column to service_ticket table
ALTER TABLE service_ticket
ADD service_type VARCHAR(100);

-- Confirm column add
SELECT *
FROM service_ticket;

-- DROP NOT NULL requirement from service_ticket table, parts_id column (not every service ticket will include a part)
ALTER TABLE service_ticket
ALTER COLUMN parts_id
DROP NOT NULL;





