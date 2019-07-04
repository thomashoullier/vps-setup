#!/bin/sh
# VPS setup script over ssh.
# Arguments:
#   1: root@IP
#   2: Username to create on the remote.

# Add user
echo "Enter the old VPS root password and then new password for $2"
ssh -t "$1" 'useradd --create-home '"$2"'; passwd '"$2"

#ssh -t "$1" <<'ENDSSH'
#	apt update
#	apt upgrade
#	apt autoremove
	
#	echo "Adding a new user"
#	adduser "$2"
#	usermod -aG sudo "$2"
#ENDSSH

# Changing root password
#ssh -t "$1" passwd

# Generating SSH keys and pushing it to new user.

# Connecting using new key, setup SSH on the remote and add local entry.
