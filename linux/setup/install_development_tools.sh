#!/bin/bash

echo -e "\033[1;33m install development tools \033[0m"
sudo apt-get install -y php php-gd php-fpm php-common php-json php-zip php-mbstring php-xml python3-pip virtualenvwrapper > /dev/null
echo -e "\033[1;32m Done \033[0m \n"
echo -e "\033[1;33m install php composer packages \033[0m"
composer global require phpunit/phpunit phing/phing phploc/phploc phpmd/phpmd squizlabs/php_codesniffer > /dev/null
echo -e "\033[1;32m Done \033[0m \n"
echo -e "\033[1;33m install python packages \033[0m"
pip3 install --user cookiecutter > /dev/null
echo -e "\033[1;32m Done \033[0m \n"
echo -e "\033[1;33m install javascript packages \033[0m"
if [ ! -e "$HOME/.nvm" ]; then
    echo cloning NVM
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
fi
. ~/.nvm/nvm.sh &&  nvm install node
. ~/.nvm/nvm.sh && $(command -v npm) install -g eslint standard

if [ ! -e ~/.rbenv ]; then
    echo "clonning rbenv"
    git clone https://github.com/rbenv/rbenv.git  "$USERHOME/.rbenv"
    cd ~/.rbenv && src/configure && make -C src
    ~/.rbenv/bin/rbenv init
    # shellcheck disable=SC1090
    source  "$USERHOME/.zshrc"
    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
fi
