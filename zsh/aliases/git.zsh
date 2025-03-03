# Git aliases
function gc { git commit -m "$@"; }
alias s="git status"
alias p="git pull"
alias gf="git fetch"
alias gpush="git push"
alias gd="git diff"
alias ga="git add ."
dif() { git diff --color --no-index "$1" "$2" | diff-so-fancy; }
cdiff() { code --diff "$1" "$2"; }