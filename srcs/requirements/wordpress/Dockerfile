FROM debian:bullseye

RUN apt update -y \
    && apt upgrade -y \
    && apt install -y wget php7.4 php-fpm php-mysql mariadb-client

# Check if www-data user exists
RUN id www-data || useradd -ms /bin/bash www-data

# #download wordpress & remove the compressed file
# RUN wget https://wordpress.org/wordpress-6.5.2.tar.gz -P /var/www \
# 	&& tar -xzf /var/www/wordpress-6.5.2.tar.gz -C /var/www \
# 	&& rm /var/www/wordpress-6.5.2.tar.gz

#download WP-CLI - a command line interface for wordpress download and setup - and give permissions
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp \
	&& chmod +x /usr/local/bin/wp

#copy FastCGI Process Manager congigurations and setup script for wordpress
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/wp_setup.sh /usr/local/bin/

RUN	chmod +x /usr/local/bin/wp_setup.sh

EXPOSE 9000

STOPSIGNAL SIGQUIT

WORKDIR /var/www/html
#needs to be /var/www so that wp can create cache
RUN chown -R www-data:www-data /var/www/ 
#-is there this user already??
USER www-data

# ENTRYPOINT [ "/usr/local/bin/wp_setup.sh" ]


