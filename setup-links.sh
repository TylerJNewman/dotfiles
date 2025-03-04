#!/usr/bin/env bash

# Script to set up symbolic links for dotfiles
# Inspired by Kent C. Dodds' dotfiles

# Set up colors for output
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "${BLUE}Setting up dotfiles from $DOTFILES_DIR${NC}"

# Create backup directory only if needed
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
BACKUP_NEEDED=false

# Function to backup and link a file
backup_and_link() {
  local src="$1"
  local dest="$2"
  
  # Create parent directory if it doesn't exist
  mkdir -p "$(dirname "$dest")"
  
  # Check if the file exists and is already linked correctly
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo -e "${BLUE}Link from $src to $dest already exists and is correct. Skipping.${NC}"
    return 0
  fi
  
  # Backup existing file if it exists and is not a symlink to our file
  if [ -e "$dest" ]; then
    if [ ! -d "$BACKUP_DIR" ]; then
      mkdir -p "$BACKUP_DIR"
      echo -e "${YELLOW}Backup directory created at $BACKUP_DIR${NC}"
      BACKUP_NEEDED=true
    fi
    echo -e "${YELLOW}Backing up $dest to $BACKUP_DIR/$(basename "$dest")${NC}"
    mv "$dest" "$BACKUP_DIR/$(basename "$dest")"
  fi
  
  # Create symbolic link
  echo -e "${GREEN}Linking $src to $dest${NC}"
  ln -sf "$src" "$dest"
}

# Make scripts executable
echo -e "${YELLOW}Making scripts executable...${NC}"
find "$DOTFILES_DIR" -name "*.sh" -type f -exec chmod +x {} \;
if [ -d "$DOTFILES_DIR/on-login" ]; then
  find "$DOTFILES_DIR/on-login" -type f -exec chmod +x {} \;
fi

# Link Git configuration files
echo -e "${YELLOW}Setting up Git configuration...${NC}"
backup_and_link "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
backup_and_link "$DOTFILES_DIR/git/gitconfig.local" "$HOME/.gitconfig.local"
backup_and_link "$DOTFILES_DIR/git/gitignore_global" "$HOME/.gitignore_global"

# Link Zsh configuration files
echo -e "${YELLOW}Setting up Zsh configuration...${NC}"
backup_and_link "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"

# Link ripgrep configuration
echo -e "${YELLOW}Setting up ripgrep configuration...${NC}"
backup_and_link "$DOTFILES_DIR/ripgreprc" "$HOME/.ripgreprc"

# Set up macOS defaults if on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo -e "${YELLOW}Setting up macOS defaults...${NC}"
  read -p "Do you want to set up macOS defaults? This may restart some applications. (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    "$DOTFILES_DIR/macos/defaults.sh"
  fi
fi

# Set up on-login scripts
if [ -f "$DOTFILES_DIR/setup-on-login.sh" ]; then
  echo -e "${YELLOW}Setting up on-login scripts...${NC}"
  "$DOTFILES_DIR/setup-on-login.sh"
fi

# Clean up empty backup directory if no backups were needed
if [ "$BACKUP_NEEDED" = false ] && [ -d "$BACKUP_DIR" ]; then
  rmdir "$BACKUP_DIR" 2>/dev/null
fi

echo -e "${GREEN}Dotfiles setup complete!${NC}"
echo -e "${YELLOW}You may need to restart your terminal for all changes to take effect.${NC}" 