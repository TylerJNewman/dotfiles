#!/usr/bin/env zsh

# Custom prompt configuration
# Simple prompt showing just filename and git branch with arrow

# Load colors
autoload -U colors && colors

# Set up the prompt
setopt prompt_subst

# Function to get the current filename
function get_filename() {
  local dir="${PWD##*/}"
  if [[ "$dir" == "" ]]; then
    dir="/"
  fi
  echo "$dir"
}

# Function to get the current git branch
function get_git_branch() {
  local branch=$(command git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3-)
  if [[ -z $branch ]]; then
    branch=$(command git rev-parse --short HEAD 2>/dev/null)
  fi
  
  if [[ -n $branch ]]; then
    # Format exactly as in screenshot: git:(branch)
    echo " %{$fg[blue]%}git:(%{$fg[red]%}$branch%{$fg[blue]%})%{$reset_color%}"
  fi
}

# Set the prompt with arrow and spaces - using lighter colors to match screenshot
# Using fg instead of fg_bold for a lighter appearance
PROMPT='%{$fg[cyan]%}→%{$reset_color%}  %{$fg[green]%}$(get_filename)%{$reset_color%}$(get_git_branch) '

# No right prompt
RPROMPT='' 