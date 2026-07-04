#!/bin/bash

# This script restores file permissions from a previously saved backup file

# Check if script is running with root permission
if [ "$EUID" -ne 0 ]; then
    echo "Run this script as root"
    exit 1
fi

# Ask the user for the backup file to restore from
read -p "Enter the backup file to restore from: " BACKUP_FILE

# Verify the backup file actually exists
if [ ! -f "$BACKUP_FILE" ]; then
    echo "File does not exist $BACKUP_FILE"
    exit 1
fi

# Read each line from the backup file - split into permission and file path
while read -r PERM FILEPATH; do
    chmod "$PERM" "$FILEPATH"
    echo "Restored $FILEPATH to $PERM"
done < "$BACKUP_FILE"

echo "Successfully changed all the permissions to normal"
