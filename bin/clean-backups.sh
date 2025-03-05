#!/bin/bash
#
# File: clean-backups.sh
# Purpose: Removes backup and temporary files from the repository
# Dependencies: None
# Last updated: 2024-03-05
# Author: Tyler Newman
# Usage: ./bin/clean-backups.sh
# Note: This is a focused script that only removes backup files. For a more
#       comprehensive cleanup, use cleanup.sh which includes this functionality
#       along with additional maintenance tasks.

# Simple script to clean up backup and temporary files

# Get the root directory of the git repository
ROOT_DIR=$(git rev-parse --show-toplevel)

echo "Cleaning up backup and temporary files..."

# Remove backup files
find "$ROOT_DIR" -name "*.bak" -type f -delete
find "$ROOT_DIR" -name "*~" -type f -delete
find "$ROOT_DIR" -name "*.swp" -type f -delete
find "$ROOT_DIR" -name "*.swo" -type f -delete
find "$ROOT_DIR" -name ".*.swp" -type f -delete
find "$ROOT_DIR" -name ".*.swo" -type f -delete
find "$ROOT_DIR" -name "_tmp_*" -type f -delete
find "$ROOT_DIR" -name "*.orig" -type f -delete
find "$ROOT_DIR" -name "*.old" -type f -delete
find "$ROOT_DIR" -name "*.backup" -type f -delete
find "$ROOT_DIR" -name "*.backup.*" -type f -delete

# Remove .DS_Store files
find "$ROOT_DIR" -name ".DS_Store" -type f -delete

echo "Cleanup complete!"
exit 0 