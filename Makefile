all:
	cd ./srcs && docker-compose up -d

#clean stops containers and network
clean:
	cd ./srcs && docker-compose stop 

#fclean removes containers and network , should also remove volumes!!!
fclean:
	cd ./srcs && docker-compose down
	rm -rf /Users/tmarts/data/db_volume /Users/tmarts/data/wp_volume

re: fclean all

.PHONY: all re fclean clean