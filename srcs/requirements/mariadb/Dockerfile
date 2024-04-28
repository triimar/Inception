FROM debian:bullseye

ENV MYSQL_DATABASE=wordpress
ENV MYSQL_USER=wordpressuser
ENV MYSQL_ROOT_PASSWORD=parool
ENV MYSQL_PASSWORD=wordpresspassword

RUN apt update -y \
    && apt upgrade -y \
    && apt install mariadb-server -y

COPY ./conf/mariadb.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/start_mariadb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start_mariadb.sh

EXPOSE 3306

STOPSIGNAL SIGQUIT

ENTRYPOINT ["start_mariadb.sh"]

