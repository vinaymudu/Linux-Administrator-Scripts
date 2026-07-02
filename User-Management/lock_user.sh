#!/bin/bash

# Check if the script is being executed with root privileges.
# Locking user accounts requires administrative permissions.
if [ "$EUID" -ne 0 ]; then
	echo "❌ Please run this script as root"
	exit 1
fi

# Prompt the administrator to enter the username to lock.
read -p "Enter the username you want to lock:" UNAME

# Verify that the specified user exists on the system.
if id "$UNAME" &>/dev/null; then
	echo "User exists $UNAME"
else
	# Exit the script if the user account is not found.
	echo "User does not exist"
	exit 1
fi

# Retrieve the account status using the passwd command.
# The second field contains the account status:
# P = Password set and account active
# L = Account locked
STATUS=$(passwd -S "$UNAME" | awk '{print $2}')

# Check whether the account is already locked.
if [ "$STATUS" = "L" ]; then
	echo "Account is already locked"
	exit 0
else
	# Ask for confirmation before locking the account.
	read -p "Are you sure you want to lock the user? (y/n)" LOCK

	# Proceed only if the administrator confirms with 'y'.
	if [ "$LOCK" = "y" ]; then
		# Lock the user account by disabling password authentication.
		passwd -l "$UNAME"

		# Display a success message after locking the account.
		echo "✅ $UNAME Account locked successfully"
		exit 0
	else
		# Cancel the operation if the administrator chooses not to continue.
		echo "Cancelled"
		exit 0
	fi
fi
