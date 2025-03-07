#!/usr/bin/env zsh
# Completion config

autoload -Uz compinit
compinit -C

setopt COMPLETE_IN_WORD ALWAYS_TO_END AUTO_MENU AUTO_LIST AUTO_PARAM_SLASH
unsetopt MENU_COMPLETE FLOW_CONTROL

# Styling
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':completion:*:matches' group 'yes'

# Fuzzy matching
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Directories
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*' squeeze-slashes true

# History
zstyle ':completion:*:history-words' remove-all-dups yes

# Kill
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'

# SSH
zstyle ':completion:*:(ssh|scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *' 