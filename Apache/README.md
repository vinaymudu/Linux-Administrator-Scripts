# Apache

Scripts for installing and managing Apache web server on Linux.
Built hands-on as part of my DevOps engineering journey.

## Scripts

| Script | What it does |
|--------|--------------|
| install_apache.sh | Installs Apache, detecting the correct package manager and service name across distros |
| check_apache_status.sh | Checks if Apache is running and shows key status info |
| create_virtual_host.sh | Sets up a new virtual host configuration for a site |
| enable_disable_site.sh | Enables or disables a site configuration |
| backup_apache_config.sh | Backs up Apache config before making changes |

## What I Learned So Far
- How to detect the package manager (apt vs yum) to write distro-portable scripts
- How to install and enable a service in one line using systemctl enable --now
- How to verify a service is running using systemctl is-active --quiet
- How checking process names with ss -p requires root, and how to check by port number instead

## Goal
Becoming a DevOps Engineer — building real skills, one script at a time.
