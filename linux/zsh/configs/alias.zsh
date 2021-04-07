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
alias reload="source ~/.zshrc"
alias sf="screenfetch"
alias psa="ps aux"
alias psg="ps aux | grep "
alias ducks='du -cks * | sort -rn | head' #get biggest directories
alias distro='cat /etc/*-release'
# vimrc editing
alias ve='vim ~/.vimrc'
# zsh profile editing
alias ze='vim ~/.zshrc'
# open currenct directory on nautilus
alias op="nautilus . > /dev/null 2>&1"
alias syncDotFiles=""

#apps
alias irssi='TERM=screen-256color irssi'
alias checkBranchesToRemove='git branch -r | awk "{print $1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print $1}"'
alias removeMergedBranches='git branch -r | awk "{print $1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print $1}" | xargs git branch -d'
