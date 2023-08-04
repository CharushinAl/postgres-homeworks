-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
SELECT c.company_name as customer, CONCAT(e.last_name, ' ',e.first_name) as employee
FROM orders o
	JOIN employees e using(employee_id)
	JOIN customers  c using(customer_id)
	JOIN shippers s on o.ship_via = s.shipper_id
WHERE c.city = 'London' AND e.city = 'London' AND s.company_name = 'United Package'

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
SELECT product_name, p.units_in_stock, s.contact_name, s.phone
FROM products p
	JOIN suppliers s ON p.supplier_id = s.supplier_id
	JOIN categories c ON p.category_id = c.category_id
WHERE p.discontinued = 0 AND p.units_in_stock < 25
AND c.category_name IN ('Dairy Products', 'Condiments')
ORDER BY p.units_in_stock ASC

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
SELECT company_name
FROM customers c
	LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
SELECT DISTINCT p.product_name
FROM order_details o_d
	JOIN products p ON o_d.product_id = p.product_id
WHERE o_d.quantity = 10

# порядок выдачи не соответствует скриншоту
SELECT DISTINCT product_name FROM products
WHERE EXISTS(SELECT * FROM order_details WHERE order_details.product_id = products.product_id
			AND order_details.quantity = 10)
