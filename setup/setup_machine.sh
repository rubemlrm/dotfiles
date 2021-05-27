#!/bin/bash
#################################################
#               HELPER TOOLS                    #
#################################################
clone_repo()
{
    git clone "$1" "$2"  >> bootstrap_install.logs 2>>bootstrap_error_install.logs
}


#################################################
#               SYSTEM TOOLS                    #
#################################################

echo -e "\033[1;33m Update System \033[0m"
# Update System
# shellcheck disable=SC2024
sudo apt-get update >> bootstrap_install.logs 2>>bootstrap_error_install.logs
# Install packages
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
    wget \
    screenfetch \
    python3-pip \
    python-virtualenv \
    curl \
    powerline \
    fonts-powerline \
    build-essential \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    php \
    php-gd \
    php-fpm \
    php-common \
    php-json \
    php-zip \
    php-mbstring \
    php-xml >> bootstrap_install.logs 2>>bootstrap_error_install.logs

#################################################
#           DEVELOPMENT TOOLS                   #
#################################################

echo -e "\033[1;33m Setup NVM \033[0m"
NVM_DIR="$HOME/.nvm"
clone_repo https://github.com/nvm-sh/nvm.git "$NVM_DIR"
cd "$NVM_DIR" || exit
# shellcheck disable=SC2046
git checkout $(git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)) >> bootstrap_install.logs 2>>bootstrap_error_install.logs

echo -e "\033[1;33m Installing NPM and Packages \033[0m"
# shellcheck disable=SC1091
source "$HOME/.nvm/nvm.sh" &&  nvm install node >> bootstrap_install.logs 2>>bootstrap_error_install.logs
# shellcheck disable=SC1091
source "$HOME/.nvm/nvm.sh" && $(command -v npm) install -g webpack jshint eslint standard >> bootstrap_install.logs 2>>bootstrap_error_install.logs


echo -e "\033[1;33m Setup PHP Dev Environment \033[0m"
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
PHP_PACKAGES=("phpunit/phpunit" "phing/phing" "phploc/phploc" "phpmd/phpmd" "squizlabs/php_codesniffer")
INSTALLED_PACKAGES=$(composer global show)
for i in "${PHP_PACKAGES[@]}"
do
    if [ "$(echo "$INSTALLED_PACKAGES" | grep -c "$i")" -ne 1 ]; then
        composer global require "$i" -q -n
    fi
done

echo -e "\033[1;33m Setup Python Dev Environment \033[0m"
pip3 install --user cookiecutter virtualenvwrapper >> bootstrap_install.logs 2>>bootstrap_error_install.logs

echo -e "\033[1;33m Install act \033[0m"
curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
