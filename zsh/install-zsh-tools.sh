#!/usr/bin/env bash
# Zsh Tools Installation Script
# This script installs the recommended tools for an optimized Zsh setup in 2025

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

# Install Zinit
install_zinit() {
  section "Installing Zinit (Plugin Manager)"
  
  ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
  
  if [ -d "$ZINIT_HOME" ]; then
    info "Zinit is already installed"
  else
    info "Installing Zinit..."
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
    info "Zinit installed successfully"
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

# Install Starship prompt
install_starship() {
  section "Installing Starship (Modern Shell Prompt)"
  
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
  
  # Create a basic Starship config if it doesn't exist
  if [ ! -f "$HOME/.config/starship.toml" ]; then
    info "Creating default Starship configuration..."
    cat > "$HOME/.config/starship.toml" << 'EOF'
# Starship Configuration
# See https://starship.rs/config/ for more information

# Format
format = """
$directory\
$git_branch\
$git_status\
$cmd_duration\
$line_break\
$character"""

# Prompt character
[character]
success_symbol = "[❯](green)"
error_symbol = "[❯](red)"
vimcmd_symbol = "[❮](green)"

# Directory
[directory]
truncation_length = 3
truncate_to_repo = true
style = "blue bold"

# Git branch
[git_branch]
format = "[$symbol$branch]($style) "
symbol = " "
style = "purple"

# Git status
[git_status]
format = '([\[$all_status$ahead_behind\]]($style) )'
style = "yellow"

# Command duration
[cmd_duration]
format = "[$duration]($style) "
style = "yellow"
min_time = 2000
EOF
    info "Default Starship configuration created at ~/.config/starship.toml"
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

# Install ripgrep (improved grep, used for searching)
install_ripgrep() {
  section "Installing ripgrep (Improved grep command)"
  
  if command_exists rg; then
    info "ripgrep is already installed: $(rg --version)"
  else
    info "Installing ripgrep..."
    
    case "$OS" in
      macos)
        brew install ripgrep
        ;;
      linux)
        case "$DISTRO" in
          debian)
            sudo apt update
            sudo apt install -y ripgrep
            ;;
          arch)
            sudo pacman -S --noconfirm ripgrep
            ;;
          fedora)
            sudo dnf install -y ripgrep
            ;;
          *)
            # Generic installation method using cargo
            if command_exists cargo; then
              cargo install ripgrep
            else
              warning "Cargo not found. Please install Rust and Cargo, then run: cargo install ripgrep"
            fi
            ;;
        esac
        ;;
      *)
        # Generic installation method using cargo
        if command_exists cargo; then
          cargo install ripgrep
        else
          warning "Cargo not found. Please install Rust and Cargo, then run: cargo install ripgrep"
        fi
        ;;
    esac
    
    if command_exists rg; then
      info "ripgrep installed successfully: $(rg --version)"
    else
      warning "ripgrep installation may have failed. Please install manually."
    fi
  fi
}

# Main function
main() {
  section "Starting Zsh Tools Installation"
  
  # Detect OS
  detect_os
  info "Detected OS: $OS"
  if [ "$OS" = "linux" ]; then
    info "Detected Linux distribution: $DISTRO"
  fi
  
  # Install tools
  install_zsh
  install_zinit
  install_fzf
  install_zoxide
  install_starship
  install_fd
  install_ripgrep
  install_bat
  
  section "Installation Complete!"
  info "Please restart your shell or run 'exec zsh' to apply changes."
  info "For more information, see the README.md file in the zsh/configs directory."
}

# Run the main function
main 