#!/bin/bash
#
# File: check-alias-conflicts.sh
# Purpose: Checks for potential conflicts between aliases and functions
# Dependencies: None
# Last updated: 2024-03-05
# Author: Tyler Newman
# Usage: ./bin/check-alias-conflicts.sh
# Description: This script identifies potential conflicts between aliases and functions
#              in your ZSH configuration files to help prevent errors.

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get the root directory of the git repository
ROOT_DIR=$(git rev-parse --show-toplevel)
ZSH_DIR="$ROOT_DIR/zsh"

echo -e "${BLUE}Checking for potential alias conflicts with functions...${NC}"

# Extract all aliases
echo -e "\n${BLUE}Extracting aliases...${NC}"
ALIASES=$(grep -r "^alias " "$ZSH_DIR" --include="*.zsh" | 
  awk -F'alias ' '{print $2}' | 
  awk -F'=' '{print $1}' | 
  sort | 
  uniq)

# Extract all function names
echo -e "\n${BLUE}Extracting functions...${NC}"
FUNCTIONS=$(grep -r "^function " "$ZSH_DIR" --include="*.zsh" | 
  awk -F'function ' '{print $2}' | 
  awk -F'(' '{print $1}' | 
  sort | 
  uniq)

FUNCTIONS2=$(grep -r "^[a-zA-Z0-9_-]*()" "$ZSH_DIR" --include="*.zsh" | 
  awk -F':' '{print $2}' | 
  awk -F'(' '{print $1}' | 
  sort | 
  uniq)

# Combine function lists
FUNCTIONS=$(echo -e "$FUNCTIONS\n$FUNCTIONS2" | sort | uniq)

# Check for conflicts
echo -e "\n${BLUE}Checking for conflicts...${NC}"
CONFLICTS=0

for alias in $ALIASES; do
  # Skip the .. aliases
  if [[ "$alias" == ".." || "$alias" == "..." || "$alias" == "...." || "$alias" == "....." || "$alias" == "..l" ]]; then
    continue
  fi
  
  if echo "$FUNCTIONS" | grep -q "^$alias$"; then
    echo -e "${RED}Conflict found: '$alias' is both an alias and a function${NC}"
    CONFLICTS=$((CONFLICTS + 1))
  fi
done

# Report results
echo -e "\n${GREEN}Check completed!${NC}"
if [ $CONFLICTS -eq 0 ]; then
  echo -e "${GREEN}No conflicts found!${NC}"
  exit 0
else
  echo -e "${RED}Found $CONFLICTS alias/function conflicts.${NC}"
  echo -e "${YELLOW}Please fix these issues to prevent errors when loading your ZSH configuration.${NC}"
  exit 1
fi 