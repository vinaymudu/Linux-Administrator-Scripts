#!/bin/bash

# Retrieve all regular user accounts from /etc/passwd.
# Users with UID 1000 or higher are generally considered normal users,
# while lower UIDs are usually reserved for system accounts.
USERS=$(awk -F: '$3 >= 1000 {print $1}' /etc/passwd)

# Display a heading for the report.
echo "Last Login activity for all users"
echo "---------------------------------"

# Iterate through each user in the list.
for USERNAME in $USERS; do

	# Retrieve the most recent login record for the current user.
	# The 'last' command displays login history, and '-n 1'
	# limits the output to the latest login entry.
	RESULT=$(last -n 1 "$USERNAME" | head -n 1)

	# Check whether any login record was found.
	if [ -z "$RESULT" ]; then
		# Display a message if the user has never logged in.
		echo "$USERNAME: Never logged in"
	else
		# Display the user's most recent login information.
		echo "$RESULT"
	fi
done
