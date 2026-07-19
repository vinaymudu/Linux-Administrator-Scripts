#!/bin/bash

# This script creates a new Nginx server block (Nginx's equivalent of Apache's virtual host)

# Check if script is running with root permission
if [ "$EUID" -ne 0 ]; then
    echo "Run this script as root"
    exit 1
fi

# Ask for the domain name and where its files will live
read -p "Enter the domain name (e.g. example.com): " DOMAIN
read -p "Enter the document root path (e.g. /var/www/example.com): " DOCROOT

# Create the document root folder if it doesn't already exist
mkdir -p "$DOCROOT"

# Detect which distro's Nginx config directory to use
if [ -d /etc/nginx/sites-available ]; then
    CONFIG_FILE="/etc/nginx/sites-available/$DOMAIN.conf"
elif [ -d /etc/nginx/conf.d ]; then
    CONFIG_FILE="/etc/nginx/conf.d/$DOMAIN.conf"
else
    echo "❌ Could not detect Nginx config directory"
    exit 1
fi

# Write the server block config file using a heredoc
cat << EOF > "$CONFIG_FILE"
server {
    listen 80;
    server_name $DOMAIN;
    root $DOCROOT;
    index index.html index.htm;

    access_log /var/log/nginx/${DOMAIN}_access.log;
    error_log /var/log/nginx/${DOMAIN}_error.log;
}
EOF

echo "✅ Server block created: $CONFIG_FILE"
