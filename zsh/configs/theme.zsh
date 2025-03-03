# Theme and prompt configuration

# Using Starship prompt - a modern, fast cross-shell prompt
ZSH_THEME=""

# Disable Oh-My-Zsh prompt completely
PROMPT=""
RPROMPT=""

# Initialize Starship if installed
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# Note: Powerlevel10k has been removed in favor of Starship
# If you want to switch back to Powerlevel10k, use the following:
# ZSH_THEME="powerlevel10k/powerlevel10k"
# POWERLEVEL9K_INSTANT_PROMPT=quiet
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
