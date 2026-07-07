#!/bin/bash

# This script disables SSH password login, allowing only key-based login

# Check if script is running with root permission
if [ "$EUID" -ne 0 ]; then
    echo "Run this script as root"
    exit 1
fi

# Backup the current SSH config before making any changes
cp /etc/ssh/sshd_config.d /etc/ssh/sshd_config.backup
echo "Backup saved as sshd_config.backup"

# Warn the user since this is a risky, production-impacting change
echo "⚠️  WARNING: This will disable password login. Make sure your SSH key login works first!"
read -p "Are you sure you want to continue? (y/n): " CONFIRM

if [ "$CONFIRM" = "y" ]; then
    # Replace the PasswordAuthentication setting from yes to no
    sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
else
    echo "Cancelled"
    exit 0
fi

# Restart SSH service so the new setting takes effect
systemctl restart sshd

# Check if the restart actually succeeded
if [ $? -eq 0 ]; then
    echo "✅ Password authentication disabled. SSH service restarted successfully!"
else
    echo "❌ Failed to restart SSH service. Restoring backup..."
    cp /etc/ssh/sshd_config.backup /etc/ssh/sshd_config.d
    systemctl restart sshd
fi
