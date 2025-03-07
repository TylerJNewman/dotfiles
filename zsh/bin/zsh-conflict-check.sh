#!/usr/bin/env zsh
# Zsh Plugin Conflict Checker
# This script checks for common plugin conflicts and configuration issues
# Last updated: 2025

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print section header
section() {
  echo -e "\n${BLUE}==>${NC} ${GREEN}$1${NC}"
}

# Print success message
success() {
  echo -e "${GREEN}[OK]${NC} $1"
}

# Print warning message
warning() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

# Print error message
error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

# Check if command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Capture all output for later analysis
output=""

section "Checking for Plugin Conflicts"

# Check fzf-tab dominance
echo "Checking fzf-tab configuration..."
if zstyle | grep -q "fzf-tab"; then
  success_msg="fzf-tab styles are configured"
  success "$success_msg"
  output+="$success_msg\n"
else
  warning_msg="fzf-tab styles not configured"
  warning "$warning_msg"
  output+="$warning_msg\n"
fi

# Check zoxide configuration
echo "Checking zoxide configuration..."
if env | grep -q "_ZO_DATA_DIR"; then
  success_msg="zoxide database is properly isolated"
  success "$success_msg"
  output+="$success_msg\n"
else
  warning_msg="zoxide database location not explicitly set"
  warning "$warning_msg"
  output+="$warning_msg\n"
fi

if env | grep -q "_ZO_EXCLUDE_DIRS"; then
  success_msg="zoxide has network mounts excluded"
  success "$success_msg"
  output+="$success_msg\n"
else
  warning_msg="zoxide network mount exclusions not configured"
  warning "$warning_msg"
  output+="$warning_msg\n"
fi

# Check for duplicate keybindings
echo "Checking for duplicate keybindings..."
CTRL_R_COUNT=$(bindkey | grep -c "\\^R")
ALT_C_COUNT=$(bindkey | grep -c "\\ec")
RIGHT_ARROW_COUNT=$(bindkey | grep -c "\\e\[C")

if [ "$CTRL_R_COUNT" -gt 1 ]; then
  error_msg="Multiple Ctrl+R bindings detected (${CTRL_R_COUNT})"
  error "$error_msg"
  output+="$error_msg\n"
else
  success_msg="No duplicate Ctrl+R bindings"
  success "$success_msg"
  output+="$success_msg\n"
fi

if [ "$ALT_C_COUNT" -gt 1 ]; then
  error_msg="Multiple Alt+C bindings detected (${ALT_C_COUNT})"
  error "$error_msg"
  output+="$error_msg\n"
else
  success_msg="No duplicate Alt+C bindings"
  success "$success_msg"
  output+="$success_msg\n"
fi

if [ "$RIGHT_ARROW_COUNT" -gt 1 ]; then
  error_msg="Multiple Right Arrow bindings detected (${RIGHT_ARROW_COUNT})"
  error "$error_msg"
  output+="$error_msg\n"
else
  success_msg="No duplicate Right Arrow bindings"
  success "$success_msg"
  output+="$success_msg\n"
fi

# Check for zsh-defer
echo "Checking zsh-defer configuration..."
# Source the plugins file to ensure zsh-defer is loaded for the check
if [[ -f "$HOME/dotfiles/zsh/configs/plugins.zsh" ]]; then
  source "$HOME/dotfiles/zsh/configs/plugins.zsh" 2>/dev/null
fi

if typeset -f zsh-defer > /dev/null 2>&1; then
  success_msg="zsh-defer is available"
  success "$success_msg"
  output+="$success_msg\n"
  
  # Check if any critical paths are using zsh-defer
  if typeset -f compinit > /dev/null 2>&1 && typeset -f compinit | grep -q "zsh-defer"; then
    error_msg="zsh-defer is blocking compinit (critical path)"
    error "$error_msg"
    output+="$error_msg\n"
  else
    success_msg="zsh-defer not blocking critical paths"
    success "$success_msg"
    output+="$success_msg\n"
  fi
else
  warning_msg="zsh-defer not found"
  warning "$warning_msg"
  output+="$warning_msg\n"
fi

# Check for syntax highlighting configuration
echo "Checking syntax highlighting configuration..."
# Source the syntax highlighting config to ensure it's loaded for the check
if [[ -f "$HOME/dotfiles/zsh/configs/syntax-highlighting.zsh" ]]; then
  source "$HOME/dotfiles/zsh/configs/syntax-highlighting.zsh" 2>/dev/null
fi

if typeset -p FAST_HIGHLIGHT > /dev/null 2>&1; then
  success_msg="Fast-syntax-highlighting is configured"
  success "$success_msg"
  output+="$success_msg\n"
else
  warning_msg="Fast-syntax-highlighting configuration not found"
  warning "$warning_msg"
  output+="$warning_msg\n"
fi

# Check for lazy loading of heavy tools
echo "Checking lazy loading configuration..."
# Source the lazy-load file to ensure it's loaded for the check
if [[ -f "$HOME/dotfiles/zsh/configs/lazy-load.zsh" ]]; then
  source "$HOME/dotfiles/zsh/configs/lazy-load.zsh" 2>/dev/null
fi

if typeset -f lazy_load > /dev/null 2>&1 || typeset -f defer_fn > /dev/null 2>&1; then
  success_msg="Lazy loading functions are defined"
  success "$success_msg"
  output+="$success_msg\n"
else
  warning_msg="No lazy loading functions found"
  warning "$warning_msg"
  output+="$warning_msg\n"
fi

section "Overall Health Check"

# Count warnings and errors
WARNING_COUNT=$(echo -e "$output" | grep -c "\[WARN\]")
ERROR_COUNT=$(echo -e "$output" | grep -c "\[ERROR\]")

if [ "$ERROR_COUNT" -eq 0 ] && [ "$WARNING_COUNT" -eq 0 ]; then
  echo -e "${GREEN}All checks passed! Your Zsh configuration is optimized.${NC}"
elif [ "$ERROR_COUNT" -eq 0 ]; then
  echo -e "${YELLOW}Configuration looks good with $WARNING_COUNT minor issues to consider.${NC}"
else
  echo -e "${RED}Found $ERROR_COUNT issues that should be fixed for optimal performance.${NC}"
fi

# Provide startup time information if available
if command_exists zsh && command_exists time; then
  echo -e "\n${BLUE}Measuring shell startup time...${NC}"
  time zsh -i -c exit
fi 