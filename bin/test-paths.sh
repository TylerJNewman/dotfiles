#!/bin/bash
#
# File: test-paths.sh
# Purpose: Tests that the directory paths are correct
# Dependencies: None
# Last updated: 2024-03-05
# Author: Tyler Newman
# Usage: ./bin/test-paths.sh

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get the root directory of the git repository
ROOT_DIR=$(git rev-parse --show-toplevel)
BIN_DIR="$ROOT_DIR/bin"
CONFIG_DIR="$ROOT_DIR/config"
MACOS_DIR="$ROOT_DIR/macos"
DOCS_DIR="$ROOT_DIR/docs"

echo -e "${BLUE}Testing directory paths...${NC}"

# Check if directories exist
echo -e "\n${BLUE}Checking if directories exist...${NC}"
if [ -d "$BIN_DIR" ]; then
  echo -e "${GREEN}bin directory exists.${NC}"
else
  echo -e "${RED}bin directory does not exist.${NC}"
fi

if [ -d "$CONFIG_DIR" ]; then
  echo -e "${GREEN}config directory exists.${NC}"
else
  echo -e "${RED}config directory does not exist.${NC}"
fi

if [ -d "$MACOS_DIR" ]; then
  echo -e "${GREEN}macos directory exists.${NC}"
else
  echo -e "${RED}macos directory does not exist.${NC}"
fi

if [ -d "$DOCS_DIR" ]; then
  echo -e "${GREEN}docs directory exists.${NC}"
else
  echo -e "${RED}docs directory does not exist.${NC}"
fi

# Check if files exist
echo -e "\n${BLUE}Checking if files exist...${NC}"
if [ -f "$MACOS_DIR/Brewfile" ]; then
  echo -e "${GREEN}Brewfile exists in macos directory.${NC}"
else
  echo -e "${RED}Brewfile does not exist in macos directory.${NC}"
fi

if [ -f "$CONFIG_DIR/starship/starship.toml" ]; then
  echo -e "${GREEN}starship.toml exists in config/starship directory.${NC}"
else
  echo -e "${RED}starship.toml does not exist in config/starship directory.${NC}"
fi

if [ -f "$CONFIG_DIR/ripgrep/ripgreprc" ]; then
  echo -e "${GREEN}ripgreprc exists in config/ripgrep directory.${NC}"
else
  echo -e "${RED}ripgreprc does not exist in config/ripgrep directory.${NC}"
fi

if [ -f "$BIN_DIR/setup-links.sh" ]; then
  echo -e "${GREEN}setup-links.sh exists in bin directory.${NC}"
else
  echo -e "${RED}setup-links.sh does not exist in bin directory.${NC}"
fi

if [ -f "$BIN_DIR/setup-on-login.sh" ]; then
  echo -e "${GREEN}setup-on-login.sh exists in bin directory.${NC}"
else
  echo -e "${RED}setup-on-login.sh does not exist in bin directory.${NC}"
fi

echo -e "\n${GREEN}Test completed!${NC}"
exit 0 