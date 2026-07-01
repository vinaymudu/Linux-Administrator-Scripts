#!/bin/bash

read -p "Enter the username you want to search:" UNAME

if id "$UNAME" &>/dev/null; then
	echo "✅ $UNAME exists on this system"
else
	echo "❌ $UNAME does not exist on this system"
	exit 1
fi
