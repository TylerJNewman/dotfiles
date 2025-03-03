#!/bin/bash
# Script to install modern developer tools

# Set text colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Modern Developer Tools Installer${NC}"
echo "This script will install a curated set of modern developer tools."
echo

# Check OS
if [[ "$OSTYPE" == "darwin"* ]]; then
  PACKAGE_MANAGER="brew"
  echo "Detected macOS. Using Homebrew."
  
  # Check if Homebrew is installed
  if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}Homebrew not found. Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  if command -v apt-get &> /dev/null; then
    PACKAGE_MANAGER="apt"
    echo "Detected Debian/Ubuntu. Using apt."
  elif command -v dnf &> /dev/null; then
    PACKAGE_MANAGER="dnf"
    echo "Detected Fedora/RHEL. Using dnf."
  elif command -v pacman &> /dev/null; then
    PACKAGE_MANAGER="pacman"
    echo "Detected Arch Linux. Using pacman."
  else
    echo -e "${RED}Unsupported Linux distribution.${NC}"
    exit 1
  fi
else
  echo -e "${RED}Unsupported operating system: $OSTYPE${NC}"
  exit 1
fi

# Function to install packages
install_packages() {
  local packages=("$@")
  
  case $PACKAGE_MANAGER in
    brew)
      for pkg in "${packages[@]}"; do
        echo -e "${YELLOW}Installing $pkg...${NC}"
        brew install "$pkg"
      done
      ;;
    apt)
      sudo apt-get update
      for pkg in "${packages[@]}"; do
        echo -e "${YELLOW}Installing $pkg...${NC}"
        sudo apt-get install -y "$pkg"
      done
      ;;
    dnf)
      for pkg in "${packages[@]}"; do
        echo -e "${YELLOW}Installing $pkg...${NC}"
        sudo dnf install -y "$pkg"
      done
      ;;
    pacman)
      for pkg in "${packages[@]}"; do
        echo -e "${YELLOW}Installing $pkg...${NC}"
        sudo pacman -S --noconfirm "$pkg"
      done
      ;;
  esac
}

# Function to install Rust tools with cargo
install_cargo_tools() {
  local tools=("$@")
  
  # Check if Rust is installed
  if ! command -v cargo &> /dev/null; then
    echo -e "${YELLOW}Rust not found. Installing Rust...${NC}"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME/.cargo/env"
  fi
  
  for tool in "${tools[@]}"; do
    echo -e "${YELLOW}Installing $tool with cargo...${NC}"
    cargo install "$tool"
  done
}

# Function to install npm packages globally
install_npm_packages() {
  local packages=("$@")
  
  # Check if npm is installed
  if ! command -v npm &> /dev/null; then
    echo -e "${RED}npm not found. Please install Node.js first.${NC}"
    return 1
  fi
  
  for pkg in "${packages[@]}"; do
    echo -e "${YELLOW}Installing $pkg with npm...${NC}"
    npm install -g "$pkg"
  done
}

# Function to install GitHub CLI extensions
install_gh_extensions() {
  local extensions=("$@")
  
  # Check if GitHub CLI is installed
  if ! command -v gh &> /dev/null; then
    echo -e "${RED}GitHub CLI not found. Please install it first.${NC}"
    return 1
  fi
  
  for ext in "${extensions[@]}"; do
    echo -e "${YELLOW}Installing GitHub CLI extension: $ext...${NC}"
    gh extension install "$ext"
  done
}

# Ask user which tool categories to install
echo "Which tool categories would you like to install?"
echo "1) Rust-based CLI replacements (bat, exa, fd, ripgrep, etc.)"
echo "2) Modern shell tools (fzf, zoxide, starship, etc.)"
echo "3) AI development tools (GitHub Copilot CLI, etc.)"
echo "4) Container tools (Docker, lazydocker, etc.)"
echo "5) Git enhancements (lazygit, delta, etc.)"
echo "6) Node.js tools (pnpm, bun, etc.)"
echo "7) All of the above"
echo "0) Exit"

read -p "Enter your choices (comma-separated): " choices

IFS=',' read -ra CHOICES <<< "$choices"

for choice in "${CHOICES[@]}"; do
  case $choice in
    1|7)
      echo -e "\n${BLUE}Installing Rust-based CLI replacements...${NC}"
      install_packages bat exa fd ripgrep delta
      ;;
    2|7)
      echo -e "\n${BLUE}Installing Modern shell tools...${NC}"
      install_packages fzf zoxide starship jq tmux
      ;;
    3|7)
      echo -e "\n${BLUE}Installing AI development tools...${NC}"
      install_npm_packages "@githubnext/github-copilot-cli"
      if [[ "$PACKAGE_MANAGER" == "brew" ]]; then
        brew install ollama
      else
        echo "Please install Ollama manually from https://ollama.ai"
      fi
      ;;
    4|7)
      echo -e "\n${BLUE}Installing Container tools...${NC}"
      if [[ "$PACKAGE_MANAGER" == "brew" ]]; then
        brew install docker docker-compose lazydocker
      elif [[ "$PACKAGE_MANAGER" == "apt" ]]; then
        sudo apt-get install -y docker.io docker-compose
        install_cargo_tools lazydocker
      else
        install_packages docker docker-compose
        install_cargo_tools lazydocker
      fi
      ;;
    5|7)
      echo -e "\n${BLUE}Installing Git enhancements...${NC}"
      install_packages lazygit delta gh
      install_gh_extensions dlvhdr/gh-dash
      ;;
    6|7)
      echo -e "\n${BLUE}Installing Node.js tools...${NC}"
      install_npm_packages pnpm bun turbo
      ;;
    0)
      echo "Exiting..."
      exit 0
      ;;
    *)
      echo -e "${RED}Invalid choice: $choice${NC}"
      ;;
  esac
done

echo -e "\n${GREEN}Installation complete!${NC}"
echo "Please restart your shell or run 'source ~/.zshrc' to apply the changes."
echo
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Configure your tools by editing the appropriate files in zsh/configs/"
echo "2. Check out the documentation for each tool to learn more about its features"
echo "3. Enjoy your enhanced development environment!" 