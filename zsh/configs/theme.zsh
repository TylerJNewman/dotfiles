# Theme and prompt configuration

# Powerlevel10k instant prompt
POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load p10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
