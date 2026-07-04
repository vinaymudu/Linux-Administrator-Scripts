# File-Permissions

Scripts for managing file and folder permissions on a Linux system.
Built hands-on as part of my DevOps engineering journey.

## Scripts

| Script | What it does |
|--------|--------------|
| check_permissions.sh | Shows the permissions, owner, and group of a file or folder |
| set_permissions.sh | Changes file permissions safely using chmod, with validation and confirmation |
| find_world_writable.sh | Scans the system for files/folders that anyone can write to — a common security risk |
| backup_permissions.sh | Saves the current permissions of all files in a folder to a backup file |
| restore_permissions.sh | Restores permissions from a previously saved backup file |

## What I Learned So Far
- How to check if a file or folder exists using -e
- How to display permissions using stat with custom format
- How to validate input format using regex with =~
- How to safely change file permissions using chmod with confirmation
- How to save custom formatted output using find -printf
- How to write command output directly into a file using >
- How to count lines directly from a file using wc -l

## Goal
Becoming a DevOps Engineer — building real skills, one script at a time.
