#!/bin/bash

CWD=$(pwd)
USERHOME="/home/$(whoami)"
print_message()
{
    echo -e "\033[1;33m $1 \033[0m"
}

print_sucess_message()
{
    echo -e "\033[1;33m $1 \033[0m ....... \e[32mDONE\033[0m"
}
export CWD
export USERHOME
export -f print_message
export -f print_sucess_message

echo install base terminal software
sudo apt-get update > /dev/null
sudo apt-get install -y  aspell aspell-pt automake cmake ctags gcc git htop ruby tmux vim nano zsh numlockx wget exfat-utils screenfetch python3-pip python3-oauth2client curl wget vim screenfetch powerline fonts-powerline build-essential libssl-dev libreadline-dev zlib1g-dev ufw > /dev/null
bash ./linux/setup/restore_user_configs.sh
bash ./linux/setup/javascript.install
bash ./linux/setup/php.install
bash ./linux/setup/python.install
bash ./linux/setup/ruby.install
