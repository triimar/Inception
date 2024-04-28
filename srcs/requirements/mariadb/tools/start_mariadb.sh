#!/bin/bash

# MYSQL_DATABASE=wordpress
# MYSQL_USER=wordpressuser
# MYSQL_ROOT_PASSWORD=parool
# MYSQL_PASSWORD=wordpresspassword

service mariadb start 2>/dev/null
if ! mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "USE $MYSQL_DATABASE" 2>/dev/null; then
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e \
		"CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE ; \
        CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ; \
        GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' ; \
        ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' ; \
        FLUSH PRIVILEGES;"
fi

mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown

mysqld_safe
