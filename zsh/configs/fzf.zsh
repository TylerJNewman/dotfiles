#!/usr/bin/env zsh
# File: fzf.zsh
# Purpose: FZF configuration and integration with fzf-tab
# Last updated: 2025

# Only proceed if fzf is installed
if (( ! $+commands[fzf] )); then
  return
fi

# Source fzf keybindings and completion
# For Homebrew on Apple Silicon
if [[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/completion.zsh
elif [[ -f /usr/local/opt/fzf/shell/completion.zsh ]]; then
  # For Homebrew on Intel Mac
  source /usr/local/opt/fzf/shell/completion.zsh
elif [[ -f /usr/share/fzf/completion.zsh ]]; then
  # For Linux
  source /usr/share/fzf/completion.zsh
fi

if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
elif [[ -f /usr/local/opt/fzf/shell/key-bindings.zsh ]]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
elif [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
fi

# fzf options
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
export FZF_ALT_C_OPTS="--preview 'ls -la {}'"

# fzf-tab configuration
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with ls when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -la $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
# show previews for more commands
zstyle ':fzf-tab:complete:(ls|cat|bat|vim|nvim|nano|less):*' fzf-preview 'bat --color=always --style=numbers --line-range=:500 $realpath'

# fzf-tab configuration to prevent common issues
# Fix padding and visual glitches
zstyle ':fzf-tab:complete:*' fzf-pad 4

# Fix arrow key navigation
zstyle ':fzf-tab:*' switch-group ',' '.'

# Ensure proper completion order
zstyle ':completion:*' completer _complete _ignored _files

# Custom height for directory navigation
zstyle ':fzf-tab:complete:cd:*' fzf-command fzf --height 50%

# Preview configuration for different commands
zstyle ':fzf-tab:complete:(ls|cat|bat|vim|nvim|nano|less):*' fzf-preview 'bat --color=always --style=numbers --line-range=:500 $realpath'
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff --color=always $realpath | bat'
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo $realpath'

# Use continuous-trigger for better navigation
zstyle ':fzf-tab:*' continuous-trigger 'tab'

# Set different preview command for different file types
zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
zstyle ':fzf-tab:complete:*:directories' fzf-preview 'ls -la --color=always $realpath'

# fzf functions
# fe - fuzzy edit file
fe() {
  local file
  file=$(fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

# fh - search command history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

# fd_custom - cd to selected directory (renamed to avoid conflict with fd command)
fd_custom() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m)
  [ -n "$dir" ] && cd "$dir"
}

# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  [ -n "$pid" ] && echo $pid | xargs kill -${1:-9}
}

# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fco - checkout git commit
fco() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# Load fzf keybindings and completion
if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
elif [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
elif [[ -f /usr/local/opt/fzf/shell/key-bindings.zsh ]]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
elif [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  source /opt/homebrew/opt/fzf/shell/completion.zsh
fi

# fzf functions
function fzf-git-branch() {
  git rev-parse HEAD > /dev/null 2>&1 || return
  
  git branch --color=always --all --sort=-committerdate |
    grep -v HEAD |
    fzf --height 50% --ansi --no-multi --preview-window right:65% \
        --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
    sed "s/.* //"
}

function fzf-git-checkout() {
  git rev-parse HEAD > /dev/null 2>&1 || return
  
  local branch
  
  branch=$(fzf-git-branch)
  if [[ "$branch" = "" ]]; then
    echo "No branch selected."
    return
  fi
  
  # If branch name starts with 'remotes/' then it's a remote branch
  if [[ "$branch" = 'remotes/'* ]]; then
    # Get the branch name without the 'remotes/origin/' part
    local remoteBranch=$(echo "$branch" | sed 's/remotes\/origin\///')
    git checkout -b "$remoteBranch" --track "origin/$remoteBranch"
  else
    git checkout "$branch"
  fi
}

function fzf-git-log() {
  git rev-parse HEAD > /dev/null 2>&1 || return
  
  local commits=$(git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@")
  local commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
} 