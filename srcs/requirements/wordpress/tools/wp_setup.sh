#!/bin/bash

# --force-root ??
#script is run as user www-data, that has permissions only for /var/www/
if ! wp core is-installed >/dev/null; then
  wp core download --locale=en_US
fi

if [ ! -f "wp-config.php" ]; then
  wp config create --dbname=$WORDPRESS_DB_NAME \
                  --dbuser=$WORDPRESS_DB_USER \
                  --dbpass=$WORDPRESS_DB_PASSWORD \
                  --dbhost=$WORDPRESS_DB_HOST
  chmod 644 wp-config.php #?
fi

#install wordpress with admin

#create user

