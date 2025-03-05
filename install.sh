#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Create dotfiles directory if it doesn't exist
mkdir -p $HOME/dotfiles

# Function to create a backup of the dotfiles
create_backup() {
  echo -e "${BLUE}Creating backup of existing dotfiles...${NC}"
  BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
  
  # Check if there's anything to backup
  if [ -d "$HOME/dotfiles" ] && [ "$(ls -A $HOME/dotfiles)" ]; then
    mkdir -p "$BACKUP_DIR"
    cp -R "$HOME/dotfiles/"* "$BACKUP_DIR/"
    echo -e "${GREEN}Backup created at $BACKUP_DIR${NC}"
  else
    echo -e "${YELLOW}No existing dotfiles to backup.${NC}"
  fi
}

# Function to check if Nerd Font is installed
check_nerd_font() {
  echo -e "${BLUE}Checking for Nerd Font installation...${NC}"
  
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS font check
    if ls ~/Library/Fonts/*Nerd* 1> /dev/null 2>&1 || ls /Library/Fonts/*Nerd* 1> /dev/null 2>&1; then
      echo -e "${GREEN}Nerd Font detected!${NC}"
      return 0
    fi
  else
    # Linux font check
    if ls ~/.local/share/fonts/*Nerd* 1> /dev/null 2>&1 || ls /usr/share/fonts/*Nerd* 1> /dev/null 2>&1; then
      echo -e "${GREEN}Nerd Font detected!${NC}"
      return 0
    fi
  fi
  
  echo -e "${YELLOW}Warning: No Nerd Font detected.${NC}"
  echo -e "${YELLOW}Your Starship prompt requires a Nerd Font to display special symbols correctly.${NC}"
  echo -e "${YELLOW}We will install Hack Nerd Font via Homebrew, but you'll need to configure your terminal to use it.${NC}"
  echo -e "${YELLOW}After installation, set your terminal font to 'Hack Nerd Font' or any other Nerd Font.${NC}"
  return 1
}

# Function to check versions of key tools
check_tool_versions() {
  echo -e "${BLUE}Checking versions of key tools...${NC}"
  
  # Check Starship version
  if command -v starship &> /dev/null; then
    STARSHIP_VERSION=$(starship --version | cut -d ' ' -f 2)
    STARSHIP_MIN_VERSION="1.16.0"
    if [ "$(printf '%s\n' "$STARSHIP_MIN_VERSION" "$STARSHIP_VERSION" | sort -V | head -n1)" != "$STARSHIP_MIN_VERSION" ]; then
      echo -e "${YELLOW}Warning: Starship version $STARSHIP_VERSION is below recommended version $STARSHIP_MIN_VERSION${NC}"
    else
      echo -e "${GREEN}Starship version $STARSHIP_VERSION ✓${NC}"
    fi
  fi
  
  # Check Zsh version
  if command -v zsh &> /dev/null; then
    ZSH_VERSION=$(zsh --version | cut -d ' ' -f 2)
    ZSH_MIN_VERSION="5.8"
    if [ "$(printf '%s\n' "$ZSH_MIN_VERSION" "$ZSH_VERSION" | sort -V | head -n1)" != "$ZSH_MIN_VERSION" ]; then
      echo -e "${YELLOW}Warning: Zsh version $ZSH_VERSION is below recommended version $ZSH_MIN_VERSION${NC}"
    else
      echo -e "${GREEN}Zsh version $ZSH_VERSION ✓${NC}"
    fi
  fi
  
  # Check Git version
  if command -v git &> /dev/null; then
    GIT_VERSION=$(git --version | cut -d ' ' -f 3)
    GIT_MIN_VERSION="2.30.0"
    if [ "$(printf '%s\n' "$GIT_MIN_VERSION" "$GIT_VERSION" | sort -V | head -n1)" != "$GIT_MIN_VERSION" ]; then
      echo -e "${YELLOW}Warning: Git version $GIT_VERSION is below recommended version $GIT_MIN_VERSION${NC}"
    else
      echo -e "${GREEN}Git version $GIT_VERSION ✓${NC}"
    fi
  fi
  
  # Check Node.js version
  if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version | cut -c 2-)
    NODE_MIN_VERSION="18.0.0"
    if [ "$(printf '%s\n' "$NODE_MIN_VERSION" "$NODE_VERSION" | sort -V | head -n1)" != "$NODE_MIN_VERSION" ]; then
      echo -e "${YELLOW}Warning: Node.js version $NODE_VERSION is below recommended version $NODE_MIN_VERSION${NC}"
    else
      echo -e "${GREEN}Node.js version $NODE_VERSION ✓${NC}"
    fi
  fi
  
  # Check Homebrew version
  if command -v brew &> /dev/null; then
    BREW_VERSION=$(brew --version | head -n 1 | cut -d ' ' -f 2)
    BREW_MIN_VERSION="4.0.0"
    if [ "$(printf '%s\n' "$BREW_MIN_VERSION" "$BREW_VERSION" | sort -V | head -n1)" != "$BREW_MIN_VERSION" ]; then
      echo -e "${YELLOW}Warning: Homebrew version $BREW_VERSION is below recommended version $BREW_MIN_VERSION${NC}"
    else
      echo -e "${GREEN}Homebrew version $BREW_VERSION ✓${NC}"
    fi
  fi
}

# Function to update dotfiles
update_dotfiles() {
  echo -e "${BLUE}Updating dotfiles repository...${NC}"
  
  # Check if we're in a git repository
  if [ -d "$HOME/dotfiles/.git" ]; then
    cd "$HOME/dotfiles"
    
    # Stash any local changes
    git stash
    
    # Pull latest changes
    git pull origin main || git pull origin master
    
    # Apply stashed changes if any
    git stash pop 2>/dev/null
    
    echo -e "${GREEN}Dotfiles updated!${NC}"
    
    # Update dependencies
    if command -v brew &> /dev/null; then
      echo -e "${BLUE}Updating Homebrew dependencies...${NC}"
      brew bundle
    fi
    
    # Update Oh-My-Zsh plugins
    echo -e "${BLUE}Updating Oh-My-Zsh plugins...${NC}"
    cd "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" && git pull
    cd "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" && git pull
    cd "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-abbr" && git pull && git submodule update
    cd "$HOME/dotfiles"
    
    # Update Starship
    if command -v starship &> /dev/null; then
      echo -e "${BLUE}Updating Starship...${NC}"
      curl -sS https://starship.rs/install.sh | sh
    fi
    
    echo -e "${GREEN}All dependencies updated!${NC}"
  else
    echo -e "${RED}Not a git repository. Cannot update.${NC}"
  fi
}

# Check if this is an update
if [ "$1" = "update" ]; then
  update_dotfiles
  exit 0
fi

# Create backup of existing dotfiles
create_backup

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
  echo -e "${BLUE}Installing Homebrew...${NC}"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Add Homebrew to PATH based on platform
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    if [[ "$(uname -m)" == "arm64" ]]; then
      # Apple Silicon
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
      eval "$(/opt/homebrew/bin/brew shellenv)"
    else
      # Intel
      echo 'eval "$(/usr/local/bin/brew shellenv)"' >> $HOME/.zprofile
      eval "$(/usr/local/bin/brew shellenv)"
    fi
  else
    # Linux
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.zprofile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
fi

# Install dependencies from Brewfile
if command -v brew &> /dev/null; then
  echo -e "${BLUE}Installing dependencies from Brewfile...${NC}"
  brew bundle
  
  # Check for Nerd Font after Brewfile installation
  check_nerd_font
fi

# Install custom Oh-My-Zsh plugins
echo -e "${BLUE}Installing custom Oh-My-Zsh plugins...${NC}"

# Check if Oh-My-Zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo -e "${BLUE}Oh-My-Zsh not found. Installing...${NC}"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  echo -e "${GREEN}Oh-My-Zsh installed!${NC}"
else
  echo -e "${GREEN}Oh-My-Zsh already installed.${NC}"
fi

# Create custom plugins directory if it doesn't exist
mkdir -p "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

# Install zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
  echo -e "${BLUE}Installing zsh-autosuggestions...${NC}"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# Install zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
  echo -e "${BLUE}Installing zsh-syntax-highlighting...${NC}"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Install zsh-history-substring-search
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search" ]; then
  echo -e "${BLUE}Installing zsh-history-substring-search...${NC}"
  git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
fi

# Install zsh-abbr
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-abbr" ]; then
  echo -e "${BLUE}Installing zsh-abbr...${NC}"
  git clone https://github.com/olets/zsh-abbr ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-abbr
  echo -e "${BLUE}Initializing zsh-abbr submodules...${NC}"
  cd ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-abbr && git submodule init && git submodule update
  cd - > /dev/null
fi

# Install Starship prompt if not already installed
if ! command -v starship &> /dev/null; then
  echo -e "${BLUE}Installing Starship prompt...${NC}"
  curl -sS https://starship.rs/install.sh | sh
fi

# Create Starship config directory if it doesn't exist
echo -e "${BLUE}Setting up Starship configuration...${NC}"
mkdir -p "$HOME/.config"

# Create symlink for Starship configuration file
echo -e "${BLUE}Creating symlink for Starship configuration...${NC}"
ln -sf $HOME/dotfiles/starship.toml $HOME/.config/starship.toml
echo -e "${GREEN}Starship configuration linked!${NC}"

# Remind about Nerd Font requirement
echo -e "${YELLOW}Remember: Starship configuration uses Nerd Font symbols.${NC}"
echo -e "${YELLOW}Make sure your terminal is configured to use a Nerd Font (e.g., Hack Nerd Font).${NC}"

# Install Atuin shell history if not already installed
if ! command -v atuin &> /dev/null; then
  echo -e "${BLUE}Installing Atuin shell history...${NC}"
  bash <(curl https://raw.githubusercontent.com/ellie/atuin/main/install.sh)
fi

# Create PNPM plugin if it doesn't exist
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/pnpm" ]; then
  echo -e "${BLUE}Creating PNPM plugin...${NC}"
  mkdir -p "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/pnpm"
  cat > "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/pnpm/pnpm.plugin.zsh" << 'EOF'
# PNPM completions
if [ -f "$HOME/.config/tabtab/zsh/__tabtab.zsh" ]; then
  source "$HOME/.config/tabtab/zsh/__tabtab.zsh"
fi

# PNPM path
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# PNPM aliases
alias pi="pnpm install"
alias pa="pnpm add"
alias pad="pnpm add -D"
alias prm="pnpm remove"
alias pls="pnpm list"
alias prun="pnpm run"
alias pdev="pnpm run dev"
alias pbuild="pnpm run build"
alias pstart="pnpm run start"
alias ptest="pnpm run test"
alias pdx="pnpm dlx"
alias pupdate="pnpm update"
alias pupgrade="pnpm update -i"
EOF
  echo -e "${GREEN}PNPM plugin created!${NC}"
fi

# Create Bun plugin if it doesn't exist
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/bun" ]; then
  echo -e "${BLUE}Creating Bun plugin...${NC}"
  mkdir -p "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/bun"
  cat > "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/bun/bun.plugin.zsh" << 'EOF'
# Bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Bun path
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Bun aliases
alias br="bun run"
alias bi="bun install"
alias ba="bun add"
alias bad="bun add -d"
alias brm="bun remove"
alias bx="bunx"
alias bdev="bun run dev"
alias bbuild="bun run build"
alias bstart="bun run start"
alias btest="bun run test"
EOF
  echo -e "${GREEN}Bun plugin created!${NC}"
fi

# Create symlinks
echo -e "${BLUE}Creating symlinks...${NC}"

# Backup existing .zshrc if it exists
if [ -f "$HOME/.zshrc" ]; then
  echo -e "${BLUE}Backing up existing .zshrc to .zshrc.backup${NC}"
  mv $HOME/.zshrc $HOME/.zshrc.backup
fi

# Create symlink for .zshrc
echo -e "${BLUE}Linking .zshrc${NC}"
ln -sf $HOME/dotfiles/zsh/zshrc $HOME/.zshrc

# Copy the example secrets file if env.zsh doesn't exist
if [ ! -f "$HOME/dotfiles/zsh/secrets/env.zsh" ]; then
  echo -e "${BLUE}Creating example secrets file${NC}"
  cp $HOME/dotfiles/zsh/secrets/env.zsh.example $HOME/dotfiles/zsh/secrets/env.zsh
  echo -e "${GREEN}Created secrets file. Remember to update with your actual API keys!${NC}"
fi

# Check versions of key tools
check_tool_versions

# Set up Cursor as the default editor if available
echo -e "${BLUE}Setting up editor preferences...${NC}"
if command -v cursor &> /dev/null; then
  echo -e "${GREEN}Cursor found. Setting as default editor...${NC}"
  git config --global core.editor "cursor --wait"
elif [ -d "/Applications/Cursor.app" ] && [ -f "/Applications/Cursor.app/Contents/MacOS/Cursor" ]; then
  echo -e "${YELLOW}Cursor found in Applications but not in PATH. Creating symlink...${NC}"
  sudo ln -sf "/Applications/Cursor.app/Contents/MacOS/Cursor" /usr/local/bin/cursor
  git config --global core.editor "cursor --wait"
  echo -e "${GREEN}Cursor set as default editor.${NC}"
else
  echo -e "${YELLOW}Cursor not found. Using vim as default editor.${NC}"
  echo -e "${YELLOW}To use Cursor, install it from https://cursor.sh/ and run:${NC}"
  echo -e "${YELLOW}  git config --global core.editor \"cursor --wait\"${NC}"
fi

echo -e "${GREEN}Dotfiles installation complete!${NC}"