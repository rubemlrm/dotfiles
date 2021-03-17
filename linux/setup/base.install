#!/bin/bash

clean_user_directory() {
    print_message "Cleaning old files"
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
}

update_system() {
    MESSAGE="Update System"
    # shellcheck disable=SC2024
    sudo apt-get update >> bootstrap_install.logs 2>>bootstrap_error_install.logs
    print_feedback_message $? "$MESSAGE"
}


install_base_packages() {
    MESSAGE="Install base terminal software"
    # shellcheck disable=SC2024
    sudo apt-get install -y aspell \
        aspell-pt \
        automake \
        cmake \
        ctags \
        gcc \
        git \
        htop \
        ruby \
        tmux \
        vim \
        nano \
        zsh \
        numlockx \
        wget \
        exfat-utils \
        screenfetch \
        python3-pip \
        python3-oauth2client \
        python-virtualenv \
        curl \
        powerline \
        fonts-powerline \
        build-essential \
        libssl-dev \
        libreadline-dev \
        zlib1g-dev \
        ufw  \
        php \
        php-gd \
        php-fpm \
        php-common \
        php-json \
        php-zip \
        php-mbstring \
        php-xml \
        virtualenvwrapper >> bootstrap_install.logs 2>>bootstrap_error_install.logs
    # shellcheck disable=SC2181
    print_feedback_message $? "$MESSAGE"
}



clean_user_directory
update_system
install_base_packages
