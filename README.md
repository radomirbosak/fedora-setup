fedora-setup
============
My custom fedora setup using ansible.

Currently it installs and configures fish shell, git, sublime_text, docker. Sets gnome keyboard shortcuts and enables the minimize button.
Also various packages are installed.

Usage
-----

### Prerequisities for the target machine

    dnf install -y ansible git python2-dnf libselinux-python


### Local usage
These scripts serve as convenient shortcut which just run ansible with different parameters.

Perform tasks requiring root privileges (mainly installing packages):
```console
$ ./deploy-local-root.sh
```

Perform tasks doable by user:
```console
$ ./deploy-local-user.sh
```
