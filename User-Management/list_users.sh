#!/bin/bash

echo "Real users on this system"

USERS=$(awk -F: '$3 >= 1000 {print $1}' /etc/passwd)

echo "$USERS"

COUNT=$(echo "$USERS" | wc -l)

echo "Total users: $COUNT"
