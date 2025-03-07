#!/usr/bin/env zsh
#
# File: lazy-load.zsh
# Purpose: Minimal lazy loading for performance-heavy tools

# Generic lazy loading function
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
  lazy_load "source \"$NVM_DIR/nvm.sh\"" "nvm"
  
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
  lazy_load "[ -s \"$BUN_INSTALL/_bun\" ] && source \"$BUN_INSTALL/_bun\"" "bun"
fi

# Lazy load pyenv if installed
if command -v pyenv &>/dev/null; then
  lazy_load "eval \"\$(pyenv init -)\"" "pyenv"
fi

# Lazy load rbenv if installed
if command -v rbenv &>/dev/null; then
  lazy_load "eval \"\$(rbenv init -)\"" "rbenv"
fi

# Lazy load direnv if installed
if command -v direnv &>/dev/null; then
  lazy_load "eval \"\$(direnv hook zsh)\"" "direnv"
fi 