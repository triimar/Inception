all:
	mkdir -p /Users/tmarts/data/database_volume /Users/tmarts/data/wordpress_volume
	cd ./srcs && docker-compose up -d

#clean stops containers and network
clean:
	cd ./srcs && docker-compose stop 

#fclean removes containers and network , should also remove volumes!!!
fclean:
	cd ./srcs && docker-compose down

vclean:
	cd ./srcs && docker-compose down --volumes
re: fclean all

.PHONY: all re fclean clean

#docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q) 2>/dev/null
