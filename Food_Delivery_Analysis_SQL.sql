-- FOOD DELIVERY ANALYSIS PROJECT

CREATE DATABASE IF NOT EXISTS FoodDeliveryProject;
USE FoodDeliveryProject;


-- 1. Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(60) NOT NULL,
    signup_date DATE NOT NULL
);

-- 2. Restaurants
CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL,
    cuisine_type VARCHAR(50) NOT NULL,
    city VARCHAR(60) NOT NULL,
    rating DECIMAL(2,1)
);

-- 3. Menu items
CREATE TABLE menu_items (
    item_id INT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    category VARCHAR(40) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

-- 4. Delivery partners
CREATE TABLE delivery_partners (
    partner_id INT PRIMARY KEY,
    partner_name VARCHAR(100) NOT NULL,
    vehicle_type VARCHAR(30) NOT NULL,
    hire_date DATE NOT NULL
);

-- 5. Orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    order_status VARCHAR(20) NOT NULL,
    delivery_fee DECIMAL(10,2) NOT NULL DEFAULT 0,
    discount DECIMAL(10,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

-- 6. Order items: one order can contain multiple menu items
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    item_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id)
);

-- 7. Payments
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT NOT NULL UNIQUE,
    payment_method VARCHAR(30) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 8. Delivery performance
CREATE TABLE deliveries (
    delivery_id INT PRIMARY KEY,
    order_id INT NOT NULL UNIQUE,
    partner_id INT NOT NULL,
    pickup_time DATETIME,
    delivered_time DATETIME,
    delivery_minutes INT,
    delivery_status VARCHAR(20) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (partner_id) REFERENCES delivery_partners(partner_id)
);

-- SAMPLE DATA
INSERT INTO customers VALUES
(1,'Aarav Sharma','Delhi','2024-01-12'),
(2,'Meera Patel','Delhi','2024-02-03'),
(3,'Kabir Singh','Noida','2024-02-18'),
(4,'Ananya Gupta','Gurugram','2024-03-05'),
(5,'Ishaan Verma','Delhi','2024-03-21'),
(6,'Sana Khan','Noida','2024-04-10'),
(7,'Rohan Mehta','Gurugram','2024-04-25'),
(8,'Priya Nair','Delhi','2024-05-02'),
(9,'Dev Malhotra','Noida','2024-05-19'),
(10,'Aditi Rao','Gurugram','2024-06-01'),
(11,'Arjun Das','Delhi','2024-06-15'),
(12,'Kiara Joshi','Noida','2024-07-04');

INSERT INTO restaurants VALUES
(1,'Spice Route','North Indian','Delhi',4.5),
(2,'Wok This Way','Chinese','Delhi',4.2),
(3,'Green Bowl','Healthy','Noida',4.6),
(4,'Pizza Point','Italian','Gurugram',4.1),
(5,'Dosa Corner','South Indian','Delhi',4.4),
(6,'Burger Barn','Fast Food','Noida',3.9);

INSERT INTO menu_items VALUES
(1,1,'Paneer Butter Masala','Main Course',280),
(2,1,'Butter Naan','Bread',45),
(3,1,'Dal Makhani','Main Course',220),
(4,2,'Veg Hakka Noodles','Main Course',190),
(5,2,'Chilli Paneer','Starter',240),
(6,2,'Spring Rolls','Starter',160),
(7,3,'Quinoa Salad','Healthy Bowl',260),
(8,3,'Grilled Tofu Bowl','Healthy Bowl',290),
(9,3,'Fresh Lime Water','Beverage',70),
(10,4,'Margherita Pizza','Pizza',299),
(11,4,'Farmhouse Pizza','Pizza',399),
(12,4,'Garlic Bread','Side',129),
(13,5,'Masala Dosa','Main Course',150),
(14,5,'Idli Sambar','Main Course',100),
(15,5,'Filter Coffee','Beverage',55),
(16,6,'Classic Burger','Burger',180),
(17,6,'Crispy Fries','Side',100),
(18,6,'Veg Wrap','Wrap',160);

INSERT INTO delivery_partners VALUES
(1,'Rahul Yadav','Bike','2023-11-10'),
(2,'Neha Kumari','Scooter','2024-01-15'),
(3,'Aman Ali','Bike','2024-02-20'),
(4,'Pooja Sethi','Scooter','2024-03-11'),
(5,'Vikram Rao','Bike','2024-04-05'),
(6,'Simran Kaur','Bicycle','2024-05-17');

