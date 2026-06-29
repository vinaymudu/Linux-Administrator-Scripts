#!/bin/bash

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "❌ Please run this script as root: sudo ./create_user.sh"
    exit 1
fi

read -p "Enter the username you want to create: " UNAME
useradd -m $UNAME
passwd $UNAME
echo "✅ User $UNAME created successfully!"
