#!/usr/bin/env zsh

# Custom shell functions
# Inspired by Kent C. Dodds' dotfiles

# Create a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$@" || return
}

# Create a directory and cd into it
function mg() {
  mkdir -p "$@" && cd "$@" || return
}

# Create a directory and cd into it (Oh My Zsh style)
function take() {
  mkdir -p "$@" && cd "$@" || return
}

# Change directory and list contents
function cdl() {
  cd "$@" && ls -la
}

# Go up N directories
function up() {
  local d=""
  local limit=$1
  
  # Default to 1 level
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi
  
  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done
  
  # Perform cd to the target directory
  cd "$d" || return
}

# Find and kill process by name
function findkill() {
  ps aux | grep -i "$1" | grep -v grep | awk '{print $2}' | xargs kill -9
}

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

# Create a data URL from a file
function dataurl() {
  local mimeType
  mimeType=$(file -b --mime-type "$1")
  if [[ $mimeType == text/* ]]; then
    mimeType="${mimeType};charset=utf-8"
  fi
  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Create a git.io short URL
function gitio() {
  if [ -z "${1}" ] || [ -z "${2}" ]; then
    echo "Usage: gitio <github-url> <shortcode>"
    return 1
  fi
  curl -i https://git.io/ -F "url=${1}" -F "code=${2}"
}

# Create a .tar.gz archive, using zopfli, pigz or gzip for compression
function targz() {
  local tmpFile="${1%/}.tar"
  tar -cf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1

  size=$(stat -f"%z" "${tmpFile}" 2> /dev/null)
  echo "Compressing ${tmpFile} (${size} bytes)"

  if hash pigz 2> /dev/null; then
    pigz -v "${tmpFile}" || return 1
  else
    gzip -v "${tmpFile}" || return 1
  fi

  [ -f "${tmpFile}.gz" ] && echo "${tmpFile}.gz created successfully."
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

# Get weather information
function weather() {
  local city="${1:-San Francisco}"
  curl -s "wttr.in/${city// /+}?m" | grep -v "Follow"
}

# Get IP address
function myip() {
  curl -s https://api.ipify.org
  echo
}

# Get local IP address
function localip() {
  ipconfig getifaddr en0
}

# Start an HTTP server from a directory
function server() {
  local port="${1:-8000}"
  open "http://localhost:${port}/"
  python -m http.server "$port"
}

# Generate a random password
function genpass() {
  local length="${1:-16}"
  LC_ALL=C tr -dc 'A-Za-z0-9!#$%&()*+,-./:;<=>?@[\]^_`{|}~' </dev/urandom | head -c "$length"
  echo
}

# Set random emoji for prompt
function setRandomEmoji() {
  local emojis=(
    "😀" "😃" "😄" "😁" "😆" "😅" "😂" "🤣" "😊" "😇" "🙂" "🙃" "😉" "😌" "😍" "🥰" "😘" "😗" "😙" "😚"
    "😋" "😛" "😝" "😜" "🤪" "🤨" "🧐" "🤓" "😎" "🤩" "🥳" "😏" "😒" "😞" "😔" "😟" "😕" "🙁" "☹️" "😣"
    "😖" "😫" "😩" "🥺" "😢" "😭" "😤" "😠" "😡" "🤬" "🤯" "😳" "🥵" "🥶" "😱" "😨" "😰" "😥" "😓" "🤗"
    "🤔" "🤭" "🤫" "🤥" "😶" "😐" "😑" "😬" "🙄" "😯" "😦" "😧" "😮" "😲" "🥱" "😴" "🤤" "😪" "😵" "🤐"
    "🥴" "🤢" "🤮" "🤧" "😷" "🤒" "🤕" "🤑" "🤠" "👽" "👾" "🤖" "🎃" "👻" "💩" "🦄" "🐶" "🐱" "🐭" "🐹"
    "🐰" "🦊" "🐻" "🐼" "🐨" "🐯" "🦁" "🐮" "🐷" "🐸" "🐵" "🙈" "🙉" "🙊" "🐔" "🐧" "🐦" "🐤" "🦆" "🦅"
    "🦉" "🦇" "🐺" "🐗" "🐴" "🦄" "🐝" "🐛" "🦋" "🐌" "🐞" "🐜" "🦟" "🦗" "🕷" "🕸" "🦂" "🐢" "🐍" "🦎"
    "🦖" "🦕" "🐙" "🦑" "🦐" "🦞" "🦀" "🐡" "🐠" "🐟" "🐬" "🐳" "🐋" "🦈" "🐊" "🐅" "🐆" "🦓" "🦍" "🦧"
    "🐘" "🦛" "🦏" "🐪" "🐫" "🦒" "🦘" "🐃" "🐂" "🐄" "🐎" "🐖" "🐏" "🐑" "🦙" "🐐" "🦌" "🐕" "🐩" "🦮"
    "🐕‍🦺" "🐈" "🐓" "🦃" "🦚" "🦜" "🦢" "🦩" "🕊" "🐇" "🦝" "🦨" "🦡" "🦦" "🦥" "🐁" "🐀" "🐿" "🦔"
  )
  
  local random_index=$((RANDOM % ${#emojis[@]}))
  echo "${emojis[$random_index]}"
}

# Set a new random emoji for the prompt
function newRandomEmoji() {
  PROMPT_EMOJI=$(setRandomEmoji)
  # Only show output if verbose flag is passed
  if [[ "$1" == "--verbose" ]]; then
    echo "New emoji set: $PROMPT_EMOJI"
  fi
}

# Initialize the prompt emoji if not already set
if [ -z "$PROMPT_EMOJI" ]; then
  PROMPT_EMOJI=$(setRandomEmoji)
fi 