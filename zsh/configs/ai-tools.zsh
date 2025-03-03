# AI Development Tools Configuration

# GitHub Copilot CLI - Enhanced terminal experience with AI
if command -v github-copilot-cli &> /dev/null; then
  # Setup Copilot CLI aliases
  alias ??="github-copilot-cli what-the-shell"
  alias git?="github-copilot-cli git-assist"
  alias gh?="github-copilot-cli gh-assist"
  
  # Enable Copilot CLI autocompletions
  eval "$(github-copilot-cli alias -- zsh)"
fi

# Codeium CLI - Alternative to GitHub Copilot
if command -v codeium &> /dev/null; then
  # Enable Codeium CLI completions
  eval "$(codeium shell-init zsh)"
  alias codeium-auth="codeium auth"
  alias codeium-reset="codeium reset"
fi

# Continue.dev - Local AI coding assistant
if command -v continue &> /dev/null; then
  alias cont="continue"
  alias ai-explain="continue explain"
  alias ai-refactor="continue refactor"
fi

# Ollama - Run local LLMs
if command -v ollama &> /dev/null; then
  # Ollama shortcuts
  alias ollm="ollama run"
  alias ollm-list="ollama list"
  alias ollm-codellama="ollama run codellama"
  alias ollm-llama3="ollama run llama3"
  
  # Function to chat with a model
  ollm-chat() {
    local model=${1:-llama3}
    echo "Starting chat with $model (type 'exit' to quit)"
    ollama run $model
  }
fi

# AI-powered search and documentation
if command -v aichat &> /dev/null; then
  alias aic="aichat"
fi 