fedora-setup
============
My custom fedora setup using ansible.


Usage
-----

### Prerequisities for the target machine

    dnf install ansible git python2-dnf libselinux-python


### Local usage

    ansible-playbook  -i "localhost," -c local root.yml -b