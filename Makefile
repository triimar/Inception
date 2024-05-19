build:
	cd ./srcs && docker compose build

up:
	mkdir -p /home/tmarts/data/database_volume /home/tmarts/data/wordpress_volume
	cd ./srcs && docker compose up -d

stop:
	cd ./srcs && docker compose stop 

down:
	cd ./srcs && docker compose down

clean:
	cd ./srcs && docker compose down --rmi all --volumes

fclean: clean
	docker system prune --all --force

.PHONY: build up stop down clean fclean
