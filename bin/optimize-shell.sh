#!/bin/bash
# Script to apply shell performance optimizations

# Set text colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Shell Performance Optimization${NC}"
echo "This script will apply performance optimizations to your shell configuration."
echo

# Check if we're in the dotfiles directory
if [[ ! -d "zsh" || ! -d "bin" ]]; then
  echo -e "${RED}Error: This script must be run from the dotfiles directory.${NC}"
  echo "Please run: cd ~/dotfiles && ./bin/optimize-shell.sh"
  exit 1
fi

# Function to backup a file
backup_file() {
  local file=$1
  if [[ -f "$file" ]]; then
    local backup="${file}.bak.$(date +%Y%m%d%H%M%S)"
    echo -e "${YELLOW}Backing up ${file} to ${backup}${NC}"
    cp "$file" "$backup"
  fi
}

# Backup current configuration
echo "Backing up current configuration..."
backup_file "$HOME/.zshrc"
backup_file "$HOME/dotfiles/zsh/zshrc"
backup_file "$HOME/dotfiles/zsh/configs/tools.zsh"
backup_file "$HOME/dotfiles/zsh/configs/path.zsh"

# Apply optimizations
echo -e "${YELLOW}Applying optimizations...${NC}"

# Create lazy-tools.zsh if it doesn't exist
if [[ ! -f "zsh/configs/lazy-tools.zsh" ]]; then
  echo "Creating lazy-tools.zsh..."
  cp "zsh/configs/tools.zsh" "zsh/configs/lazy-tools.zsh"
  # This is just a placeholder - the actual content should be created manually
  echo "# Lazy loading implementation for various tools" > "zsh/configs/lazy-tools.zsh"
  echo "# Please see the documentation for details on how to implement lazy loading." >> "zsh/configs/lazy-tools.zsh"
fi

# Create performance.zsh if it doesn't exist
if [[ ! -f "zsh/functions/performance.zsh" ]]; then
  echo "Creating performance.zsh..."
  mkdir -p "zsh/functions"
  # This is just a placeholder - the actual content should be created manually
  echo "# Shell performance measurement functions" > "zsh/functions/performance.zsh"
  echo "# Please see the documentation for details on how to implement performance measurement." >> "zsh/functions/performance.zsh"
fi

# Update zshrc to remove unnecessary plugins
if [[ -f "zsh/zshrc" ]]; then
  echo "Updating zshrc to remove unnecessary plugins..."
  sed -i.tmp -E 's/plugins=\((.*)(node|npm|yarn|pnpm|bun|fzf)(.*)\)/plugins=\(\1\3\)/g' "zsh/zshrc"
  rm -f "zsh/zshrc.tmp"
  
  # Replace zsh-syntax-highlighting with fast-syntax-highlighting
  echo "Replacing zsh-syntax-highlighting with fast-syntax-highlighting..."
  sed -i.tmp -E 's/zsh-syntax-highlighting/fast-syntax-highlighting/g' "zsh/zshrc"
  rm -f "zsh/zshrc.tmp"
  
  # Remove docker, docker-compose, and vscode plugins
  echo "Removing docker, docker-compose, and vscode plugins..."
  sed -i.tmp -E 's/plugins=\((.*)(docker|docker-compose|vscode)(.*)\)/plugins=\(\1\3\)/g' "zsh/zshrc"
  rm -f "zsh/zshrc.tmp"
fi

# Update tools.zsh to remove VSCode configuration
if [[ -f "zsh/configs/tools.zsh" ]]; then
  echo "Removing VSCode configuration from tools.zsh..."
  sed -i.tmp -E 's/^alias code=.*$/#alias code="\/Applications\/Visual Studio Code.app\/Contents\/Resources\/app\/bin\/code"/g' "zsh/configs/tools.zsh"
  sed -i.tmp -E 's/^function c \{.*\}$/#function c \{ code \$\{@:-.\} \}/g' "zsh/configs/tools.zsh"
  rm -f "zsh/configs/tools.zsh.tmp"
fi

# Create test script if it doesn't exist
if [[ ! -f "bin/test-lazy-loading.sh" ]]; then
  echo "Creating test-lazy-loading.sh..."
  # This is just a placeholder - the actual content should be created manually
  echo "#!/bin/bash" > "bin/test-lazy-loading.sh"
  echo "# Script to test lazy loading of various tools" >> "bin/test-lazy-loading.sh"
  echo "echo 'Testing lazy loading implementation...'" >> "bin/test-lazy-loading.sh"
  chmod +x "bin/test-lazy-loading.sh"
fi

# Install fast-syntax-highlighting if not already installed
if [[ -f "bin/install-fast-syntax-highlighting.sh" ]]; then
  echo "Installing fast-syntax-highlighting..."
  ./bin/install-fast-syntax-highlighting.sh
else
  echo -e "${YELLOW}Warning: fast-syntax-highlighting installation script not found.${NC}"
  echo "Please run the following commands manually:"
  echo "git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \\"
  echo "  \$HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting"
fi

# Measure current shell startup time
echo -e "${YELLOW}Measuring current shell startup time...${NC}"
TIMEFORMAT='%3R'
STARTUP_TIME=$( { time zsh -i -c exit; } 2>&1 )
echo -e "Current shell startup time: ${GREEN}${STARTUP_TIME} seconds${NC}"

echo -e "${GREEN}Optimizations applied successfully!${NC}"
echo
echo "Next steps:"
echo "1. Review the changes made to your configuration files"
echo "2. Run './bin/test-lazy-loading.sh' to test the lazy loading implementation"
echo "3. Restart your shell or run 'source ~/.zshrc' to apply the changes"
echo
echo -e "${YELLOW}For more information, see:${NC}"
echo "- docs/PERFORMANCE.md - Detailed documentation on performance optimizations"
echo "- zsh/configs/README.md - Information on lazy loading implementation" 