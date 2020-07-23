#directories
alias works="cd ~/Works"
#networking
alias ports='netstat -tulanp'
alias eh="sudo nano /etc/hosts"
alias ch="cat /etc/hosts"
alias sysinfo="sudo rpm -qi basesystem"
alias speedtest="wget -O /dev/null https://speed.hetzner.de/100MB.bin"
alias getIp="curl ipinfo.io/ip"
#system utils
alias h='history'
alias g="git"
alias zreload="source ~/.zshrc"
alias sf="screenfetch"
alias psa="ps aux"
alias psg="ps aux | grep "
alias ducks='du -cks * | sort -rn | head' #get biggest directories
# vimrc editing
alias ve='vim ~/.vimrc'
# zsh profile editing
alias ze='vim ~/.zshrc'
# open currenct directory on nautilus
alias op="nautilus . > /dev/null 2>&1"
#apps
alias irssi='TERM=screen-256color irssi'
