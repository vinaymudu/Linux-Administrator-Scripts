#!/bin/bash

# This script checks Nginx's status and shows which ports it's listening on

# Show whether the service is active or not
echo "Checking status of nginx..."
systemctl is-active nginx

# Show which ports Nginx is listening on (checking ports directly avoids needing root)
echo "Ports Nginx is listening on:"
ss -tln | grep -E ":80 |:443 "

# Warn if no ports were found - likely means Nginx isn't actually running
if [ -z "$(ss -tln | grep -E ':80 |:443 ')" ]; then
    echo "⚠️  No active ports found - Nginx may not be running"
fi
