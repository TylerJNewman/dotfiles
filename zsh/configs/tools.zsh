# Tool configurations

# VS Code
alias code="\"/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code\""
function c { code ${@:-.} }

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Zoxide
eval "$(zoxide init --cmd cd zsh)"

# GitHub Copilot
eval "$(gh copilot alias -- zsh)"

# Bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then 
  source "$HOME/google-cloud-sdk/path.zsh.inc"
fi

if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then 
  source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# Enable vim mode but keep history
bindkey -v
bindkey ^R history-incremental-search-backward 
bindkey ^S history-incremental-search-forward
