# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jramos-a <jramos-a@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/08/27 09:49:18 by jramos-a          #+#    #+#              #
#    Updated: 2025/08/27 11:43:01 by jramos-a         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all:
	build up

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

re:
	down build up

