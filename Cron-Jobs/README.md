# Cron-Jobs

Scripts for managing scheduled tasks (cron jobs) on a Linux system.
Built hands-on as part of my DevOps engineering journey.

## Scripts

| Script | What it does |
|--------|--------------|
| add_cron_job.sh | Adds a new scheduled cron job without erasing existing ones |
| list_cron_jobs.sh | Lists all current cron jobs for the user |
| remove_cron_job.sh | Removes a specific cron job by matching text, with confirmation |
| backup_cron_jobs.sh | Backs up the current crontab to a timestamped file |
| check_cron_service.sh | Checks if the cron service is running, across distro naming differences |

## What I Learned So Far
- How to add a cron job without overwriting existing ones using crontab -l and crontab -
- How to list existing cron jobs and handle the case when none exist
- How to remove a specific line from crontab using grep -v with confirmation
- How to check if a file has actual content using -s, not just existence
- How cron is named differently across distros (cron vs crond)
## Goal
Becoming a DevOps Engineer — building real skills, one script at a time.
