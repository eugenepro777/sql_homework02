CREATE DATABASE IF NOT EXISTS homework2_db;

USE homework2_db;

/*
1. Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными
*/
DROP TABLE IF EXISTS sales;
CREATE TABLE sales 
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    count_product INT DEFAULT 0    
);
INSERT sales(order_date, count_product)
VALUES
	("2022-01-01", 156),
	("2022-01-02", 180),
	("2022-01-03", 21),
	("2022-01-04", 124),
	("2022-01-05", 341);
    
SELECT * FROM sales;

/*
2. Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300.
*/
-- для самопроверки оставил count_product, но это не обязательно
SELECT
	id AS "id заказа",
    count_product AS "Количество",
    IF(count_product < 100, "Маленький заказ",
		IF (count_product BETWEEN 100 AND 300, "Средний заказ",
			IF (count_product > 300, "Большой заказ", "Ошибка в значениях"))
	) AS "Тип заказа"	
FROM sales;
		
/*
3. Создайте таблицу “orders”, заполните ее значениями. Покажите “полный” статус заказа, используя оператор CASE	
*/
DROP TABLE IF EXISTS orders;
/*
думаю что employee_id должно быть уникальным,
а amount может и выйти за пределы 6 знаков
*/
CREATE TABLE orders
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id VARCHAR(255) UNIQUE,
    amount DECIMAL(9,2),
    order_status VARCHAR(20)
);
INSERT orders(employee_id, amount, order_status)
VALUES
	("e03", 15.00, "OPEN"),
	("e01", 25.50, "OPEN"),
	("e05", 100.70, "CLOSED"),
	("e02", 22.18, "OPEN"),
	("e04", 9.50, "CANCELLED");
    
SELECT * FROM orders;
 
SELECT
	id,
    employee_id,
    order_status,
    CASE
		WHEN order_status = "OPEN"
			THEN "Order is in open state"
		WHEN order_status = "CLOSED"
			THEN "Order is closed"
		WHEN order_status = "CANCELLED"
			THEN "Order is cancelled"
		ELSE "Статус задан не верно"
	END AS "full_order_status"
FROM orders;