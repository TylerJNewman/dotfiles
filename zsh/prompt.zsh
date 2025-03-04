#!/usr/bin/env zsh

# Custom prompt configuration
# Inspired by Kent C. Dodds' dotfiles

# Load colors
autoload -U colors && colors

# Load vcs_info for git branch display
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats "%{$fg[blue]%}(%{$fg[red]%}%b%{$fg[blue]%})%{$reset_color%} "
zstyle ':vcs_info:git*' actionformats "%{$fg[blue]%}(%{$fg[red]%}%b|%a%{$fg[blue]%})%{$reset_color%} "

# Set up the prompt
setopt prompt_subst

# Function to get the current directory
# Shortens the path if it's too long
function get_pwd() {
  local pwd="${PWD/#$HOME/~}"
  
  # If the path is longer than 30 characters, show only the last 2 directories
  if [[ ${#pwd} -gt 30 ]]; then
    pwd="...$(echo $pwd | awk -F/ '{print $(NF-1)"/"$NF}')";
  fi
  
  echo $pwd
}

# Function to check if we're in a git repo
function is_git_repo() {
  git rev-parse --is-inside-work-tree 2>/dev/null
}

# Function to check if there are uncommitted changes
function has_uncommitted_changes() {
  if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
    echo "%{$fg[red]%}✗%{$reset_color%}"
  else
    echo "%{$fg[green]%}✓%{$reset_color%}"
  fi
}

# Function to get the current git branch
function get_git_branch() {
  local branch=$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3-)
  if [[ -z $branch ]]; then
    branch=$(git rev-parse --short HEAD 2>/dev/null)
  fi
  echo $branch
}

# Function to get the current git status
function get_git_status() {
  if $(is_git_repo); then
    echo "$(has_uncommitted_changes) %{$fg[blue]%}($(get_git_branch))%{$reset_color%}"
  else
    echo ""
  fi
}

# Function to get the execution time of the last command
function cmd_exec_time() {
  local stop=$(date +%s)
  local start=${cmd_timestamp:-$stop}
  let local elapsed=$stop-$start
  
  if [[ $elapsed -gt 5 ]]; then
    echo "%{$fg[yellow]%}${elapsed}s%{$reset_color%} "
  fi
}

# Function to set the command timestamp
function preexec() {
  cmd_timestamp=$(date +%s)
}

# Function to reset the command timestamp
function precmd() {
  vcs_info
  unset cmd_timestamp
}

# Set the prompt
PROMPT='$PROMPT_EMOJI %{$fg[cyan]%}$(get_pwd)%{$reset_color%} $(get_git_status)
%{$fg[magenta]%}❯%{$reset_color%} '

RPROMPT='$(cmd_exec_time)'

# Initialize the prompt emoji if not already set
if [ -z "$PROMPT_EMOJI" ]; then
  source "${0:h}/functions.zsh"
  PROMPT_EMOJI=$(setRandomEmoji)
fi 