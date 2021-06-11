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
rm -rf "$USERHOME/.p10k.zsh"
rm -rf "$USERHOME/.config/zsh"
rm -rf "$USERHOME/.config/tmux"
rm -rf "$USERHOME/.local/share/fonts"
rm -rf "$USERHOME/.vimrc"
rm -rf "$USERHOME/.vim"
rm -rf "$USERHOME/.nvm"
rm -rf "$USERHOME/.tmux.conf"
rm -rf "$USERHOME/.tmux/"
rm -rf "$USERHOME/.gitconfig"
rm -rf "$USERHOME/.gitignore"
rm -rf "$USERHOME/.gitattributes"
rm -rf "$USERHOME/.npmrc"

echo -e "\033[1;33m cloning oh-my-zsh \033[0m"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended >> bootstrap_install.logs 2>>bootstrap_error_install.logs
mkdir -p "$USERHOME/.config/zsh/plugins"
ln -f -s "$CWD/configs/zsh/zshrc"  "$USERHOME/.zshrc"
ln -f -s "$CWD/configs/zsh/p10.zsh" "$USERHOME/.p10k.zsh"


ln -f -s "$CWD/configs/zsh/configs/aliases/alias.zsh"  "$USERHOME/.config/zsh/"
ln -f -s "$CWD/configs/zsh/configs/plugins/dojo"  "$USERHOME/.config/zsh/plugins/dojo"
git clone https://github.com/zsh-users/zsh-autosuggestions  "$USERHOME/.config/zsh/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$USERHOME/.config/zsh/plugins/zsh-syntax-highlighting"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$USERHOME/.config/zsh/themes/powerlevel10k" >> bootstrap_install.logs 2>>bootstrap_error_install.logs
touch "$USERHOME/.config/zsh/development.zsh"
mkdir -p "$USERHOME/.local/share/fonts"
cd "$USERHOME/.local/share/fonts" && curl -fLo 'Droid Sans Mono for Powerline Nerd Font Complete.otf' https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
cd  "$CWD" || exit

echo -e "\033[1;33m creating vim symlinks \033[0m"
ln -s -f "$CWD/configs/vim/vimrc"  "$USERHOME/.vimrc"
ln -s -f "$CWD/configs/vim/vim"  "$USERHOME/.vim"
curl -sfLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim >> bootstrap_install.logs 2>>bootstrap_error_install.logs
vim +'PlugInstall' +qa

echo -e "\033[1;33m creating tmux symlinks \033[0m"
ln -s -f "$CWD/configs/tmux/tmux.conf" "$USERHOME/.tmux.conf"
git clone https://github.com/tmux-plugins/tpm.git "$USERHOME/.tmux/plugins/tpm"
ln -f -s "$CWD/configs/tmux/configs"  "$USERHOME/.config/tmux"

echo -e "\033[1;33m creating tmux symlinks \033[0m"
ln -s -f "$CWD/configs/git/gitattributes" "$USERHOME/.gitattributes"
ln -s -f "$CWD/configs/git/gitconfig" "$USERHOME/.gitconfig"
ln -s -f "$CWD/configs/git/gitignore" "$USERHOME/.gitignore"
ln -s -f "$CWD/configs/npm/npmrc" "$USERHOME/.npmrc"
touch "$USERHOME/.gitconfig-default"

echo -e "Restore kde settings"
ln -s -f "$CWD/configs/kde/kdeglobals" "$USERHOME/.config/kdeglobals"
ln -s -f "$CWD/configs/kde/kwinrc" "$USERHOME/.config/kwinrc"
ln -s -f "$CWD/configs/kde/plasma-org.kde.plasma.desktop-appletsrc" "$USERHOME/.config/kwiplasma-org.kde.plasma.desktop-appletsrcnrc"
ln -s -f "$CWD/configs/kde/plasmarc" "$USERHOME/.config/plasmarc"
ln -s -f "$CWD/configs/kde/plasmashellrc" "$USERHOME/.config/plasmashellrc"
wget -O /home/rubemlrm/Pictures/wallhaven-8ogod1.jpg https://w.wallhaven.cc/full/8o/wallhaven-8ogod1.jpg

echo -e "Restore latte settings"
ln -s -f "$CWD/configs/latteDock/lattedockrc" "$USERHOME/.config/lattedockrc"
ln -s -f "$CWD/configs/latteDock/latte/Default.layout.latte" "$USERHOME/.config/latte/Default.layout.latte"

curl -L https://yt-dl.org/downloads/latest/youtube-dl -o "$USERHOME/bin/youtube-dl"
chmod a+rx "$USERHOME/bin/youtube-dl"
