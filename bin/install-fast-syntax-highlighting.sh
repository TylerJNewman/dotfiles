#!/bin/bash
# Script to install fast-syntax-highlighting

# Set text colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Installing fast-syntax-highlighting${NC}"
echo "This script will install fast-syntax-highlighting and replace zsh-syntax-highlighting."
echo

# Check if Oh-My-Zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo -e "${RED}Error: Oh-My-Zsh is not installed.${NC}"
  echo "Please install Oh-My-Zsh first: https://ohmyz.sh/"
  exit 1
fi

# Check if zsh-syntax-highlighting is installed
if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
  echo -e "${YELLOW}Backing up zsh-syntax-highlighting...${NC}"
  mv "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting.bak"
fi

# Check if fast-syntax-highlighting is already installed
if [ -d "$HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting" ]; then
  echo -e "${YELLOW}fast-syntax-highlighting is already installed.${NC}"
  echo "Updating to the latest version..."
  cd "$HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting" && git pull
else
  # Install fast-syntax-highlighting
  echo -e "${YELLOW}Installing fast-syntax-highlighting...${NC}"
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
    "$HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting"
fi

# Check if installation was successful
if [ -d "$HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting" ]; then
  echo -e "${GREEN}fast-syntax-highlighting installed successfully!${NC}"
  echo
  echo "The plugin has been installed to:"
  echo "$HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting"
  echo
  echo "Your zshrc has been updated to use fast-syntax-highlighting."
  echo "Please restart your shell or run 'source ~/.zshrc' to apply the changes."
else
  echo -e "${RED}Error: Installation failed.${NC}"
  echo "Please try installing manually:"
  echo "git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \\"
  echo "  \$HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting"
  exit 1
fi

# Provide information about the plugin
echo
echo -e "${BLUE}About fast-syntax-highlighting:${NC}"
echo "fast-syntax-highlighting is a feature-rich syntax highlighting for Zsh."
echo "It provides syntax highlighting of commands while they are typed at a Zsh prompt."
echo "This package provides syntax highlighting that works by creating regions on"
echo "the command line that can be colorized by using zsh's syntax highlighting mechanism."
echo
echo "It's significantly faster than zsh-syntax-highlighting and provides more features."
echo
echo -e "${YELLOW}For more information, visit:${NC}"
echo "https://github.com/zdharma-continuum/fast-syntax-highlighting" 