fedora-setup
============
My custom fedora setup using ansible.


Usage
-----

### Prerequisities for the target machine

    dnf install -y ansible git python2-dnf libselinux-python


### Local usage

Install main packages:

    ansible-playbook  -i "localhost," -c local root.yml -b --ask-become-pass

Configure fish:

    ansible-playbook  -i "localhost," -c local user.yml --ask-become-pass