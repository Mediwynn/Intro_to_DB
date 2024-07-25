import mysql.connector
import sys
from mysql.connector import errorcode

# Check if the database name is provided as a command-line argument
if len(sys.argv) != 2:
    print("Usage: python list_tables.py <database_name>")
    sys.exit(1)

database_name = sys.argv[1]

# Database connection parameters
config = {
    'user': 'your_username',      # Replace with your MySQL username
    'password': 'your_password',  # Replace with your MySQL password
    'host': 'localhost',          # Replace with your MySQL server host if different
    'raise_on_warnings': True
}

try:
    # Establishing a connection to the MySQL server
    cnx = mysql.connector.connect(**config)
    cursor = cnx.cursor()

    # Selecting the database
    cursor.execute(f"USE {database_name}")

    # Retrieving the list of tables
    cursor.execute("SHOW TABLES")
    tables = cursor.fetchall()

    if tables:
        print(f"Tables in the '{database_name}' database:")
        for table in tables:
            print(table[0])
    else:
        print(f"No tables found in the '{database_name}' database.")

except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("Something is wrong with your user name or password")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print(f"Database '{database_name}' does not exist")
    else:
        print(err)

finally:
    # Closing the connection
    cursor.close()
    cnx.close()
