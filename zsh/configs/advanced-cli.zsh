# Advanced CLI Tool Integrations
# This file contains advanced integrations between modern CLI tools

# Function to preview directories with eza and files with bat
function preview() {
  if [ -d "$1" ]; then
    # If it's a directory, use eza/exa
    if command -v eza &> /dev/null; then
      eza -la --icons --group-directories-first "$1"
    elif command -v exa &> /dev/null; then
      exa -la --group-directories-first "$1"
    else
      ls -la "$1"
    fi
  elif [ -f "$1" ]; then
    # If it's a file, use bat
    if command -v bat &> /dev/null; then
      bat --style=numbers,grid "$1"
    else
      cat "$1"
    fi
  else
    echo "File or directory not found: $1"
  fi
}

# Function to list directory contents and preview selected file/directory with fzf
function browse() {
  local target
  if [ -z "$1" ]; then
    target="."
  else
    target="$1"
  fi
  
  if command -v fzf &> /dev/null; then
    if command -v eza &> /dev/null; then
      selected=$(eza -a --icons --group-directories-first "$target" | fzf --preview "if [ -d $target/{} ]; then eza -la --icons --group-directories-first $target/{}; else bat --color=always --style=numbers $target/{}; fi")
    elif command -v exa &> /dev/null; then
      selected=$(exa -a --group-directories-first "$target" | fzf --preview "if [ -d $target/{} ]; then exa -la --group-directories-first $target/{}; else bat --color=always --style=numbers $target/{}; fi")
    else
      selected=$(ls -a "$target" | fzf --preview "if [ -d $target/{} ]; then ls -la $target/{}; else bat --color=always --style=numbers $target/{}; fi")
    fi
    
    if [ -n "$selected" ]; then
      if [ -d "$target/$selected" ]; then
        cd "$target/$selected"
      elif [ -f "$target/$selected" ]; then
        if command -v bat &> /dev/null; then
          bat --style=numbers,grid "$target/$selected"
        else
          cat "$target/$selected"
        fi
      fi
    fi
  else
    echo "fzf is not installed. Please install it first."
  fi
}

# Function to search file contents with ripgrep and preview with bat
function search_contents() {
  if command -v rg &> /dev/null && command -v fzf &> /dev/null && command -v bat &> /dev/null; then
    local result=$(rg --color=always --line-number --no-heading --smart-case "$1" | fzf --ansi --preview "bat --color=always --highlight-line {2} {1}")
    if [ -n "$result" ]; then
      local file=$(echo "$result" | awk -F: '{print $1}')
      local line=$(echo "$result" | awk -F: '{print $2}')
      if [ -n "$EDITOR" ]; then
        $EDITOR +$line $file
      else
        bat --style=numbers,grid --highlight-line $line $file
      fi
    fi
  else
    echo "This function requires ripgrep, fzf, and bat to be installed."
  fi
}

# Alias for the search_contents function
alias sc="search_contents"

# Function to show directory tree with eza/exa and preview files with bat
function tree_preview() {
  local depth=${1:-2}
  
  if command -v eza &> /dev/null && command -v fzf &> /dev/null && command -v bat &> /dev/null; then
    local selected=$(eza -T --level=$depth --icons | fzf --ansi --preview "if [ -d {} ]; then eza -la --icons --group-directories-first {}; else bat --color=always --style=numbers {}; fi")
    if [ -n "$selected" ]; then
      if [ -d "$selected" ]; then
        cd "$selected"
      elif [ -f "$selected" ]; then
        bat --style=numbers,grid "$selected"
      fi
    fi
  elif command -v exa &> /dev/null && command -v fzf &> /dev/null && command -v bat &> /dev/null; then
    local selected=$(exa -T --level=$depth | fzf --ansi --preview "if [ -d {} ]; then exa -la --group-directories-first {}; else bat --color=always --style=numbers {}; fi")
    if [ -n "$selected" ]; then
      if [ -d "$selected" ]; then
        cd "$selected"
      elif [ -f "$selected" ]; then
        bat --style=numbers,grid "$selected"
      fi
    fi
  else
    echo "This function requires eza/exa, fzf, and bat to be installed."
  fi
}

# Alias for the tree_preview function
alias tp="tree_preview" 