FROM debian:bullseye

RUN apt update -y \
    && apt upgrade -y

RUN apt install -y wget\
	php7.4\
	php-fpm\
	php-mysql\
	mariadb-client

RUN wget https://wordpress.org/wordpress-6.5.2.tar.gz -P /var/www

RUN cd /var/www && tar -xzf wordpress-6.5.2.tar.gz && rm wordpress-6.5.2.tar.gz

RUN	chown -R root:root /var/www/wordpress

EXPOSE 9000

STOPSIGNAL SIGQUIT


