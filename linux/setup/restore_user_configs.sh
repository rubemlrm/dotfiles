#!/bin/bash

setup_zsh()
{
    print_message "cloning oh-my-zsh"
    chsh -s /usr/bin/zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended >> bootstrap_install.logs 2>>bootstrap_error_install.logs
    mkdir "$USERHOME/.config/zsh"
    ln -f -s "$CWD/linux/zsh/zshrc"  "$USERHOME/.zshrc"
    ln -f -s "$CWD/linux/zsh/p10.zsh" "$USERHOME/.p10k.zsh"
    ln -f -s "$CWD/linux/zsh/configs/"  "$USERHOME/.config/zsh/aliases"
    clone_repo https://github.com/zsh-users/zsh-autosuggestions  "$USERHOME/.config/zsh/plugins/zsh-autosuggestions"
    clone_repo https://github.com/zsh-users/zsh-syntax-highlighting.git "$USERHOME/.config/zsh/plugins/zsh-syntax-highlighting"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$USERHOME/.config/zsh/themes/powerlevel10k" >> bootstrap_install.logs 2>>bootstrap_error_install.logs
    touch "$USERHOME/.config/zsh/development.zsh"
    mkdir -p "$USERHOME/.local/share/fonts"
    cd "$USERHOME/.local/share/fonts" && curl -fLo 'Droid Sans Mono for Powerline Nerd Font Complete.otf' https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
    cd  "$CWD" || exit
}

setup_vim()
{
    print_message "creating vim symlinks"
    ln -s -f "$CWD/linux/vim/vimrc"  "$USERHOME/.vimrc"
    ln -s -f "$CWD/linux/vim/vim"  "$USERHOME/.vim"
    curl -sfLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim >> bootstrap_install.logs 2>>bootstrap_error_install.logs
    vim +'PlugInstall' +qa
}

setup_tmux()
{
    print_message "creating tmux symlinks"
    ln -s -f "$CWD/linux/tmux/tmux.conf" "$USERHOME/.tmux.conf"
    clone_repo https://github.com/tmux-plugins/tpm.git "$USERHOME/.tmux/plugins/tpm"
    ln -f -s "$CWD/linux/tmux/configs"  "$USERHOME/.config/tmux"
}

setup_git()
{
    print_message "creating shared hosts configs"
    ln -s -f "$CWD/shared/.gitconfig"  "$USERHOME/.gitconfig"
    ln -s -f "$CWD/shared/.gitignore" "$USERHOME/.gitignore"
    ln -s -f "$CWD/shared/.gitattributes" "$USERHOME/.gitattributes"
    ln -s -f "$CWD/shared/.npmrc" "$USERHOME/.npmrc"
}

setup_utils()
{
    curl -L https://yt-dl.org/downloads/latest/youtube-dl -o "$USERHOME/bin/youtube-dl"
    chmod a+rx "$USERHOME/bin/youtube-dl"
}


#Create base structure
print_message "Creating base strucure"
# save current directory to path
mkdir -p "$USERHOME/bin"
setup_zsh
setup_git
setup_tmux
setup_vim
setup_utils
