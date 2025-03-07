#!/usr/bin/env zsh
#
# File: lazy-load.zsh
# Purpose: Minimal lazy loading for performance-heavy tools

# Safe wrapper for zsh-defer to prevent race conditions
defer_fn() {
  emulate -L zsh
  local fn=$1
  
  # Only use zsh-defer if it's available
  if (( $+functions[zsh-defer] )); then
    zsh-defer -c "$fn"
  else
    # Fallback to direct execution if zsh-defer isn't available
    eval "$fn"
  fi
}

# Generic lazy loading function for commands
function lazy_load() {
  local load_cmd=$1
  local cmd_name=$2
  
  eval "function ${cmd_name}() {
    unfunction ${cmd_name}
    eval \"${load_cmd}\"
    ${cmd_name} \"\$@\"
  }"
}

# Lazy load NVM
if [[ -d "$NVM_DIR" ]]; then
  # Use defer_fn for NVM initialization
  defer_fn 'source "$NVM_DIR/nvm.sh"'
  
  # Create node/npm/npx shims
  for cmd in node npm npx; do
    eval "function ${cmd}() {
      unfunction node npm npx
      source \"$NVM_DIR/nvm.sh\"
      ${cmd} \"\$@\"
    }"
  done
fi

# Lazy load Bun
if [[ -d "$BUN_INSTALL" ]]; then
  defer_fn '[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"'
fi

# Lazy load pyenv if installed
if command -v pyenv &>/dev/null; then
  defer_fn 'eval "$(pyenv init -)"'
fi

# Lazy load rbenv if installed
if command -v rbenv &>/dev/null; then
  defer_fn 'eval "$(rbenv init -)"'
fi

# Lazy load direnv if installed
if command -v direnv &>/dev/null; then
  defer_fn 'eval "$(direnv hook zsh)"'
fi 