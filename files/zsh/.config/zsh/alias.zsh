#!/bin/env zsh
source "$ZSH_CUSTOM/alias/ansible.zsh"
source "$ZSH_CUSTOM/alias/kubernetes.zsh"
source "$ZSH_CUSTOM/alias/networking.zsh"
source "$ZSH_CUSTOM/alias/python.zsh"
source "$ZSH_CUSTOM/alias/utils.zsh"
if [ -e "$ZSH_CUSTOM/alias/work.zsh" ]
then
    source "$ZSH_CUSTOM/alias/work.zsh"
fi
