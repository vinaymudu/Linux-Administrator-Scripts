#!/bin/bash

# Prompt the user to enter the path of a file or directory
# whose permissions need to be checked.
read -p "Enter the file or folder path:" PATH_INPUT

# Verify that the specified path exists in the filesystem.
# The '-e' option checks for both files and directories.
if [ ! -e "$PATH_INPUT" ]; then
	echo "❌ Path does not exist: $PATH_INPUT"
	exit 1
fi

# Display the path for which permission details are being shown.
echo "Permissions for: $PATH_INPUT"

# Use the stat command to display:
# %A -> File permissions in symbolic format (e.g., rwxr-xr-x)
# %U -> Owner of the file or directory
# %G -> Group ownership of the file or directory
stat -c "Permissions: %A | Owner: %U | Group: %G" "$PATH_INPUT"
