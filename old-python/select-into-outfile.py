from pathlib import Path
from dbhelpers.db import get_db


LOCAL_OUT_PATH = '../.share'
OUTFILE = 'filename.csv'

local_outfile = Path(LOCAL_OUT_PATH, OUTFILE)

if local_outfile.exists():
    print(f'{local_outfile} exists, removing...')
    local_outfile.unlink()

db = get_db()
db.database = 'jpassion'
cursor = db.cursor()

query = """-- sql
    select * 
    into outfile '/var/lib/mysql-files/filename.csv'
    FIELDS TERMINATED BY ',' 
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    from name
"""

cursor.execute(query)
for row in cursor:
    print(row)

print(local_outfile.read_text())