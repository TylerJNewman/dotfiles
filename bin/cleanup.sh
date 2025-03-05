#!/bin/bash
#
# File: cleanup.sh
# Purpose: Performs cleanup tasks for the dotfiles repository
# Dependencies: None
# Last updated: 2024-03-05
# Author: Tyler Newman
# Usage: ./bin/cleanup.sh
# Description: This script performs various cleanup tasks for the dotfiles
#              repository, including removing temporary files, checking
#              script permissions, and running linting tools.

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get the root directory of the git repository
ROOT_DIR=$(git rev-parse --show-toplevel)

echo -e "${BLUE}Running dotfiles cleanup tasks...${NC}"

# 1. Remove temporary files
echo -e "\n${BLUE}Removing temporary files...${NC}"
find "$ROOT_DIR" -name "_tmp_*" -type f -delete
find "$ROOT_DIR" -name "*.swp" -type f -delete
find "$ROOT_DIR" -name "*.swo" -type f -delete
find "$ROOT_DIR" -name "*~" -type f -delete
echo -e "${GREEN}Temporary files removed.${NC}"

# 2. Ensure scripts have proper permissions
echo -e "\n${BLUE}Checking script permissions...${NC}"
find "$ROOT_DIR/bin" -name "*.sh" -type f -exec chmod +x {} \;
chmod +x "$ROOT_DIR/install.sh" 2>/dev/null || true
chmod +x "$ROOT_DIR/bin/setup-links.sh" 2>/dev/null || true
chmod +x "$ROOT_DIR/bin/setup-on-login.sh" 2>/dev/null || true
echo -e "${GREEN}Script permissions updated.${NC}"

# 3. Verify that configuration files are properly formatted
echo -e "\n${BLUE}Checking configuration file formatting...${NC}"
if command -v shfmt &> /dev/null; then
  shfmt -l -i 2 -ci "$ROOT_DIR/zsh"/*.zsh "$ROOT_DIR/bin"/*.sh 2>/dev/null || true
  echo -e "${GREEN}Configuration files checked.${NC}"
else
  echo -e "${YELLOW}shfmt not installed. Skipping formatting check.${NC}"
fi

# 4. Run linting tools if available
echo -e "\n${BLUE}Running linting tools...${NC}"
if [ -f "$ROOT_DIR/bin/lint-scripts.sh" ] && [ -x "$ROOT_DIR/bin/lint-scripts.sh" ]; then
  "$ROOT_DIR/bin/lint-scripts.sh" || echo -e "${YELLOW}Linting found issues that need to be addressed.${NC}"
else
  echo -e "${YELLOW}lint-scripts.sh not found or not executable. Skipping linting.${NC}"
fi

# 5. Measure shell startup time
echo -e "\n${BLUE}Measuring shell startup time...${NC}"
if [ -f "$ROOT_DIR/bin/measure-startup-time.sh" ] && [ -x "$ROOT_DIR/bin/measure-startup-time.sh" ]; then
  "$ROOT_DIR/bin/measure-startup-time.sh" 3 || echo -e "${YELLOW}Failed to measure shell startup time.${NC}"
else
  echo -e "${YELLOW}measure-startup-time.sh not found or not executable. Skipping measurement.${NC}"
fi

echo -e "\n${GREEN}Cleanup completed successfully!${NC}"
echo -e "${YELLOW}Don't forget to commit your changes with a clear, descriptive message.${NC}"

exit 0 