#!/bin/bash

echo -e "
#===========================================#
#           DOTFILES SETUP                  #
#===========================================#"

# shellcheck disable=SC1091
. ./linux/setup/helpers.sh
bash ./linux/setup/base.sh
bash ./linux/setup/javascript.sh
bash ./linux/setup/php.sh
bash ./linux/setup/python.sh
bash ./linux/setup/utils.sh
bash ./linux/setup/restore_user_configs.sh
