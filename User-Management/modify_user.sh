#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "❌ Please run this script as root"
    exit 1
fi

read -p "Enter the username: " UNAME

if id "$UNAME" &>/dev/null; then
    echo "User exists"
else
    echo "❌ User does not exist"
    exit 1
fi

read -p "Enter the group name to add user to: " GNAME

if getent group "$GNAME" &>/dev/null; then
    echo "Group exists"
else
    echo "Group does not exist"
    read -p "If you want to create group please select (y/n): " CGNAME
    if [ "$CGNAME" = "y" ]; then
        groupadd "$GNAME"
        echo "Group added successfully"
    else
        exit 0
    fi
fi

usermod -aG "$GNAME" "$UNAME"
echo "✅ User $UNAME added to group $GNAME successfully!"
