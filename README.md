
Docker container NGINX TSLv1.2 or TSLv1.3

Docker container with WordPress with php-fpm (installed and configured), no NGINX

Docker container with only MariaDB, no NGINX

A volume with the WP DB

Scond volume with WP website files

A docker-network to stablish conection between containers

-- CONTAINERS MUST RESTART IN CASE OF CRASH --


---------------------------------------------------------------------------------


In the WP DB must be two users:
Admin, must not contain any reference to admin

Volumes will be able at /home/jramos-a/data

Domain name to point the local IP
Domain name> jramos-a.42.fr


