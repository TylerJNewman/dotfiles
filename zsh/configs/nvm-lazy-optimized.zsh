# Optimized lazy loading for NVM to improve shell startup time

export NVM_DIR="$HOME/.nvm"

# Helper function to lazy load a tool
lazy_load() {
  local tool_name=$1
  local load_command=$2
  local -a tool_commands=("${@:3}")
  
  for cmd in "${tool_commands[@]}"; do
    eval "function $cmd() {
      unfunction ${(j: :)tool_commands}
      echo \"🔄 Loading $tool_name...\"
      $load_command
      $cmd \"\$@\"
    }"
  done
}

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

# Lazy load Node.js and related tools
lazy_load "Node.js" "[ -s \"$NVM_DIR/nvm.sh\" ] && \. \"$NVM_DIR/nvm.sh\"" "node" "npm" "npx" "yarn" "pnpm"

# Auto use .nvmrc if present in directory
autoload -U add-zsh-hook
load-nvmrc() {
  # Only run if nvm is loaded
  if type nvm_find_nvmrc &> /dev/null; then
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
  fi
}

add-zsh-hook chpwd load-nvmrc 