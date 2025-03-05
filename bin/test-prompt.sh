#!/bin/bash
#
# File: test-prompt.sh
# Purpose: Tests the new prompt configuration
# Dependencies: None
# Last updated: 2024-03-05
# Author: Tyler Newman
# Usage: ./bin/test-prompt.sh
# Description: This script opens a new ZSH shell with the updated prompt configuration

# Get the root directory of the git repository
ROOT_DIR=$(git rev-parse --show-toplevel)

# Create a temporary zshrc file
TMP_ZSHRC="/tmp/test_zshrc_$$"

# Write a minimal zshrc that sources just the prompt configuration
cat > "$TMP_ZSHRC" << EOF
# Minimal zshrc for testing the prompt
source "$ROOT_DIR/zsh/prompt.zsh"

# Display a message
echo "Testing new prompt configuration..."
echo "You are now in a test shell with the new prompt."
echo "Type 'exit' to return to your normal shell."
echo
EOF

# Make the file executable
chmod +x "$TMP_ZSHRC"

# Start a new ZSH shell with the temporary zshrc
ZDOTDIR=/tmp zsh -i

# Clean up
rm -f "$TMP_ZSHRC" 