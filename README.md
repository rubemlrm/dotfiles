Dot Files Repo for linux machines


 ![Desktop](/docs/desktop.png)


This repo provides my personal configs for the following softwares:

* Alacritty
* Bspwm
* Dunst
* Git
* Gtk
* Neofetch
* Lazygit
* NPM
* PICOM
* Polybar
* Rofi
* etc


## Install configs

### Command to Install

To install it's only need to run the following command:

```sh
ansible-playbook setup/setup.yml -i setup/inventory.yml --ask-become-pass
```