INSERT INTO orders VALUES
(1001,1,1,'2024-07-01','12:15:00','Delivered',25,20),
(1002,2,2,'2024-07-01','19:20:00','Delivered',20,0),
(1003,3,3,'2024-07-02','13:05:00','Delivered',18,15),
(1004,4,4,'2024-07-02','20:10:00','Delivered',25,30),
(1005,5,5,'2024-07-03','09:15:00','Delivered',15,0),
(1006,6,6,'2024-07-03','18:45:00','Delivered',20,10),
(1007,1,2,'2024-07-04','20:05:00','Delivered',20,0),
(1008,7,4,'2024-07-04','19:30:00','Delivered',25,25),
(1009,8,1,'2024-07-05','13:20:00','Delivered',25,0),
(1010,9,3,'2024-07-05','12:40:00','Cancelled',18,0),
(1011,10,5,'2024-07-06','08:55:00','Delivered',15,5),
(1012,2,1,'2024-07-06','20:15:00','Delivered',25,20),
(1013,11,6,'2024-07-07','19:05:00','Delivered',20,0),
(1014,12,3,'2024-07-07','13:10:00','Delivered',18,0),
(1015,3,2,'2024-07-08','12:25:00','Delivered',20,10),
(1016,4,4,'2024-07-08','21:00:00','Delivered',25,0),
(1017,5,1,'2024-07-09','13:35:00','Delivered',25,15),
(1018,6,5,'2024-07-09','09:20:00','Delivered',15,0),
(1019,7,6,'2024-07-10','18:30:00','Delivered',20,10),
(1020,8,2,'2024-07-10','19:45:00','Delivered',20,0),
(1021,9,4,'2024-07-11','20:20:00','Delivered',25,30),
(1022,10,3,'2024-07-11','12:50:00','Delivered',18,0),
(1023,11,5,'2024-07-12','09:05:00','Delivered',15,0),
(1024,12,1,'2024-07-12','13:45:00','Delivered',25,20),
(1025,1,6,'2024-07-13','19:15:00','Delivered',20,0),
(1026,2,4,'2024-07-13','20:40:00','Delivered',25,15),
(1027,3,5,'2024-07-14','09:30:00','Delivered',15,0),
(1028,4,2,'2024-07-14','12:35:00','Preparing',20,0),
(1029,5,3,'2024-07-15','13:25:00','Delivered',18,10),
(1030,6,1,'2024-07-15','20:10:00','Delivered',25,0),
(1031,7,2,'2024-07-16','19:55:00','Delivered',20,10),
(1032,8,4,'2024-07-16','20:15:00','Delivered',25,0),
(1033,9,6,'2024-07-17','18:20:00','Delivered',20,0),
(1034,10,1,'2024-07-17','12:10:00','Delivered',25,10),
(1035,11,3,'2024-07-18','13:00:00','Delivered',18,0),
(1036,12,5,'2024-07-18','09:10:00','Delivered',15,5);

INSERT INTO order_items VALUES
(1,1001,1,1,280),(2,1001,2,3,45),
(3,1002,4,2,190),(4,1002,5,1,240),
(5,1003,7,1,260),(6,1003,9,2,70),
(7,1004,11,1,399),(8,1004,12,2,129),
(9,1005,13,2,150),(10,1005,15,1,55),
(11,1006,16,2,180),(12,1006,17,1,100),
(13,1007,4,1,190),(14,1007,6,2,160),
(15,1008,10,2,299),(16,1008,12,1,129),
(17,1009,1,1,280),(18,1009,3,1,220),(19,1009,2,2,45),
(20,1010,8,1,290),
(21,1011,14,2,100),(22,1011,15,2,55),
(23,1012,1,2,280),(24,1012,2,4,45),
(25,1013,16,1,180),(26,1013,18,2,160),
(27,1014,8,1,290),(28,1014,9,1,70),
(29,1015,5,1,240),(30,1015,4,2,190),
(31,1016,11,2,399),(32,1016,12,1,129),
(33,1017,3,2,220),(34,1017,2,3,45),
(35,1018,13,1,150),(36,1018,14,2,100),
(37,1019,16,2,180),(38,1019,17,2,100),
(39,1020,4,2,190),(40,1020,6,1,160),
(41,1021,10,1,299),(42,1021,11,1,399),
(43,1022,7,2,260),(44,1022,9,2,70),
(45,1023,13,2,150),(46,1023,15,2,55),
(47,1024,1,1,280),(48,1024,3,1,220),(49,1024,2,2,45),
(50,1025,16,1,180),(51,1025,18,1,160),
(52,1026,11,1,399),(53,1026,12,2,129),
(54,1027,13,3,150),(55,1027,15,1,55),
(56,1028,4,1,190),(57,1028,5,1,240),
(58,1029,7,1,260),(59,1029,8,1,290),
(60,1030,1,1,280),(61,1030,2,2,45),
(62,1031,4,1,190),(63,1031,5,2,240),
(64,1032,10,1,299),(65,1032,12,2,129),
(66,1033,16,2,180),(67,1033,17,1,100),
(68,1034,1,1,280),(69,1034,3,1,220),
(70,1035,7,1,260),(71,1035,9,2,70),
(72,1036,13,2,150),(73,1036,14,1,100);

