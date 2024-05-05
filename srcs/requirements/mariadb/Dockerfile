FROM debian:bullseye

#download necessary packages
RUN apt update -y \
    && apt upgrade -y \
    && apt install mariadb-server -y

#copy config and enteypoint
COPY ./conf/mariadb.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/start_mariadb.sh /usr/local/bin/

#create necessary directories and set ownership
RUN mkdir -p /var/lib/mysql && \
    mkdir -p /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld

#set permissions for executable
RUN chmod +x /usr/local/bin/start_mariadb.sh

# HEALTHCHECK --start-period=5m \
#   CMD mariadb -e 'SELECT @@datadir;' || exit 1

EXPOSE 3306

STOPSIGNAL SIGQUIT

ENTRYPOINT ["start_mariadb.sh"]
