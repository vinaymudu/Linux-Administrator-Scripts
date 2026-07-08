# SSH

Scripts for managing SSH keys and configuration on a Linux system.
Built hands-on as part of my DevOps engineering journey.

## Scripts

| Script | What it does |
|--------|--------------|
| generate_ssh_key.sh | Generates a new SSH key pair for secure, passwordless login |
| copy_ssh_key.sh | Copies your public key to a remote server for passwordless login |
| disable_password_auth.sh | Hardens SSH by disabling password login, allowing only key-based login |
| check_ssh_status.sh | Checks if the SSH service is running and shows its status |
| backup_ssh_config.sh | Backs up the SSH config file before making any changes |

## What I Learned So Far
- How to generate an SSH key pair using ssh-keygen
- How to check if a key already exists before creating a new one
- The difference between a public key and a private key
- How to copy a public key to a remote server using ssh-copy-id
- How to check if a command succeeded using $?
- How to edit SSH config safely using sed with backup and rollback
- How to restart services and verify success using systemctl and $?
- How commented-out config lines need special regex handling
- How to test SSH hardening safely across two real machines
- How to detect different service names across Linux distributions using systemctl list-units
- How to check service status using systemctl is-active and systemctl status
- How to create timestamped filenames using date +%Y%m%d_%H%M%S
- How to use curly braces to combine variables with extra text safely
## Goal
Becoming a DevOps Engineer — building real skills, one script at a time.
