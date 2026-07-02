#!/bin/bash

# Prompt the user to enter the username to search for.
read -p "Enter the username you want to search:" UNAME

# Check whether the specified user exists on the system.
# The 'id' command returns success if the user exists.
if id "$UNAME" &>/dev/null; then
	# Display a success message if the user account is found.
	echo "✅ $UNAME exists on this system"
else
	# Display an error message if the user account is not found.
	echo "❌ $UNAME does not exist on this system"

	# Exit the script with a non-zero status code to indicate failure.
	exit 1
fi
