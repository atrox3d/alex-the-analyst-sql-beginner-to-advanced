# importing csv module
import csv
from pathlib import Path
from mysql.connector.cursor import MySQLCursor
from mysql.connector import MySQLConnection

from dbhelpers.db import get_db
from dbhelpers.config import get_default_config

LOCAL_IN_PATH = '../.share'
INFILE = 'filename.csv'

# csv file name
filename = Path(LOCAL_IN_PATH, INFILE)

def read_csv(filename:str, header:bool=False):
    fields = []
    rows = []
    with open(filename, 'r') as csvfile:
        csvreader = csv.reader(csvfile)
        if header:
            fields = next(csvreader)
        for row in csvreader:
            yield row
            # rows.append(row)
    # return fields, rows

def setup_conn() -> MySQLConnection:
    config = get_default_config()
    config['database'] = 'jpassion'
    # config['allow_local_infile'] = True     # enable client local infile
    db = get_db(config)
    return db

def create_table(cursor:MySQLCursor):
    cursor.execute("""-- sql
        drop table if exists abc
    """)

    cursor.execute("""-- sql
        create table abc like name
    """)

db = setup_conn()
cursor = db.cursor()
create_table(cursor)

insert = """-- sql
    insert into abc
    values(%s, %s)
"""
db.start_transaction()
for row in read_csv(filename):
    cursor.execute(insert, row)
db.commit()

select = """-- sql
    select * from abc
"""
cursor.execute(select)
for row in cursor:
    print(row)
