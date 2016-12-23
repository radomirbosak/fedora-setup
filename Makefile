
test: test-syntax test-user-check ansible-lint

test-all: test test-root-check

test-user-check:
	@echo "Running check mode for user.yml"
	ansible-playbook -i "localhost," -c local --check user.yml
	@echo

test-root-check:
	@echo "Running check mode for root.yml"
	ansible-playbook -i "localhost," -c local --check -b --ask-become-pass root.yml
	@echo

test-syntax:
	@echo "Syntax checking user.yml"
	ansible-playbook --syntax-check user.yml
	@echo

	@echo "Syntax checking root.yml"
	ansible-playbook --syntax-check root.yml
	@echo

ansible-lint:
	@echo "Running ansible-lint for user.yml"
	ansible-lint user.yml -x ANSIBLE0012
	@echo

	@echo "Running ansible-lint for root.yml"
	ansible-lint root.yml
	@echo
