#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Create dotfiles directory if it doesn't exist
mkdir -p $HOME/dotfiles

# Create symlinks
echo -e "${BLUE}Creating symlinks...${NC}"

# Backup existing .zshrc if it exists
if [ -f "$HOME/.zshrc" ]; then
  echo -e "${BLUE}Backing up existing .zshrc to .zshrc.backup${NC}"
  mv $HOME/.zshrc $HOME/.zshrc.backup
fi

# Create symlink for .zshrc
echo -e "${BLUE}Linking .zshrc${NC}"
ln -sf $HOME/dotfiles/zsh/zshrc $HOME/.zshrc

# Copy the example secrets file if env.zsh doesn't exist
if [ ! -f "$HOME/dotfiles/zsh/secrets/env.zsh" ]; then
  echo -e "${BLUE}Creating example secrets file${NC}"
  cp $HOME/dotfiles/zsh/secrets/env.zsh.example $HOME/dotfiles/zsh/secrets/env.zsh
  echo -e "${GREEN}Created secrets file. Remember to update with your actual API keys!${NC}"
fi

echo -e "${GREEN}Dotfiles installation complete!${NC}"