#!/usr/bin/env zsh
#
# File: plugins.zsh
# Purpose: Plugin management with optimal loading order for 2025 recommended stack
# Last updated: 2025

# Only set up Zinit if it's already installed (don't auto-install)
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [[ -d "$ZINIT_HOME" ]]; then
  source "${ZINIT_HOME}/zinit.zsh"
  
  # Load zsh-defer first if not already available
  if ! (( $+functions[zsh-defer] )); then
    zinit light romkatv/zsh-defer
  fi
  
  # Step 1: Load zsh-completions first (before compinit)
  # Use wait'0' to load immediately after shell starts but async
  zinit ice wait'0' lucid
  zinit light zsh-users/zsh-completions
  
  # Step 2: Load fzf-tab (after compinit, but before other widgets that bind TAB)
  # Note: compinit is called in completion.zsh which is sourced before plugins.zsh
  # Load without waiting to ensure tab completion works immediately
  zinit light Aloxaf/fzf-tab
  
  # Step 3: Load autosuggestions with slight delay
  # This prevents slowdowns during initial shell startup
  zinit ice wait'0.2' lucid atload'_zsh_autosuggest_start'
  zinit light zsh-users/zsh-autosuggestions
  
  # Step 4: Load syntax highlighting with slight delay
  # This prevents slowdowns during initial shell startup
  zinit ice wait'0.1' lucid
  zinit light zdharma-continuum/fast-syntax-highlighting
  
  # Step 5: Load history substring search (after syntax highlighting)
  # Important: Load this immediately after syntax highlighting and bind keys in the atload hook
  zinit ice wait'0.1' lucid atload'bindkey "^[[A" history-substring-search-up; bindkey "^[[B" history-substring-search-down'
  zinit light zsh-users/zsh-history-substring-search
  
  # Git plugin from Oh My Zsh - defer loading since it's not needed immediately
  zinit ice wait'1' lucid
  zinit snippet OMZ::plugins/git/git.plugin.zsh
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

# Note: zoxide initialization is now handled in zoxide.zsh 