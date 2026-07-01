#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "Run this script as root:"
	exit 1
fi

read -p "Enter the username who's password you want to change:" UNAME

if id "$UNAME" &>/dev/null; then
	echo "$UNAME is exists"

	read -p "Are you sure you want to change the password? (y/n):" PASSWD

	if [ "$PASSWD" = "y" ]; then
		passwd "$UNAME"
		echo "✅Password successfully updated"
	else
		echo "Cancelled"
		exit 0
	fi
else
	echo "$UNAME does not exists"
	exit 1
fi
