#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Create bin directory if it doesn't exist
mkdir -p $HOME/dotfiles/bin

# Function to display usage
usage() {
  echo "Usage: prompt-switch [minimal|standard|none]"
  echo "  minimal   - Ultra minimal prompt with just an arrow"
  echo "  standard  - Standard prompt with directory and git info"
  echo "  none      - No prompt at all (just a cursor)"
  exit 1
}

# Check if an argument was provided
if [ $# -ne 1 ]; then
  usage
fi

case "$1" in
  minimal)
    echo -e "${BLUE}Switching to minimal prompt...${NC}"
    cat > $HOME/.config/starship.toml << 'EOF'
# Starship Configuration - Ultra Minimal
add_newline = false
format = "$character"

[character]
success_symbol = "[→](bold green)"
error_symbol = "[→](bold red)"

# Disable everything else
[username]
disabled = true
[hostname]
disabled = true
[directory]
disabled = true
[git_branch]
disabled = true
[git_status]
disabled = true
[nodejs]
disabled = true
[python]
disabled = true
[rust]
disabled = true
[docker_context]
disabled = true
[time]
disabled = true
[cmd_duration]
disabled = true
EOF
    ;;
  standard)
    echo -e "${BLUE}Switching to standard prompt...${NC}"
    cat > $HOME/.config/starship.toml << 'EOF'
# Starship Configuration - Standard
add_newline = true
format = "$directory$git_branch$git_status$character"

[character]
success_symbol = "[→](bold green)"
error_symbol = "[→](bold red)"

[directory]
truncation_length = 3
home_symbol = "~"
style = "blue bold"

[git_branch]
format = "[$branch]($style) "
style = "bold green"

# Disable everything else
[username]
disabled = true
[hostname]
disabled = true
[nodejs]
disabled = true
[python]
disabled = true
[rust]
disabled = true
[docker_context]
disabled = true
[time]
disabled = true
[cmd_duration]
disabled = true
EOF
    ;;
  none)
    echo -e "${BLUE}Switching to no prompt...${NC}"
    cat > $HOME/.config/starship.toml << 'EOF'
# Starship Configuration - No Prompt
add_newline = false
format = ""

# Disable everything
[character]
disabled = true
[username]
disabled = true
[hostname]
disabled = true
[directory]
disabled = true
[git_branch]
disabled = true
[git_status]
disabled = true
[nodejs]
disabled = true
[python]
disabled = true
[rust]
disabled = true
[docker_context]
disabled = true
[time]
disabled = true
[cmd_duration]
disabled = true
EOF
    ;;
  *)
    usage
    ;;
esac

echo -e "${GREEN}Prompt updated! Restart your terminal or run 'source ~/.zshrc' to apply changes.${NC}" 