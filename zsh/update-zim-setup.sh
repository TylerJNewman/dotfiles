#!/usr/bin/env bash
# Update script for Zim-based Zsh setup
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

# Check if command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Update Zim and modules
update_zim() {
  section "Updating Zim Framework and Modules"
  
  if [ -d "${ZDOTDIR:-${HOME}}/.zim" ]; then
    info "Updating Zim..."
    zsh -c "source ${ZDOTDIR:-${HOME}}/.zim/zimfw.zsh && zimfw update && zimfw upgrade"
    info "Zim updated successfully"
  else
    warning "Zim not found. Please run install-zim-setup.sh first."
  fi
}

# Update Starship
update_starship() {
  section "Updating Starship Prompt"
  
  if command_exists starship; then
    info "Current Starship version: $(starship --version)"
    
    if command_exists brew && brew list starship &>/dev/null; then
      info "Updating Starship via Homebrew..."
      brew upgrade starship
    else
      info "Updating Starship via installer..."
      curl -sS https://starship.rs/install.sh | sh -s -- -y
    fi
    
    info "Updated Starship version: $(starship --version)"
  else
    warning "Starship not found. Please run install-zim-setup.sh first."
  fi
}

# Update Zoxide
update_zoxide() {
  section "Updating Zoxide"
  
  if command_exists zoxide; then
    info "Current Zoxide version: $(zoxide --version)"
    
    if command_exists brew && brew list zoxide &>/dev/null; then
      info "Updating Zoxide via Homebrew..."
      brew upgrade zoxide
    elif command_exists cargo; then
      info "Updating Zoxide via Cargo..."
      cargo install zoxide
    else
      warning "No suitable method found to update Zoxide. Please update manually."
    fi
    
    info "Updated Zoxide version: $(zoxide --version)"
  else
    warning "Zoxide not found. Please run install-zim-setup.sh first."
  fi
}

# Update FZF and supporting tools
update_tools() {
  section "Updating Supporting Tools"
  
  if command_exists brew; then
    info "Updating tools via Homebrew..."
    brew upgrade fzf fd bat 2>/dev/null || true
  elif command_exists apt; then
    info "Updating tools via apt..."
    sudo apt update
    sudo apt install -y fzf fd-find bat 2>/dev/null || true
  elif command_exists pacman; then
    info "Updating tools via pacman..."
    sudo pacman -Syu fzf fd bat 2>/dev/null || true
  elif command_exists dnf; then
    info "Updating tools via dnf..."
    sudo dnf update -y fzf fd-find bat 2>/dev/null || true
  else
    warning "No suitable package manager found. Please update tools manually."
  fi
}

