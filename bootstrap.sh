#!/bin/bash
set -eo pipefail

CWD=$(pwd)
ZSH_CUSTOM="$HOME/.config/zsh"

export CWD
export HOME

echo -e "\033[1;33m Cleaning old files \033[0m"
rm -rf "$HOME/.zshrc"
rm -rf "$HOME/.p10k.zsh"
rm -rf "$HOME/.p10.zsh"
rm -rf "$HOME/.config/tmux"
rm -rf "$HOME/.config/zsh"
rm -rf "$HOME/.local/share/fonts"
rm -rf "$HOME/.vimrc"
rm -rf "$HOME/.vim"
rm -rf "$HOME/.nvm"
rm -rf "$HOME/.tmux.conf"
rm -rf "$HOME/.tmux/plugins"
rm -rf "$HOME/.gitconfig"
rm -rf "$HOME/.gitignore"
rm -rf "$HOME/.gitattributes"
rm -rf "$HOME/.npmrc"
rm -rf "$HOME/.gitconfig-default"
rm -rf "$HOME/.oh-my-zsh-custom"


if [[ $OSTYPE == 'linux-gnu'* ]]; then
    rm -rf "$HOME/.config/solaar"
    gtk3FilesToRemove=$(ls ./gtk-3.0/.config/gtk-3.0)
    for item in $gtk3FilesToRemove; do
        rm -rf "$HOME/.config/gtk-3.0/$item"
    done
    gtk4FilesToRemove=$(ls ./gtk-4.0/.config/gtk-4.0)
    for item in $gtk4FilesToRemove; do
        rm -rf "$HOME/.config/gtk-4.0/$item"
    done
fi



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

gem install --user-install tmuxinator

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"


if [[ $OSTYPE == 'linux-gnu'* ]]; then
    stow -vSt "$HOME" terminator gtk-3.0 gtk-4.0 solaar wallpapers alacritty picom polybar sxhkd dunst bspmw rofi networkmanager-dmenu
fi

stow -vSt "$HOME" stow zsh vim nvim tmux git npm
echo -e "\033[1;33m creating vim symlinks \033[0m"
pip3 install --user --upgrade pynvim
vim +'PlugInstall' +qa
vim +'CocInstall coc-snippets coc-json coc-powershell coc-toml coc-vetur coc-python coc-jedi' +qa
