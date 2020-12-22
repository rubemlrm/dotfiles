#!/bin/bash

CWD=$(pwd)
USERHOME="/home/$(whoami)"
export CWD
export USERHOME

print_message()
{
    echo -e "\033[1;33m $1 \033[0m"
}

print_sucess_message()
{
    echo -e "\033[1;33m $1 \033[0m ....... \e[32mDone\033[0m"
}

print_failed_message()
{
    echo -e "\033[1;33m $1 \033[0m ....... \e[31mFailed\033[0m"
}
export -f print_message
export -f print_sucess_message
export -f print_failed_message
