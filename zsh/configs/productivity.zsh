# Productivity Enhancements

# Fuzzy finder enhancements
if command -v fzf &> /dev/null; then
  # Enhanced Ctrl+R history search
  export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info"
  
  # Enhanced file search
  alias fzf-preview="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
  
  # Find and edit file
  fe() {
    local file=$(fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}')
    if [[ -n $file ]]; then
      ${EDITOR:-vim} "$file"
    fi
  }
  
  # Find and cd into directory
  fcd() {
    local dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m)
    if [[ -n $dir ]]; then
      cd "$dir"
    fi
  }
  
  # Git checkout branch with fzf - using command git to avoid alias conflicts
  function gcob() {
    local branches branch
    branches=$(command git branch -a) &&
    branch=$(echo "$branches" | fzf +s +m -e) &&
    command git checkout $(echo "$branch" | sed "s:.* remotes/origin/::" | sed "s:.* ::")
  }
  
  # Kill process with fzf
  fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    if [ "x$pid" != "x" ]; then
      echo $pid | xargs kill -${1:-9}
    fi
  }
fi

# Directory bookmarks
if command -v zoxide &> /dev/null; then
  # Add bookmark
  bookmark() {
    zoxide add "$1"
  }
  
  # List bookmarks
  bookmarks() {
    zoxide query -l
  }
fi

# Enhanced clipboard
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS clipboard
  alias copy="pbcopy"
  alias paste="pbpaste"
  
  # Copy current directory path
  alias cpwd="pwd | tr -d '\n' | pbcopy"
  
  # Copy file contents
  cpfile() {
    cat "$1" | pbcopy
  }
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux clipboard (requires xclip)
  if command -v xclip &> /dev/null; then
    alias copy="xclip -selection clipboard"
    alias paste="xclip -selection clipboard -o"
    alias cpwd="pwd | tr -d '\n' | xclip -selection clipboard"
    cpfile() {
      cat "$1" | xclip -selection clipboard
    }
  fi
fi

# Quick note taking
if command -v jq &> /dev/null; then
  NOTES_DIR="$HOME/.notes"
  
  # Create notes directory if it doesn't exist
  [[ ! -d "$NOTES_DIR" ]] && mkdir -p "$NOTES_DIR"
  
  # Add a quick note
  note() {
    local note_file="$NOTES_DIR/notes.md"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    
    if [[ ! -f "$note_file" ]]; then
      echo "# Quick Notes\n\n" > "$note_file"
    fi
    
    echo -e "## $timestamp\n\n$*\n" >> "$note_file"
    echo "Note added: $*"
  }
  
  # List all notes
  notes() {
    ${EDITOR:-vim} "$NOTES_DIR/notes.md"
  }
fi

# Enhanced man pages with tldr
if command -v tldr &> /dev/null; then
  alias help="tldr"
fi

# Quick HTTP server
serve() {
  local port=${1:-8000}
  echo "Starting server at http://localhost:$port"
  python3 -m http.server $port
}

# Extract various archive formats
extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
} 