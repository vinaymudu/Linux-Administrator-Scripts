#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "❌ Please run this script as root"
	exit 1
fi

read -p "Enter the username you want to delete: " UNAME

if id "$UNAME" &>/dev/null; then
	echo "User exists"
else
	echo "User does not exists"
	exit 1
fi


read -p "Are you sure you want to delete $UNAME? (y/n): " CONFIRM

if [ "$CONFIRM" = "y" ]; then
	userdel -r "$UNAME"
	echo "✅User $UNAME deleted successfully!"
else
	echo "Cancelled"
	exit
fi

