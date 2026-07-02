#!/bin/bash

# Ensure that the script is executed with root privileges.
# Changing another user's password requires administrative access.
if [ "$EUID" -ne 0 ]; then
	echo "Run this script as root:"
	exit 1
fi

# Prompt the administrator to enter the username whose password needs to be changed.
read -p "Enter the username who's password you want to change:" UNAME

# Check if the specified user exists in the system.
if id "$UNAME" &>/dev/null; then
	echo "$UNAME exists"

	# Ask for confirmation before changing the password.
	read -p "Are you sure you want to change the password? (y/n):" PASSWD

	# Proceed with password change only if the user confirms with 'y'.
	if [ "$PASSWD" = "y" ]; then
		# Launch the password change utility for the specified user.
		passwd "$UNAME"

		# Display success message after updating the password.
		echo "✅ Password successfully updated"
	else
		# Cancel the operation if the user chooses not to continue.
		echo "Cancelled"
		exit 0
	fi
else
	# Inform the administrator if the specified user does not exist.
	echo "$UNAME does not exist"
	exit 1
fi
