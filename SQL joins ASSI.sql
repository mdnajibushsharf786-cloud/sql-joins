create database amazon;
use amazon;

-- TABLE 1: CUSTOMERS

create table customers(
CustomerID int primary key,
CustomerName varchar(30),
City varchar(20));

insert into customers values
(1,'John Smith','New York'),
(2,'Mary Johnson','Chicago'),
(3,'Peter Addams','Los Angeles'),
(4,'Nancy Millers','Houston'),
(5,'Robert White','Miami');
select * from customers;

-- TABLE 2: ORDERS

create table orders(
OrderID int primary key,
CustomerID int,
OrderDate date,
Amount int);

insert into orders values
(101,1,'1024-10-01',250),
(102,2,'2024-10-05',300),
(103,1,'2024-10-07',150),
(104,3,'2024-10-10',450),
(105,6,'2024-10-12',400);
select * from orders

-- TABLE 3: PAYMENTS
create table payments(
PaymentID varchar(30) primary key,
CustomerID int,
PaymentDate date,
Amount int);

insert into Payments values
('P001',1,'2024-10-02',250),
('P002',2,'2024-10-06',300),
('P003',3,'2024-10-11',450),
('P004',4,'2024-10-15',200);
select * from payments;

-- TABLE 4: EMPLOYEES

create table Employees(
EmployeeID int primary key,
EmployeeName varchar(50),
ManagerID int);

insert into Employees values

(1,'Alex Green', null),
(2,'Brian Lee', 1),
(3,'Carol Ray',1),
(4,'David Kim', 2),
(5,'Eva Smith',2);
select * from employees

-- Question 1. Retrieve all customers who have placed at least one order.

SELECT DISTINCT c.CustomerID, c.CustomerName, c.City
FROM customers c
INNER JOIN orders o
ON c.CustomerID = o.CustomerID;

-- Question 2. Retrieve all customers and their orders, including customers who have not placed any orders

SELECT c.CustomerID, c.CustomerName, c.City,
       o.OrderID, o.OrderDate, o.Amount
FROM customers c
LEFT JOIN orders o
ON c.CustomerID = o.CustomerID;

-- Question 3. Retrieve all orders and their corresponding customers, including orders placed by unknown customers.

SELECT o.OrderID, o.CustomerID, o.OrderDate, o.Amount,
       c.CustomerName, c.City
FROM orders o
LEFT JOIN customers c
ON o.CustomerID = c.CustomerID;


-- Question 4. Display all customers and orders, whether matched or not.

SELECT c.CustomerID, c.CustomerName, c.City,
       o.OrderID, o.OrderDate, o.Amount
FROM customers c
LEFT JOIN orders o
ON c.CustomerID = o.CustomerID

UNION

SELECT c.CustomerID, c.CustomerName, c.City,
       o.OrderID, o.OrderDate, o.Amount
FROM customers c
RIGHT JOIN orders o
ON c.CustomerID = o.CustomerID;

-- Question 5. Find customers who have not placed any orders.

SELECT c.CustomerID, c.CustomerName, c.City
FROM customers c
LEFT JOIN orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;


-- Question 6. Retrieve customers who made payments but did not place any orders.
SELECT DISTINCT p.CustomerID, c.CustomerName, c.City
FROM payments p
INNER JOIN customers c
    ON p.CustomerID = c.CustomerID
LEFT JOIN orders o
    ON p.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;


-- Question 7. Generate a list of all possible combinations between Customers and Orders

SELECT c.CustomerID, c.CustomerName, c.City,
       o.OrderID, o.CustomerID AS OrderCustomerID, o.OrderDate, o.Amount
FROM customers c
CROSS JOIN  orders o;

-- Question 8. Show all customers along with order and payment amounts in one table.

SELECT c.CustomerID, c.CustomerName, c.City,
       o.OrderID, o.Amount AS OrderAmount,
       p.PaymentID, p.Amount AS PaymentAmount
FROM customers c
LEFT JOIN orders o
    ON c.CustomerID = o.CustomerID
LEFT JOIN payments p
    ON c.CustomerID = p.CustomerID;


-- Question 9. Retrieve all customers who have both placed orders and made payments. 
SELECT DISTINCT c.CustomerID, c.CustomerName, c.City
FROM customers c
INNER JOIN orders o
    ON c.CustomerID = o.CustomerID
INNER JOIN payments p
    ON c.CustomerID = p.CustomerID;
