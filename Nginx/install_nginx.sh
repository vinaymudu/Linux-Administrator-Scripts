#!/bin/bash

# This script installs Nginx, detecting the correct package manager for the distro

# Check if script is running with root permission
if [ "$EUID" -ne 0 ]; then
    echo "Run this script as root"
    exit 1
fi

# Detect which package manager this distro uses
if command -v apt &>/dev/null; then
    PKG_MANAGER="apt"
elif command -v yum &>/dev/null; then
    PKG_MANAGER="yum"
else
    echo "❌ Unsupported package manager"
    exit 1
fi

# Install Nginx using the detected package manager
if [ "$PKG_MANAGER" = "apt" ]; then
    apt install nginx -y
else
    yum install nginx -y
fi

# Start the service now and enable it to start on every boot
systemctl enable --now nginx

# Confirm the service is actually running
if systemctl is-active --quiet nginx; then
    echo "✅ Nginx installed and running successfully!"
else
    echo "❌ Something went wrong - Nginx is not running"
    exit 1
fi
