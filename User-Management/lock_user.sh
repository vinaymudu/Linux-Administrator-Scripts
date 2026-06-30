#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "❌ Please run this script as root"
	exit 1
fi

read -p "Enter the username you want to lock:" UNAME

if id "$UNAME" &>/dev/null; then
	echo "User exists $UNAME"
else
	echo "User does not exist"
	exit 1
fi

STATUS=$(passwd -S "$UNAME" | awk '{print $2}')

if [ "$STATUS" = "L" ]; then
	echo "Account is already locked"
	exit 0
else
	read -p "Are you sure you want to lock the user? (y/n)" LOCK
	if [ "$LOCK" = "y" ]; then
		passwd -l "$UNAME"
		echo "$UNAME Account locked successfully"
		exit 0
	else
		echo "Cancelled"
		exit 0
	fi
fi
