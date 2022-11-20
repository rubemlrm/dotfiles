#!/bin/bash
set -eo pipefail

CWD=$(pwd)
USERHOME="/home/$(whoami)"
export CWD
export USERHOME

echo -e "\033[1;33m Cleaning old files \033[0m"
rm -rf "$USERHOME/.zshrc"
rm -rf "$USERHOME/.p10k.zsh"
rm -rf "$USERHOME/.p10.zsh"
rm -rf "$USERHOME/.config/tmux"
rm -rf "$USERHOME/.local/share/fonts"
rm -rf "$USERHOME/.vimrc"
rm -rf "$USERHOME/.vim"
rm -rf "$USERHOME/.nvm"
rm -rf "$USERHOME/.tmux.conf"
rm -rf "$USERHOME/.tmux/plugins"
rm -rf "$USERHOME/.gitconfig"
rm -rf "$USERHOME/.gitignore"
rm -rf "$USERHOME/.gitattributes"
rm -rf "$USERHOME/.npmrc"
rm -rf "$USERHOME/.gitconfig-default"
rm -rf "$USERHOME/.config/solaar"

stow -vSt "$HOME" stow zsh vim nvim tmux terminator git npm neofetch solaar wallpapers alacritty
echo -e "\033[1;33m creating vim symlinks \033[0m"
pip3 install --user --upgrade pynvim
vim +'PlugInstall' +qa
vim +'CocInstall coc-snippets coc-json coc-powershell coc-toml coc-vetur coc-python coc-jedi' +qa
