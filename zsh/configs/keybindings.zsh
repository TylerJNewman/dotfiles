#!/usr/bin/env zsh
#
# File: keybindings.zsh
# Purpose: Manage key bindings and prevent collisions between plugins
# Last updated: 2025

# Reset key bindings that might cause conflicts
bindkey -r "^R"       # Reset Ctrl+R (fzf history vs zsh-history-substring-search)
bindkey -r "^[c"      # Reset Alt+C (fzf dir jump vs other plugins)
bindkey -r "^[[C"     # Reset Right Arrow (autosuggestions vs fzf-tab)

# If zsh-defer is available, use it to rebind after plugin initialization
if (( $+functions[zsh-defer] )); then
  # Defer fzf keybindings to ensure they take precedence
  zsh-defer -c 'bindkey "^R" fzf-history-widget'
  zsh-defer -c 'bindkey "^[c" fzf-cd-widget'
  
  # Ensure autosuggestions work with right arrow
  zsh-defer -c 'bindkey "^[[C" forward-char'
else
  # If zsh-defer isn't available, set bindings directly
  # These might get overridden by plugins loaded later
  bindkey "^R" fzf-history-widget
  bindkey "^[c" fzf-cd-widget
  bindkey "^[[C" forward-char
fi

# Note: history-substring-search keybindings are now handled in the plugin loading
# with the atload hook in plugins.zsh

# Vim-like keybindings
bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word 