-- Query to pull full customer list showing who has received invoices (included nulls), price/invoice amount, and details of car purchased
SELECT *
FROM customer
LEFT JOIN invoice
ON customer.customer_id = invoice.customer_id
LEFT JOIN dealer_car
ON invoice.dealer_id = dealer_car.dealer_id;


-- Query to pull customer list joined with c_car and service_ticket to see full list of service tickets/service history including full customer name and car_id
SELECT customer.customer_id, first_name,last_name,c_car.car_id,service_id,service_cost,status,ticket_date,mechanic_id,parts_id,service_type
FROM customer
LEFT JOIN c_car
ON customer.customer_id = c_car.customer_id
INNER JOIN service_ticket
ON c_car.car_id = service_ticket.car_id
ORDER BY customer_id;


-- Query to count how many service tickets each customer has
SELECT COUNT(customer.customer_id), first_name,last_name,c_car.car_id
FROM customer
LEFT JOIN c_car
ON customer.customer_id = c_car.customer_id
INNER JOIN service_ticket
ON c_car.car_id = service_ticket.car_id
GROUP BY customer.customer_id, last_name, first_name, c_car.car_id
ORDER BY customer.customer_id;


-- Query - How many service tickets has each mechanic worked on?
SELECT mechanic.mechanic_id, COUNT(mechanic.mechanic_id), first_name, last_name
FROM mechanic
LEFT JOIN service_ticket
ON mechanic.mechanic_id = service_ticket.mechanic_id
GROUP BY mechanic.mechanic_id;

