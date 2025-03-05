#!/bin/bash
#
# File: update.sh
# Purpose: Simple script to update the dotfiles repository
# Dependencies: git
# Last updated: 2024-03-05
# Author: Tyler Newman
# Usage: ./bin/update.sh

# Simple script to update the dotfiles repository

echo "Updating dotfiles repository..."

# Get the root directory of the git repository
ROOT_DIR=$(git rev-parse --show-toplevel)
cd "$ROOT_DIR" || exit 1

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
  echo "You have uncommitted changes. Please commit or stash them first."
  exit 1
fi

# Pull the latest changes
echo "Pulling the latest changes..."
git pull

# Run the installation script
echo "Running the installation script..."
./install.sh

echo "Update complete!"
echo "You may need to restart your terminal or source your zshrc:"
echo "source ~/.zshrc"

exit 0 