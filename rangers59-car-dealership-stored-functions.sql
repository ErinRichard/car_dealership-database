-- Stored Function to add New Customer 
CREATE OR REPLACE FUNCTION add_customer(
	_customer_id INTEGER,
	_first_name VARCHAR,
	_last_name VARCHAR,
	_billing_info VARCHAR,
	_address VARCHAR
)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO customer(customer_id,first_name,last_name,billing_info,address)
	VALUES(_customer_id, _first_name, _last_name, _billing_info,_address);
END;
$MAIN$
LANGUAGE plpgsql;


-- Populate customer table using add_customer Stored Function
SELECT add_customer(1,'Big','Bird','2222 2222 2222 2222 111 11/21','Sesame Street');

SELECT add_customer(2,'Barley','Lightfoot','5555 5555 5555 5555 999 12/22', '75 Mushroom Ave, New Mushroomton');

SELECT add_customer(3,'Didier','Lockwood','1234 5678 4321 8765 432 06/21', '555 Main St, Anywhere, IL');

SELECT add_customer(4,'Sally','Smith','9999 9999 9999 9999 777 07/22', 'Wildwood Lane, Denver, CO');

-- Verify that new customers have been added
SELECT *
FROM customer;



-- Stored Function to add new Salesperson
CREATE OR REPLACE FUNCTION add_salesperson(
	_sales_id INTEGER,
	_first_name VARCHAR,
	_last_name VARCHAR
)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO salesperson(sales_id,first_name,last_name)
	VALUES(_sales_id, _first_name, _last_name);
END;
$MAIN$
LANGUAGE plpgsql;


-- Populate salesperson table using add_saleperson Stored Function
SELECT add_salesperson(1,'Dale','Carnegie');

SELECT add_salesperson(2,'Zig','Ziglar');


-- Confirm sales_person entries
SELECT *
FROM salesperson;



-- Stored Function to add parts to Parts table
CREATE OR REPLACE FUNCTION add_parts(
	_parts_id INTEGER,
	_part_type VARCHAR,
	_part_cost NUMERIC
)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO parts(parts_id,part_type,part_cost)
	VALUES(_parts_id, _part_type, _part_cost);
END;
$MAIN$
LANGUAGE plpgsql;


-- Populate parts table using add_parts Stored Function
SELECT add_parts(10,'muffler',200.00);

SELECT add_parts(20,'spark plugs',100.00);

SELECT add_parts(30,'oil filter',5.00);

-- Confirm parts were added
SELECT*
FROM parts;



-- Stored Function to add mechanics to mechanics table
CREATE OR REPLACE FUNCTION add_mechanic(
	_mechanic_id INTEGER,
	_first_name VARCHAR,
	_last_name VARCHAR
)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO mechanic(mechanic_id,first_name,last_name)
	VALUES(_mechanic_id, _first_name, _last_name);
END;
$MAIN$
LANGUAGE plpgsql;


-- Populate mechanics table using add_mechanics Stored Function
SELECT add_mechanic(100,'Rosie','Riveter');

SELECT add_mechanic(200,'Orville','Wright');

SELECT add_mechanic(300,'Wilbur','Wright');

-- Confirm data in mechanic table
SELECT*
FROM mechanic;



-- Stored Function to add vehicle to dealer_car table
CREATE OR REPLACE FUNCTION add_vehicle(
	_dealer_id INTEGER,
	_make VARCHAR,
	_model VARCHAR,
	_car_year INTEGER,
	_color VARCHAR,
	_price NUMERIC,
	_status VARCHAR
)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO dealer_car(dealer_id, make, model, car_year, color, price, status)
	VALUES(_dealer_id, _make, _model, _car_year, _color, _price, _status);
END;
$MAIN$
LANGUAGE plpgsql;


-- Populate dealer_car table using add_vehicle Stored Function
SELECT add_vehicle(1000,'Honda','Accord',2021,'blue',17500.00,'new');

SELECT add_vehicle(1100,'Honda','Accord',2021,'red',19000.00,'new');

SELECT add_vehicle(2100,'Honda','CR-V',2018,'white',15000.00,'used');

