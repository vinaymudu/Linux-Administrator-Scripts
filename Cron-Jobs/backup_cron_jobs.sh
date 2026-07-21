#!/bin/bash

# This script backs up the current user's crontab to a timestamped file

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="crontab_${TIMESTAMP}.backup"

# Save current crontab to a backup file
crontab -l 2>/dev/null > "$BACKUP_NAME"

if [ -s "$BACKUP_NAME" ]; then
    echo "✅ Crontab backed up to: $BACKUP_NAME"
else
    echo "⚠️  No cron jobs found - empty backup created"
fi
