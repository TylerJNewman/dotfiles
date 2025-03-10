#!/usr/bin/env bash
# Zim + Starship Installation Script
# This script installs a feature-rich yet optimized Zsh setup using Zim framework and Starship prompt
# Last updated: 2025

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Print section header
section() {
  echo -e "\n${BLUE}==>${NC} ${GREEN}$1${NC}"
}

# Print info message
info() {
  echo -e "${BLUE}-->${NC} $1"
}

# Print warning message
warning() {
  echo -e "${YELLOW}Warning:${NC} $1"
}

# Print error message
error() {
  echo -e "${RED}Error:${NC} $1"
}

# Check if command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Detect OS
detect_os() {
  case "$(uname -s)" in
    Darwin*)  OS="macos" ;;
    Linux*)   OS="linux" ;;
    *)        OS="unknown" ;;
  esac
  
  # Detect Linux distribution
  if [ "$OS" = "linux" ]; then
    if [ -f /etc/debian_version ]; then
      DISTRO="debian"
    elif [ -f /etc/arch-release ]; then
      DISTRO="arch"
    elif [ -f /etc/fedora-release ]; then
      DISTRO="fedora"
    else
      DISTRO="unknown"
    fi
  fi
}

# Install Zsh if not already installed
install_zsh() {
  section "Checking for Zsh"
  
  if command_exists zsh; then
    info "Zsh is already installed: $(zsh --version)"
  else
    info "Installing Zsh..."
    
    case "$OS" in
      macos)
        brew install zsh
        ;;
      linux)
        case "$DISTRO" in
          debian)
            sudo apt update
            sudo apt install -y zsh
            ;;
          arch)
            sudo pacman -S --noconfirm zsh
            ;;
          fedora)
            sudo dnf install -y zsh
            ;;
          *)
            error "Unsupported Linux distribution. Please install Zsh manually."
            exit 1
            ;;
        esac
        ;;
      *)
        error "Unsupported OS. Please install Zsh manually."
        exit 1
        ;;
    esac
    
    info "Zsh installed: $(zsh --version)"
  fi
}

# Install Zim framework
install_zim() {
  section "Installing Zim Framework"
  
  if [ -d "${ZDOTDIR:-${HOME}}/.zim" ]; then
    info "Zim is already installed"
    info "Updating Zim..."
    zsh -c "source ${ZDOTDIR:-${HOME}}/.zim/zimfw.zsh && zimfw update && zimfw upgrade"
  else
    info "Installing Zim..."
    git clone --recursive https://github.com/zimfw/zimfw.git ${ZDOTDIR:-${HOME}}/.zim
    info "Zim installed successfully"
  fi
  
  # Create .zimrc configuration
  info "Creating Zim configuration..."
  cat > "${HOME}/.zimrc" << 'EOF'
# Essential modules
zmodule Aloxaf/fzf-tab
zmodule zsh-users/zsh-autosuggestions
zmodule zdharma-continuum/fast-syntax-highlighting
zmodule hlissner/zsh-autopair

# Additional recommended modules
zmodule zsh-users/zsh-history-substring-search
zmodule ptavares/zsh-direnv

# Tools integration
zmodule junegunn/fzf --source shell/completion.zsh --source shell/key-bindings.zsh
zmodule ajeetdsouza/zoxide --cmd z --hook none

# Core modules
zmodule input
zmodule completion
zmodule environment
zmodule git
zmodule utility
zmodule archive
EOF
  
  # Install Zim modules
  info "Installing Zim modules..."
  zsh -c "source ${ZDOTDIR:-${HOME}}/.zim/zimfw.zsh && zimfw install"
}

# Install Starship prompt
install_starship() {
  section "Installing Starship Prompt"
  
  if command_exists starship; then
    info "Starship is already installed: $(starship --version)"
  else
    info "Installing Starship..."
    
    case "$OS" in
      macos)
        # Use Homebrew on macOS for better integration
        brew install starship
        ;;
      linux)
        case "$DISTRO" in
          debian|arch|fedora)
            # Use the official installer script
            curl -sS https://starship.rs/install.sh | sh -s -- -y
            ;;
          *)
            # Use the official installer script
            curl -sS https://starship.rs/install.sh | sh -s -- -y
            ;;
        esac
        ;;
      *)
        # Use the official installer script
        curl -sS https://starship.rs/install.sh | sh -s -- -y
        ;;
    esac
    
    if command_exists starship; then
      info "Starship installed successfully: $(starship --version)"
    else
      warning "Starship installation may have failed. Please install manually."
    fi
  fi
  
  # Create Starship config directory if it doesn't exist
  if [ ! -d "$HOME/.config" ]; then
    mkdir -p "$HOME/.config"
  fi
  
  # Create a Starship config if it doesn't exist
  if [ ! -f "$HOME/.config/starship.toml" ]; then
    info "Creating Starship configuration..."
    cat > "$HOME/.config/starship.toml" << 'EOF'
