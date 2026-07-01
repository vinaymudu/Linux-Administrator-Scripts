#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "Run this script as a root"
	exit 1
fi

read -p "Enter the filename containing usernames:" FILENAME #Enter the complete file location here

if [ ! -f "$FILENAME" ]; then
	echo "❌ File not found: $FILENAME"
	exit 1
fi

CREATED=0
SKIPPED=0

while read -r USERNAME; do

	if id "$USERNAME" &>/dev/null; then
		echo "⏭️  $USERNAME already exists, skipping"
		SKIPPED=$((SKIPPED + 1))
	else
		useradd -m "$USERNAME"
		echo "$USERNAME:Welcome@123" | chpasswd
		passwd -e "$USERNAME"
		echo "✅ $USERNAME created successfully with temporary password"
		CREATED=$((CREATED + 1))
	fi
done < "$FILENAME"

echo ""
echo "Summary: $CREATED users created, $SKIPPED users skipped"
