#!/bin/bash
set -eo pipefail

CWD=$(pwd)
USERHOME="/home/$(whoami)"
ZSH_CUSTOM="$USERHOME/.config/zsh"

export CWD
export USERHOME

echo -e "\033[1;33m Cleaning old files \033[0m"
rm -rf "$USERHOME/.zshrc"
rm -rf "$USERHOME/.p10k.zsh"
rm -rf "$USERHOME/.p10.zsh"
rm -rf "$USERHOME/.config/tmux"
rm -rf "$USERHOME/.config/zsh"
rm -rf "$USERHOME/.local/share/fonts"
rm -rf "$USERHOME/.vimrc"
rm -rf "$USERHOME/.vim"
rm -rf "$USERHOME/.nvm"
rm -rf "$USERHOME/.tmux.conf"
rm -rf "$USERHOME/.tmux/plugins"
rm -rf "$USERHOME/.npmrc"
rm -rf "$USERHOME/.gitconfig-default"
rm -rf "$USERHOME/.config/solaar"
rm -rf "$USERHOME/.oh-my-zsh-custom"

gtk3FilesToRemove=$(ls ./gtk-3.0/.config/gtk-3.0)
for item in $gtk3FilesToRemove; do
    rm -rf "$USERHOME/.config/gtk-3.0/$item"
done
gtk4FilesToRemove=$(ls ./gtk-4.0/.config/gtk-4.0)
for item in $gtk4FilesToRemove; do
    rm -rf "$USERHOME/.config/gtk-4.0/$item"
done

echo "setup krew"
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)

gem install tmuxinator

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

stow -vSt "$HOME" stow zsh vim nvim tmux i3 terminator npm neofetch gtk-3.0 gtk-4.0 solaar wallpapers alacritty picom polybar sxhkd dunst bspmw rofi networkmanager-dmenu
echo -e "\033[1;33m creating vim symlinks \033[0m"
pip3 install --user --upgrade pynvim
vim +'PlugInstall' +qa
vim +'CocInstall coc-snippets coc-json coc-powershell coc-toml coc-vetur coc-python coc-jedi' +qa