# Starship Configuration
# See https://starship.rs/config/ for more information

# Performance optimizations
command_timeout = 500  # Milliseconds before timing out
add_newline = false    # Disable extra newlines

# Format
format = """
$directory\
$git_branch\
$git_status\
$cmd_duration\
$character"""

# Prompt character
[character]
success_symbol = "[➜](bold green)"
error_symbol = "[➜](bold red)"
vimcmd_symbol = "[❮](bold green)"

# Directory
[directory]
truncation_length = 3
truncate_to_repo = true
style = "blue bold"

# Git branch
[git_branch]
format = "[$symbol$branch]($style) "
symbol = "🌱 "
style = "purple"

# Git status
[git_status]
format = '([\[$all_status$ahead_behind\]]($style) )'
style = "yellow"
conflicted = "🏳"
ahead = "🏎💨"
behind = "😰"
diverged = "😱"
untracked = "??"
stashed = "📦"
modified = "!"
staged = "+"
renamed = "»"
deleted = "✘"

# Command duration
[cmd_duration]
format = "[$duration]($style) "
style = "yellow"
min_time = 2000
EOF
    info "Starship configuration created at ~/.config/starship.toml"
  fi
}

# Install Zoxide
install_zoxide() {
  section "Installing Zoxide (Smart Directory Jumper)"
  
  if command_exists zoxide; then
    info "Zoxide is already installed: $(zoxide --version)"
  else
    info "Installing Zoxide..."
    
    case "$OS" in
      macos)
        brew install zoxide
        ;;
      linux)
        case "$DISTRO" in
          debian)
            sudo apt update
            sudo apt install -y zoxide
            ;;
          arch)
            sudo pacman -S --noconfirm zoxide
            ;;
          fedora)
            sudo dnf install -y zoxide
            ;;
          *)
            # Generic installation method using cargo
            if command_exists cargo; then
              cargo install zoxide
            else
              warning "Cargo not found. Please install Rust and Cargo, then run: cargo install zoxide"
            fi
            ;;
        esac
        ;;
      *)
        # Generic installation method using cargo
        if command_exists cargo; then
          cargo install zoxide
        else
          warning "Cargo not found. Please install Rust and Cargo, then run: cargo install zoxide"
        fi
        ;;
    esac
    
    if command_exists zoxide; then
      info "Zoxide installed successfully: $(zoxide --version)"
    else
      warning "Zoxide installation may have failed. Please install manually."
    fi
  fi
}

# Install FZF
install_fzf() {
  section "Installing FZF (Fuzzy Finder)"
  
  if command_exists fzf; then
    info "FZF is already installed: $(fzf --version)"
  else
    info "Installing FZF..."
    
    case "$OS" in
      macos)
        brew install fzf
        "$(brew --prefix)"/opt/fzf/install --key-bindings --completion --no-update-rc
        ;;
      linux)
        case "$DISTRO" in
          debian)
            sudo apt update
            sudo apt install -y fzf
            ;;
          arch)
            sudo pacman -S --noconfirm fzf
            ;;
          fedora)
            sudo dnf install -y fzf
            ;;
          *)
            # Generic installation method for Linux
            git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
            ~/.fzf/install --key-bindings --completion --no-update-rc
            ;;
        esac
        ;;
      *)
        # Generic installation method
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --key-bindings --completion --no-update-rc
        ;;
    esac
    
    if command_exists fzf; then
      info "FZF installed successfully: $(fzf --version)"
    else
      warning "FZF installation may have failed. Please install manually."
    fi
  fi
}

# Install fd (improved find, used by FZF)
install_fd() {
  section "Installing fd (Improved find command)"
  
  if command_exists fd; then
    info "fd is already installed: $(fd --version)"
  else
    info "Installing fd..."
    
    case "$OS" in
      macos)
        brew install fd
        ;;
      linux)
        case "$DISTRO" in
          debian)
            sudo apt update
            sudo apt install -y fd-find
            # Create symlink for fd
            if ! command_exists fd && command_exists fdfind; then
              sudo ln -s $(which fdfind) /usr/local/bin/fd
            fi
            ;;
          arch)
            sudo pacman -S --noconfirm fd
            ;;
          fedora)
            sudo dnf install -y fd-find
            ;;
          *)
            # Generic installation method using cargo
            if command_exists cargo; then
              cargo install fd-find
            else
              warning "Cargo not found. Please install Rust and Cargo, then run: cargo install fd-find"
            fi
            ;;
        esac
        ;;
      *)
        # Generic installation method using cargo
        if command_exists cargo; then
          cargo install fd-find
        else
          warning "Cargo not found. Please install Rust and Cargo, then run: cargo install fd-find"
        fi
        ;;
    esac
    
    if command_exists fd; then
      info "fd installed successfully: $(fd --version)"
    else
      warning "fd installation may have failed. Please install manually."
    fi
  fi
}

