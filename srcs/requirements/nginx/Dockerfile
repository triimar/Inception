FROM debian:bullseye

#installing nginx and openssl 
RUN apt update -y \
	&& apt install nginx -y \
	&& mkdir -p /etc/nginx/ssl \
	&& apt install openssl -y

#creating log directories
RUN mkdir -p /var/log/nginx && \
    touch /var/log/nginx/access.log && \
    touch /var/log/nginx/error.log && \
    chown -R www-data:www-data /var/log/nginx

#creating SSL certificate and key
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=DE/L=Heilbronn/O=42/OU=42Heilbronn/CN=tmarts.42.fr/emailAddress=tmarts@student.42heilbronn.de"

#copy configuration file intot he container
COPY ./conf/nginx.conf etc/nginx/nginx.conf

EXPOSE 443

#Ensures that the service in container gracefully shuts down when the container is stopped 
STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]