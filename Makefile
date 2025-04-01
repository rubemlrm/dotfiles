.PHONY: help
# Display all commands
help: # Show this help.
	@awk '/^#/{c=substr($$0,3);next}c&&/^[[:alpha:]][[:alnum:]_-]+:/{print substr($$1,1,index($$1,":")),c}1{c=0}' $(MAKEFILE_LIST) | column -s: -t

.PHONY: lint
# Lint all files with ansible-lint
lint:
	molecule lint

.PHONY: verify-tests
# Run molecule verify tests
verify-tests:
	MOLECULE_DISTRO="geerlingguy/docker-debian12-ansible" molecule verify

.PHONY: molecule-test
# Test molecule
molecule-test:
	MOLECULE_DISTRO="geerlingguy/docker-debian12-ansible" molecule test

.PHONY: run-playbook
# Run role against host
run-playbook:
	ansible-playbook setup.yml -i inventory.yml --ask-become-pass

