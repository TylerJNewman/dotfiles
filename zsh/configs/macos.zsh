#!/usr/bin/env zsh
# Essential macOS aliases

# Finder
alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
alias cleanup="fd -e DS_Store -H -x rm {}"

# System
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias cpu="top -l 1 -s 0 | rg 'CPU usage'"
alias mem="top -l 1 -s 0 | rg PhysMem"
alias battery="pmset -g batt | rg -E '([0-9]+\%).*' -o"
alias ql="qlmanage -p &>/dev/null"

# Network
alias ip="curl -s https://api.ipify.org"
alias localip="ipconfig getifaddr en0"

# Clipboard
alias pbp="pbpaste"
alias pbc="pbcopy"

# Homebrew
if command -v brew &>/dev/null; then
  alias brewup="brew update && brew upgrade && brew cleanup"
fi

# Apps
alias chrome="open -a 'Google Chrome'"
alias vscode="open -a 'Visual Studio Code'"
alias cursor="open -a 'Cursor'"

# Development directories
alias code="cd ~/code"  # Navigate to code directory (alternative to 'd' which conflicts with docker) 