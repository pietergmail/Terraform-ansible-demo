# usage
This project was developed for linux or wsl, will not work on windows.

## run terraform
   ```bash
   terraform plan
   terraform apply
   ```
## Private Key Fix

If you're facing issues with your private key, you might need to manually adjust the permissions on a Linux file system for it to work properly.

### Permissions Adjustment

To fix the issue, change the permissions on the file:
   ```bash
   chmod 600 terraform_key.pem
   ```
## ansible
Go to the ansible directory and run the playbook with the created hosts file.
   ```bash
   cd ansible_project
   ansible -i hosts.ini playbook.yml
   ```
