import mysql.connector
from mysql.connector import errorcode

# Database connection parameters
config = {
    'user': 'your_username',
    'password': 'your_password',
    'host': 'localhost',
    'raise_on_warnings': True
}

try:
    # Establishing a connection to the MySQL server
    cnx = mysql.connector.connect(**config)
    cursor = cnx.cursor()

    # Creating the database if it does not exist
    cursor.execute("CREATE DATABASE IF NOT EXISTS alx_book_store")
    print("Database 'alx_book_store' created successfully or already exists.")

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
