#!/usr/bin/env zsh
# PATH management

# Core tool directories
export NVM_DIR="$HOME/.nvm"
export PNPM_HOME="$HOME/Library/pnpm"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export BUN_INSTALL="$HOME/.bun"

# PATH additions (highest to lowest priority)
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
export PATH="$HOME/bin:$HOME/dotfiles/bin:$HOME/.local/bin:$PATH"
export PATH="$BUN_INSTALL/bin:$PNPM_HOME:$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Node modules (lowest priority)
export PATH="$PATH:./node_modules/.bin:../node_modules/.bin"

# Function path for completions
if command -v brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:$FPATH"
fi

# Helper for viewing PATH
alias path='echo -e ${PATH//:/\\n}'
