#!/bin/bash

# Verify that the script is executed with root privileges.
# Changing file permissions may require administrative access.
if [ "$EUID" -ne 0 ]; then
	echo "Run this script as root"
	exit 1
fi

# Prompt the user to enter the path of the file or directory
# whose permissions need to be modified.
read -p "Enter the file path you want to change the permission:" FILE_PATH

# Check whether the specified file or directory exists.
if [ ! -e "$FILE_PATH" ]; then
	echo "❌ File does not exist $FILE_PATH"
	exit 1
fi

# Display the current permissions, owner, and group information
# before making any changes.
stat -c "Permissions: %A | Owner: %U | Group: %G" "$FILE_PATH"

# Prompt the user to enter the new permission value
# in numeric format (e.g., 755, 644, 700).
read -p "Enter new permission for the file:" NEW_PERM

# Validate that the permission consists of exactly
# three octal digits ranging from 0 to 7.
if [[ ! "$NEW_PERM" =~ ^[0-7]{3}$ ]]; then
	echo "Invalid permission format. Use 3 digits like 755"
	exit 1
fi

# Ask for confirmation before applying the new permissions.
read -p "Are you sure you want to set permission $NEW_PERM on $FILE_PATH? (y/n):" CONFIRM

# Proceed only if the user confirms with 'y'.
if [ "$CONFIRM" = "y" ]; then
    # Apply the new permissions using chmod.
    chmod "$NEW_PERM" "$FILE_PATH"

    # Display a success message.
    echo "✅ Permission updated successfully!"

    # Show the updated permissions, owner, and group information.
    stat -c "New Permissions: %A | Owner: %U | Group: %G" "$FILE_PATH"
else
    # Cancel the operation if the user chooses not to continue.
    echo "Cancelled"
    exit 0
fi
