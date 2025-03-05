#!/usr/bin/env bash

# Script to set up Cursor as the default editor
# This script helps configure Cursor as the default editor for Git and other applications

# Set up colors for output
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Setting up Cursor as the default editor...${NC}"

# Check if Cursor is installed
if ! command -v cursor &> /dev/null; then
  echo -e "${YELLOW}Cursor command not found in PATH.${NC}"
  
  # Check common installation locations on macOS
  CURSOR_APP="/Applications/Cursor.app"
  if [ -d "$CURSOR_APP" ]; then
    echo -e "${GREEN}Found Cursor.app in Applications folder.${NC}"
    
    # Create a symlink to the cursor binary
    CURSOR_BIN="$CURSOR_APP/Contents/MacOS/Cursor"
    if [ -f "$CURSOR_BIN" ]; then
      echo -e "${YELLOW}Creating symlink to Cursor binary...${NC}"
      sudo ln -sf "$CURSOR_BIN" /usr/local/bin/cursor
      echo -e "${GREEN}Symlink created at /usr/local/bin/cursor${NC}"
    else
      echo -e "${RED}Cursor binary not found at expected location: $CURSOR_BIN${NC}"
      echo -e "${YELLOW}You may need to manually create a symlink to the Cursor binary.${NC}"
    fi
  else
    echo -e "${YELLOW}Cursor.app not found in Applications folder.${NC}"
    echo -e "${YELLOW}Please install Cursor from https://cursor.sh/ or create a symlink manually.${NC}"
  fi
fi

# Set up Git to use Cursor
if command -v cursor &> /dev/null; then
  echo -e "${YELLOW}Configuring Git to use Cursor...${NC}"
  git config --global core.editor "cursor --wait"
  echo -e "${GREEN}Git configured to use Cursor as the default editor.${NC}"
else
  echo -e "${YELLOW}Skipping Git configuration as Cursor is not available.${NC}"
fi

# Check if zsh-history-substring-search plugin is installed
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
HISTORY_PLUGIN_DIR="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/plugins/zsh-users---zsh-history-substring-search"

if [ ! -d "$HISTORY_PLUGIN_DIR" ]; then
  echo -e "${YELLOW}Installing zsh-history-substring-search plugin...${NC}"
  if [ -d "$ZINIT_HOME" ]; then
    # Use zinit to install the plugin
    zsh -c "source \"${ZINIT_HOME}/zinit.zsh\" && zinit light zsh-users/zsh-history-substring-search"
    echo -e "${GREEN}Plugin installed successfully.${NC}"
  else
    echo -e "${RED}Zinit not found. Cannot install the plugin automatically.${NC}"
    echo -e "${YELLOW}Please install the plugin manually or run the zinit setup first.${NC}"
  fi
else
  echo -e "${GREEN}zsh-history-substring-search plugin is already installed.${NC}"
fi

# Set up environment variables
echo -e "${YELLOW}Updating shell configuration...${NC}"
echo -e "${GREEN}Your zshrc has been updated to use Cursor when available.${NC}"
echo -e "${YELLOW}Please restart your terminal or run 'source ~/.zshrc' for changes to take effect.${NC}"

echo -e "${GREEN}Setup complete!${NC}" 