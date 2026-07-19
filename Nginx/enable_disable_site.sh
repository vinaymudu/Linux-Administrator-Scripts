#!/bin/bash

# This script enables or disables an Nginx server block site

# Check if script is running with root permission
if [ "$EUID" -ne 0 ]; then
    echo "Run this script as root"
    exit 1
fi

# Ask for the domain and whether to enable or disable it
read -p "Enter the domain name (e.g. example.com): " DOMAIN
read -p "Enable or disable this site? (enable/disable): " ACTION

# Detect distro style and act accordingly
if [ -d /etc/nginx/sites-available ]; then
    # Debian/Kali style - uses a symlink between sites-available and sites-enabled
    AVAILABLE="/etc/nginx/sites-available/$DOMAIN.conf"
    ENABLED="/etc/nginx/sites-enabled/$DOMAIN.conf"

    if [ "$ACTION" = "enable" ]; then
        ln -s "$AVAILABLE" "$ENABLED"
    else
        rm -f "$ENABLED"
    fi
else
    # CentOS style - rename the file to toggle it on/off
    CONFIG_FILE="/etc/nginx/conf.d/$DOMAIN.conf"
    if [ "$ACTION" = "enable" ]; then
        mv "$CONFIG_FILE.disabled" "$CONFIG_FILE" 2>/dev/null
    else
        mv "$CONFIG_FILE" "$CONFIG_FILE.disabled" 2>/dev/null
    fi
fi

# Reload Nginx so the change takes effect
systemctl reload nginx

echo "✅ Site $DOMAIN has been ${ACTION}d"
