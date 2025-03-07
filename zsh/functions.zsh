#!/usr/bin/env zsh
#
# File: functions.zsh
# Purpose: Essential shell functions

# Directory Navigation
# -------------------

# Create a directory and cd into it
function mkd() {
  mkdir -p "$@" && cd "$@" || return
}

# Change directory and list contents
function cdl() {
  cd "$@" && ls -la
}

# Development
# ----------

# Kill process on a specific port
function killport() {
  lsof -i tcp:"$*" | awk 'NR!=1 {print $2}' | xargs kill -9
}

# Extract most archive formats
function extract() {
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar e "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Git
# ---

# Simple git commit with message
function gc() {
  git commit -m "$*"
}

# System
# ------

# Get weather information
function weather() {
  curl -s "wttr.in/${1:-}?m" | grep -v "Follow"
}

# Get public IP address
function myip() {
  curl -s https://api.ipify.org && echo
}

# Create a gif from a video file
function gif() {
  if [ -z "$1" ]; then
    echo "Usage: gif <input_movie.mov> [max_width] [fps]"
    return 1
  fi
  
  local input="$1"
  local max_width="${2:-480}"
  local fps="${3:-15}"
  local output="${input%.*}.gif"
  
  ffmpeg -i "$input" -vf "fps=$fps,scale=$max_width:-1:flags=lanczos,palettegen" -y "/tmp/palette.png"
  ffmpeg -i "$input" -i "/tmp/palette.png" -lavfi "fps=$fps,scale=$max_width:-1:flags=lanczos [x]; [x][1:v] paletteuse" -y "$output"
  
  echo "Created $output"
} 