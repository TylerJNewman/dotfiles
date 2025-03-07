#!/usr/bin/env zsh
# Essential macOS aliases

# Finder
alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
alias deleteDSFiles="find . -name '.DS_Store' -type f -delete"  # Alternative DS_Store cleanup

# System
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias cpu="top -l 1 -s 0 | grep 'CPU usage'"
alias mem="top -l 1 -s 0 | grep PhysMem"
alias battery="pmset -g batt | grep -E '([0-9]+\%).*' -o"
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