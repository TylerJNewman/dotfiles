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

section "Checking for Plugin Conflicts"

# Check fzf-tab dominance
echo "Checking fzf-tab configuration..."
if bindkey | grep -q "fzf-tab"; then
  success "fzf-tab keybindings are active"
else
  warning "fzf-tab keybindings not found"
fi

if zstyle | grep -q "fzf-tab"; then
  success "fzf-tab styles are configured"
else
  warning "fzf-tab styles not configured"
fi

# Check zoxide configuration
echo "Checking zoxide configuration..."
if env | grep -q "_ZO_DATA_DIR"; then
  success "zoxide database is properly isolated"
else
  warning "zoxide database location not explicitly set"
fi

if env | grep -q "_ZO_EXCLUDE_DIRS"; then
  success "zoxide has network mounts excluded"
else
  warning "zoxide network mount exclusions not configured"
fi

# Check for duplicate keybindings
echo "Checking for duplicate keybindings..."
CTRL_R_COUNT=$(bindkey | grep -c "\\^R")
ALT_C_COUNT=$(bindkey | grep -c "\\ec")
RIGHT_ARROW_COUNT=$(bindkey | grep -c "\\e\[C")

if [ "$CTRL_R_COUNT" -gt 1 ]; then
  error "Multiple Ctrl+R bindings detected (${CTRL_R_COUNT})"
else
  success "No duplicate Ctrl+R bindings"
fi

if [ "$ALT_C_COUNT" -gt 1 ]; then
  error "Multiple Alt+C bindings detected (${ALT_C_COUNT})"
else
  success "No duplicate Alt+C bindings"
fi

if [ "$RIGHT_ARROW_COUNT" -gt 1 ]; then
  error "Multiple Right Arrow bindings detected (${RIGHT_ARROW_COUNT})"
else
  success "No duplicate Right Arrow bindings"
fi

# Check for zsh-defer
echo "Checking zsh-defer configuration..."
if declare -f zsh-defer > /dev/null 2>&1; then
  success "zsh-defer is available"
  
  # Check if any critical paths are using zsh-defer
  if declare -f compinit > /dev/null 2>&1 && declare -f compinit | grep -q "zsh-defer"; then
    error "zsh-defer is blocking compinit (critical path)"
  else
    success "zsh-defer not blocking critical paths"
  fi
else
  warning "zsh-defer not found"
fi

# Check for syntax highlighting configuration
echo "Checking syntax highlighting configuration..."
if env | grep -q "FAST_HIGHLIGHT"; then
  success "Fast-syntax-highlighting is configured"
else
  warning "Fast-syntax-highlighting configuration not found"
fi

# Check for lazy loading of heavy tools
echo "Checking lazy loading configuration..."
if declare -f lazy_load > /dev/null 2>&1 || declare -f defer_fn > /dev/null 2>&1; then
  success "Lazy loading functions are defined"
else
  warning "No lazy loading functions found"
fi

section "Overall Health Check"

# Count warnings and errors
WARNING_COUNT=$(echo "$output" | grep -c "\[WARN\]")
ERROR_COUNT=$(echo "$output" | grep -c "\[ERROR\]")

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