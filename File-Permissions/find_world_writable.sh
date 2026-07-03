#!/bin/bash

# This script scans a folder for world-writable files,
# which are considered a common security risk.

# Ask the user which folder should be scanned.
read -p "Enter the folder path to scan: " FOLDER

# Verify that the specified folder exists before starting the scan.
if [ ! -d "$FOLDER" ]; then
        echo "❌ Folder does not exist: $FOLDER"
        exit 1
fi

# Search for files and directories where "others" have write permission.
# The permission mode -0002 matches world-writable files.
echo "Scanning $FOLDER for world-writable files...."

# Suppress permission denied errors by redirecting stderr to /dev/null.
RESULT=$(find "$FOLDER" -perm -0002 2>/dev/null)

# If no results are found, the folder contains no world-writable files.
# Otherwise, display the list of potentially risky files and directories.
if [ -z "$RESULT" ]; then
        echo "✅ No world-writable files found. Good security!"
else
        echo "⚠️ World-writable files found:"
        echo "$RESULT"

        # Count the number of risky files and directories found.
        COUNT=$(echo "$RESULT" | wc -l)

        # Display the total number of findings.
        echo "Total risky files: $COUNT"
fi
