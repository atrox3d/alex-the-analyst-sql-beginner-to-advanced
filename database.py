from pathlib import Path
import mysql.connector
from mysql.connector import MySQLConnection

PASSWORD = Path('.secrets/password.txt').read_text().strip()
config = dict(
    host='localhost',
    user='root',
    password=PASSWORD,
    # database='company'
)

__db: MySQLConnection = None

def get_db(config:dict=config) -> MySQLConnection:
    ''' returns new connection'''
    global __db

    if __db is None or not __db.is_connected():
        connection = mysql.connector.connect(**config )
        __db = connection
    else:
        connection = __db
    print(f'GET_DB| {connection.connection_id = }')
    return connection

def exec_statement(stmt:str, db:MySQLConnection=None):
    ''' 
    gets new or exiting db connection,
    gets new cursor,
    executes query,
    commits,
    closes cursor,
    returns result
    '''
    db = db or get_db()
    cursor = db.cursor()
    cursor.execute(stmt)
    result = cursor.fetchall()
    db.commit()
    cursor.close()
    return result

def test_connection(config:dict) -> tuple:
    ''' 
    tests the connection
    returns user, host, port
    '''
    db = get_db(config)
    assert db.is_connected()
    
    db.close()
    print(db.is_connected())
    assert not db.is_connected()

    return(
            db.user,
            db.server_host,
            db.server_port,
    )

def drop_table(name:str, db:MySQLConnection=None):
    ''' drops a table '''
    print(f'DROP_TABLE| dropping {name}')
    result = exec_statement(f'drop table if exists {name}', db)
    print(f'DROP_TABLE| {result = }')

if __name__ == "__main__":
    try:
        user, server, port = test_connection(config)
        print('SUCCESS| ', f'{user}@{server}:{port}')
    except Exception as e:
        print('ERROR |', e.__class__.__qualname__)
        print('ERROR |', e)
