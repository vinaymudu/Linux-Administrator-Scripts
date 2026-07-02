#!/bin/bash

# Check whether the script is being executed with root privileges.
# Deleting user accounts requires administrative permissions.
if [ "$EUID" -ne 0 ]; then
	echo "❌ Please run this script as root"
	exit 1
fi

# Prompt the administrator to enter the username to be deleted.
read -p "Enter the username you want to delete: " UNAME

# Verify that the specified user exists on the system.
if id "$UNAME" &>/dev/null; then
	echo "User exists"
else
	# Display an error message and terminate if the user does not exist.
	echo "User does not exist"
	exit 1
fi

# Ask for confirmation before permanently deleting the user account.
read -p "Are you sure you want to delete $UNAME? (y/n): " CONFIRM

# Proceed with deletion only if the administrator confirms with 'y'.
if [ "$CONFIRM" = "y" ]; then
	# Delete the user account along with its home directory and mail spool.
	userdel -r "$UNAME"

	# Display a success message after deletion.
	echo "✅ User $UNAME deleted successfully!"
else
	# Cancel the operation if the administrator chooses not to continue.
	echo "Cancelled"
	exit
fi
