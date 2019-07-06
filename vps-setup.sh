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
sshconfig=$(echo "$sshconfig" | sed '/Port 0/c\Port '"$4"'')

# Put SSH configuration on remote
echo "Connecting as root to change the SSH configuration:"
ssh -t root@"$1" 'printf "%s" "'"$sshconfig"'" > /etc/ssh/sshd_config;'\
'systemctl reload sshd'

echo "Adding key to local ~/.ssh/config, enter local sudo password:"
echo 'Host '"$1"'
  User '"$2"'
  IdentityFile '"$3"'
  Port '"$4"'
' | sudo tee -a ~/.ssh/config

# Now connect one last time using the new key and finish configuration
fail2banconf=$(cat jail.local)
#     Input correct port
fail2banconf=$(echo "$fail2banconf" | sed '/port = XXXXX/c\port = '"$4"'')
uu=$(cat 50unattended-upgrades)
au=$(cat 20auto-upgrades)

echo "Connecting using new key:"
ssh -t "$2"@"$1" 'sudo ufw allow '"$4"'; sudo ufw enable;'\
'sudo apt install fail2ban;'\
'echo "'"$fail2banconf"'" | sudo tee /etc/fail2ban/jail.d/jail.local;'\
'sudo systemctl restart fail2ban;'\
'echo "'"$uu"'" | sudo tee /etc/apt/apt.conf.d/50unattended-upgrades;'\
'echo "'"$au"'" | sudo tee /etc/apt/apt.conf.d/20auto-upgrades'

