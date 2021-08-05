# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
########################
# Export Variables     #
########################
export ZSH=~/.oh-my-zsh
export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/rubemlrm/.config/composer/vendor/bin:/home/rubemlrm/.local/bin:~/.rbenv/bin:~/bin:~/bin/node_modules"

export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden'


########################
#     ZSH CONFIGS      #
########################
ZSH_CUSTOM=~/.config/zsh
plugins=(git common-aliases tmux history systemd zsh-autosuggestions zsh-syntax-highlighting)
# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
ZSH_DISABLE_COMPFIX=true
# UI settings
ZSH_THEME="powerlevel10k/powerlevel10k"
# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"
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
source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[[ -r ${TTY:-} && -w ${TTY:-} && $+commands[stty] == 1 ]] && stty -ixon <$TTY >$TTY
emulate sh -c "source /etc/profile"

source $HOME/.config/zsh/alias.zsh
source $HOME/.config/zsh/functions.zsh
