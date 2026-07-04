#!/bin/bash

# This script backs up the current permissions of all files in a folder into a text file

# Ask the user which folder they want to backup permissions for
read -p "Enter the folder path to backup permissions from: " FOLDER_BACKUP

# Verify the folder actually exists before scanning
if [ ! -d "$FOLDER_BACKUP" ]; then
    echo "Folder path does not exist $FOLDER_BACKUP"
    exit 1
fi

# Ask for a filename to save the backup into
read -p "Enter a name for the backup file (e.g. backup.txt): " BACKUP_FILE

# Save each file's permission number and path into the backup file
find "$FOLDER_BACKUP" -printf "%m %p\n" > "$BACKUP_FILE"

echo "Backup was successfully done in this file $BACKUP_FILE"

# Show how many entries were saved
wc -l < "$BACKUP_FILE"
