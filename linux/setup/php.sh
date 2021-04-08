#!/bin/bash

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
