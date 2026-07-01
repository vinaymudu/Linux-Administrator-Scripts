#!/bin/bash

read -p "Enter the file or folder path:" PATH_INPUT

if [ ! -e "$PATH_INPUT" ]; then
	echo "❌ Path does not exist: $PATH_INPUT"
	exit 1
fi

echo "Permissions for: $PATH_INPUT"
stat -c "Permissions: %A | Owner: %U | Group: %G" "$PATH_INPUT"