# Check for performance optimizations
check_performance() {
  section "Checking Performance Optimizations"
  
  # Check Starship configuration
  if [ -f "$HOME/.config/starship.toml" ]; then
    info "Checking Starship configuration..."
    
    if grep -q "command_timeout" "$HOME/.config/starship.toml"; then
      info "✓ Starship command timeout is configured"
    else
      warning "Consider adding 'command_timeout = 500' to your Starship config for better performance"
    fi
    
    if grep -q "add_newline = false" "$HOME/.config/starship.toml"; then
      info "✓ Starship newlines are optimized"
    else
      warning "Consider adding 'add_newline = false' to your Starship config for cleaner output"
    fi
  fi
  
  # Check .zshrc for performance settings
  if [ -f "$HOME/.zshrc" ]; then
    info "Checking Zsh configuration..."
    
    if grep -q "ZSH_AUTOSUGGEST_MANUAL_REBIND" "$HOME/.zshrc"; then
      info "✓ Autosuggestions are optimized"
    else
      warning "Consider adding 'export ZSH_AUTOSUGGEST_MANUAL_REBIND=1' to your .zshrc"
    fi
    
    if grep -q "DISABLE_MAGIC_FUNCTIONS" "$HOME/.zshrc"; then
      info "✓ Magic functions are disabled for better performance"
    else
      warning "Consider adding 'export DISABLE_MAGIC_FUNCTIONS=true' to your .zshrc"
    fi
    
    # Check for fast-syntax-highlighting optimizations
    if grep -q "FAST_HIGHLIGHT\[use_brackets\]" "$HOME/.zshrc"; then
      info "✓ Fast-syntax-highlighting turbo mode is enabled"
    else
      warning "Consider adding 'FAST_HIGHLIGHT[use_brackets]=1' to your .zshrc for better syntax highlighting performance"
    fi
    
    if grep -q "FAST_HIGHLIGHT\[use_pattern_search\]" "$HOME/.zshrc" && 
       grep -q "FAST_HIGHLIGHT\[use_async\]" "$HOME/.zshrc" && 
       grep -q "FAST_HIGHLIGHT\[use_shortcut_patterns\]" "$HOME/.zshrc"; then
      info "✓ Advanced fast-syntax-highlighting optimizations are enabled"
    else
      warning "Consider adding additional fast-syntax-highlighting optimizations to your .zshrc:"
      echo "  FAST_HIGHLIGHT[use_pattern_search]=1"
      echo "  FAST_HIGHLIGHT[use_async]=1"
      echo "  FAST_HIGHLIGHT[use_shortcut_patterns]=1"
    fi
  fi
  
  # Check .zimrc for unused modules
  if [ -f "$HOME/.zimrc" ]; then
    info "Checking Zim modules..."
    
    # Count number of modules
    module_count=$(grep -c "^zmodule" "$HOME/.zimrc")
    info "You have $module_count Zim modules enabled"
    
    if [ "$module_count" -gt 10 ]; then
      warning "You have many Zim modules enabled. Consider disabling unused ones for better performance."
    else
      info "✓ Module count is reasonable"
    fi
  fi
}

# Add zsh-defer for slow-initializing tools
add_zsh_defer() {
  section "Setting Up zsh-defer for Slow Tools"
  
  if [ -f "$HOME/.zimrc" ] && ! grep -q "zsh-defer" "$HOME/.zimrc"; then
    info "Adding zsh-defer to your Zim modules..."
    echo "" >> "$HOME/.zimrc"
    echo "# Deferred loading for slow-initializing tools" >> "$HOME/.zimrc"
    echo "zmodule romkatv/zsh-defer" >> "$HOME/.zimrc"
    
    info "Installing zsh-defer..."
    zsh -c "source ${ZDOTDIR:-${HOME}}/.zim/zimfw.zsh && zimfw install"
    
    info "zsh-defer installed. You can now use it in your .zshrc like this:"
    echo ""
    echo "  # Example: Defer loading of nvm"
    echo "  zsh-defer source \"\$HOME/.nvm/nvm.sh\""
    echo ""
    info "Add the above lines to your .zshrc to defer loading of slow tools."
  elif grep -q "zsh-defer" "$HOME/.zimrc"; then
    info "✓ zsh-defer is already installed"
  else
    warning "Could not find .zimrc. Please run install-zim-setup.sh first."
  fi
}

# Measure shell startup time
measure_startup_time() {
  section "Measuring Shell Startup Time"
  
  info "Running 3 trials to measure startup time..."
  for i in {1..3}; do
    echo -n "Trial $i: "
    time zsh -i -c exit
  done
  
  info "If startup time is over 200ms, consider optimizing further using the suggestions above."
}

# Main function
main() {
  section "Starting Zim Setup Update and Optimization"
  
  update_zim
  update_starship
  update_zoxide
  update_tools
  check_performance
  add_zsh_defer
  measure_startup_time
  
  section "Update Complete!"
  info "Your Zim-based Zsh setup has been updated and optimized."
  info "Please restart your shell or run 'exec zsh' to apply changes."
}

# Run the main function
main 