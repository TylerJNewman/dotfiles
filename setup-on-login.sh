#!/usr/bin/env bash

# This script sets up the on-login scripts to run automatically when you log in
# Inspired by Kent C. Dodds' dotfiles

# Set up colors for output
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ON_LOGIN_DIR="$DOTFILES_DIR/on-login"
LAUNCH_AGENTS_DIR="$HOME/Library/LaunchAgents"

echo -e "${BLUE}Setting up on-login scripts...${NC}"

# Make sure the on-login directory exists
if [ ! -d "$ON_LOGIN_DIR" ]; then
  echo -e "${YELLOW}Creating on-login directory...${NC}"
  mkdir -p "$ON_LOGIN_DIR"
fi

# Make sure the LaunchAgents directory exists
if [ ! -d "$LAUNCH_AGENTS_DIR" ]; then
  echo -e "${YELLOW}Creating LaunchAgents directory...${NC}"
  mkdir -p "$LAUNCH_AGENTS_DIR"
fi

# Make all scripts in the on-login directory executable
echo -e "${YELLOW}Making on-login scripts executable...${NC}"
find "$ON_LOGIN_DIR" -type f -name "*.sh" -exec chmod +x {} \;

# Create a LaunchAgent plist file for each script in the on-login directory
for script in "$ON_LOGIN_DIR"/*.sh; do
  if [ -f "$script" ]; then
    script_name=$(basename "$script" .sh)
    plist_file="$LAUNCH_AGENTS_DIR/com.user.onlogin.$script_name.plist"
    
    echo -e "${YELLOW}Creating LaunchAgent for $script_name...${NC}"
    
    cat > "$plist_file" << EOL
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.onlogin.$script_name</string>
    <key>ProgramArguments</key>
    <array>
        <string>$script</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
EOL
    
    # Load the LaunchAgent
    launchctl unload "$plist_file" 2>/dev/null
    launchctl load "$plist_file"
    
    echo -e "${GREEN}LaunchAgent for $script_name created and loaded.${NC}"
  fi
done

echo -e "${GREEN}On-login scripts setup complete!${NC}"
echo -e "${YELLOW}The following scripts will run when you log in:${NC}"
ls -la "$ON_LOGIN_DIR" 