#!/usr/bin/env bash

function syntax() {
    echo "syntax $(basename $0) <database_name> [sql_filename | procedures.sql]"
    exit 1 
}

if [ $# -lt 1 ]
then
    syntax
else
    DATABASE="${1}"
fi

if [ $# -gt 1 ]
then
    SQL_FILE="${2}"
else
    SQL_FILE="procedures.sql"
fi

echo "DATABASE....: ${DATABASE}"
echo "SQL_FILE....: ${SQL_FILE}"



echo docker compose exec -it \
    db /bin/bash -c \
    "mysqldump -u root -p --routines --no-create-info --no-data --no-create-db --skip-opt --skip-triggers ${DATABASE} > /out/${SQL_FILE}"
