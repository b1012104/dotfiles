# zshrc
autoload -U compinit && compinit

## History
# History options
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space

# History settings
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

## Options
# for prompt '!'
setopt PROMPT_BANG
# Do not beep
setopt NO_LIST_BEEP
# Enable extended_glob
setopt EXTENDED_GLOB
#setopt nolistbeep

## User aliases
# ls aliases
alias ls='ls --color=auto'
alias l='ls -l'
alias la='ls -a'
alias ll='ls -la'
alias rm='rm -i'
alias mv='mv -i'
# cd aliases
alias cd-='cd -'
alias ..='cd ..'
alias ...='cd ../../'
# push and pop
alias pu=pushd
alias po=popd
# etc
alias f='fg'
alias b='bg'
alias dirs='dirs -v'
alias tmux='tmux -2'
alias cd='cdls'
alias vi='vim'

## Functions
function cdls() {
    \cd "$@" && ls;
}

## Keybind
# default keybind
bindkey -v

# ZLE vi keybind
zle -A backward-kill-word vi-backward-kill-word
zle -A backward-delete-char vi-backward-delete-char
bindkey -v "[3~" vi-delete-char # DEL key enable
bindkey -v "^A" push-line
bindkey -v '^P' history-beginning-search-backward-end
bindkey -v '^N' history-beginning-search-forward-end
bindkey -v '^Xh' _complete_help

## Prompt configure
# left prompt enable
#PROMPT='%n:%~>'
# left prompt enable
PROMPT='%n@%M:%~>'
# print job num and history num
RPROMPT='%B%j %!%b'

# Enable colors
autoload -U colors; colors	# for color
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## Completion
# compdef
compdef cdls=cd

# zstyle settings
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z} r:|[-_.]=**'
zstyle ':completion:*' format '%BCompleting %d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:(rm|diff|vimdiff|vi):*' ignore-line true
zstyle ':completion:*:*:(vi|vim|vimdiff|less|diff|cat):*' ignored-patterns '*.o' '*~' '*.class'

# Disable ctrl-s ctrl-q
stty stop undef

# keychain setting
#keychain ~/.ssh/id_rsa_github > /dev/null 2>&1
#source $HOME/.keychain/${HOSTNAME}-sh

## Change keyboard type into US
#setxkbmap us -model us101
# Japanese keyboard setting
#setxkbmap -model jp106
