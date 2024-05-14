build:
	cd ./srcs && docker compose build --no-cache

up:
	# mkdir -p /Users/tmarts/data/database_volume /Users/tmarts/data/wordpress_volume
	cd ./srcs && docker compose up -d

stop:
	cd ./srcs && docker-compose stop 

down:
	cd ./srcs && docker-compose down

clean:
	cd ./srcs && docker compose down --rmi all --volumes

fclean: clean
	docker system prune --all --force

.PHONY: build up stop down

#docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q) 2>/dev/null
