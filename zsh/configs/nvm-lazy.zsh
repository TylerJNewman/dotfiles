# Lazy loading for NVM to improve shell startup time

export NVM_DIR="$HOME/.nvm"

# Define nvm as a function instead of loading it immediately
nvm() {
  # Remove the nvm function
  unfunction nvm
  
  # Load NVM
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  
  # Load bash completion
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  
  # Call nvm with the provided arguments
  nvm "$@"
}

# Define node, npm, npx, etc. as functions to trigger NVM loading when needed
node() {
  # Remove all the functions we're about to replace with real commands
  unfunction node npm npx yarn pnpm
  
  # Load NVM
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  
  # Call the command with the provided arguments
  node "$@"
}

# Create similar functions for npm, npx, yarn, and pnpm
npm() {
  node >/dev/null 2>&1
  npm "$@"
}

npx() {
  node >/dev/null 2>&1
  npx "$@"
}

yarn() {
  node >/dev/null 2>&1
  yarn "$@"
}

pnpm() {
  node >/dev/null 2>&1
  pnpm "$@"
}

# Auto use .nvmrc if present in directory
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  fi
}

add-zsh-hook chpwd load-nvmrc 