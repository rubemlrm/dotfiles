#!/bin/bash
CWD=$(pwd)
USERHOME="/home/$(whoami)"
print_message()
{
    echo -e "\033[1;33m $1 \033[0m"
}

print_feedback_message()
{
    if [ "$1" -eq 0 ]; then
        print_sucess_message "$2"
    else
        print_failed_message "$3"
    fi
}
print_sucess_message()
{
    echo -e "\033[1;33m $1 \033[0m ....... \e[32mDone\033[0m"
}

print_failed_message()
{
    echo -e "\033[1;33m $1 \033[0m ....... \e[31mFailed\033[0m"
}

clone_repo()
{
    git clone "$1" "$2"  >> bootstrap_install.logs 2>>bootstrap_error_install.logs
}

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

setup_nvm()
{
    MESSAGE="Setup NVM"
    if [ ! -e "$USERHOME/.nvm" ]; then
        print_message "Clonning nvm"
        NVM_DIR="$USERHOME/.nvm"
        clone_repo https://github.com/nvm-sh/nvm.git "$NVM_DIR"
        cd "$NVM_DIR" || exit
        # shellcheck disable=SC2046
        git checkout $(git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)) >> bootstrap_install.logs 2>>bootstrap_error_install.logs
        print_feedback_message $? "$MESSAGE"
    else
        print_sucess_message "$MESSAGE"
    fi
}
install_node()
{
    print_message "Installing NPM and Packages"
    MESSAGE="Installing Node"
    if ! [ -x "$(command -v node)" ]; then
        # shellcheck disable=SC1090
        . "$USERHOME/.nvm/nvm.sh" &&  nvm install node >> bootstrap_install.logs 2>>bootstrap_error_install.logs
        print_feedback_message $? "$MESSAGE"
    else
        print_sucess_message "$MESSAGE"
    fi
}

install_npm_packages()
{
    MESSAGE="Installing NPM packages"
    # shellcheck disable=SC1090
    . "$USERHOME/.nvm/nvm.sh" && $(command -v npm) install -g webpack jshint eslint standard >> bootstrap_install.logs 2>>bootstrap_error_install.logs
    # shellcheck disable=SC2181
    print_feedback_message $? "$MESSAGE"
}











# calling methods
clean_user_directory
update_system
install_base_packages

print_message "Setup Javascript Dev Environment"
setup_nvm
install_node
install_npm_packages

print_message "Setup PHP Dev Environment"
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
MESSAGE="install php composer packages"
PHP_PACKAGES=("phpunit/phpunit" "phing/phing" "phploc/phploc" "phpmd/phpmd" "squizlabs/php_codesniffer")
INSTALLED_PACKAGES=$(composer global show)
for i in "${PHP_PACKAGES[@]}"
do
    if [ "$(echo "$INSTALLED_PACKAGES" | grep -c "$i")" -ne 1 ]; then
        composer global require "$i" -q -n > /dev/null >> bootstrap_install.logs 2>>bootstrap_error_install.logs
    fi
done
print_feedback_message $? "$MESSAGE"

print_message "Setup Python Dev Environment"
MESSAGE="install PIP packages"
pip3 install --user cookiecutter virtualenvwrapper >> bootstrap_install.logs 2>>bootstrap_error_install.logs
print_feedback_message $? "$MESSAGE"

echo "Install act"
curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
