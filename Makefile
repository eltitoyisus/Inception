# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jramos-a <jramos-a@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/08/27 09:49:18 by jramos-a          #+#    #+#              #
#    Updated: 2025/11/05 09:43:34 by jramos-a         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all: build up

bonus:
	@sudo mkdir -p /home/jramos-a/data/db
	@sudo mkdir -p /home/jramos-a/data/wp
	@sudo mkdir -p /home/jramos-a/data/portainer
	sudo docker compose build
	sudo docker compose up -d

build:
	@sudo mkdir -p /home/jramos-a/data/db
	@sudo mkdir -p /home/jramos-a/data/wp
	@sudo mkdir -p /home/jramos-a/data/portainer
	sudo docker compose build

up:
	sudo docker compose up -d

down:
	sudo docker compose down

clean: down
	sudo docker system prune -af
	sudo docker volume prune -f

fclean: clean
	sudo rm -rf /home/jramos-a/data
	sudo rm -rf .env

re: fclean all

.PHONY: all bonus build up down clean fclean re

