#!/bin/bash

# Script to optimize ~/.zshrc by removing Node.js related plugins

# Backup the original file
cp ~/.zshrc ~/.zshrc.bak

# Define the plugins to keep
KEEP_PLUGINS="git zsh-autosuggestions zsh-syntax-highlighting zsh-abbr docker docker-compose fzf"

# Read the current plugins line
CURRENT_PLUGINS=$(grep -E "^plugins=\(" ~/.zshrc | head -1)

if [ -z "$CURRENT_PLUGINS" ]; then
  echo "Could not find plugins line in ~/.zshrc"
  exit 1
fi

# Create the new plugins line
NEW_PLUGINS="plugins=(\n  $(echo $KEEP_PLUGINS | sed 's/ /\n  /g')\n)"

# Replace the plugins line in the file
sed -i.tmp -E "s/^plugins=\(.*\)/$(echo $NEW_PLUGINS | sed 's/\//\\\//g')/" ~/.zshrc

# Remove the temporary file
rm -f ~/.zshrc.tmp

echo "Your ~/.zshrc has been optimized!"
echo "Original file backed up to ~/.zshrc.bak"
echo ""
echo "The following plugins were kept:"
echo "$KEEP_PLUGINS" | tr ' ' '\n' | sed 's/^/- /'
echo ""
echo "Node.js related plugins (node, npm, yarn, pnpm, bun) were removed"
echo "since they're now handled by the lazy loading mechanism."
echo ""
echo "Restart your shell or run 'source ~/.zshrc' to apply changes." 