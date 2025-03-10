#!/usr/bin/env zsh
#
# File: linux.zsh
# Purpose: Essential Linux-specific configurations
# Last updated: 2024-03-07

# Core utilities
alias open="xdg-open"
alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"

# System info
alias meminfo="free -h"
alias cpuinfo="lscpu"
alias diskinfo="df -h"
alias duh="du -h --max-depth=1 | sort -hr"

# Network
alias ip="curl -s https://api.ipify.org"
alias localip="hostname -I | awk '{print \$1}'"
alias ports="netstat -tulanp"

# Process management
alias psa="ps aux"
alias psg="ps aux | rg -v rg | rg -i"

# Package management - detect distro automatically
if command -v apt &>/dev/null; then
  # Debian/Ubuntu
  alias update="sudo apt update && sudo apt upgrade -y"
  alias install="sudo apt install"
  alias remove="sudo apt remove"
elif command -v dnf &>/dev/null; then
  # Fedora/RHEL
  alias update="sudo dnf update -y"
  alias install="sudo dnf install"
  alias remove="sudo dnf remove"
elif command -v pacman &>/dev/null; then
  # Arch Linux
  alias update="sudo pacman -Syu"
  alias install="sudo pacman -S"
  alias remove="sudo pacman -R"
fi 