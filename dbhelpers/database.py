import mysql.connector
from mysql.connector import MySQLConnection

from dbhelpers.config import build_config, load_config


__DB: MySQLConnection = None

def get_db(config:dict=load_config()) -> MySQLConnection:
    ''' returns new connection'''
    global __DB
    
    if __DB is None or not __DB.is_connected():
        connection = mysql.connector.connect(**config )
        __DB = connection
    else:
        connection = __DB
    print(f'GET_DB| {connection.connection_id = }')
    return connection


def exec_statement(
    stmt:str, *args, 
    db:MySQLConnection=None, 
    commit:bool=False,
    # close:bool=False
):
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
    
    # print(f'{stmt=}')
    # print(f'{args=}')
    cursor.execute(stmt, args)
    result = cursor.fetchall()
    
    if commit:
        db.commit()
    cursor.close()
    
    return result


def test_connection(config:dict|None=None) -> tuple:
    ''' 
    tests the connection
    returns user, host, port
    '''
    db = get_db(config or build_config())
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
        user, server, port = test_connection()
        print('SUCCESS| ', f'{user}@{server}:{port}')
    except Exception as e:
        print('ERROR |', e.__class__.__qualname__)
        print('ERROR |', e)
