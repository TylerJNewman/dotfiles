#!/usr/bin/env zsh
#
# File: plugins.zsh
# Purpose: Minimal plugin management

# Only set up Zinit if it's already installed (don't auto-install)
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [[ -d "$ZINIT_HOME" ]]; then
  source "${ZINIT_HOME}/zinit.zsh"
  
  # Load essential plugins only
  zinit light zsh-users/zsh-autosuggestions
  zinit light zdharma-continuum/fast-syntax-highlighting
else
  # Fallback for basic functionality if Zinit isn't installed
  # Enable basic autocompletion
  autoload -Uz compinit && compinit
  zstyle ':completion:*' menu select
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
  
  # Basic history search with up/down arrows
  bindkey '^[[A' history-beginning-search-backward
  bindkey '^[[B' history-beginning-search-forward
fi 