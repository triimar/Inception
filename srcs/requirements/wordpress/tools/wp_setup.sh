#!/bin/bash

# <<Script is run as the user www-data>>

# Wait for mariadb to start
# sleep 5

if [ ! -f "/var/www/html/wp-config.php" ]; then
	echo "Creating wordpress configuration file ..."
	wp config create --dbname=$WP_DB_NAME \
    				--dbuser=$WP_DB_USER \
                	--prompt=dbpass < $WP_DB_PASSWORD_FILE \
                	--dbhost="$WP_DB_HOST:$WP_DB_PORT" \
					--dbprefix=$WP_TABLE_PREFIX \
					|| { echo "Failed to create WordPress configuration file" >&2; exit 1; }
	chmod 644 wp-config.php || { echo "Failed to set permissions for wp-config.php" >&2; exit 1; }
fi

if ! wp core is-installed >/dev/null; then
	echo "Downloading and installing wordpress ..."
	wp core download --path=/var/www/html --locale=en_US
	wp core install --url=localhost \
					--title=Inception \
					--admin_user=$WP_ADMIN_USER \
					--prompt=admin_password < $WP_ADMIN_PASSWORD_FILE \
					--admin_email=$WP_ADMIN_EMAIL || { echo "Failed to install WordPress" >&2; exit 1; }				
fi

if ! wp user get $WP_USER >/dev/null; then
	echo "Creating a new user ..."
    wp user create  $WP_USER $WP_USER_EMAIL --role=author --prompt=user_pass < $WP_USER_PASSWORD_FILE || { echo "Failed to create user" >&2; exit 1; }
fi

echo "Starting php-fpm ..."
php-fpm7.4 -F
# -F flag means foreground