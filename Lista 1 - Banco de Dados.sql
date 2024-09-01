CREATE DATABASE IF NOT EXISTS ecommerce_22A;
use ecommerce_22A;

-- Criação da tabela Customers
CREATE TABLE IF NOT EXISTS Customers (
   customer_id INT PRIMARY KEY,
   first_name VARCHAR(50),
   last_name VARCHAR(50),
   email VARCHAR(100)
);

-- Criação da tabela Orders
CREATE TABLE IF NOT EXISTS Orders (
   order_id INT PRIMARY KEY,
   customer_id INT,
   order_date DATE,
   FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Criação da tabela Products
CREATE TABLE IF NOT EXISTS Products (
   product_id INT PRIMARY KEY,
   product_name VARCHAR(100),
   price DECIMAL(10, 2)
);

-- Criação da tabela Order_Items
CREATE TABLE IF NOT EXISTS Order_Items (
   order_item_id INT PRIMARY KEY,
   order_id INT,
   product_id INT,
   quantity INT,
   FOREIGN KEY (order_id) REFERENCES Orders(order_id),
   FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Inserção de dados na tabela Customers
INSERT INTO Customers (customer_id, first_name, last_name, email) VALUES
(1, 'Ana', 'Silva', 'ana.silva@example.com'),
(2, 'Bruno', 'Santos', 'bruno.santos@example.com'),
(3, 'Carlos', 'Pereira', 'carlos.pereira@example.com'),
(4, 'Daniela', 'Oliveira', 'daniela.oliveira@example.com');

-- Inserção de dados na tabela Orders
INSERT INTO Orders (order_id, customer_id, order_date) VALUES
(1, 1, '2023-07-01'),
(2, 2, '2023-07-02'),
(3, 1, '2023-07-03'),
(4, 3, '2023-07-04');

-- Inserção de dados na tabela Products
INSERT INTO Products (product_id, product_name, price) VALUES
(1, 'Notebook', 2500.00),
(2, 'Mouse', 50.00),
(3, 'Teclado', 100.00),
(4, 'Monitor', 600.00);

-- Inserção de dados na tabela Order_Items
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity) VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 2, 1),
(4, 2, 3, 1),
(5, 3, 1, 2),
(6, 4, 4, 1);




-- Exercício 1

SELECT
    Orders.order_id,
    Orders.order_date,
    CONCAT(Customers.first_name, ' ', Customers.last_name) AS full_name,
    Customers.email
FROM Orders
JOIN Customers ON Orders.customer_id = Customers.customer_id;

-- Exercício 2

SELECT
    Products.product_name,
    Order_Items.quantity
FROM Order_Items
JOIN Orders ON Order_Items.order_id = Orders.order_id
JOIN Products ON Order_Items.product_id = Products.product_id
WHERE Orders.customer_id = 1;

-- Exercício 3

SELECT
    CONCAT(Customers.first_name, ' ', Customers.last_name) AS full_name,
    SUM(Order_Items.quantity * Products.price) AS total_spent
FROM Customers
LEFT JOIN Orders ON Customers.customer_id = Orders.customer_id
LEFT JOIN Order_Items ON Orders.order_id = Order_Items.order_id
LEFT JOIN Products ON Order_Items.product_id = Products.product_id
GROUP BY Customers.customer_id, Customers.first_name, Customers.last_name;

-- Exercício 4

SELECT
    CONCAT(Customers.first_name, ' ', Customers.last_name) AS full_name
FROM Customers
LEFT JOIN Orders ON Customers.customer_id = Orders.customer_id
WHERE Orders.order_id IS NULL;

-- Exercício 5

SELECT
    Products.product_name,
    SUM(Order_Items.quantity) AS total_sold
FROM Order_Items
JOIN Products ON Order_Items.product_id = Products.product_id
GROUP BY Products.product_id, Products.product_name
ORDER BY total_sold DESC;