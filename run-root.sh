#!/usr/bin/bash
ansible-playbook  -i "localhost," -c local root.yml -b --ask-become-pass