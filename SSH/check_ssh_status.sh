#!/bin/bash

# This script checks if the SSH service is running, works on both Debian (ssh) and RHEL/CentOS (sshd) systems

# Detect which service name exists on this system
if systemctl list-units --full -all | grep -q "sshd.service"; then
    SERVICE="sshd"
elif systemctl list-units --full -all | grep -q "ssh.service"; then
    SERVICE="ssh"
else
    echo "❌ No SSH service found on this system"
    exit 1
fi

# Show whether the service is active or not
echo "Checking status of $SERVICE...."
systemctl is-active "$SERVICE"

# Show detailed status information
systemctl status "$SERVICE" --no-pager
