# Developer Workflow Enhancements

# Git workflow enhancements
if command -v git &> /dev/null; then
  # Git status shorthand
  alias gs="git status -sb"
  
  # Git log with pretty format
  alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
  
  # Git diff with word diff
  alias gd="git diff --word-diff"
  
  # Git add all and commit
  gac() {
    git add -A && git commit -m "$*"
  }
  
  # Git add all, commit, and push
  gacp() {
    git add -A && git commit -m "$*" && git push
  }
  
  # Create a new branch and switch to it
  gnb() {
    git checkout -b "$1"
  }
  
  # Delete merged branches
  gdmb() {
    git branch --merged | grep -v "\*" | grep -v "master" | grep -v "main" | xargs -n 1 git branch -d
  }
  
  # Git stash operations
  alias gst="git stash"
  alias gsp="git stash pop"
  alias gsl="git stash list"
  
  # Git reset hard
  alias grh="git reset --hard"
  
  # Git clean
  alias gclean="git clean -fd"
  
  # Git bisect helper
  gbisect() {
    git bisect start
    git bisect bad
    git bisect good "$1"
  }
fi

# GitHub CLI enhancements
if command -v gh &> /dev/null; then
  # Create PR
  alias ghpr="gh pr create"
  
  # List PRs
  alias ghprl="gh pr list"
  
  # View PR
  alias ghprv="gh pr view"
  
  # Checkout PR
  alias ghprc="gh pr checkout"
  
  # Create issue
  alias ghi="gh issue create"
  
  # List issues
  alias ghil="gh issue list"
  
  # View issue
  alias ghiv="gh issue view"
  
  # Create a new repository
  ghnew() {
    gh repo create "$1" --public
  }
fi

# Node.js development
if command -v node &> /dev/null; then
  # Run package.json scripts
  alias nr="npm run"
  
  # Update all packages
  alias ncu="npx npm-check-updates -u && npm install"
  
  # List outdated packages
  alias nco="npm outdated"
  
  # Initialize a new project
  ninit() {
    mkdir -p "$1" && cd "$1" && npm init -y
  }
  
  # Create a new TypeScript project
  tsinit() {
    mkdir -p "$1" && cd "$1" && npm init -y && npm install typescript @types/node --save-dev && npx tsc --init
  }
fi

# Docker development
if command -v docker &> /dev/null; then
  # Docker compose shortcuts
  alias dc="docker-compose"
  alias dcu="docker-compose up"
  alias dcd="docker-compose down"
  alias dcb="docker-compose build"
  
  # Docker container management
  alias dps="docker ps"
  alias dpsa="docker ps -a"
  alias dimg="docker images"
  
  # Docker cleanup
  alias dprune="docker system prune -af"
  
  # Enter a running container
  denter() {
    docker exec -it "$1" bash
  }
  
  # View container logs
  dlogs() {
    docker logs -f "$1"
  }
fi

# Kubernetes development
if command -v kubectl &> /dev/null; then
  # Kubectl shortcuts
  alias k="kubectl"
  alias kg="kubectl get"
  alias kgp="kubectl get pods"
  alias kgs="kubectl get services"
  alias kgd="kubectl get deployments"
  
  # Kubectl context and namespace management
  alias kctx="kubectl config use-context"
  alias kns="kubectl config set-context --current --namespace"
  
  # Get pod logs
  kl() {
    kubectl logs -f "$1"
  }
  
  # Execute command in pod
  kexec() {
    kubectl exec -it "$1" -- "${@:2}"
  }
  
  # Port forward
  kpf() {
    kubectl port-forward "$1" "$2:$3"
  }
fi 