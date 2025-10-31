
#!/bin/bash

# Initialize database if not already present
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing database..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Check if database already configured
if [ ! -f /var/lib/mysql/.db_configured ]; then
    echo "Configuring database..."
    
    # Start MySQL temporarily in the background with skip-grant-tables for initial setup
    echo "Starting MySQL service temporarily..."
    mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking --skip-grant-tables &
    MYSQL_PID=$!
    
    # Wait for MySQL to start
    echo "Waiting for MySQL to be ready..."
    for i in {1..30}; do
        if mysqladmin ping --socket=/run/mysqld/mysqld.sock >/dev/null 2>&1; then
            echo "MySQL is ready!"
            break
        fi
        echo "Waiting... ($i/30)"
        sleep 1
    done
    
    # Create database and users
    echo "Creating database and users..."
    mysql --socket=/run/mysqld/mysqld.sock <<-EOSQL
		FLUSH PRIVILEGES;
		CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
		CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
		CREATE USER IF NOT EXISTS '${MYSQL_ADMIN_USER}'@'%' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';
		GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
		GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_ADMIN_USER}'@'%';
		ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
		FLUSH PRIVILEGES;
	EOSQL
    
    # Stop the temporary MySQL instance
    echo "Stopping temporary MySQL instance..."
    kill $MYSQL_PID
    wait $MYSQL_PID 2>/dev/null
    
    # Mark as configured
    touch /var/lib/mysql/.db_configured
    echo "Database configuration complete!"
else
    echo "Database already configured, skipping initialization..."
fi

# Start MySQL in foreground
echo "Starting MySQL in foreground..."
exec mysqld --user=mysql --datadir=/var/lib/mysql --port=3306 --bind-address=0.0.0.0

