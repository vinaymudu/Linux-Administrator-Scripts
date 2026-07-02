#!/bin/bash

# Verify that the script is being executed with root privileges.
# Unlocking user accounts requires administrative permissions.
if [ "$EUID" -ne 0 ]; then
	echo "Run this script as root"
	exit 1
fi

# Prompt the administrator to enter the username to unlock.
read -p "Enter the username you want to unlock:" UNAME

# Check whether the specified user exists on the system.
if id "$UNAME" &>/dev/null; then
	echo "$UNAME exists"
else
	# Exit the script if the user account does not exist.
	echo "$UNAME does not exist"
	exit 1
fi

# Retrieve the account status using the passwd command.
# The second field indicates the account status:
# P = Password set and account active (unlocked)
# L = Account locked
STATUS=$(passwd -S "$UNAME" | awk '{print $2}')

# Check if the account is already unlocked.
if [ "$STATUS" = "P" ]; then
	echo "$UNAME is already unlocked"
	exit 0
else
	# Ask for confirmation before unlocking the account.
	read -p "Do you want to unlock the user (y/n):" UNLOCK

	# Proceed with unlocking only if the administrator confirms with 'y'.
	if [ "$UNLOCK" = "y" ]; then
		# Unlock the user account by re-enabling password authentication.
		passwd -u "$UNAME"

		# Display a success message after unlocking the account.
		echo "✅ $UNAME successfully unlocked"
		exit 0
	else
		# Cancel the operation if the administrator chooses not to continue.
		echo "Cancelled"
		exit 0
	fi
fi
