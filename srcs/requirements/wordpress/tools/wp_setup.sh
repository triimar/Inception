#!/bin/bash

# <<Script is run as the user www-data>>

if ! wp core is-installed >/dev/null 2>&1; then
	wp core download --path=/var/www/html/ --locale=en_US \
					|| { echo "Failed to download WordPress" >&2; exit 1; }				
fi

if [ ! -f "/var/www/html/wp-config.php" ]; then
	echo "Creating wordpress configuration file ..."
	wp config create --dbname=$WP_DB_NAME \
    				--dbuser=$WP_DB_USER \
                	--prompt=dbpass < /run/secrets/db_pass \
                	--dbhost="$WP_DB_HOST:$WP_DB_PORT" \
					--dbprefix=$WP_TABLE_PREFIX \
					--quiet || { echo "Failed to create WordPress configuration file" >&2; exit 1; }
	chmod 644 wp-config.php || { echo "Failed to set permissions for wp-config.php" >&2; exit 1; }
fi

if ! wp core is-installed >/dev/null 2>&1; then
	echo "Installing wordpress ..."
	wp core install --url=$DOMAIN_NAME \
					--title=Inception \
					--admin_user=$WP_ADMIN_USER \
					--prompt=admin_password < /run/secrets/wp_admin_pass \
					--admin_email=$WP_ADMIN_EMAIL \
					--quiet || { echo "Failed to install WordPress" >&2; exit 1; }				
fi

if ! wp user get $WP_USER >/dev/null 2>&1; then
	echo "Creating a new user ..."
    wp user create  $WP_USER $WP_USER_EMAIL --role=author --prompt=user_pass < /run/secrets/wp_user_pass \
					--quiet || { echo "Failed to create user" >&2; exit 1; }
fi

echo "Starting php-fpm ..."
exec php-fpm7.4 -F
# -F flag means foreground