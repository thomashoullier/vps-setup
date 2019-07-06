# VPS Setup
I have too many VPS instances. Setting up a basic configuration became a chore.
Here is a basic script to setup a Ubuntu 18.04 
instance with features I like to see on every instance I administer.

⚠ This is in a "works for me" state ⚠

## Starting point
Some operations are still manual. Depending on your VPS provider, you could need
logging in some KVM to change some SSH configuration files.
We assume the VPS is reachable by ssh with the root password.

## Usage 
Inputs are:
1. IP
1. Username to create
1. File in which to store the SSH key for new user
1. Port to configure for SSH.

For example:

```shell
./vps-setup.sh 00.00.000.000 luigi ~/.ssh/luigi-key 34323
```

## Included configuration
This script will:
* Setup a new root password.
* Setup a new user in group sudo.
* Create a new SSH key for the user.
* Configure SSH to use a custom port, and deny all connections not using keys.
* Run updates and configure `unattended-upgrades`.
* Configure a `fail2ban` jail on the SSH incoming connections.

## Testing
Passes `shellcheck`.

