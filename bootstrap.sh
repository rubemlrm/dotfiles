#!/bin/bash
CWD=$(pwd)
USERHOME="/home/$(whoami)"
export CWD
export USERHOME

#Create base structure
echo -e "\033[1;33m Creating base strucure \033[0m"
# save current directory to path
mkdir -p "$USERHOME/bin"

echo -e "\033[1;33m Cleaning old files \033[0m"
rm -rf "$USERHOME/.oh-my-zsh/"
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
rm -rf "$USERHOME/.tmux/"
rm -rf "$USERHOME/.tmux.conf"
rm -rf "$USERHOME/.gitconfig"
rm -rf "$USERHOME/.gitignore"
rm -rf "$USERHOME/.gitattributes"
rm -rf "$USERHOME/.npmrc"
rm -rf "$USERHOME/.gitconfig-default"
stow -vSt ~ stow
echo -e "\033[1;33m cloning oh-my-zsh \033[0m"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended >> bootstrap_install.logs 2>>bootstrap_error_install.logs
rm -rf ~/.zshrc
stow -vSt ~ zsh

git clone https://github.com/zsh-users/zsh-autosuggestions  "$USERHOME/.config/zsh/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$USERHOME/.config/zsh/plugins/zsh-syntax-highlighting"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$USERHOME/.config/zsh/themes/powerlevel10k" >> bootstrap_install.logs 2>>bootstrap_error_install.logs

echo -e "\033[1;33m cloning custom fonts \033[0m"
mkdir -p "$USERHOME/.local/share/fonts"
cd "$USERHOME/.local/share/fonts" && curl -fLo 'Droid Sans Mono for Powerline Nerd Font Complete.otf' https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
cd  "$CWD" || exit

echo -e "\033[1;33m creating vim symlinks \033[0m"
stow -vSt ~ vim
stow -vSt ~ nvim
pip3 install --user --upgrade pynvim
vim +'PlugInstall' +qa
vim +'CocInstall coc-json coc-powershell coc-toml coc-vetur coc-python' +qa

echo -e "\033[1;33m creating tmux symlinks \033[0m"
stow -vSt ~ tmux
stow -vSt ~ terminator

echo -e "\033[1;33m creating Git and symlinks \033[0m"
stow -vSt ~ git npm

echo -e "Restore kde settings"
stow -vSt ~ kde
wget -O /home/rubemlrm/Pictures/wallhaven-8ogod1.jpg https://w.wallhaven.cc/full/8o/wallhaven-8ogod1.jpg

curl -L https://yt-dl.org/downloads/latest/youtube-dl -o "$USERHOME/bin/youtube-dl"
chmod a+rx "$USERHOME/bin/youtube-dl"
