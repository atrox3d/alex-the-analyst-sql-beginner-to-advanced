from pathlib import Path
from dbhelpers.db import get_db
from dbhelpers.config import get_default_config


LOCAL_IN_PATH = '../.share'
INFILE = 'filename.csv'

local_infile = Path(LOCAL_IN_PATH, INFILE)

config = get_default_config()
config['database'] = 'jpassion'
config['allow_local_infile'] = True     # enable client local infile
db = get_db(config)
cursor = db.cursor()

cursor.execute("""-- sql
    set global local_infile=ON
""")                                    # enable server local infile

cursor.execute("""-- sql
    drop table if exists abc
""")

cursor.execute("""-- sql
    create table abc like name
""")

cursor.execute(f"""-- sql
    LOAD DATA LOCAL INFILE '{local_infile}' 
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
