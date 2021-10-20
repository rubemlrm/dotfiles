#directories
alias works="cd ~/Works"
alias code="cd ~/Works/Code"
alias dotfiles="cd ~/Works/Code/Personal/dotfiles"
alias buildfiles="cd ~/Works/Code/Personal/buildfiles"
alias personalSite="cd ~/Works/Code/Personal/rubemlrm.github.io"
alias professionalCode="cd ~/Works/Code/Professional"
alias sandbox="cd ~/Works/Code/Sandbox"
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
alias syncDotFiles="dotfiles && git pull && bash bootstrap.sh"
alias vim='nvim'
alias vi='nvim'

#apps
alias irssi='TERM=screen-256color irssi'
alias checkBranchesToRemove='git branch -r | awk "{print $1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print $1}"'
alias removeMergedBranches='git branch -r | awk "{print $1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print $1}" | xargs git branch -d'

#docker
alias updateDockerImages='docker images --format "{{.Repository}}:{{.Tag}}" | grep ":latest" | xargs -L1 docker pull'

#python alias
alias activateVenv='source ./venv/bin/activate'
alias pr='poetry run'
alias prn='poetry shell'

#encodes
alias t64='toBase64 $1'
alias f64='fromBase64 $1'

#tmux
alias tdev='tmux new-session "tmux source-file ~/.tmux/development"'

#kubernetes
alias k='kubectl'
alias kp='kubectl get pods'
alias kn='kubectl get nodes'
alias knc='kubernetes-scaffold'
