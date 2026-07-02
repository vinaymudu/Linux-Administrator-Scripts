#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "Run this script as root"
	exit 1
fi

read -p "Enter the file path you want to change the permission:" FILE_PATH

if [ ! -e "$FILE_PATH" ]; then
	echo "❌ File does not exist $FILE_PATH"
	exit 1
fi

stat -c "Permissions: %A | Owner: %U | Group: %G" "$FILE_PATH"

read -p "Enter new permission for the file:" NEW_PERM

if [[ ! "$NEW_PERM" =~ ^[0-7]{3}$ ]]; then
	echo "Invalied permission format. Use 3 digits like 755"
	exit 1
fi

read -p "Are you sure you want to set permission $NEW_PERM on $FILE_PATH? (y/n):" CONFIRM

if [ "$CONFIRM" = "y" ]; then
    chmod "$NEW_PERM" "$FILE_PATH"
    echo "✅ Permission updated successfully!"
    stat -c "New Permissions: %A | Owner: %U | Group: %G" "$FILE_PATH"
else
    echo "Cancelled"
    exit 0
fi
