#!/bin/bash

# Display a heading for the list of regular users.
echo "Real users on this system"

# Extract usernames from /etc/passwd whose User ID (UID) is 1000 or greater.
# On most Linux distributions, UID 1000+ represents regular user accounts,
# while lower UIDs are typically reserved for system and service accounts.
USERS=$(awk -F: '$3 >= 1000 {print $1}' /etc/passwd)

# Display the list of regular users.
echo "$USERS"

# Count the number of users in the list using wc (word count).
COUNT=$(echo "$USERS" | wc -l)

# Display the total number of regular users found on the system.
echo "Total users: $COUNT"
