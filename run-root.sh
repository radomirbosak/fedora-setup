#!/usr/bin/bash
ansible-playbook -i "localhost," -c local main.yml --tags "root" --ask-become-pass
