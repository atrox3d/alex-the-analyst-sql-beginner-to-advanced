from dbhelpers.db import get_db

db = get_db()
db.database = 'jpassion'
cursor = db.cursor()

query = """-- sql
    select * 
    from name
    where id = %s
"""

cursor.execute(query, (11,))

for row in cursor:
    print(row)