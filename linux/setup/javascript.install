#!/bin/bash

setup_nvm()
{
    MESSAGE="Setup NVM"
    if [ ! -e "$USERHOME/.nvm" ]; then
        print_message "Clonning nvm"
        NVM_DIR="$USERHOME/.nvm"
        clone_repo https://github.com/nvm-sh/nvm.git "$NVM_DIR"
        cd "$NVM_DIR" || exit
        # shellcheck disable=SC2046
        git checkout $(git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)) >> bootstrap_install.logs 2>>bootstrap_error_install.logs
        print_feedback_message $? "$MESSAGE"
    else
        print_sucess_message "$MESSAGE"
    fi
}
install_node()
{
    print_message "Installing NPM and Packages"
    MESSAGE="Installing Node"
    if ! [ -x "$(command -v node)" ]; then
        # shellcheck disable=SC1090
        . "$USERHOME/.nvm/nvm.sh" &&  nvm install node >> bootstrap_install.logs 2>>bootstrap_error_install.logs
        print_feedback_message $? "$MESSAGE"
    else
        print_sucess_message "$MESSAGE"
    fi
}

install_npm_packages()
{
    MESSAGE="Installing NPM packages"
    # shellcheck disable=SC1090
    . "$USERHOME/.nvm/nvm.sh" && $(command -v npm) install -g webpack jshint eslint standard >> bootstrap_install.logs 2>>bootstrap_error_install.logs
    # shellcheck disable=SC2181
    print_feedback_message $? "$MESSAGE"
}

print_message "Setup Javascript Dev Environment"
setup_nvm
install_node
install_npm_packages
