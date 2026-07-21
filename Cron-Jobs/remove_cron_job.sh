#!/bin/bash

# This script removes a specific cron job by matching text, with confirmation

# Show current jobs first so the user knows what to remove
echo "Current cron jobs:"
crontab -l 2>/dev/null

read -p "Enter the exact text of the cron job line to remove: " JOB_TEXT

read -p "Are you sure you want to remove this job? (y/n): " CONFIRM

if [ "$CONFIRM" = "y" ]; then
    # Filter out the matching line, keep everything else
    crontab -l 2>/dev/null | grep -vF "$JOB_TEXT" | crontab -
    echo "✅ Cron job removed"
else
    echo "Cancelled"
    exit 0
fi
