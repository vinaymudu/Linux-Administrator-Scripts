#!/bin/bash

# This script creates a new Apache virtual host configuration for a domain

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

# Detect which distro's Apache config directory to use
if [ -d /etc/apache2/sites-available ]; then
    CONFIG_FILE="/etc/apache2/sites-available/$DOMAIN.conf"
elif [ -d /etc/httpd/conf.d ]; then
    CONFIG_FILE="/etc/httpd/conf.d/$DOMAIN.conf"
else
    echo "❌ Could not detect Apache config directory"
    exit 1
fi

# Write the virtual host config file using a heredoc
cat << EOF > "$CONFIG_FILE"
<VirtualHost *:80>
    ServerName $DOMAIN
    DocumentRoot $DOCROOT
    ErrorLog \${APACHE_LOG_DIR}/${DOMAIN}_error.log
    CustomLog \${APACHE_LOG_DIR}/${DOMAIN}_access.log combined
</VirtualHost>
EOF

echo "✅ Virtual host created: $CONFIG_FILE"
