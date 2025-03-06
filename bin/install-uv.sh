#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Installing and configuring uv (Python package installer)...${NC}"

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
  echo -e "${RED}Homebrew is not installed. Please install Homebrew first.${NC}"
  echo -e "${YELLOW}Run: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"${NC}"
  exit 1
fi

# Install uv using Homebrew
echo -e "${BLUE}Installing uv via Homebrew...${NC}"
brew install uv

# Check if installation was successful
if ! command -v uv &> /dev/null; then
  echo -e "${RED}Failed to install uv. Please check Homebrew and try again.${NC}"
  exit 1
fi

# Create Python configuration directory if it doesn't exist
echo -e "${BLUE}Setting up Python configuration...${NC}"
mkdir -p "$HOME/dotfiles/zsh/configs"

# Create Python configuration file if it doesn't exist
if [ ! -f "$HOME/dotfiles/zsh/configs/python.zsh" ]; then
  echo -e "${BLUE}Creating Python configuration file...${NC}"
  cat > "$HOME/dotfiles/zsh/configs/python.zsh" << 'EOF'
#!/usr/bin/env zsh

# Python configuration file
# Contains settings for Python development tools and environments

# Python aliases (already defined in path.zsh)
# alias python=python3
# alias pip=pip3

# UV - Python package installer and resolver
# https://github.com/astral-sh/uv

# Set UV as the default pip command if available
if command -v uv &> /dev/null; then
  # UV environment variables
  export UV_SYSTEM_PYTHON=1  # Use system Python by default
  export UV_CACHE_DIR="$HOME/.cache/uv"  # Set cache directory

  # UV aliases
  alias pip="uv pip"
  alias uvp="uv pip"
  alias uvi="uv pip install"
  alias uvid="uv pip install --dev"
  alias uvr="uv pip uninstall"
  alias uvl="uv pip list"
  alias uvs="uv pip search"
  alias uvshow="uv pip show"
  alias uvreq="uv pip freeze > requirements.txt"
  alias uvvenv="uv venv"
  alias uvcvenv="uv venv .venv && source .venv/bin/activate"
  
  # Create and activate a virtual environment
  function pyvenv() {
    local venv_name="${1:-.venv}"
    uv venv "$venv_name" && source "$venv_name/bin/activate"
  }
  
  # Install requirements.txt with UV
  function uvinstall() {
    local req_file="${1:-requirements.txt}"
    if [ -f "$req_file" ]; then
      uv pip install -r "$req_file"
    else
      echo "Error: $req_file not found"
      return 1
    fi
  }
fi

# Python virtual environment helpers
function venv() {
  local venv_name="${1:-.venv}"
  if [ -d "$venv_name" ]; then
    source "$venv_name/bin/activate"
  else
    echo "Virtual environment $venv_name not found."
    echo "Create it with: uv venv $venv_name"
    return 1
  fi
}

# Check if we're in a virtual environment
function in_venv() {
  if [ -n "$VIRTUAL_ENV" ]; then
    echo "Active virtual environment: $VIRTUAL_ENV"
    return 0
  else
    echo "No active virtual environment"
    return 1
  fi
}

# Only define deactivate alias if we're not in a virtual environment
# This prevents conflicts with the deactivate function in virtual environments
if [ -z "$VIRTUAL_ENV" ]; then
  alias deactivate="echo 'No virtual environment active'"
fi
EOF
  echo -e "${GREEN}Python configuration file created!${NC}"
else
  echo -e "${YELLOW}Python configuration file already exists. Skipping creation.${NC}"
fi

# Make the script executable
chmod +x "$HOME/dotfiles/bin/install-uv.sh"

# Display UV version
UV_VERSION=$(uv --version)
echo -e "${GREEN}UV installed successfully: ${UV_VERSION}${NC}"
echo -e "${BLUE}Testing UV with a simple command...${NC}"
uv --help | head -n 5

echo -e "${GREEN}Installation complete!${NC}"
echo -e "${YELLOW}To use UV, restart your terminal or run: source ~/.zshrc${NC}"
echo -e "${YELLOW}Then try commands like: uvi requests or uvvenv .venv${NC}"
echo -e "${BLUE}Usage tips:${NC}"
echo -e "${YELLOW}1. Create a virtual environment: uvvenv or pyvenv my_env${NC}"
echo -e "${YELLOW}2. Install packages in a virtual environment: uv pip install --python .venv/bin/python3 package_name${NC}"
echo -e "${YELLOW}3. Install tools: uv tool install --python .venv/bin/python3 tool_name${NC}" 