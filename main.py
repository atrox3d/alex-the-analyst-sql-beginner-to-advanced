from time import sleep
import database

config = database.build_config(database='jpassion')
db = database.get_db(config)

db.start_transaction()
try:
    rows = database.exec_statement("""-- sql
        select * from name
        where id = %s
        for update
    """, 11)

    print(rows)
    sleep(60)
except Exception as e:
    print(repr(e))
    print(e)
    print(e.__class__.__qualname__)
