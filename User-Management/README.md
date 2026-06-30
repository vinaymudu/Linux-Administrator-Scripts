# User-Management

Bash scripts for managing users on a Linux system.
Built hands-on, one script at a time, as part of my DevOps engineering journey.

## What This Folder Covers

Real tasks a Linux administrator does every day — creating users,
removing users, checking accounts, locking access, and more.

## Scripts

| Script | What it does |
|--------|--------------|
| create_user.sh | Creates a new user with a home folder and password |
| delete_user.sh | Deletes a user and their home folder, with confirmation |
| list_users.sh | Lists all regular users on the system |
| modify_user.sh | Changes user details, like adding them to a group |
| lock_user.sh | Locks a user account so they cannot log in |
| unlock_user.sh | Unlocks a previously locked user account |
| change_password.sh | Forces a password reset for a user |
| check_user_exists.sh | Checks if a username already exists on the system |
| bulk_user_create.sh | Creates many users at once from a list |
| user_activity.sh | Shows the last login time of every user |

## What I Learned So Far
- How to create users using useradd
- How to set passwords using passwd
- How to check root permissions inside a script
- How to handle errors and exit safely
- How to check if a user exists using id
- How to ask for confirmation before a risky action
- How to delete a user using userdel

## Goal
Becoming a DevOps Engineer — building real skills, one script at a time.
