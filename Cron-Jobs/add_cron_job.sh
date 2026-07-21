#!/bin/bash

# This script adds a new cron job to the current user's crontab

# Ask for the schedule and the command to run
read -p "Enter the cron schedule (e.g. */5 * * * * for every 5 minutes): " SCHEDULE
read -p "Enter the command to run: " COMMAND

# Combine schedule and command into one cron line
CRON_LINE="$SCHEDULE $COMMAND"

# Append the new job to the existing crontab without erasing old entries
(crontab -l 2>/dev/null; echo "$CRON_LINE") | crontab -

echo "✅ Cron job added: $CRON_LINE"
