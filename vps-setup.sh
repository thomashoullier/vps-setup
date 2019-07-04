#!/bin/sh
# VPS setup script over ssh.
# Arguments:
#   1: root@IP
#   2: Username to create on the remote.

# Add user and change root password.
echo "Enter:
  * Current root password
  * New root password
  * New user password"
ssh -t "$1" 'passwd; useradd --create-home '"$2"'; usermod -aG sudo '"$2"';'\
'passwd '"$2"

#ssh -t "$1" <<'ENDSSH'
#	apt update
#	apt upgrade
#	apt autoremove
	
#ENDSSH

# Changing root password
#ssh -t "$1" passwd

# Generating SSH keys and pushing it to new user.

# Connecting using new key, setup SSH on the remote and add local entry.
