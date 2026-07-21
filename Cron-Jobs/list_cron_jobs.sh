#!/bin/bash

# This script lists all cron jobs for the current user

echo "Current cron jobs:"

# Show the crontab, or a friendly message if there are none
if ! crontab -l 2>/dev/null; then
    echo "No cron jobs found for this user"
fi
