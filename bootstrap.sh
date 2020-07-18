#!/bin/bash

CWD=$(pwd)
USERHOME="/home/$(whoami)"
echo install base terminal software
YUM_CMD=$(which yum)
APT_GET_CMD=$(which apt-get)


if [[ -n  $YUM_CMD ]]; then
    sudo yum install -y  tmux zsh vim screenfetch adobe-source-code-pro-fonts automake cmake ctags gcc-c++ gcc htop git powerline-fonts powerline tmux-powerline tmux
elif [[ -n $APT_GET_CMD ]]; then
   sudo apt-get update
    sudo apt-get install -y  git tmux zsh  curl wget vim screenfetch powerline fonts-powerline wget build-essential libssl-dev libreadline-dev zlib1g-dev
else
    echo "error can't install package $PACKAGE"
    exit 1;
fi

#Create base structure
echo "Creating base strucure"
mkdir -p "$USERHOME/bin"

echo "cloning needed packages"
echo "Cloning urxvt perl extensions"
if [ ! -e  "$USERHOME/.urxvt/ext" ]; then
    mkdir -p "$USERHOME/.urxvt/ext"
    git clone https://github.com/muennich/urxvt-perls.git  "$USERHOME/.urxvt/ext"
fi

echo "cloning oh-my-zsh"
if [ ! -e  "$USERHOME/.oh-my-zsh/ " ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    mkdir "$USERHOME/.config/zsh"
    ln -f -s "$CWD/linux/zsh/zshrc"  "$USERHOME/.zshrc"
    ln -f -s "$CWD/linux/zsh/p10.zsh" "$USERHOME/.p10k.zsh"
    ln -f -s "$CWD/linux/zsh/configs"  "$USERHOME/.config/zsh"
    git clone https://github.com/zsh-users/zsh-autosuggestions  "$USERHOME/.config/zsh/plugins/zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$USERHOME/.config/zsh/plugins/zsh-syntax-highlighting"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$USERHOME/.config/zsh/themes/powerlevel10k"
    touch "$USERHOME/.config/zsh/development.zsh"
    mkdir -p "$USERHOME/.local/share/fonts"
    cd "$USERHOME/.local/share/fonts" && curl -fLo 'Droid Sans Mono for Powerline Nerd Font Complete.otf' https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
    cd  "$CWD" || exit
fi


echo "creating symlinks"
if [ ! -e ~/.vimrc ]; then
    ln -s -f "$CWD/linux/vim/vimrc"  "$USERHOME/.vimrc"
    ln -s -f "$CWD/linux/vim/vim"  "$USERHOME/.vim"
    vim +'PlugInstall' +qa
fi

if [ ! -e ~/.Xdefaults ]; then
    ln -s -f "$CWD/linux/Xstuff/Xdefaults" "$USERHOME/.Xdefaults"
fi

if [ ! -e ~/.tmux.conf ]; then
    ln -s -f "$CWD/linux/tmux/tmux.conf" "$USERHOME/.tmux.conf"
fi

if [ ! -e ~/.config/tmux ]; then
    ln -f -s "$CWD/linux/tmux/configs"  "$USERHOME/.config/tmux"
fi


echo "clonning rbenv"
if [ ! -e ~/.rbenv ]; then
    git clone https://github.com/rbenv/rbenv.git  "$USERHOME/.rbenv"
    cd ~/.rbenv && src/configure && make -C src
    ~/.rbenv/bin/rbenv init
    # shellcheck disable=SC1090
    source  "$USERHOME/.zshrc"
    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
fi

echo "creating shared hosts configs"
if [ ! -e ~/.gitconfig ]; then
    ln -s -f "$CWD/shared/.gitconfig"  "$USERHOME/.gitconfig"
fi

if [ ! -e ~/.gitignore ]; then
    ln -s -f "$CWD/shared/.gitignore" "$USERHOME/.gitignore"
fi

if [ ! -e ~/.gitignore ]; then
    ln -s -f "$CWD/shared/.gitattributes" "$USERHOME/.gitattributes"
fi

if [ ! -e ~/.npmrc ]; then
    ln -s -f "$CWD/shared/.npmrc" "$USERHOME/.npmrc"
fi
