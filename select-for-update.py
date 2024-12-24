from time import sleep
from dbhelpers.config import build_config
from dbhelpers.db import get_db
import dbhelpers.sql


config = build_config(database='jpassion')
db = get_db(config)
print(db.database)

db.start_transaction()
try:
    rows = dbhelpers.sql.exec_statement("""-- sql
        select * from name
        where id = %s
        for update
    """, 11)

    print(rows)
    sleep(10)
except Exception as e:
    print(repr(e))
    print(e)
    print(e.__class__.__qualname__)
