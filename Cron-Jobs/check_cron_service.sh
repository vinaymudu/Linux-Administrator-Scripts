#!/bin/bash

# This script checks if the cron service is running, across distro naming differences

# Detect which service name this distro uses - cron (Debian) or crond (CentOS)
if systemctl list-units --full -all | grep -q "cron.service"; then
    SERVICE="cron"
elif systemctl list-units --full -all | grep -q "crond.service"; then
    SERVICE="crond"
else
    echo "❌ Cron service not found on this system"
    exit 1
fi

echo "Checking status of $SERVICE..."
systemctl is-active "$SERVICE"
