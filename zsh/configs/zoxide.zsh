#!/usr/bin/env zsh
# File: zoxide.zsh
# Purpose: Configuration for zoxide, a smarter cd command
# Last updated: 2025

# Set zoxide data directory to prevent database corruption
export _ZO_DATA_DIR="$HOME/.local/share/zoxide"

# Exclude network mounts to prevent database corruption
export _ZO_EXCLUDE_DIRS='/mnt/*:/Volumes/*'

# Only proceed if zoxide is installed
if (( ! $+commands[zoxide] )); then
  # Provide installation instructions if zoxide is not found
  if [[ ! -f "$ZSH_CUSTOM_DIR/.zoxide_notified" ]]; then
    echo "zoxide not found. Install with:"
    echo "  brew install zoxide    # macOS"
    echo "  apt install zoxide     # Ubuntu/Debian"
    echo "  cargo install zoxide   # Using Rust"
    touch "$ZSH_CUSTOM_DIR/.zoxide_notified"
  fi
  return
fi

# Initialize zoxide with zsh integration
eval "$(zoxide init zsh)"

# Aliases for zoxide
alias cd="z"      # Replace cd with z for smart directory jumping
alias cdi="zi"    # Interactive selection with fzf

# Add current directory to zoxide database when changing directory
function chpwd() {
  zoxide add "$(pwd)"
}

# Function to list frequently visited directories
function zl() {
  zoxide query --list | sort -nr | head -n ${1:-20}
}

# Function to remove a directory from zoxide database
function zrm() {
  if [[ -z "$1" ]]; then
    echo "Usage: zrm <directory>"
    return 1
  fi
  zoxide remove "$1" && echo "Removed $1 from zoxide database"
}

# Function to jump to a directory with fzf preview
function zp() {
  local dir
  dir=$(zoxide query --list | sort -nr | fzf --preview 'ls -la {2}' | awk '{print $2}')
  if [[ -n "$dir" ]]; then
    cd "$dir"
  fi
}

# Add custom 'zi' alias for interactive mode that excludes current directory
alias zi="zoxide query -i --exclude \$PWD" 