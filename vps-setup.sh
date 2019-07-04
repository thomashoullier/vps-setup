#!/bin/sh
# VPS setup script over ssh.
# Arguments:
#   1: IP
#   2: Username to create on the remote.
#   3: File in which to put the SSH key on local machine.

# Add user and change root password.
echo "Enter:
  * Current root password
  * New root password
  * New user password"
ssh -t root@"$1" 'passwd; useradd --create-home '"$2"';'\
'usermod -aG sudo '"$2"'; passwd '"$2"'; apt update; apt upgrade;'\
'apt autoremove'

# Generating SSH keys, pushing it to new user and adding it locally.
ssh-keygen -f "$3"
ssh-copy-id -i "$3".pub "$2"@"$1"
echo "Adding key to local ~/.ssh/config"
echo 'Host '"$1"'
  User '"$2"'
  IdentityFile '"$3"'
' | sudo tee -a ~/.ssh/config

# Connecting using new key, setup SSH on the remote and add local entry.

