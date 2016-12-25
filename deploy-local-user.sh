#!/usr/bin/bash
ansible-playbook \
	-i "localhost," -c local \
	--tags "user" \
	main.yml
