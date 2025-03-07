#!/usr/bin/env zsh
#
# File: path.zsh
# Purpose: Minimal PATH management
# Last updated: 2024-03-07

# Core tool directories
export NVM_DIR="$HOME/.nvm"
export PNPM_HOME="$HOME/Library/pnpm"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export BUN_INSTALL="$HOME/.bun"

# PATH additions (highest to lowest priority)
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
export PATH="$HOME/bin:$HOME/dotfiles/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$PNPM_HOME:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"  # For uv and other Rust tools

# Node modules (lowest priority)
export PATH="$PATH:./node_modules/.bin:../node_modules/.bin:../../node_modules/.bin:../../../node_modules/.bin:../../../../node_modules/.bin"

# Remove duplicates
typeset -U PATH

# Helper aliases
alias path='echo -e ${PATH//:/\\n}'
alias python=python3

# Use standard pip for compatibility
alias pip=pip3
