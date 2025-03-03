#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Create dotfiles directory if it doesn't exist
mkdir -p $HOME/dotfiles

# Install custom Oh-My-Zsh plugins
echo -e "${BLUE}Installing custom Oh-My-Zsh plugins...${NC}"

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

echo -e "${GREEN}Dotfiles installation complete!${NC}"