#!/bin/bash

export CWD=$(pwd)
export USERHOME="/home/$(whoami)"
echo install base terminal software
sudo apt-get update > /dev/null
sudo apt-get install -y  aspell aspell-pt automake cmake ctags gcc git htop ruby tmux vim nano zsh numlockx wget exfat-utils screenfetch python3-pip python3-oauth2client curl wget vim screenfetch powerline fonts-powerline build-essential libssl-dev libreadline-dev zlib1g-dev ufw > /dev/null
bash ./linux/setup/restore_user_configs.sh
bash ./linux/setup/install_development_tools.sh