# Install bat (improved cat, used by FZF for previews)
install_bat() {
  section "Installing bat (Improved cat command)"
  
  if command_exists bat; then
    info "bat is already installed: $(bat --version)"
  else
    info "Installing bat..."
    
    case "$OS" in
      macos)
        brew install bat
        ;;
      linux)
        case "$DISTRO" in
          debian)
            sudo apt update
            sudo apt install -y bat
            # Create symlink for bat on some Debian-based systems
            if ! command_exists bat && command_exists batcat; then
              sudo ln -s $(which batcat) /usr/local/bin/bat
            fi
            ;;
          arch)
            sudo pacman -S --noconfirm bat
            ;;
          fedora)
            sudo dnf install -y bat
            ;;
          *)
            # Generic installation method using cargo
            if command_exists cargo; then
              cargo install bat
            else
              warning "Cargo not found. Please install Rust and Cargo, then run: cargo install bat"
            fi
            ;;
        esac
        ;;
      *)
        # Generic installation method using cargo
        if command_exists cargo; then
          cargo install bat
        else
          warning "Cargo not found. Please install Rust and Cargo, then run: cargo install bat"
        fi
        ;;
    esac
    
    if command_exists bat; then
      info "bat installed successfully: $(bat --version)"
    else
      warning "bat installation may have failed. Please install manually."
    fi
  fi
}

# Create zshrc file
create_zshrc() {
  section "Creating Zsh Configuration"
  
  # Backup existing zshrc if it exists
  if [ -f "$HOME/.zshrc" ]; then
    info "Backing up existing .zshrc to .zshrc.bak"
    mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
  fi
  
  info "Creating new .zshrc"
  cat > "$HOME/.zshrc" << 'EOF'
# Zsh configuration with Zim framework and Starship prompt
# Last updated: 2025

# Initialize Zim
source ${ZDOTDIR:-${HOME}}/.zim/zimfw.zsh

# Performance optimizations
export DISABLE_MAGIC_FUNCTIONS=true
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Enable turbo mode for fast-syntax-highlighting (better performance)
FAST_HIGHLIGHT[use_brackets]=1
# Additional fast-syntax-highlighting optimizations
FAST_HIGHLIGHT[use_pattern_search]=1       # Use faster pattern search
FAST_HIGHLIGHT[use_async]=1                # Enable asynchronous processing
FAST_HIGHLIGHT[use_shortcut_patterns]=1    # Use shortcut patterns for common syntax

# Configure history-substring-search
bindkey '^[[A' history-substring-search-up    # Up arrow
bindkey '^[[B' history-substring-search-down  # Down arrow
bindkey '^P' history-substring-search-up      # Ctrl+P
bindkey '^N' history-substring-search-down    # Ctrl+N

# FZF configuration
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --info=inline --preview "bat --color=always --style=numbers --line-range=:500 {}"'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
export FZF_ALT_C_OPTS="--preview 'ls -la {}'"

# Uncomment to customize FZF keybindings if they conflict with your setup
# bindkey '^Y' fzf-file-widget      # Change Ctrl+T to Ctrl+Y for file search
# bindkey '^[f' fzf-cd-widget       # Change Alt+C to Alt+F for directory jump
# bindkey '^[r' fzf-history-widget  # Change Ctrl+R to Alt+R for history search

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
# customize fzf-tab appearance
zstyle ':fzf-tab:*' fzf-flags '--height=50%'

# Zoxide configuration with enhanced completion
# Note: Ongoing configuration is in zsh/configs/zoxide.zsh
eval "$(zoxide init zsh)"

# Aliases
# Modern file listing with eza
alias ls="eza --icons"
alias ll="eza -la --icons"
alias la="eza -a --icons"
alias l="eza -l --icons"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias cd="z"      # Replace cd with z for smart directory jumping
alias zi="zoxide query -i --exclude \$PWD"  # Interactive selection with fzf

# Initialize Starship prompt (must be at the end)
eval "$(starship init zsh)"
EOF
  
  info ".zshrc created successfully"
}

# Measure shell startup time
measure_startup_time() {
  section "Measuring Shell Startup Time"
  
  info "Running 3 trials to measure startup time..."
  for i in {1..3}; do
    echo -n "Trial $i: "
    time zsh -i -c exit
  done
  
  info "If startup time is over 200ms, consider optimizing further."
}

# Main function
main() {
  section "Starting Zim + Starship Installation"
  
  # Detect OS
  detect_os
  info "Detected OS: $OS"
  if [ "$OS" = "linux" ]; then
    info "Detected Linux distribution: $DISTRO"
  fi
  
  # Install tools
  install_zsh
  install_zim
  install_starship
  install_zoxide
  install_fzf
  install_fd
  install_bat
  create_zshrc
  
  section "Installation Complete!"
  info "Please restart your shell or run 'exec zsh' to apply changes."
  
  # Measure startup time
  measure_startup_time
}

# Run the main function
main 