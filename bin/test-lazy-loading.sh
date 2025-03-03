#!/bin/bash
# Script to test lazy loading of various tools

# Set text colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}Testing Lazy Loading Implementation${NC}"
echo "This script will test the lazy loading of various tools"
echo

# Function to test a command
test_command() {
  local cmd=$1
  local description=$2
  
  echo -e "${YELLOW}Testing: ${description}${NC}"
  echo -e "Running: ${cmd}"
  eval "$cmd"
  echo
}

# Test NVM lazy loading
test_command "node --version" "Node.js (via NVM lazy loading)"

# Test Zoxide lazy loading
test_command "z" "Zoxide"

# Test FZF lazy loading (if installed)
if command -v fzf &> /dev/null; then
  test_command "echo 'test' | fzf -f 'test'" "FZF"
fi

# Test Deno lazy loading (if installed)
if [ -d "$HOME/.deno" ]; then
  test_command "deno --version" "Deno"
fi

# Test Bun lazy loading (if installed)
if [ -d "$HOME/.bun" ]; then
  test_command "bun --version" "Bun"
fi

# Test Google Cloud SDK lazy loading (if installed)
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  test_command "gcloud --version | head -n 1" "Google Cloud SDK"
fi

# Test Atuin lazy loading (if installed)
if command -v atuin &> /dev/null; then
  test_command "atuin --version" "Atuin"
fi

# Test GitHub Copilot lazy loading (if installed)
if command -v gh &> /dev/null; then
  test_command "gh --version | head -n 1" "GitHub CLI"
fi

# Test Docker lazy loading (if installed)
if command -v docker &> /dev/null; then
  test_command "docker --version" "Docker"
fi

# Test Docker Compose lazy loading (if installed)
if command -v docker-compose &> /dev/null; then
  test_command "docker-compose --version" "Docker Compose"
fi

echo -e "${GREEN}All tests completed!${NC}"
echo "You should have seen loading messages for each tool when first used."
echo "This confirms that lazy loading is working correctly." 