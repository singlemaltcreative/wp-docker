#!/bin/bash

DBNAME=wordpress
MYSQL=$(docker-compose ps -q mysql)
docker exec $MYSQL /bin/bash -c "mysql -u root -ppassword $DBNAME < /var/lib/mysql/database.sql"