#!/bin/bash

# This script creates a timestamped backup of Nginx's configuration before making changes

# Verify the Nginx config directory exists before backing it up
if [ ! -d /etc/nginx ]; then
    echo "❌ Nginx config directory not found"
    exit 1
fi

# Generate a unique timestamp for this backup
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="nginx_config_${TIMESTAMP}.tar.gz"

# Compress the entire config directory into a single backup archive
tar -czf "$BACKUP_NAME" /etc/nginx 2>/dev/null

echo "✅ Backup created: $BACKUP_NAME"
