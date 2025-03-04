# PATH configurations

# Dotfiles bin directory
export PATH="$HOME/dotfiles/bin:$PATH"

# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# PNPM
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

# Deno - Now lazy loaded in lazy-tools.zsh
# export DENO_INSTALL="$HOME/.deno"
# export PATH="$DENO_INSTALL/bin:$PATH"

# Bun - Now lazy loaded in lazy-tools.zsh
# export BUN_INSTALL="$HOME/.bun"
# export PATH="$BUN_INSTALL/bin:$PATH"

# Pipx
export PIPX_HOME=$HOME/.pipx
export PIPX_BIN_DIR=$HOME/.local/bin
export PATH="$PIPX_BIN_DIR:$PATH"
export PATH="$PIPX_HOME/completions:$PATH"

# NVM - Now using lazy loading in nvm-lazy.zsh
export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Python aliases
alias python=python3
alias pip=pip3
