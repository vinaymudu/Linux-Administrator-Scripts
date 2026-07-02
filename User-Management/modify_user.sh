#!/bin/bash

# Verify that the script is executed with root privileges.
# Modifying users and groups requires administrative permissions.
if [ "$EUID" -ne 0 ]; then
    echo "❌ Please run this script as root"
    exit 1
fi

# Prompt the administrator to enter the username.
read -p "Enter the username: " UNAME

# Check whether the specified user exists on the system.
if id "$UNAME" &>/dev/null; then
    echo "User exists"
else
    # Exit if the user account is not found.
    echo "❌ User does not exist"
    exit 1
fi

# Prompt the administrator to enter the group name.
read -p "Enter the group name to add user to: " GNAME

# Check whether the specified group already exists.
if getent group "$GNAME" &>/dev/null; then
    echo "Group exists"
else
    # Inform the administrator that the group was not found.
    echo "Group does not exist"

    # Ask whether a new group should be created.
    read -p "If you want to create group please select (y/n): " CGNAME

    # Create the group if the administrator confirms.
    if [ "$CGNAME" = "y" ]; then
        groupadd "$GNAME"
        echo "Group added successfully"
    else
        # Exit if the administrator chooses not to create the group.
        exit 0
    fi
fi

# Add the user to the specified group without removing
# the user from any existing supplementary groups.
usermod -aG "$GNAME" "$UNAME"

# Display a success message after adding the user to the group.
echo "✅ User $UNAME added to group $GNAME successfully!"
