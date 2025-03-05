#!/bin/bash
#
# File: install-git-hooks.sh
# Purpose: Installs git hooks for the repository
# Dependencies: None
# Last updated: 2024-03-05
# Author: Tyler Newman
# Usage: ./bin/install-git-hooks.sh
# Description: This script installs git hooks from the git/hooks directory
#              to the .git/hooks directory, making them active for the repository.

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get the root directory of the git repository
ROOT_DIR=$(git rev-parse --show-toplevel)
SOURCE_HOOKS_DIR="$ROOT_DIR/git/hooks"
TARGET_HOOKS_DIR="$ROOT_DIR/.git/hooks"

# Check if source hooks directory exists
if [ ! -d "$SOURCE_HOOKS_DIR" ]; then
  echo -e "${RED}Error: Source hooks directory not found at $SOURCE_HOOKS_DIR${NC}"
  exit 1
fi

# Create target hooks directory if it doesn't exist
mkdir -p "$TARGET_HOOKS_DIR"

# Copy all hooks and make them executable
echo -e "${BLUE}Installing git hooks...${NC}"
for hook in "$SOURCE_HOOKS_DIR"/*; do
  if [ -f "$hook" ]; then
    hook_name=$(basename "$hook")
    cp "$hook" "$TARGET_HOOKS_DIR/$hook_name"
    chmod +x "$TARGET_HOOKS_DIR/$hook_name"
    echo -e "${GREEN}Installed hook: $hook_name${NC}"
  fi
done

echo -e "${GREEN}Git hooks installed successfully!${NC}"
exit 0 