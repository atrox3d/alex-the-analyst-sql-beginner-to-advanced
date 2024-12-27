from pathlib import Path
from dbhelpers.db import get_db
from dbhelpers.config import get_default_config


LOCAL_IN_PATH = '../.share'
INFILE = 'filename.csv'

local_outfile = Path(LOCAL_IN_PATH, INFILE)

config = get_default_config()
config['database'] = 'jpassion'
db = get_db(config)
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
