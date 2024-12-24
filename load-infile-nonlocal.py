from pathlib import Path
from dbhelpers.db import get_db


LOCAL_IN_PATH = '../.share'
INFILE = 'filename.csv'

local_outfile = Path(LOCAL_IN_PATH, INFILE)

# if local_outfile.exists():
#     print(f'{local_outfile} exists, removing...')
#     local_outfile.unlink()

db = get_db()
db.database = 'jpassion'
cursor = db.cursor()

cursor.execute("""-- sql
    drop table if exists abc
""")

cursor.execute("""-- sql
    create table abc like name
""")

cursor.execute("""-- sql
    LOAD DATA INFILE '/var/lib/mysql-files/filename.csv' 
    INTO TABLE abc
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
""")
db.commit()

cursor.execute("""-- sql
    select * from abc
""")

for row in cursor:
    print(row)
