#!/bin/zsh
#networking
alias ports='netstat -tulanp'
alias eh="sudo nano /etc/hosts"
alias ch="cat /etc/hosts"
alias sysinfo="sudo rpm -qi basesystem"
alias speedtest="wget -O /dev/null https://speed.hetzner.de/100MB.bin"
alias getIp="curl ipinfo.io/ip"
alias getWifiPasswords="sudo grep -r '^psk=' /etc/NetworkManager/system-connections/"
alias mac-wg-up="/opt/homebrew/bin/bash wg-quick up wg0"
alias mac-wg-down="/opt/homebrew/bin/bash wg-quick down wg0"
