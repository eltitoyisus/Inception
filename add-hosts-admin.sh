#!/bin/bash

# This script must be run with: wsl -u root bash add-hosts-admin.sh

HOSTS_FILE="/mnt/c/Windows/System32/drivers/etc/hosts"
DOMAIN="127.0.0.1 jramos-a.42.fr"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "ERROR: This script must be run as root!"
    echo "Run it with: wsl -u root bash add-hosts-admin.sh"
    exit 1
fi

# Check if entry already exists
if grep -q "jramos-a.42.fr" "$HOSTS_FILE" 2>/dev/null; then
    echo "jramos-a.42.fr already exists in hosts file!"
else
    # Add the domain to hosts file
    echo "$DOMAIN" >> "$HOSTS_FILE"
    echo "Successfully added jramos-a.42.fr to hosts file!"
fi

echo ""
echo "You can now access your site at: https://jramos-a.42.fr"
