#!/bin/bash

# Check whether the script is being executed by the root user.
# User management operations such as creating users require root privileges.
if [ "$EUID" -ne 0 ]; then
	echo "Run this script as a root"
	exit 1
fi

# Prompt the administrator to enter the path of the file
# containing the list of usernames (one username per line).
read -p "Enter the filename containing usernames:" FILENAME

# Verify that the specified file exists before proceeding.
if [ ! -f "$FILENAME" ]; then
	echo "❌ File not found: $FILENAME"
	exit 1
fi

# Counters to keep track of how many users were created
# and how many existing users were skipped.
CREATED=0
SKIPPED=0

# Read the username file line by line.
while read -r USERNAME; do

	# Check whether the user already exists in the system.
	if id "$USERNAME" &>/dev/null; then
		# If the user exists, skip creation and increment the skipped counter.
		echo "⏭️  $USERNAME already exists, skipping"
		SKIPPED=$((SKIPPED + 1))
	else
		# Create a new user account with a home directory.
		useradd -m "$USERNAME"

		# Assign a temporary default password to the new user.
		echo "$USERNAME:Welcome@123" | chpasswd

		# Force the user to change the password at first login.
		passwd -e "$USERNAME"

		# Display success message and increment the created counter.
		echo "✅ $USERNAME created successfully with temporary password"
		CREATED=$((CREATED + 1))
	fi

# Redirect the contents of the input file to the while loop.
done < "$FILENAME"

# Display a summary of the script execution.
echo ""
echo "Summary: $CREATED users created, $SKIPPED users skipped"
