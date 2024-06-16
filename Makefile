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
	MOLECULE_DISTRO="rubemlrm/fedora-ansible:40" molecule verify

.PHONY: test-fedora
# Test molecule
test-fedora:
	MOLECULE_DISTRO="rubemlrm/fedora-ansible:40" molecule test

.PHONY: test-fedora-next
# Test molecule
test-fedora-next:
	MOLECULE_DISTRO="rubemlrm/fedora-ansible:41" molecule test

.PHONY: run-playbook
# Run role against host
run-playbook:
	ansible-playbook setup/setup.yml -i setup/inventory.yml --ask-become-pass

.PHONY: symlink-role
# Create symlink to role
symlink-role:
	mkdir -p ~/.ansible/roles
	ln -s ~/Works/Code/Personal/dotfiles ~/.ansible/roles/rubemlrm.dotfiles
