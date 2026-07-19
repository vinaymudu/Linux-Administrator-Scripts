# Nginx

Scripts for installing and managing Nginx web server on Linux.
Built hands-on as part of my DevOps engineering journey.

## Scripts

| Script | What it does |
|--------|--------------|
| install_nginx.sh | Installs Nginx, detecting the correct package manager across distros |
| check_nginx_status.sh | Checks if Nginx is running and shows which ports it's listening on |
| create_server_block.sh | Creates a new server block (Nginx's version of a virtual host) for a domain |
| enable_disable_site.sh | Enables or disables a server block site |
| backup_nginx_config.sh | Backs up the entire Nginx config directory before making changes |

## What I Learned So Far
- How Nginx uses server blocks instead of Apache's virtual hosts
- How Nginx's sites-available/sites-enabled structure differs from Apache's a2ensite approach
- How to detect config paths across Debian and CentOS style systems
- How to compress a config directory into a timestamped backup using tar -czf

## Goal
Becoming a DevOps Engineer — building real skills, one script at a time.
