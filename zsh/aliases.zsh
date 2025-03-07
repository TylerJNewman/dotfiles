#!/usr/bin/env zsh

# Custom aliases
# Inspired by Kent C. Dodds' dotfiles

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
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
alias ltt="eza -la --tree --level=3 --icons"
alias lttt="eza -la --tree --level=4 --icons"
alias find="fd"
alias grep="rg"

# Git
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gca="git commit -a"
alias gcam="git commit -a -m"
alias gcm="git commit -m"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gd="git diff"
alias gl="git pull"
alias gp="git push"
alias gf="git fetch"
alias gb="git branch"
alias gm="git merge"
alias grh="git reset --hard"
alias gst="git stash"
alias gstp="git stash pop"
alias glog="git log --oneline --decorate --graph"

# npm
alias ni="npm install"
alias nid="npm install --save-dev"
alias nig="npm install -g"
alias ns="npm start"
alias nt="npm test"
alias nb="npm run build"
alias nw="npm run watch"
alias nd="npm run dev"
alias nr="npm run"
alias nrm="npm run migrate"
alias nrs="npm run seed"
alias nrb="npm run build"
alias nrd="npm run dev"
alias nrt="npm run test"
alias nrtw="npm run test:watch"
alias nrv="npm run validate"
alias rmn="rm -rf node_modules"
alias flush-npm="rm -rf node_modules package-lock.json && npm i"

# yarn
alias yi="yarn install"
alias ya="yarn add"
alias yad="yarn add --dev"
alias yag="yarn global add"
alias ys="yarn start"
alias yt="yarn test"
alias yb="yarn build"
alias yd="yarn dev"
alias yr="yarn run"
alias yar="yarn run"
alias yas="yarn run start"
alias yab="yarn run build"
alias yat="yarn run test"
alias yav="yarn run validate"
alias yoff="yarn add --offline"

# pnpm
alias pn="pnpm"
alias pni="pnpm install"
alias pna="pnpm add"
alias pnad="pnpm add -D"
alias pnag="pnpm add -g"
alias pns="pnpm start"
alias pnt="pnpm test"
alias pnb="pnpm build"
alias pnd="pnpm dev"
alias pnr="pnpm run"

# Docker
alias d="docker"
alias dc="docker-compose"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias di="docker images"
alias dex="docker exec -it"
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias dcr="docker-compose restart"
alias dcp="docker-compose pull"

# Kubernetes
alias k="kubectl"
alias kg="kubectl get"
alias kgp="kubectl get pods"
alias kgs="kubectl get services"
alias kgd="kubectl get deployments"
alias kgn="kubectl get nodes"
alias kd="kubectl describe"
alias kdp="kubectl describe pod"
alias kds="kubectl describe service"
alias kdd="kubectl describe deployment"
alias kdn="kubectl describe node"
alias kl="kubectl logs"
alias klf="kubectl logs -f"
alias ke="kubectl exec -it"

# System
alias ip="curl -s https://api.ipify.org"
alias localip="ipconfig getifaddr en0"
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
alias update="sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup"
alias afk="pmset displaysleepnow"
alias screensaver="open -a ScreenSaverEngine"
alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias reload="source ~/.zshrc"
alias path='echo -e ${PATH//:/\\n}'

# Networking
alias ports="lsof -i -P | grep -i 'listen'"
alias myip="curl -s https://api.ipify.org"
alias ping="ping -c 5"
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"

# Misc
alias weather="curl -s wttr.in"
alias week="date +%V"
alias timer="echo 'Timer started. Stop with Ctrl-D.' && date && time cat && date"
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias hidehidden="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
alias showhidden="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"

# Python
alias python=python3
alias pip=pip3 