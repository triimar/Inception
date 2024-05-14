#!/bin/bash

# Check if the WordPress database directory does not exist & start the MariaDB server directly, run in backgroudn (&)
if [ ! -d "/var/lib/mysql/wordpress" ]; then
    mysqld --user=mysql &

	#Wait for MariaDB daemon to start
	sleep 5

	mysql -u root -p"$(cat /run/secrets/db_root_pass)" -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
	mysql -u root -p"$(cat /run/secrets/db_root_pass)" -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '$(cat /run/secrets/db_pass)';"
	mysql -u root -p"$(cat /run/secrets/db_root_pass)" -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
	mysql -u root -p"$(cat /run/secrets/db_root_pass)" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$(cat /run/secrets/db_root_pass)';"
	mysql -u root -p"$(cat /run/secrets/db_root_pass)" -e "FLUSH PRIVILEGES;"
	mysqladmin -u root -p"$(cat /run/secrets/db_root_pass)" shutdown 
else
	exec mysqld --user=mysql
fi