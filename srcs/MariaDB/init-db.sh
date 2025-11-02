#!/bin/bash

# Read from environment variables
MARIADB_ROOT_PASSWORD=${MARIADB_ROOT_PASSWORD}
MARIADB_DATABASE=${MARIADB_DATABASE}
MARIADB_USER=${MARIADB_USER}
MARIADB_PASSWORD=${MARIADB_PASSWORD}
MARIADB_SECOND_USER=${MARIADB_SECOND_USER}
MARIADB_SECOND_PASSWORD=${MARIADB_SECOND_PASSWORD}

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing database..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

if [ ! -f /var/lib/mysql/.db_configured ]; then
    echo "Configuring database..."
    echo "Starting MySQL service temporarily..."
    mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking --skip-grant-tables &
    MYSQL_PID=$!

    echo "Waiting for MySQL to be ready..."
    for i in {1..30}; do
        if mysqladmin ping --socket=/run/mysqld/mysqld.sock >/dev/null 2>&1; then
            echo "MySQL is ready!"
            break
        fi
        echo "Waiting... ($i/30)"
        sleep 1
    done
    
    echo "Creating database and users..."
    mysql --socket=/run/mysqld/mysqld.sock <<-EOSQL
		FLUSH PRIVILEGES;
		CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE}\`;
		CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
		CREATE USER IF NOT EXISTS '${MARIADB_SECOND_USER}'@'%' IDENTIFIED BY '${MARIADB_SECOND_PASSWORD}';
		GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO '${MARIADB_USER}'@'%';
		GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO '${MARIADB_SECOND_USER}'@'%';
		ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
		FLUSH PRIVILEGES;
	EOSQL
    
    echo "Stopping temporary MySQL instance..."
    kill $MYSQL_PID
    wait $MYSQL_PID 2>/dev/null
    
    touch /var/lib/mysql/.db_configured
    echo "Database configuration complete!"
else
    echo "Database already configured, skipping initialization..."
fi

echo "Starting MySQL in foreground..."
exec mysqld --user=mysql --datadir=/var/lib/mysql --port=3306 --bind-address=0.0.0.0
