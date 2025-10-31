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
	docker compose build

up:
	docker compose up -d

down:
	docker compose down

clean: down
	docker system prune -af
	docker volume prune -f

fclean: clean
	rm -rf /home/jramos-a/data/db/*
	rm -rf /home/jramos-a/data/wp/*

re: fclean all

.PHONY: all build up down clean fclean re

