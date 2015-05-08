# Created by newuser for 4.3.10

# History options
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space	# do not register in the history when start with space

#History settings
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# Options
setopt PROMPT_BANG # for prompt '!'

# User aliases
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

## Suffix aliases
#alias -s c=rungcc
#
## User funection
#function rungcc () {
#	DIR=`dirname $1`
#	gcc $1 && shift && $DIR/tmp.out $@
#	rm -f $DIR/tmp.out
#}

function cdls() {
	\cd $1 && ls;
}
alias cd='cdls'

# Do not beep
setopt NO_LIST_BEEP
#setopt nolistbeep
setopt EXTENDED_GLOB

# Keybind
bindkey -v	# vi keybind

# ZLE vi configure
zle -A backward-kill-word vi-backward-kill-word
zle -A backward-delete-char vi-backward-delete-char
bindkey "[3~" vi-delete-char	# DEL key enable
bindkey -v "^A" push-line

# Prompt configure
#PROMPT='%n:%~>'	# left prompt enable
PROMPT='%n@%M:%~>'	# left prompt enable
RPROMPT='%B[%j] !%b' # job num history num

autoload -U colors; colors	# for color
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Incremental search
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end

# Completion
#zstyle ':completion:*' menu true
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z} r:|[-_.]=**'
zstyle ':completion:*' format '%BCompleting %d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:(less|rm|vi):*' ignore-line true
zstyle ':completion:*:*:(^(rm|unlink|mv)):*:*files' ignored-patterns '?*.o' '*~'
autoload -U compinit && compinit

# shell ctrl-s ctrl-q
stty stop undef

# Change keyboard type into US
#setxkbmap us -model us101
# Japanese keyboard setting
#setxkbmap -model jp106
