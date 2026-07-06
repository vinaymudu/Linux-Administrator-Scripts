#!/bin/bash

# This script copies your SSH public key to a remote server for passwordless login

# Ask the user for the public key file to copy
read -p "Enter the public key filename (e.g. mykey.pub): " KEYFILE

# Verify the public key file actually exists
if [ ! -f "$KEYFILE" ]; then
    echo "❌ Public key file not found: $KEYFILE"
    exit 1
fi

# Ask for the remote server's username and address
read -p "Enter the remote username: " REMOTE_USER
read -p "Enter the remote server IP or hostname: " SERVER

# Copy the public key to the remote server's authorized_keys file
ssh-copy-id -i "$KEYFILE" "$REMOTE_USER@$SERVER"

# Check if the previous command actually succeeded ($? = 0 means success)
if [ $? -eq 0 ]; then
    echo "✅ Public key copied to $SERVER successfully!"
else
    echo "❌ Failed to copy public key to $SERVER"
    exit 1
fi
