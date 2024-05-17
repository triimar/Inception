FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y \
    && apt upgrade -y \
    && apt install -y wget php7.4 php-fpm php-mysql

#cleaning up apt-get cache to reduce image size
RUN apt clean && rm -rf /var/lib/apt/lists/*

#setting back to default value
ENV DEBIAN_FRONTEND=

RUN id www-data || useradd -ms /bin/bash www-data

#download WP-CLI - a command line interface for wordpress download and setup - and give permissions
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp \
	&& chmod +x /usr/local/bin/wp

#copy FastCGI Process Manager congigurations and setup script for wordpress
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/wp_setup.sh /usr/local/bin/

RUN	chmod +x /usr/local/bin/wp_setup.sh && \
	mkdir -p /run/php

EXPOSE 9000

STOPSIGNAL SIGQUIT

WORKDIR /var/www/html

RUN chown -R www-data:www-data /var/www/ \
	&& chown -R www-data:www-data /var/www/html/ \
	&& chown -R www-data:www-data /var/log/ \
	&& chown -R www-data:www-data /run/php/

ENTRYPOINT ["wp_setup.sh"]
