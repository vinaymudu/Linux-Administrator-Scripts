#!/bin/bash

# This script checks Apache's status and shows which ports it's listening on

# Detect which service name this distro uses
if systemctl list-units --full -all | grep -q "apache2.service"; then
    SERVICE="apache2"
elif systemctl list-units --full -all | grep -q "httpd.service"; then
    SERVICE="httpd"
else
    echo "❌ Apache service not found on this system"
    exit 1
fi

# Show whether the service is active or not
echo "Checking status of $SERVICE..."
systemctl is-active "$SERVICE"

# Show which ports Apache is currently listening on
echo "Ports Apache is listening on:"
ss -tln | grep -E ":80 |:443 "

# Warn if no ports were found - likely means Apache isn't actually running
if [ -z "$(ss -tln | grep -E ':80 |:443 ')" ]; then
    echo "⚠️  No active ports found - Apache may not be running"
fi
