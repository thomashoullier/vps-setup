# VPS Setup
I have too many VPS instances. Setting up a basic configuration became a chore.
Here is a basic set of scripts and instructions to setup a Ubuntu 18.04 
instance with automatic updates and features I like to see on every instance I
administer.

## Starting point
Some operations are still manual. Depending on your VPS provider, you could need
logging in some KVM to change some SSH configuration files.
We will assume the VPS is reachable by ssh via the root password.

## References
* https://stackoverflow.com/questions/305035/how-to-use-ssh-to-run-a-shell-script-on-a-remote-machine/3872762#3872762