SELECT add_vehicle(2200,'Ford','Fusion',2015,'black',13500.00,'used');


-- change the status for each vehicle from 'new' or 'used' to 'sold' or 'available'
UPDATE dealer_car
SET status = 'sold'
WHERE dealer_id = 1100;

UPDATE dealer_car
SET status = 'available'
WHERE dealer_id != 1100;

-- Confirm data in dealer_car table
SELECT *
FROM dealer_car;



-- Stored Function to add new customer car to c_car table
CREATE OR REPLACE FUNCTION add_customer_car(
	_car_id INTEGER,
	_make VARCHAR,
	_model VARCHAR,
	_c_caryear INTEGER,
	_color VARCHAR,
	_mileage INTEGER,
	_customer_id INTEGER
)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO c_car(car_id, make, model, c_caryear, color, mileage, customer_id)
	VALUES(_car_id, _make, _model, _c_caryear, _color, _mileage, _customer_id);
END;
$MAIN$
LANGUAGE plpgsql;


-- Populate c_car table using add_customer_car Stored Function
SELECT add_customer_car(5000,'Volkswagen','Beetle',1970,'yellow',200000,1);

SELECT add_customer_car(6000,'Chevrolet','Astro',1970,'blue',300000,2);

SELECT add_customer_car(1100,'Honda','Accord',2021,'red',250,4);


-- Change the car_id for customer_id 2 from 6000 to 5001
UPDATE c_car
SET car_id = 5001
WHERE customer_id = 2;

-- Confirm data in c_car table
SELECT *
FROM c_car;




-- Stored Function to add new service ticket to service_ticket table
CREATE OR REPLACE FUNCTION add_service_ticket(
	_service_id INTEGER,
	_service_type VARCHAR,
	_service_cost NUMERIC,
	_status VARCHAR,
	_car_id INTEGER,
	_mechanic_id INTEGER,
	_parts_id INTEGER,
	_ticket_date DATE DEFAULT CURRENT_DATE
)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO service_ticket(service_id, service_type, service_cost, status, ticket_date, car_id, mechanic_id, parts_id)
	VALUES(_service_id, _service_type, _service_cost, _status, _ticket_date, _car_id, _mechanic_id, _parts_id);
END;
$MAIN$
LANGUAGE plpgsql;


-- Populate service_ticket table using add_service_ticket Stored Function
SELECT add_service_ticket(3000,'replace muffler',300.00,'complete',5000,100,10);

SELECT add_service_ticket(3001,'replace spark plugs',200.00,'scheduled',5001,200,20);

SELECT add_service_ticket(3002,'oil change',20.00,'scheduled',5000,300,NULL);

SELECT add_service_ticket(3003,'clean fuel injector nozzle',75.00,'scheduled',5000,100,NULL);

SELECT add_service_ticket(3004,'tire roation',50.00,'completed',1100,300,NULL);


-- Update part_id on one record
UPDATE service_ticket
SET parts_id = 30
WHERE service_id = 3002 AND car_id = 5000;


-- Confirm data in service_ticket table
SELECT *
FROM service_ticket;



-- Stored Function to add new invoice to invoice table
CREATE OR REPLACE FUNCTION add_invoice(
	_invoice_id INTEGER,
	_sales_id INTEGER,
	_dealer_id INTEGER,
	_customer_id INTEGER,
	_invoice_date DATE DEFAULT CURRENT_DATE
)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO invoice(invoice_id, sales_id, dealer_id, customer_id, invoice_date)
	VALUES(_invoice_id, _sales_id, _dealer_id, _customer_id, _invoice_date);
END;
$MAIN$
LANGUAGE plpgsql;


-- Populate invoice table using add_invoice Stored Function
SELECT add_invoice(9000,1,2100,3);

SELECT add_invoice(9001,1,1100,4);

-- Confirm data in invoice table
SELECT *
FROM invoice;




-- Check data in each table
SELECT *
FROM salesperson;

SELECT *
FROM customer;

SELECT *
FROM c_car;

SELECT *
FROM service_ticket;

SELECT *
FROM mechanic;

SELECT *
FROM parts;

SELECT *
FROM dealer_car;

Select *
FROM invoice;

