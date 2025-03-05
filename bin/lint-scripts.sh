#!/bin/bash
#
# File: lint-scripts.sh
# Purpose: Lints shell scripts in the repository for errors and style issues
# Dependencies: shellcheck, shfmt
# Last updated: 2024-03-05
# Author: Tyler Newman
# Usage: ./bin/lint-scripts.sh
# Description: This script finds all shell scripts in the repository and runs
#              shellcheck and shfmt on them to ensure they follow best practices
#              and consistent formatting. It's designed to be run before committing
#              changes to ensure code quality.

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if shellcheck is installed
if ! command -v shellcheck &> /dev/null; then
  echo -e "${RED}Error: shellcheck is not installed.${NC}"
  echo -e "Please install it with: brew install shellcheck"
  exit 1
fi

# Check if shfmt is installed
if ! command -v shfmt &> /dev/null; then
  echo -e "${RED}Error: shfmt is not installed.${NC}"
  echo -e "Please install it with: brew install shfmt"
  exit 1
fi

# Find all shell scripts
echo -e "${BLUE}Finding shell scripts...${NC}"
SHELL_SCRIPTS=$(find . -type f -name "*.sh" -o -name "zshrc" -o -path "./zsh/*.zsh" | grep -v "node_modules" | sort)

# Check if any shell scripts were found
if [ -z "$SHELL_SCRIPTS" ]; then
  echo -e "${YELLOW}No shell scripts found.${NC}"
  exit 0
fi

# Run shellcheck on all shell scripts
echo -e "${BLUE}Running shellcheck...${NC}"
SHELLCHECK_ERRORS=0
for script in $SHELL_SCRIPTS; do
  echo -e "${BLUE}Checking ${script}...${NC}"
  if ! shellcheck -x "$script"; then
    SHELLCHECK_ERRORS=$((SHELLCHECK_ERRORS + 1))
  fi
done

# Run shfmt on all shell scripts
echo -e "${BLUE}Running shfmt...${NC}"
SHFMT_ERRORS=0
for script in $SHELL_SCRIPTS; do
  echo -e "${BLUE}Checking format of ${script}...${NC}"
  if ! shfmt -d -i 2 -ci "$script"; then
    SHFMT_ERRORS=$((SHFMT_ERRORS + 1))
  fi
done

# Report results
if [ $SHELLCHECK_ERRORS -eq 0 ] && [ $SHFMT_ERRORS -eq 0 ]; then
  echo -e "${GREEN}All shell scripts passed linting!${NC}"
  exit 0
else
  echo -e "${RED}Linting found issues:${NC}"
  echo -e "${RED}- ShellCheck errors: $SHELLCHECK_ERRORS${NC}"
  echo -e "${RED}- shfmt formatting issues: $SHFMT_ERRORS${NC}"
  echo -e "${YELLOW}Please fix these issues before committing.${NC}"
  exit 1
fi 