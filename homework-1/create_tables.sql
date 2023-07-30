CREATE TABLE employees
(
	employee_id smallint PRIMARY KEY,
	first_name varchar(255) NOT NULL,
	last_name varchar(255) NOT NULL,
	title varchar(255) NOT NULL,
	birt_date date,
	notes text
);

CREATE TABLE customers
(
	customer_id char(5) PRIMARY KEY,
	company_name varchar(255) NOT NULL,
	contract_name varchar(255) NOT NULL
);

CREATE TABLE orders
(
	order_id int PRIMARY KEY,
	customer_id char(5) REFERENCES customers(customer_id) NOT NULL,
	employee_id smallint REFERENCES employees(employee_id) NOT NULL,
	order_date date,
	ship_city varchar(255) NOT NULL
)
