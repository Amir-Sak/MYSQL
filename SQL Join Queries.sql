CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT,
    phone_number TEXT,
    address TEXT
);
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date DATE,
    status TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
CREATE TABLE books (
    book_id INTEGER PRIMARY KEY,
    title TEXT,
    author TEXT,
    price REAL
);
CREATE TABLE order_details (
    order_detail_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    book_id INTEGER,
    quantity INTEGER,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);
INSERT INTO customers (customer_id, name, email, phone_number, address) VALUES
(1, 'Alice Johnson', 'alice.johnson@example.com', '555-1234', '123 Main St'),
(2, 'Bob Smith', 'bob.smith@example.com', '555-5678', '456 Elm St');
INSERT INTO orders (order_id, customer_id, order_date, status) VALUES
(1, 1, '2024-05-01', 'Shipped'),
(2, 2, '2024-05-03', 'Pending');
INSERT INTO books (book_id, title, author, price) VALUES
(1, 'To Kill a Mockingbird', 'Harper Lee', 10.99),
(2, '1984', 'George Orwell', 8.99),
(3, 'Moby Dick', 'Herman Melville', 12.99);
INSERT INTO order_details (order_detail_id, order_id, book_id, quantity) VALUES
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 1);
--  Retrieve all orders along with the customer and book details. 
SELECT 
    orders.order_id,
    customers.name AS customer_name,
    customers.email AS customer_email,
    books.title AS book_title,
    books.author AS book_author,
    order_details.quantity,
    orders.order_date,
    orders.status
FROM 
    orders
join 
	customers on customers.customer_id = orders.customer_id
join 
	order_details on order_details.order_id = orders.order_id
join 
	books on books.book_id = order_details.book_id;
    
-- Find the total amount spent by each customer.

select 
 customers.name AS customer_name,
 SUM(order_details.quantity * books.price) AS total_spent
from 
	customers

JOIN 
    orders ON customers.customer_id = orders.customer_id
JOIN 
    order_details ON orders.order_id = order_details.order_id
JOIN 
    books ON order_details.book_id = books.book_id
GROUP BY 
    customers.name ;
  -- . Retrieve the most ordered book (by quantity).
  
SELECT 
    books.title AS book_title,
    SUM(order_details.quantity) AS total_quantity
FROM 
    order_details
JOIN 
    books ON order_details.book_id = books.book_id
GROUP BY 
    books.title
ORDER BY 
    total_quantity DESC
LIMIT 1;
-- Find all customers who have pending orders.
SELECT 
    DISTINCT customers.name AS customer_name,
    customers.email AS customer_email
FROM 
    customers
JOIN 
    orders ON customers.customer_id = orders.customer_id
WHERE 
    orders.status = 'Pending';

	













