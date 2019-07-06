#!/bin/sh
# VPS setup script over ssh.
# Arguments:
#   1: IP
#   2: Username to create on the remote.
#   3: File in which to put the SSH key on local machine.
#   4: Port to use for ssh connections with remote.

# Add user and change root password.
echo "Enter:
  * Current root password
  * New root password
  * New user password"
ssh -t root@"$1" 'passwd; adduser '"$2"';'\
'usermod -aG sudo '"$2"'; apt update; apt upgrade;'\
'apt autoremove'

# Generating SSH keys, and pushing it to new user.
ssh-keygen -f "$3"
ssh-copy-id -i "$3".pub "$2"@"$1"

# Loading the local SSH configuration file.
sshconfig=$(cat sshd_config)
#     Input correct Port
sshconfig_remote=$(echo "$sshconfig" | sed '/Port 0/c\Port '"$4"'')

echo "Adding key to local ~/.ssh/config"
echo 'Host '"$1"'
  User '"$2"'
  IdentityFile '"$3"'
  Port '"$4"'
' | sudo tee -a ~/.ssh/config
