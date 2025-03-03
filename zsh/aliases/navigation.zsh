# Navigation and file management aliases
alias ll="ls -1a"
alias ..="cd ../"
alias ..l="cd ../ && ll"
alias llt='ls -lt --color=auto -h'
alias de="cd ~/Desktop"
alias d="cd ~/code"
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias deleteDSFiles="find . -name '.DS_Store' -type f -delete"
alias flushdns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder"
alias dont_index_node_modules='find . -type d -name "node_modules" -exec touch "{}/.metadata_never_index" \;'
alias check-nodemon="ps aux | rg -i '.bin/nodemon'"
alias fz="ls | fzf | xargs code"
alias prompt="$HOME/dotfiles/bin/prompt-switch.sh"
