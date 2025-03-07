#!/usr/bin/env zsh

# Custom aliases
# Inspired by Kent C. Dodds' dotfiles

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias -- -="cd -"

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
alias ls="eza --icons"
alias l="eza -la --icons"
alias ll="eza -la --icons"
alias lt="eza -la --tree --level=2 --icons"
alias find="fd"
alias grep="rg"

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

# Python
alias python=python3
alias pip=pip3 