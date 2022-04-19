#!/bin/bash
set -eo pipefail

CWD=$(pwd)
USERHOME="/home/$(whoami)"
export CWD
export USERHOME

echo -e "\033[1;33m Cleaning old files \033[0m"
rm -rf "$USERHOME/.zshrc"
rm -rf "$USERHOME/.config/zsh"
rm -rf "$USERHOME/.p10k.zsh"
rm -rf "$USERHOME/.p10.zsh"
rm -rf "$USERHOME/.config/zsh"
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
rm -rf "$USERHOME/.config/latte"
rm -rf "$USERHOME/.config/solaar"

gtk3FilesToRemove=$(ls ./gtk-3.0/.config/gtk-3.0)
for item in $gtk3FilesToRemove; do
    rm -rf "$USERHOME/.config/gtk-3.0/$item"
done
gtk4FilesToRemove=$(ls ./gtk-4.0/.config/gtk-4.0)
for item in $gtk4FilesToRemove; do
    rm -rf "$USERHOME/.config/gtk-4.0/$item"
done

stow -vSt "$HOME" stow zsh vim nvim tmux terminator git npm neofetch gtk-3.0 gtk-4.0 solaar alacritty picom polybar sxhkd dunst bspmw rofi networkmanager-dmenu wallpapers
echo -e "\033[1;33m creating vim symlinks \033[0m"
pip3 install --user --upgrade pynvim
vim +'PlugInstall' +qa
vim +'CocInstall coc-snippets coc-json coc-powershell coc-toml coc-vetur coc-python coc-jedi' +qa
