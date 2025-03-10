#!/usr/bin/env zsh

# Custom aliases
# Inspired by Kent C. Dodds' dotfiles

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias -- -="cd -"
alias ..l="cd ../ && ll"  # Go up one level and list files

# Shortcuts
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias dc="cd ~/Documents"
alias p="cd ~/projects"
alias g="git"
alias h="history"
alias j="jobs"

# Modern CLI tools
alias cat="bat"
# Basic eza aliases (additional specialized aliases are in configs/modern-tools.zsh)
alias ls="eza --icons"                      # Basic listing with icons
alias l="eza -l --icons"                    # Long listing
alias ll="eza -la --icons"                  # Long listing with hidden files
alias lt="eza -la --tree --level=2 --icons" # Tree view (2 levels)
alias llt="eza -lT --level=3 --icons"       # Tree view (3 levels)
alias find="fd"
alias grep="rg"

# Fuzzy finder integration
alias fz="ls | fzf | xargs code"  # Fuzzy find files and open in code

# Git
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gd="git diff"
alias gl="git pull"
alias gp="git push"
alias gb="git branch"
alias glog="git log --oneline --decorate --graph"

# npm
alias ni="npm install"
alias nid="npm install --save-dev"
alias ns="npm start"
alias nt="npm test"
alias nr="npm run"
alias flush-npm="rm -rf node_modules package-lock.json && npm i"
alias check-nodemon="ps aux | grep -i '.bin/nodemon'"  # Check running nodemon processes

# yarn
alias yi="yarn install"
alias ya="yarn add"
alias yad="yarn add --dev"
alias ys="yarn start"
alias yt="yarn test"
alias yr="yarn run"

# pnpm
alias pn="pnpm"
alias pni="pnpm install"
alias pna="pnpm add"
alias pnad="pnpm add -D"
alias pns="pnpm start"
alias pnt="pnpm test"
alias pnr="pnpm run"

# Docker
alias d="docker"
alias dc="docker-compose"
alias dps="docker ps"
alias di="docker images"
alias dcu="docker-compose up"
alias dcd="docker-compose down"

# Kubernetes
alias k="kubectl"
alias kg="kubectl get"
alias kgp="kubectl get pods"
alias kd="kubectl describe"
alias kl="kubectl logs"
alias klf="kubectl logs -f"
alias ke="kubectl exec -it"

# System
alias reload="source ~/.zshrc"
alias dont-index-node-modules='fd -t d "node_modules$" -x touch "{}/.metadata_never_index" \;'

# Python
alias python=python3
alias pip=pip3 