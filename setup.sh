#!/bin/bash

HOSTS_FILE="/etc/hosts"
DOMAIN="127.0.0.1 jramos-a.42.fr"
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

# TODO: Set your .env file path here
ENV_FILE_PATH="/home/jramos-a/.env"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "========================================="
echo "    Inception Project Setup Script      "
echo "========================================="
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}ERROR: This script must be run as root!${NC}"
    echo "Run it with: sudo bash setup.sh"
    exit 1
fi

# Step 1: Configure hosts file
echo -e "${YELLOW}[1/2] Configuring hosts file...${NC}"
if grep -q "jramos-a.42.fr" "$HOSTS_FILE" 2>/dev/null; then
    echo -e "${GREEN}✓ jramos-a.42.fr already exists in hosts file!${NC}"
else
    echo "$DOMAIN" >> "$HOSTS_FILE"
    echo -e "${GREEN}✓ Successfully added jramos-a.42.fr to hosts file!${NC}"
fi

# Step 2: Copy .env file
echo -e "${YELLOW}[2/2] Setting up .env file...${NC}"

if [ -z "$ENV_FILE_PATH" ] || [ "$ENV_FILE_PATH" = "/path/to/your/.env" ]; then
    echo -e "${YELLOW}⚠ Warning: ENV_FILE_PATH not configured in script. Skipping .env setup.${NC}"
    echo -e "${YELLOW}  Please edit the script and set ENV_FILE_PATH variable.${NC}"
elif [ ! -f "$ENV_FILE_PATH" ]; then
    echo -e "${RED}✗ Error: File not found at $ENV_FILE_PATH${NC}"
    exit 1
else
    cp "$ENV_FILE_PATH" "$PROJECT_DIR/.env"
    chmod 600 "$PROJECT_DIR/.env"
    echo -e "${GREEN}✓ Successfully copied .env file from $ENV_FILE_PATH${NC}"
fi

echo ""
echo "========================================="
echo -e "${GREEN}Setup completed successfully!${NC}"
echo "========================================="
echo ""
echo "You can now access your site at:"
echo "  - http://localhost"
echo "  - https://jramos-a.42.fr"
