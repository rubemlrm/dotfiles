#!/bin/zsh
########################
# Export PATH Variables#
########################

export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.local/bin:~/bin:~/.rd/bin"

# Add php packages
export PATH="$HOME/.config/composer/vendor/bin:$HOME/.symfony/bin:$PATH"

# Add node modules
export PATH="$HOME/bin/node_modules:$PATH"

# Add go bin
export PATH="$HOME/go/bin:$PATH"

# Add rofi scripts to path
export PATH="$HOME/.config/rofi/scripts/:$PATH"

# Setup kubernetes krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

########################
# Export Variables#
########################
export ZSH="$HOME/.oh-my-zsh"
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

export EDITOR=/usr/bin/vim
export K9S_EDITOR=/usr/bin/vim

if [[ $OSTYPE == 'linux-gnu'* ]]; then
    # java hack
    export _JAVA_AWT_WM_NONREPARENTING=1
    export AWT_TOOLKIT=MToolkit
fi

if [[ $OSTYPE == "darwin"* ]]; then
    # GOLANG
    export GO_PATH="$HOME/go"
    export PATH="$PATH:/$GO_PATH/bin:/Users/rubemmota/Library/Python/3.9/bin"
    export GOROOT=/usr/local/go
    export PATH="$PATH:$GOROOT/bin"
else
    export GOPATH=$HOME/go
fi

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

########################
#     ZSH CONFIGS      #
########################
ZSH_CUSTOM=~/.config/zsh
plugins=(git common-aliases tmux history ansible fzf zsh-autosuggestions brew kubectl)
# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
ZSH_DISABLE_COMPFIX=true
# UI settings
ZSH_THEME="spaceship"
# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"
SPACESHIP_KUBECTL_SHOW="true"
SPACESHIP_AWS_SHOW="true"
# set options commands
setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt HIST_VERIFY
setopt SHARE_HISTORY # share history between sessions ???
setopt EXTENDED_HISTORY # add timestamps to history
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF
setopt APPEND_HISTORY # adds history
setopt INC_APPEND_HISTORY SHARE_HISTORY  # adds history incrementally and share it across sessions
setopt HIST_IGNORE_ALL_DUPS  # don't record dupes in history
setopt HIST_REDUCE_BLANKS


########################
# source files         #
########################
source "$ZSH/oh-my-zsh.sh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# shellcheck disable=SC2203
[[ -r ${TTY:-} && -w ${TTY:-} && $+commands[stty] == 1 ]] && stty -ixon <$TTY >$TTY
emulate sh -c "source /etc/profile"
source "$HOME/.config/zsh/alias.zsh"
source "$HOME/.config/zsh/functions.zsh"
# reload kubernetes context files
reload-kubectl-contexts

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/rubemmota/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
