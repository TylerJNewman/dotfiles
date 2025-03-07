#!/usr/bin/env zsh
# File: starship.zsh
# Purpose: Configuration for Starship prompt
# Last updated: 2025

# Only proceed if Starship is installed
if (( ! $+commands[starship] )); then
  # Provide installation instructions if Starship is not found
  if [[ ! -f "$ZSH_CUSTOM_DIR/.starship_notified" ]]; then
    echo "Starship not found. Install with:"
    echo "  curl -sS https://starship.rs/install.sh | sh  # All platforms"
    echo "  brew install starship                         # macOS with Homebrew"
    touch "$ZSH_CUSTOM_DIR/.starship_notified"
  fi
  return
fi

# Ensure Starship config directory exists
if [[ ! -d "$HOME/.config" ]]; then
  mkdir -p "$HOME/.config"
fi

# Initialize Starship with proper quoting to avoid issues on macOS
# The double quotes around the command substitution are critical
eval "$(starship init zsh)"

# Set Starship config path if a custom one exists
if [[ -f "$DOTFILES/config/starship/starship.toml" ]]; then
  export STARSHIP_CONFIG="$DOTFILES/config/starship/starship.toml"
fi

# Optional: Set Starship cache directory to reduce disk I/O
export STARSHIP_CACHE="$HOME/.cache/starship"
if [[ ! -d "$STARSHIP_CACHE" ]]; then
  mkdir -p "$STARSHIP_CACHE"
fi 