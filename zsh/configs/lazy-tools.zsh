# Lazy loading for various tools
# This file implements lazy loading for several tools to improve shell startup time

# Helper function to lazy load a tool
lazy_load() {
  local tool_name=$1
  local load_command=$2
  local -a tool_commands=("${@:3}")
  
  for cmd in "${tool_commands[@]}"; do
    eval "function $cmd() {
      unfunction ${(j: :)tool_commands} 2>/dev/null
      echo \"🔄 Loading $tool_name...\"
      $load_command
      $cmd \"\$@\"
    }"
  done
}

# Lazy load zoxide
if command -v zoxide &> /dev/null; then
  lazy_load "zoxide" "eval \"\$(zoxide init --cmd cd zsh)\"" "z" "zi"
fi

# Lazy load GitHub Copilot
if command -v gh &> /dev/null; then
  lazy_load "GitHub Copilot" "eval \"\$(gh copilot alias -- zsh)\"" "gh-copilot"
fi

# Lazy load Atuin
if command -v atuin &> /dev/null; then
  # Special case for Atuin due to widget binding
  function __atuin_load() {
    unfunction atuin 2>/dev/null
    eval "$(atuin init zsh)"
  }
  
  function atuin() {
    __atuin_load
    echo "🔄 Loading Atuin..."
    atuin "$@"
  }
  
  # Override Ctrl+R to load atuin when needed
  bindkey -r '^R'
  bindkey '^R' __atuin_search_widget
  
  function __atuin_search_widget() {
    __atuin_load
    # Re-bind the key to the actual atuin widget
    bindkey '^R' _atuin_search_widget
    # Trigger the search
    zle _atuin_search_widget
  }
  zle -N __atuin_search_widget
fi

# Lazy load Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  lazy_load "Google Cloud SDK" "source \"$HOME/google-cloud-sdk/path.zsh.inc\" && source \"$HOME/google-cloud-sdk/completion.zsh.inc\"" "gcloud" "gsutil" "bq"
fi

# Lazy load Deno
if [ -d "$HOME/.deno" ]; then
  lazy_load "Deno" "export DENO_INSTALL=\"$HOME/.deno\" && export PATH=\"\$DENO_INSTALL/bin:\$PATH\"" "deno"
fi

# Lazy load Bun
if [ -d "$HOME/.bun" ]; then
  lazy_load "Bun" "export BUN_INSTALL=\"$HOME/.bun\" && export PATH=\"\$BUN_INSTALL/bin:\$PATH\" && [ -s \"$HOME/.bun/_bun\" ] && source \"$HOME/.bun/_bun\"" "bun" "bunx"
fi

# Lazy load FZF
if [ -f ~/.fzf.zsh ]; then
  lazy_load "FZF" "source ~/.fzf.zsh" "fzf"
fi

# Lazy load Docker and Docker Compose
if command -v docker &> /dev/null; then
  # Special case for Docker due to completions
  function __docker_load() {
    unfunction docker docker-compose docker-machine docker-buildx 2>/dev/null
    # If using Oh-My-Zsh with docker plugin, we need to reload completions
    if [[ -f "$ZSH/plugins/docker/_docker" ]]; then
      source "$ZSH/plugins/docker/_docker"
    fi
    if [[ -f "$ZSH/plugins/docker-compose/_docker-compose" ]]; then
      source "$ZSH/plugins/docker-compose/_docker-compose"
    fi
    # If using zinit, load completions differently
    if [[ -f "$HOME/.local/share/zinit/snippets/OMZ::plugins/docker/_docker" ]]; then
      source "$HOME/.local/share/zinit/snippets/OMZ::plugins/docker/_docker"
    fi
    if [[ -f "$HOME/.local/share/zinit/snippets/OMZ::plugins/docker-compose/_docker-compose" ]]; then
      source "$HOME/.local/share/zinit/snippets/OMZ::plugins/docker-compose/_docker-compose"
    fi
  }
  
  lazy_load "Docker" "__docker_load" "docker" "docker-compose" "docker-machine" "docker-buildx"
fi

# Note: NVM lazy loading is already implemented in nvm-lazy.zsh 