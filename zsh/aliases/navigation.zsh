# Navigation and file management aliases
alias l="ls -la"
alias ll="ls -1a"
alias la="ls -a"
alias lla="ls -la"
alias lt="ls -ltra"
alias ls="ls -G"  # Colorized output on macOS
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"
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

# Directory shortcuts
alias home="cd ~"
alias dotfiles="cd ~/dotfiles"
alias projects="cd ~/projects"

# Quick edit for common config files
alias zshrc="$EDITOR ~/.zshrc"
alias reload="source ~/.zshrc"
