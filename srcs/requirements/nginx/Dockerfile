FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

#installing nginx and openssl 
RUN apt update -y && apt upgrade -y && \
	apt install nginx -y && \
	mkdir -p /etc/nginx/ssl && \
	apt install openssl -y

#cleaning up apt-get cache to reduce image size
RUN apt clean && rm -rf /var/lib/apt/lists/*

#setting back to default value
ENV DEBIAN_FRONTEND=

#creating log directories
RUN mkdir -p /var/log/nginx && \
    touch /var/log/nginx/access.log && \
    touch /var/log/nginx/error.log && \
    chown -R www-data:www-data /var/log/nginx

#creating SSL certificate and key
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=DE/L=Heilbronn/O=42/OU=42Heilbronn/CN=tmarts.42.fr/emailAddress=tmarts@student.42heilbronn.de"

#copy configuration file into the container
COPY ./conf/nginx.conf etc/nginx/nginx.conf

EXPOSE 443

#Ensures that the service in container gracefully shuts down when the container is stopped 
STOPSIGNAL SIGQUIT

#daemon off insures that the process stays in the foregroun
ENTRYPOINT ["nginx", "-g", "daemon off;"]