#!/bin/zsh
# ansible
alias agi='ansible-galaxy collection install -r'
alias apa='ansible-playbook setup.yaml -i inventory.yaml --ask-vault-pass --ask-become-pass --limit="$1"'
alias ave='ansible-vault encrypt'
alias avd='ansible-vault decrypt'
