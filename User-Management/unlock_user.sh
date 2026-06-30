#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "Run this script as root"
	exit 1
fi

read -p "Enter the username you want to unlock:" UNAME

if id "$UNAME" &>/dev/null; then
	echo "$UNAME exists"
else
	echo "$UNAME does not exist"
	exit 1
fi

STATUS=$(passwd -S "$UNAME" | awk '{print $2}')

if [ "$STATUS" = "P" ]; then
	echo "$UNAME is already unlocked"
	exit 0
else
	read -p "Do you want to unlock the user (y/n):" UNLOCK

	if [ "$UNLOCK" = "y" ]; then
		passwd -u "$UNAME"
		echo "✅ $UNAME successfully unlocked"
		exit 0
	else
		echo "Cancelled"
		exit 0
	fi
fi

