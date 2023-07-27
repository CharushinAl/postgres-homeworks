import psycopg2
import csv


customers = []
employees = []
orders = []

with open('north_data/customers_data.csv', newline='') as csvfile:
    reader = csv.reader(csvfile, delimiter=',')
    customers = [tuple(row) for row in reader if row[0].isupper()]

with open('north_data/employees_data.csv', newline='') as csvfile:
    reader = csv.reader(csvfile, delimiter=',')
    employees = [tuple(row) for row in reader if row[0].isnumeric()]

with open('north_data/orders_data.csv', newline='') as csvfile:
    reader = csv.reader(csvfile, delimiter=',')
    orders = [tuple(row) for row in reader if row[0].isnumeric()]

# connect to database
conn = psycopg2.connect(
    host='localhost',
    database='north',
    user='postgres',
    password='********'
)

# create cursor
curs = conn.cursor()

# execute query
curs.executemany('INSERT INTO customers VALUES (%s, %s, %s)', customers)
curs.execute('SELECT * FROM customers')

curs.executemany('INSERT INTO employees VALUES (%s, %s, %s, %s, %s, %s)', employees)
curs.execute('SELECT * FROM employees')

curs.executemany('INSERT INTO orders VALUES (%s, %s, %s, %s, %s)', orders)
curs.execute('SELECT * FROM orders')

conn.commit()

curs.close()
conn.close()
