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

DOCKER_OUTPUT_DIR=out
DOCKER_INPUT_DIR=in

echo "DOCKER_INPUT_DIR.....: ${DOCKER_INPUT_DIR}"
echo "DOCKER_OUTPUT_DIR....: ${DOCKER_OUTPUT_DIR}"
echo "DATABASE.............: ${DATABASE}"
echo "SQL_FILE.............: ${SQL_FILE}"


echo docker compose exec -it \
    db /bin/bash -c \
    "mysqldump -u root -p --routines --no-create-info --no-data --no-create-db --skip-opt --skip-triggers ${DATABASE} > /${DOCKER_OUTPUT_DIR}/${SQL_FILE}"

docker compose exec -it \
    db /bin/bash -c \
    "mysqldump -u root -p --routines --no-create-info --no-data --no-create-db --skip-opt --skip-triggers ${DATABASE} > /${DOCKER_OUTPUT_DIR}/${SQL_FILE}"
