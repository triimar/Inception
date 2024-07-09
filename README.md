# Inception - a system administration project using Docker
A small infrastructure to serve a WordPress website.
<br>
### Overview
Docker Compose sets up an infrastructure that contains:
- A Docker container running NGINX with TLSv1.2 or TLSv1.3 only.
- A Docker container running WordPress with php-fpm (installed and configured).
- A Docker container running MariaDB.
- A volume for storing your WordPress database.
- A second volume for storing your WordPress website files.
- A Docker network to establish connections between your containers.
  
Each service has a designated Dockerfile for building customized images. No pre-built images are used (except for the base image of Debian Bullseye).

Confidential information is managed using Docker Secrets.


### Running the Program(s)

Inception should be deployed on a virtual machine with a Linux-based OS.

The root directory should contain a 'secrets' directory, and the /src directory needs a .env file. Required variable names can be found in the docker-compose.yml file.

Use the Makefile to set up the entire application.

