#!/bin/bash

# Check if the WordPress database directory does not exit & start the MariaDB server directly, run in backgroudn (&)
if [ ! -d "/var/lib/mysql/wordpress" ]; then
    mysqld --user=mysql &

    # Wait for MariaDB daemon to start
    sleep 5

	mysql -u root -p${MYSQL_ROOT_PASSWORD_FILE} -e "CREATE DATABASE ${MYSQL_DATABASE};"
	mysql -u root -p${MYSQL_ROOT_PASSWORD_FILE} -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD_FILE}';"
	mysql -u root -p${MYSQL_ROOT_PASSWORD_FILE} -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
	mysql -u root -p${MYSQL_ROOT_PASSWORD_FILE} -e "FLUSH PRIVILEGES;"
	mysql -u root -p${MYSQL_ROOT_PASSWORD_FILE} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD_FILE}';"

else
   mysqld
fi