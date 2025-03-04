#!/usr/bin/env bash

# This script runs when you log in to set up your development environment
# Inspired by Kent C. Dodds' dotfiles

# Set up colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}Setting up your development environment...${NC}"

# Create daily directories for organization
DAILY_DIR="$HOME/Desktop/$(date +%Y-%m-%d)"
if [ ! -d "$DAILY_DIR" ]; then
  echo -e "${GREEN}Creating today's directory at $DAILY_DIR${NC}"
  mkdir -p "$DAILY_DIR"
fi

# Check for system updates
echo -e "${YELLOW}Checking for system updates...${NC}"
softwareupdate -l

# Check for homebrew updates
if command -v brew &> /dev/null; then
  echo -e "${YELLOW}Checking for homebrew updates...${NC}"
  brew update > /dev/null
  OUTDATED=$(brew outdated)
  if [ -n "$OUTDATED" ]; then
    echo -e "${YELLOW}The following packages are outdated:${NC}"
    echo "$OUTDATED"
    echo -e "${YELLOW}Run 'brew upgrade' to update them.${NC}"
  else
    echo -e "${GREEN}All homebrew packages are up to date.${NC}"
  fi
fi

# Check for Node.js updates if using nvm
if [ -s "$HOME/.nvm/nvm.sh" ]; then
  source "$HOME/.nvm/nvm.sh"
  CURRENT_VERSION=$(nvm current)
  LATEST_VERSION=$(nvm version-remote --lts)
  if [ "$CURRENT_VERSION" != "$LATEST_VERSION" ]; then
    echo -e "${YELLOW}Node.js update available: $CURRENT_VERSION -> $LATEST_VERSION${NC}"
    echo -e "${YELLOW}Run 'nvm install --lts' to update.${NC}"
  else
    echo -e "${GREEN}Node.js is up to date.${NC}"
  fi
fi

# Check git status for all repositories in ~/projects
if [ -d "$HOME/projects" ]; then
  echo -e "${BLUE}Checking git status for repositories in ~/projects${NC}"
  for dir in "$HOME/projects"/*; do
    if [ -d "$dir/.git" ]; then
      echo -e "${CYAN}$(basename "$dir")${NC}"
      (cd "$dir" && git status -s)
    fi
  done
fi

# Clean up old downloads (files older than 30 days)
echo -e "${BLUE}Cleaning up old downloads...${NC}"
find "$HOME/Downloads" -type f -mtime +30 -print | while read -r file; do
  echo "Old file: $file"
done
echo -e "${YELLOW}Run 'find ~/Downloads -type f -mtime +30 -delete' to delete these files.${NC}"

# Check disk space
echo -e "${BLUE}Checking disk space...${NC}"
df -h | grep -E "Filesystem|/dev/disk1"

# Check for large files that might be taking up space
echo -e "${BLUE}Top 5 largest directories in your home folder:${NC}"
du -h -d 2 "$HOME" 2>/dev/null | sort -hr | head -n 5

# Remind about backups
echo -e "${PURPLE}Reminder: When was your last backup?${NC}"

echo -e "${GREEN}Environment setup complete!${NC}" 