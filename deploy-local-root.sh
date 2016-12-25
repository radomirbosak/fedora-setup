#!/usr/bin/bash
ansible-playbook \
	-i "localhost," -c local \
	--ask-become-pass \
	--tags "root" \
	main.yml
