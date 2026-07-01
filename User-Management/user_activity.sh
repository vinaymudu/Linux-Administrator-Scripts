#!/bin/bash

USERS=$(awk -F: '$3 >= 1000 {print $1}' /etc/passwd)

echo "Last Login activity for all users"
echo "---------------------------------"

for USERNAME in $USERS; do
	RESULT=$(last -n 1 "$USERNAME" | head -n 1)

	if [ -z "$RESULT" ]; then
		echo "$USERNAME: Never logged in"
	else
		echo "$RESULT"
	fi
done

