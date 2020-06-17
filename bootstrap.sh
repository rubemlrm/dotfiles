CWD=`pwd`

echo install base terminal software
YUM_CMD=$(which yum)
APT_GET_CMD=$(which apt-get)


if [[ ! -z $YUM_CMD ]]; then
    sudo yum install -y  tmux zsh vim screenfetch adobe-source-code-pro-fonts automake cmake ctags gcc-c++ gcc htop git powerline-fonts powerline tmux-powerline tmux
elif [[ ! -z $APT_GET_CMD ]]; then
    sudo apt-get install -y  tmux zsh vim screenfetch powerline fonts-powerline wget
else
    echo "error can't install package $PACKAGE"
    exit 1;
fi

#Create base structure
echo "Creating base strucure"
mkdir -p ~/bin

echo "cloning needed packages"
echo "Cloning urxvt perl extensions"
if [ ! -e ~/.urxvt/ext ]; then
    mkdir -p ~/.urxvt/ext
    git clone https://github.com/muennich/urxvt-perls.git ~/.urxvt/ext
fi

echo "cloning oh-my-zsh"
if [ ! -e ~/.oh-my-zsh/ ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi
if [ ! -e ~/.config/zsh ]; then
    mkdir ~/.config/zsh
    ln -f -s $CWD/linux/zsh/zshrc ~/.zshrc
    ln -f -s $CWD/linux/zsh/p10.zsh ~/.p10k.zsh
    ln -f -s $CWD/linux/zsh/configs ~/.config/zsh
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/plugins/zsh-syntax-highlighting
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/zsh/themes/powerlevel10k
    touch ~/.config/zsh/development.zsh
fi


echo "creating symlinks"
if [ ! -e ~/.vimrc ]; then
    ln -s -f $CWD/linux/vim/vimrc ~/.vimrc
fi

if [ ! -e ~/.vim ]; then
    ln -s -f $CWD/linux/vim/vim ~/.vim
fi

if [ ! -e ~/.Xdefaults ]; then
    ln -s -f $CWD/linux/Xsutff/Xdefaults ~/.Xdefaults
fi

if [ ! -e ~/.tmux.conf ]; then
    ln -s -f $CWD/linux/tmux/tmux.conf ~/.tmux.conf
fi

if [ ! -e ~/.config/tmux ]; then
    ln -f -s $CWD/linux/tmux/configs ~/.config/tmux
fi

echo "creating shared hosts configs"
if [ ! -e ~/.gitconfig ]; then
    ln -s -f $CWD/shared/.gitconfig ~/.gitconfig
fi

if [ ! -e ~/.gitignore ]; then
    ln -s -f $CWD/shared/.gitignore ~/.gitignore
fi

if [ ! -e ~/.npmrc ]; then
    ln -s -f $CWD/shared/.npmrc ~/.npmrc
fi

