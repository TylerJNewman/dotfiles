# Git aliases
function gc { command git commit -m "$@"; }
alias s="git status"
alias p="git pull"
alias gf="git fetch"
alias gpush="git push"
alias gd="git diff"
alias ga="git add ."
dif() { command git diff --color --no-index "$1" "$2" | diff-so-fancy; }
cdiff() { code --diff "$1" "$2"; }
# Add git=hub alias if hub is installed
alias git=hub