-- Payment amount = item subtotal + delivery fee - discount.
INSERT INTO payments VALUES
(1,1001,'UPI','Paid',420),(2,1002,'Card','Paid',630),
(3,1003,'UPI','Paid',403),(4,1004,'Cash','Paid',652),
(5,1005,'UPI','Paid',370),(6,1006,'Card','Paid',650),
(7,1007,'UPI','Paid',530),(8,1008,'Card','Paid',727),
(9,1009,'Cash','Paid',595),(10,1010,'UPI','Refunded',308),
(11,1011,'UPI','Paid',370),(12,1012,'Card','Paid',645),
(13,1013,'Cash','Paid',520),(14,1014,'UPI','Paid',378),
(15,1015,'Card','Paid',630),(16,1016,'UPI','Paid',952),
(17,1017,'UPI','Paid',490),(18,1018,'Cash','Paid',365),
(19,1019,'Card','Paid',550),(20,1020,'UPI','Paid',560),
(21,1021,'Card','Paid',693),(22,1022,'UPI','Paid',608),
(23,1023,'Cash','Paid',425),(24,1024,'UPI','Paid',615),
(25,1025,'Card','Paid',360),(26,1026,'UPI','Paid',667),
(27,1027,'Cash','Paid',520),(28,1028,'UPI','Pending',450),
(29,1029,'Card','Paid',858),(30,1030,'UPI','Paid',395),
(31,1031,'Card','Paid',680),(32,1032,'UPI','Paid',582),
(33,1033,'Cash','Paid',500),(34,1034,'UPI','Paid',515),
(35,1035,'Card','Paid',488),(36,1036,'UPI','Paid',365);

INSERT INTO deliveries VALUES
(1,1001,1,'2024-07-01 12:25:00','2024-07-01 12:52:00',27,'Delivered'),
(2,1002,2,'2024-07-01 19:32:00','2024-07-01 20:05:00',33,'Delivered'),
(3,1003,3,'2024-07-02 13:15:00','2024-07-02 13:42:00',27,'Delivered'),
(4,1004,4,'2024-07-02 20:20:00','2024-07-02 21:05:00',45,'Delivered'),
(5,1005,5,'2024-07-03 09:25:00','2024-07-03 09:48:00',23,'Delivered'),
(6,1006,6,'2024-07-03 18:55:00','2024-07-03 19:30:00',35,'Delivered'),
(7,1007,1,'2024-07-04 20:15:00','2024-07-04 20:44:00',29,'Delivered'),
(8,1008,2,'2024-07-04 19:40:00','2024-07-04 20:25:00',45,'Delivered'),
(9,1009,3,'2024-07-05 13:30:00','2024-07-05 13:58:00',28,'Delivered'),
(10,1010,4,'2024-07-05 12:50:00',NULL,NULL,'Cancelled'),
(11,1011,5,'2024-07-06 09:05:00','2024-07-06 09:33:00',28,'Delivered'),
(12,1012,6,'2024-07-06 20:25:00','2024-07-06 21:00:00',35,'Delivered'),
(13,1013,1,'2024-07-07 19:15:00','2024-07-07 19:48:00',33,'Delivered'),
(14,1014,2,'2024-07-07 13:20:00','2024-07-07 13:49:00',29,'Delivered'),
(15,1015,3,'2024-07-08 12:35:00','2024-07-08 13:12:00',37,'Delivered'),
(16,1016,4,'2024-07-08 21:10:00','2024-07-08 21:55:00',45,'Delivered'),
(17,1017,5,'2024-07-09 13:45:00','2024-07-09 14:15:00',30,'Delivered'),
(18,1018,6,'2024-07-09 09:30:00','2024-07-09 09:55:00',25,'Delivered'),
(19,1019,1,'2024-07-10 18:40:00','2024-07-10 19:18:00',38,'Delivered'),
(20,1020,2,'2024-07-10 19:55:00','2024-07-10 20:27:00',32,'Delivered'),
(21,1021,3,'2024-07-11 20:30:00','2024-07-11 21:12:00',42,'Delivered'),
(22,1022,4,'2024-07-11 13:00:00','2024-07-11 13:30:00',30,'Delivered'),
(23,1023,5,'2024-07-12 09:15:00','2024-07-12 09:39:00',24,'Delivered'),
(24,1024,6,'2024-07-12 13:55:00','2024-07-12 14:24:00',29,'Delivered'),
(25,1025,1,'2024-07-13 19:25:00','2024-07-13 19:58:00',33,'Delivered'),
(26,1026,2,'2024-07-13 20:50:00','2024-07-13 21:32:00',42,'Delivered'),
(27,1027,3,'2024-07-14 09:40:00','2024-07-14 10:05:00',25,'Delivered'),
(28,1028,4,'2024-07-14 12:45:00',NULL,NULL,'Preparing'),
(29,1029,5,'2024-07-15 13:35:00','2024-07-15 14:12:00',37,'Delivered'),
(30,1030,6,'2024-07-15 20:20:00','2024-07-15 20:52:00',32,'Delivered'),
(31,1031,1,'2024-07-16 20:05:00','2024-07-16 20:39:00',34,'Delivered'),
(32,1032,2,'2024-07-16 20:25:00','2024-07-16 21:08:00',43,'Delivered'),
(33,1033,3,'2024-07-17 18:30:00','2024-07-17 19:01:00',31,'Delivered'),
(34,1034,4,'2024-07-17 12:20:00','2024-07-17 12:48:00',28,'Delivered'),
(35,1035,5,'2024-07-18 13:10:00','2024-07-18 13:42:00',32,'Delivered'),
(36,1036,6,'2024-07-18 09:20:00','2024-07-18 09:45:00',25,'Delivered');

