#!/bin/bash

# Verify that the script is being executed with root privileges.
# User creation operations require administrative permissions.
if [ "$EUID" -ne 0 ]; then
    echo "❌ Please run this script as root: sudo ./create_user.sh"
    exit 1
fi

# Prompt the administrator to enter the username for the new account.
read -p "Enter the username you want to create: " UNAME

# Check whether the user already exists on the system.
# If the user exists, stop the script to avoid duplicate accounts.
if id "$UNAME" &>/dev/null; then
    echo "User already exists"
    exit 0
fi

# Create a new user account and generate a home directory for the user.
useradd -m "$UNAME"

# Prompt the administrator to set an initial password for the new user.
passwd "$UNAME"

# Display a success message after the account is created successfully.
echo "✅ User $UNAME created successfully!"
