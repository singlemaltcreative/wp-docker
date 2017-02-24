#!/bin/bash

DBNAME=wordpress
MYSQL=$(docker-compose ps | grep mysql | awk '{ print $1 }')
docker exec $MYSQL /bin/bash -c "mysqldump -u root -ppassword $DBNAME > /var/lib/mysql/database.sql"