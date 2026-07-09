#!/bin/bash

# This script installs Apache, detecting the correct package manager and service name for the distro

# Check if script is running with root permission
if [ "$EUID" -ne 0 ]; then
    echo "Run this script as root"
    exit 1
fi

# Detect which package manager and service name this distro uses
if command -v apt &>/dev/null; then
    PKG_MANAGER="apt"
    SERVICE="apache2"
elif command -v yum &>/dev/null; then
    PKG_MANAGER="yum"
    SERVICE="httpd"
else
    echo "❌ Unsupported package manager"
    exit 1
fi

# Install Apache using the detected package manager
if [ "$PKG_MANAGER" = "apt" ]; then
    apt install apache2 -y
else
    yum install httpd -y
fi

# Start the service now and enable it to start on every boot
systemctl enable --now "$SERVICE"

# Confirm the service is actually running
if systemctl is-active --quiet "$SERVICE"; then
    echo "✅ Apache ($SERVICE) installed and running successfully!"
else
    echo "❌ Something went wrong - Apache is not running"
    exit 1
fi
