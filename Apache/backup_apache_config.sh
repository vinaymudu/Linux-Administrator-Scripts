#!/bin/bash

# This script creates a timestamped backup of Apache's configuration before making changes

# Detect which distro's Apache config directory to use
if [ -d /etc/apache2 ]; then
    CONFIG_DIR="/etc/apache2"
elif [ -d /etc/httpd ]; then
    CONFIG_DIR="/etc/httpd"
else
    echo "❌ Could not detect Apache config directory"
    exit 1
fi

# Verify the config directory actually exists before backing it up
if [ ! -d "$CONFIG_DIR" ]; then
    echo "❌ Apache config directory not found: $CONFIG_DIR"
    exit 1
fi

# Generate a unique timestamp for this backup
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="apache_config_${TIMESTAMP}.tar.gz"

# Compress the entire config directory into a single backup archive
tar -czf "$BACKUP_NAME" "$CONFIG_DIR" 2>/dev/null

echo "✅ Backup created: $BACKUP_NAME"
