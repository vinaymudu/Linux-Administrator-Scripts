#!/bin/bash

# This script creates a timestamped backup of the SSH config file

# Verify the SSH config file exists before backing it up
if [ ! -f /etc/ssh/sshd_config ]; then
    echo "❌ SSH config file not found"
    exit 1
fi

# Generate a unique timestamp for this backup
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="sshd_config_${TIMESTAMP}.backup"

# Copy the config file into the timestamped backup
cp /etc/ssh/sshd_config "$BACKUP_NAME"

echo "✅ Backup created: $BACKUP_NAME"
