#!/bin/bash

echo "==================================="
echo "Inception Project Setup"
echo "==================================="

CURRENT_USER=$(whoami)
echo "Current user: $CURRENT_USER"

DATA_DIR="/home/$CURRENT_USER/data"

echo ""
echo "Creating data directories..."

if [ ! -d "$DATA_DIR/db" ]; then
    mkdir -p "$DATA_DIR/db"
    echo "✓ Created: $DATA_DIR/db"
else
    echo "✓ Directory already exists: $DATA_DIR/db"
fi

if [ ! -d "$DATA_DIR/wp" ]; then
    mkdir -p "$DATA_DIR/wp"
    echo "✓ Created: $DATA_DIR/wp"
else
    echo "✓ Directory already exists: $DATA_DIR/wp"
fi

echo ""
echo "Setting permissions..."
chmod -R 755 "$DATA_DIR"
echo "✓ Permissions set to 755 for $DATA_DIR"

if [ ! -f ".env" ]; then
    echo ""
    echo "Creating .env file..."
    cat > .env << 'EOF'
# MariaDB credentials
MYSQL_ROOT_PASSWORD=rootpass
MYSQL_DATABASE=wpdatabase
MYSQL_USER=wpuse
MYSQL_PASSWORD=wppassword
MYSQL_ADMIN_USER=wpadmin
MYSQL_ADMIN_PASSWORD=wpadminpass
EOF
    echo "✓ Created .env file"
else
    echo ""
    echo "✓ .env file already exists"
fi

echo ""
echo "Updating docker-compose.yml with current user path..."
if [ -f "docker-compose.yml" ]; then
    cp docker-compose.yml docker-compose.yml.bak
    
    sed -i "s|/home/jramos-a/data|$DATA_DIR|g" docker-compose.yml
    echo "✓ Updated docker-compose.yml (backup saved as docker-compose.yml.bak)"
else
    echo "⚠ Warning: docker-compose.yml not found"
fi

if [ -f "Makefile" ]; then
    cp Makefile Makefile.bak
    
    sed -i "s|/home/jramos-a/data|$DATA_DIR|g" Makefile
    echo "✓ Updated Makefile (backup saved as Makefile.bak)"
else
    echo "⚠ Warning: Makefile not found"
fi

echo ""
echo "Note: The domain is currently set to 'jramos-a.42.fr'"
echo "You may need to update it to '$CURRENT_USER.42.fr' in:"
echo "  - srcs/NGINX/nginx.conf (server_name)"
echo "  - /etc/hosts (add: 127.0.0.1 $CURRENT_USER.42.fr)"

echo ""
echo "==================================="
echo "Setup Complete!"
echo "==================================="
echo ""
echo "Directory structure:"
echo "  $DATA_DIR/"
echo "  ├── db/   (MariaDB data)"
echo "  └── wp/   (WordPress files)"
echo ""
echo "Next steps:"
echo "  1. Make sure Docker is running"
echo "  2. Add to /etc/hosts: 127.0.0.1 $CURRENT_USER.42.fr"
echo "  3. Run: make"
echo "  4. Access: https://$CURRENT_USER.42.fr"
echo ""
