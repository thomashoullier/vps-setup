#!/bin/sh
# VPS setup script over ssh.
# Arguments:
#   1: user@IP

ssh "$1" <<'ENDSSH'
df
ENDSSH
