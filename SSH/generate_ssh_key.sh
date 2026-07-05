#!/bin/bash

# This script generates a new SSH key pair for secure, passwordless login

# Ask the user for a name to save the key pair as
read -p "Enter a name to save your SSH key as (e.g. mykey): " KEYNAME

# Check if a key with this name already exists to avoid overwriting it
if [ -f "$KEYNAME" ]; then
    echo "❌ A key with this name already exists!"
    exit 1
fi

# Generate a 4096-bit RSA key pair with no passphrase
ssh-keygen -t rsa -b 4096 -f "$KEYNAME" -N ""

echo "✅ SSH key pair generated successfully!"
echo "Your public key:"

# Show the public key - this is the one that gets shared with servers
cat "$KEYNAME.pub"
