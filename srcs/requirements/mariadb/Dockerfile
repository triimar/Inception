FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

#download necessary packages
RUN apt update -y \
    && apt upgrade -y \
    && apt install -y mariadb-server

#cleaning up apt-get cache to reduce image size
RUN apt clean && rm -rf /var/lib/apt/lists/*

#setting back to default value
ENV DEBIAN_FRONTEND=

#copy config and entr#ypoint
COPY ./conf/mariadb.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/start_mariadb.sh /usr/local/bin/

#create necessary directories and set ownership
RUN mkdir -p /var/lib/mysql && \
    mkdir -p /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld

#set permissions for executable
RUN chmod +x /usr/local/bin/start_mariadb.sh

EXPOSE 3306

STOPSIGNAL SIGQUIT

ENTRYPOINT ["/usr/local/bin/start_mariadb.sh"]
