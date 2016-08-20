fedora-setup
============
My custom fedora setup using ansible.

Currently only installs a bunch of dnf packages and configures fish to be the default shell.
For fish it installs some commands, completions and abbreviations.

Usage
-----

### Prerequisities for the target machine

    dnf install -y ansible git python2-dnf libselinux-python


### Local usage

Install main packages:

    ansible-playbook  -i "localhost," -c local root.yml -b --ask-become-pass

Configure fish:

    ansible-playbook  -i "localhost," -c local user.yml --ask-become-pass
