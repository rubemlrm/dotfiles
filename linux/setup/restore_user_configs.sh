#!/bin/bash

echo -e "
#===========================================#
#           HOME SETUP                      #
#===========================================#"
#Create base structure
print_message "Creating base strucure"
mkdir -p "$USERHOME/bin"

if [ ! -e  "$USERHOME/.oh-my-zsh/" ]; then
    print_message "cloning oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    mkdir "$USERHOME/.config/zsh"
    ln -f -s "$CWD/linux/zsh/zshrc"  "$USERHOME/.zshrc"
    ln -f -s "$CWD/linux/zsh/p10.zsh" "$USERHOME/.p10k.zsh"
    ln -f -s "$CWD/linux/zsh/configs"  "$USERHOME/.config/zsh/aliases"
    if [ ! -e  "$USERHOME/.config/zsh/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions  "$USERHOME/.config/zsh/plugins/zsh-autosuggestions"
    fi
    if [ ! -e  "$USERHOME/.config/zsh/plugins/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$USERHOME/.config/zsh/plugins/zsh-syntax-highlighting"
    fi
    if [ ! -e  "$USERHOME/.config/zsh/themes/powerlevel10k" ]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$USERHOME/.config/zsh/themes/powerlevel10k"
    fi
    touch "$USERHOME/.config/zsh/development.zsh"
    mkdir -p "$USERHOME/.local/share/fonts"
    cd "$USERHOME/.local/share/fonts" && curl -fLo 'Droid Sans Mono for Powerline Nerd Font Complete.otf' https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
    cd  "$CWD" || exit
fi


print_message "creating vim symlinks"
if [ ! -e ~/.vimrc ]; then
    ln -s -f "$CWD/linux/vim/vimrc"  "$USERHOME/.vimrc"
    ln -s -f "$CWD/linux/vim/vim"  "$USERHOME/.vim"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +'PlugInstall' +qa
fi

print_message "creating tmux symlinks"
if [ ! -e ~/.tmux.conf ]; then
    ln -s -f "$CWD/linux/tmux/tmux.conf" "$USERHOME/.tmux.conf"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ ! -e ~/.config/tmux ]; then
    ln -f -s "$CWD/linux/tmux/configs"  "$USERHOME/.config/tmux"
fi

print_message "creating shared hosts configs"
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
