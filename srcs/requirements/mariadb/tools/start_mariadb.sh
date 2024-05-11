#!/bin/bash

# Check if the WordPress database directory does not exist & start the MariaDB server directly, run in backgroudn (&)
if [ ! -d "/var/lib/mysql/wordpress" ]; then
    mysqld --user=mysql &

	# Wait for MariaDB daemon to start
	until mysqladmin -u root -p${MYSQL_ROOT_PASSWORD_FILE} &>/dev/null; do
   		echo "Waiting for MariaDB to start..."
    	sleep 1
	done

	mysql -u root -p${MYSQL_ROOT_PASSWORD_FILE} -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
	mysql -u root -p${MYSQL_ROOT_PASSWORD_FILE} -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD_FILE}';"
	mysql -u root -p${MYSQL_ROOT_PASSWORD_FILE} -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
	mysql -u root -p${MYSQL_ROOT_PASSWORD_FILE} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD_FILE}';"
	mysql -u root -p${MYSQL_ROOT_PASSWORD_FILE} -e "FLUSH PRIVILEGES;"

else
   mysqld --user=mysql
fi