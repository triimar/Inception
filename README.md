# Inception - a system administration project using Docker
A small infrastructure to serve a WordPress website.

### Overview
Docker compose sets up an infrastructure that contains:
- A Docker container that contains NGINX with TLSv1.2 or TLSv1.3 only.
- A Docker container that contains WordPress + php-fpm (installed and configured).
- A Docker container that contains MariaDB.
- A volume that contains your WordPress database.
- A second volume that contains your WordPress website files.
- A docker-network that establishes the connection between your containers.

Each service has a designated Dockerfile for buliding customized images. No pre-built images are used (expept base image of Debian Bullseye).
Confidential information is managed using Docker Secrets.

### Running the Program(s)
Inception should be deployed on a virtual maschine with a linux-based OS. The root directory should contain 'secrets' direcotry and /src needs a .env file. The used variables can be found in the docker-compose.yml file. 

