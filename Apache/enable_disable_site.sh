#!/bin/bash

# This script enables or disables an Apache virtual host site

# Check if script is running with root permission
if [ "$EUID" -ne 0 ]; then
    echo "Run this script as root"
    exit 1
fi

# Ask for the domain and whether to enable or disable it
read -p "Enter the domain name (e.g. example.com): " DOMAIN
read -p "Enable or disable this site? (enable/disable): " ACTION

# Detect distro style and act accordingly
if command -v a2ensite &>/dev/null; then
    # Debian/Kali style - uses a2ensite/a2dissite to manage symlinks
    if [ "$ACTION" = "enable" ]; then
        a2ensite "$DOMAIN.conf"
    else
        a2dissite "$DOMAIN.conf"
    fi
    systemctl reload apache2
else
    # CentOS style - rename the file to toggle it on/off
    CONFIG_FILE="/etc/httpd/conf.d/$DOMAIN.conf"
    if [ "$ACTION" = "enable" ]; then
        mv "$CONFIG_FILE.disabled" "$CONFIG_FILE" 2>/dev/null
    else
        mv "$CONFIG_FILE" "$CONFIG_FILE.disabled" 2>/dev/null
    fi
    systemctl reload httpd
fi

echo "✅ Site $DOMAIN has been ${ACTION}d"
