#!/bin/bash

#script is run as user www-data, that has permissions only for /var/www/

# mkdir /run/php

sleep 5
if ! wp core is-installed --allow-root >/dev/null; then
  wp core download --allow-root --path=/var/www/html --locale=en_US
fi

if [ ! -f "/var/www/html/wp-config.php" ]; then
  wp config create --dbname=$WORDPRESS_DB_NAME \
                  --dbuser=$WORDPRESS_DB_USER \
                  --dbpass=$WORDPRESS_DB_PASSWORD \
                --dbhost="$WORDPRESS_DB_HOST:$WORDPRESS_DB_PORT" \
                  --allow-root
  chmod 644 wp-config.php
fi


#install wordpress with admin

#create user

echo "Starting php-fpm7.4 ..."
php-fpm7.4 -F
