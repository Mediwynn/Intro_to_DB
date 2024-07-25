import mysql.connector
from mysql.connector import errorcode

# Database connection parameters
config = {
    'user': 'your_username',      # Replace with your MySQL username
    'password': 'your_password',  # Replace with your MySQL password
    'host': 'localhost',          # Replace with your MySQL server host if different
    'raise_on_warnings': True
}

# SQL statements to create tables
create_tables_sql = {
    'authors': """
        CREATE TABLE IF NOT EXISTS Authors (
            author_id INT AUTO_INCREMENT PRIMARY KEY,
            author_name VARCHAR(215) NOT NULL
        )
    """,
    'books': """
        CREATE TABLE IF NOT EXISTS Books (
            book_id INT AUTO_INCREMENT PRIMARY KEY,
            title VARCHAR(130) NOT NULL,
            author_id INT,
            price DOUBLE,
            publication_date DATE,
            FOREIGN KEY (author_id) REFERENCES Authors(author_id)
        )
    """,
    'customers': """
        CREATE TABLE IF NOT EXISTS Customers (
            customer_id INT AUTO_INCREMENT PRIMARY KEY,
            customer_name VARCHAR(215) NOT NULL,
            email VARCHAR(215) NOT NULL,
            address TEXT NOT NULL
        )
    """,
    'orders': """
        CREATE TABLE IF NOT EXISTS Orders (
            order_id INT AUTO_INCREMENT PRIMARY KEY,
            customer_id INT,
            order_date DATE,
            FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        )
    """,
    'order_details': """
        CREATE TABLE IF NOT EXISTS Order_Details (
            orderdetailid INT AUTO_INCREMENT PRIMARY KEY,
            order_id INT,
            book_id INT,
            quantity DOUBLE,
            FOREIGN KEY (order_id) REFERENCES Orders(order_id),
            FOREIGN KEY (book_id) REFERENCES Books(book_id)
        )
    """
}

try:
    # Establishing a connection to the MySQL server
    cnx = mysql.connector.connect(**config)
    cursor = cnx.cursor()

    # Creating the database if it does not exist
    cursor.execute("CREATE DATABASE IF NOT EXISTS alx_book_store")
    print("Database 'alx_book_store' created successfully or already exists.")
    
    # Selecting the created database
    cursor.execute("USE alx_book_store")

    # Creating the tables
    for table_name, create_table_sql in create_tables_sql.items():
        cursor.execute(create_table_sql)
        print(f"Table '{table_name}' created successfully or already exists.")

except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("Something is wrong with your user name or password")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("Database does not exist")
    else:
        print(err)

finally:
    # Closing the connection
    cursor.close()
    cnx.close()
