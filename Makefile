
test: test-syntax test-user-check

test-all: test test-root-check

test-user-check:
	@echo "Running check mode for user.yml"
	ansible-playbook -i "localhost," -c local --check user.yml

test-root-check:
	@echo "Running check mode for root.yml"
	ansible-playbook -i "localhost," -c local --check -b --ask-become-pass root.yml

test-syntax:
	@echo "Syntax checking user.yml"
	ansible-playbook --syntax-check user.yml

	@echo "Syntax checking root.yml"
	ansible-playbook --syntax-check root.yml
