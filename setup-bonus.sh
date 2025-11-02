#!/bin/bash

# Inception Project - Quick Setup Script for Bonus Services

echo "🐳 Setting up Inception Bonus Services..."

# Create necessary directories
echo "📁 Creating data directories..."
sudo mkdir -p /home/jramos-a/data/db
sudo mkdir -p /home/jramos-a/data/wp
sudo mkdir -p /home/jramos-a/data/portainer

echo "✅ Directories created"

# Set permissions
echo "🔐 Setting permissions..."
sudo chmod -R 755 /home/jramos-a/data

echo "✅ Permissions set"

echo ""
echo "📋 Bonus Services Overview:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "1. Redis Cache      - WordPress object caching"
echo "2. FTP Server       - File access (port 21)"
echo "3. Static Website   - Dashboard (port 8080)"
echo "4. Adminer          - DB Manager (port 8081)"
echo "5. Portainer        - Docker UI (port 9000)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "🚀 Ready to build and run!"
echo ""
echo "Next steps:"
echo "  1. Run: make build"
echo "  2. Run: make up"
echo "  3. Access services:"
echo "     - WordPress:      https://localhost"
echo "     - Dashboard:      http://localhost:8080"
echo "     - Adminer:        http://localhost:8081"
echo "     - Portainer:      http://localhost:9000"
echo "     - FTP:            ftp://ftpuser:ftppass@localhost:21"
echo ""
echo "✨ Setup complete!"
