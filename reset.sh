#!/bin/bash

export USERHOME="/home/$(whoami)"

rm -rf "$USERHOME/.oh-my-zsh/"
rm -rf "$USERHOME/.zshrc"
rm -rf "$USERHOME/.p10k.zsh"
rm -rf "$USERHOME/.config/zsh/aliases"
rm -rf "$USERHOME/.local/share/fonts"
rm -rf "$USERHOME/.vimrc"
rm -rf "$USERHOME/.vim"
rm -rf "$USERHOME/.tmux.conf"
rm -rf /.tmux/
rm -rf "$USERHOME/.gitconfig"
rm -rf "$USERHOME/.gitignore"
rm -rf "$USERHOME/.gitattributes"
rm -rf "$USERHOME/.npmrc"
