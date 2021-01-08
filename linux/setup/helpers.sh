#!/bin/bash

CWD=$(pwd)
USERHOME="/home/$(whoami)"
export CWD
export USERHOME

print_message()
{
    echo -e "\033[1;33m $1 \033[0m"
}

print_feedback_message()
{
    if [ "$1" -eq 0 ]; then
        print_sucess_message "$2"
    else
        print_failed_message "$3"
    fi
}
print_sucess_message()
{
    echo -e "\033[1;33m $1 \033[0m ....... \e[32mDone\033[0m"
}

print_failed_message()
{
    echo -e "\033[1;33m $1 \033[0m ....... \e[31mFailed\033[0m"
}

clone_repo()
{
    git clone "$1" "$2"  >> bootstrap_install.logs 2>>bootstrap_error_install.logs
}
export -f print_message
export -f print_sucess_message
export -f print_failed_message
export -f print_feedback_message
export -f clone_repo
