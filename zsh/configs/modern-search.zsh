#!/usr/bin/env zsh
#
# File: modern-search.zsh
# Purpose: Enhanced configuration for modern search tools (ripgrep and fd)
# Last updated: 2025

# Check if ripgrep is installed
if command -v rg &> /dev/null; then
  # Set ripgrep config file location
  export RIPGREP_CONFIG_PATH="$HOME/dotfiles/config/ripgrep/ripgreprc"
  
  # Enhanced ripgrep aliases
  alias rgl="rg --files-with-matches"       # List only filenames
  alias rgc="rg --count"                    # Count matches
  alias rgj="rg --json"                     # Output in JSON format
  alias rgh="rg --hidden"                   # Include hidden files
  alias rgf="rg --fixed-strings"            # Literal string search (no regex)
  
  # Function to search in specific file types
  rgt() {
    if [[ -z "$1" || -z "$2" ]]; then
      echo "Usage: rgt <file-type> <pattern>"
      echo "Example: rgt js 'function'"
      return 1
    fi
    rg --type "$1" "$2"
  }
  
  # Function to search and replace in files
  rgr() {
    if [[ -z "$1" || -z "$2" ]]; then
      echo "Usage: rgr <pattern> <replacement> [path]"
      echo "Example: rgr 'old_text' 'new_text' src/"
      return 1
    fi
    
    local path="${3:-.}"
    rg "$1" --files-with-matches "$path" | xargs -I{} sed -i '' "s/$1/$2/g" {}
  }
fi

# Check if fd is installed
if command -v fd &> /dev/null; then
  # Set fd config file location if supported
  export FD_IGNORE="$HOME/dotfiles/config/fd/fdignore"
  
  # Enhanced fd aliases
  alias fdf="fd --type f"                   # Find only files
  alias fdd="fd --type d"                   # Find only directories
  alias fdh="fd --hidden"                   # Include hidden files
  alias fde="fd --extension"                # Find by extension
  
  # Function to find files by extension
  fdt() {
    if [[ -z "$1" ]]; then
      echo "Usage: fdt <extension> [path]"
      echo "Example: fdt js src/"
      return 1
    fi
    
    local path="${2:-.}"
    fd --extension "$1" "$path"
  }
  
  # Function to find and execute a command on each result
  fdx() {
    if [[ -z "$1" || -z "$2" ]]; then
      echo "Usage: fdx <pattern> <command>"
      echo "Example: fdx '\.js$' 'wc -l'"
      return 1
    fi
    
    fd "$1" -x sh -c "$2 {}"
  }
  
  # Function to find recent files
  fdr() {
    local days="${1:-7}"
    fd --changed-within "${days}d"
  }
fi 