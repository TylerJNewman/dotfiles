#!/bin/bash
# Script to switch from Oh-My-Zsh to zinit for better performance

# Set text colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Switching from Oh-My-Zsh to zinit${NC}"
echo "This script will install zinit and update your zsh configuration for better performance."
echo

# Check if we're in the dotfiles directory
if [[ ! -d "zsh" || ! -d "bin" ]]; then
  echo -e "${RED}Error: This script must be run from the dotfiles directory.${NC}"
  echo "Please run: cd ~/dotfiles && ./bin/switch-to-zinit.sh"
  exit 1
fi

# Function to backup a file
backup_file() {
  local file=$1
  if [[ -f "$file" ]]; then
    local backup="${file}.omz-backup.$(date +%Y%m%d%H%M%S)"
    echo -e "${YELLOW}Backing up ${file} to ${backup}${NC}"
    cp "$file" "$backup"
  fi
}

# Backup current configuration
echo "Backing up current configuration..."
backup_file "$HOME/.zshrc"
backup_file "$HOME/dotfiles/zsh/zshrc"

# Install zinit if not already installed
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  echo -e "${YELLOW}Installing zinit...${NC}"
  command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
  command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
    echo -e "${GREEN}Installation successful.${NC}" || \
    echo -e "${RED}Installation failed.${NC}"
fi

# Copy zinit configuration files
echo "Copying zinit configuration files..."
cp "zsh/zshrc-zinit" "zsh/zshrc"
cp "$HOME/dotfiles/zsh/zshrc" "$HOME/.zshrc"

# Update .zshrc to point to the new configuration
echo "Updating .zshrc to use zinit..."
cat > "$HOME/.zshrc" << EOF
# .zshrc - Configured to use zinit instead of Oh-My-Zsh
# This file sources the main zshrc file from the dotfiles repository

# Source the main zshrc file
if [[ -f "$HOME/dotfiles/zsh/zshrc" ]]; then
  source "$HOME/dotfiles/zsh/zshrc"
fi
EOF

# Measure shell startup time with zinit
echo -e "${YELLOW}Measuring shell startup time with zinit...${NC}"
TIMEFORMAT='%3R'
STARTUP_TIME=$( { time zsh -i -c exit; } 2>&1 )
echo -e "Shell startup time with zinit: ${GREEN}${STARTUP_TIME} seconds${NC}"

echo -e "${GREEN}Switch to zinit completed successfully!${NC}"
echo
echo "Next steps:"
echo "1. Restart your shell or run 'source ~/.zshrc' to apply the changes"
echo "2. If you encounter any issues, you can revert to Oh-My-Zsh by restoring the backup files"
echo "   - cp ~/.zshrc.omz-backup.* ~/.zshrc"
echo "   - cp ~/dotfiles/zsh/zshrc.omz-backup.* ~/dotfiles/zsh/zshrc"
echo
echo -e "${YELLOW}Note:${NC} You can safely remove Oh-My-Zsh if everything works well:"
echo "rm -rf ~/.oh-my-zsh" 