-- ANALYSIS QUERIES
-- 1. Display all orders with customer and restaurant names.
SELECT o.order_id, o.order_date, c.customer_name, r.restaurant_name,
       o.order_status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
ORDER BY o.order_date, o.order_time;

-- 2. Calculate item subtotal for every order.
SELECT o.order_id, SUM(oi.quantity * oi.item_price) AS item_subtotal
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id
ORDER BY item_subtotal DESC;

-- 3. Find total paid revenue by restaurant (paid orders only).
SELECT r.restaurant_name,
       SUM(p.amount) AS paid_revenue
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_status = 'Paid'
GROUP BY r.restaurant_name
ORDER BY paid_revenue DESC;

-- 4. Find the most popular menu items by quantity sold.
SELECT mi.item_name, SUM(oi.quantity) AS units_sold
FROM menu_items mi
JOIN order_items oi ON mi.item_id = oi.item_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY mi.item_id, mi.item_name
ORDER BY units_sold DESC
LIMIT 10;

-- 5. Count orders by status.
SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- 6. Compare revenue by cuisine type.
SELECT r.cuisine_type,
       SUM(p.amount) AS paid_revenue
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_status = 'Paid'
GROUP BY r.cuisine_type
ORDER BY paid_revenue DESC;

-- 7. Find peak ordering hours.
SELECT HOUR(order_time) AS order_hour, COUNT(*) AS total_orders
FROM orders
GROUP BY HOUR(order_time)
ORDER BY total_orders DESC, order_hour;

-- 8. Find restaurants with an average rating of at least 4.3.
SELECT restaurant_name, cuisine_type, rating
FROM restaurants
WHERE rating >= 4.3
ORDER BY rating DESC;

-- 9. Calculate average order value for paid orders.
WITH order_totals AS (
    SELECT o.order_id, p.amount
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    WHERE p.payment_status = 'Paid'
)
SELECT ROUND(AVG(amount), 2) AS average_paid_order_value
FROM order_totals;

-- 10. Payment method performance.
SELECT payment_method,
       COUNT(*) AS transaction_count,
       SUM(CASE WHEN payment_status = 'Paid' THEN amount ELSE 0 END) AS successful_revenue,
       SUM(CASE WHEN payment_status <> 'Paid' THEN 1 ELSE 0 END) AS not_paid_count
FROM payments
GROUP BY payment_method
ORDER BY successful_revenue DESC;

-- 11. Revenue and order count by city.
SELECT c.city,
       COUNT(DISTINCT o.order_id) AS order_count,
       SUM(CASE WHEN p.payment_status = 'Paid' THEN p.amount ELSE 0 END) AS paid_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN payments p ON o.order_id = p.order_id
GROUP BY c.city
ORDER BY paid_revenue DESC;

-- 12. Find the top five customers by paid spending.
SELECT c.customer_id, c.customer_name,
       SUM(p.amount) AS total_paid_spending
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_status = 'Paid'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_paid_spending DESC
LIMIT 5;

-- 13. Restaurant order fulfillment summary.
SELECT r.restaurant_name,
       COUNT(o.order_id) AS total_orders,
       SUM(CASE WHEN o.order_status = 'Delivered' THEN 1 ELSE 0 END) AS delivered_orders,
       ROUND(100.0 * SUM(CASE WHEN o.order_status = 'Delivered' THEN 1 ELSE 0 END)
             / NULLIF(COUNT(o.order_id), 0), 2) AS fulfillment_percentage
FROM restaurants r
LEFT JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY fulfillment_percentage DESC;


-- END OF PROJECT
