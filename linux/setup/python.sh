#!/bin/bash
print_message "Setup Python Dev Environment"
MESSAGE="install PIP packages"
pip3 install --user cookiecutter virtualenvwrapper >> bootstrap_install.logs 2>>bootstrap_error_install.logs
print_feedback_message $? "$MESSAGE"