-- Create the database if it does not exist
CREATE DATABASE IF NOT EXISTS your_database_name;

-- Use the newly created or existing database
USE your_database_name;

-- Create the Authors table
CREATE TABLE IF NOT EXISTS Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(215) NOT NULL
);

-- Create the Books table
CREATE TABLE IF NOT EXISTS Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(130) NOT NULL,
    author_id INT,
    price DOUBLE,
    publication_date DATE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- Create the customer table
CREATE TABLE IF NOT EXISTS customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(215) NOT NULL,
    email VARCHAR(215) NOT NULL,
    address TEXT NOT NULL
);

-- Create the Orders table
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- Create the Order_Details table
CREATE TABLE IF NOT EXISTS Order_Details (
    orderdetailid INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity DOUBLE,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Check if the Books table exists
SELECT COUNT(*) INTO @table_exists
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'your_database_name' AND TABLE_NAME = 'Books';

-- Retrieve and display the structure of the Books table if it exists
IF @table_exists > 0 THEN
    SELECT 
        COLUMN_NAME AS 'Column Name',
        COLUMN_TYPE AS 'Column Type',
        IS_NULLABLE AS 'Is Nullable',
        COLUMN_DEFAULT AS 'Default Value',
        EXTRA AS 'Extra Info'
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = 'your_database_name'
    AND TABLE_NAME = 'Books';
ELSE
    SELECT 'The table Books does not exist.' AS Message;
END IF;

-- Insert multiple rows into the customer table
INSERT INTO customer (customer_id, customer_name, email, address)
VALUES
    (1, 'Cole Baidoo', 'cbaidoo@sandtech.com', '123 Happiness Ave.'),
    (2, 'Blessing Malik', 'bmalik@sandtech.com', "124  Happiness Ave."),
    (3, 'Obed Ehoneah', 'eobed@sandtech.com', '125 Happiness Ave.'),
    (4, 'Nehemial Kamolu', 'nkamolu@sandtech.com', '126 Happiness Ave.');
