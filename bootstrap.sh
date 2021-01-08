#!/bin/bash

echo -e "
#===========================================#
#           DOTFILES SETUP                  #
#===========================================#"

# shellcheck disable=SC1091
. ./linux/setup/helpers.sh
bash ./linux/setup/base.install
bash ./linux/setup/javascript.install
bash ./linux/setup/php.install
bash ./linux/setup/python.install
bash ./linux/setup/restore_user_configs.sh
