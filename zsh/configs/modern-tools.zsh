#!/usr/bin/env zsh
#
# File: modern-tools.zsh
# Purpose: Enhanced configuration for modern CLI tools
# Last updated: 2025

# Enhanced eza (ls replacement) configuration
if command -v eza &> /dev/null; then
  # Specialized eza aliases (basic aliases are in aliases.zsh)
  alias lg="eza -la --group-directories-first --git --icons"  # List with git status
  alias llg="eza -l --group-directories-first --git --icons"  # List with git status (no hidden files)
  alias lss="eza -la --sort=size --icons"                     # Sort by file size
  alias lsm="eza -la --sort=modified --icons"                 # Sort by modification time
  alias lsg="eza -a --grid --icons"                           # Grid view
fi

# Enhanced bat (cat replacement) configuration
if command -v bat &> /dev/null; then
  # Enhanced bat configuration
  export BAT_THEME="Dracula"
  export BAT_STYLE="plain"
  
  # Additional bat aliases
  alias cath="bat --style=header,grid"                        # Show with headers and grid
  alias catp="bat --style=plain --paging=never"               # No paging
  alias catl="bat --style=numbers,grid"                       # Show line numbers
  
  # Use bat for man pages with syntax highlighting
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  
  # Use bat for help pages
  alias bathelp='bat --plain --language=help'
  help() {
    "$@" --help 2>&1 | bathelp
  }
  
  # Preview files with bat in fzf
  export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
fi

# Modern package managers
if command -v pnpm &> /dev/null; then
  # Additional pnpm aliases
  alias pnx="pnpm exec"
  alias pnd="pnpm dev"
  alias pnb="pnpm build"
fi

if command -v bun &> /dev/null; then
  alias b="bun"
  alias bi="bun install"
  alias ba="bun add"
  alias br="bun remove"
  alias bx="bun x"
  alias bd="bun dev"
  alias bb="bun build"
  alias bt="bun test"
fi

# Turborepo
if command -v turbo &> /dev/null; then
  alias tb="turbo build"
  alias td="turbo dev"
  alias tt="turbo test"
  alias tl="turbo lint"
fi

# Modern container tools
# Removed podman alias to avoid replacing Docker

if command -v lazydocker &> /dev/null; then
  alias lzd="lazydocker"
fi

# Database tools
if command -v pgcli &> /dev/null; then
  alias psql="pgcli"
fi

if command -v mycli &> /dev/null; then
  alias mysql="mycli"
fi

# Git enhancements
if command -v lazygit &> /dev/null; then
  alias lg="lazygit"
fi

# Terminal multiplexer
if command -v zellij &> /dev/null; then
  alias zj="zellij"
  alias zja="zellij attach"
  alias zjl="zellij list-sessions"
fi

# Delta for git diff
if command -v delta &> /dev/null; then
  export GIT_PAGER="delta"
fi 