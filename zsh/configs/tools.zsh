# Tool configurations

# VS Code - Removed completely
# alias code="\"/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code\""
# function c { code ${@:-.} }

# FZF - Now lazy loaded in lazy-tools.zsh
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Zoxide - Now lazy loaded in lazy-tools.zsh
# eval "$(zoxide init --cmd cd zsh)"

# GitHub Copilot - Now lazy loaded in lazy-tools.zsh
# eval "$(gh copilot alias -- zsh)"

# Atuin - Enhanced shell history - Now lazy loaded in lazy-tools.zsh
# if command -v atuin &> /dev/null; then
#   eval "$(atuin init zsh)"
# fi

# Bun completions - Now lazy loaded in lazy-tools.zsh
# [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Google Cloud SDK - Now lazy loaded in lazy-tools.zsh
# if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then 
#   source "$HOME/google-cloud-sdk/path.zsh.inc"
# fi
# 
# if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then 
#   source "$HOME/google-cloud-sdk/completion.zsh.inc"
# fi

# Docker and Docker Compose - Now lazy loaded in lazy-tools.zsh
# No configuration needed here anymore

# Enable vim mode but keep history
bindkey -v
bindkey "^R" history-incremental-search-backward 
bindkey "^S" history-incremental-search-forward
