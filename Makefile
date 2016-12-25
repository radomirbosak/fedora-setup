
test: test-syntax test-user-check ansible-lint

test-all: test test-root-check

test-user-check:
	@echo "Running check mode for main.yml"
	ansible-playbook -i "localhost," -c local --check main.yml --tags "user"
	@echo

test-root-check:
	@echo "Running check mode for main.yml with root privileges"
	ansible-playbook -i "localhost," -c local --check main.yml --tags "root" -K
	@echo

test-syntax:
	@echo "Syntax checking user.yml"
	ansible-playbook --syntax-check main.yml
	@echo

ansible-lint:
	@echo "Running ansible-lint for main.yml"
	ansible-lint main.yml -x ANSIBLE0012
	@echo
