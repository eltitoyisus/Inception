# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jramos-a <jramos-a@student.42madrid.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/08/27 09:49:18 by jramos-a          #+#    #+#              #
#    Updated: 2025/10/31 08:56:07 by jramos-a         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all: build up

build:
	sudo docker compose build

up:
	sudo docker compose up -d

down:
	sudo docker compose down

clean: down
	sudo docker system prune -af
	sudo docker volume prune -f

fclean: clean
	sudo rm -rf /home/jramos-a/data/db/*
	sudo rm -rf /home/jramos-a/data/wp/*
	sudo rm -rf .env

re: fclean all

.PHONY: all build up down clean fclean re

