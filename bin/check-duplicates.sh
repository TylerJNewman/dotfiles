#!/bin/bash
#
# File: check-duplicates.sh
# Purpose: Checks for duplicate functions and aliases across files
# Dependencies: None
# Last updated: 2024-03-05
# Author: Tyler Newman
# Usage: ./bin/check-duplicates.sh

# Simple script to check for duplicate functions and aliases

# Get the root directory of the git repository
ROOT_DIR=$(git rev-parse --show-toplevel)

echo "Checking for duplicate functions and aliases..."

# Check for duplicate functions
echo "Checking functions..."
grep -r "^function " "$ROOT_DIR/zsh" --include="*.zsh" | 
  awk -F'function ' '{print $2}' | 
  awk -F'(' '{print $1}' | 
  sort | 
  uniq -c | 
  sort -nr | 
  awk '$1 > 1 {print "Function \"" $2 "\" appears " $1 " times"}'

# Check for duplicate aliases
echo "Checking aliases..."
grep -r "^alias " "$ROOT_DIR/zsh" --include="*.zsh" | 
  awk -F'alias ' '{print $2}' | 
  awk -F'=' '{print $1}' | 
  sort | 
  uniq -c | 
  sort -nr | 
  awk '$1 > 1 {print "Alias \"" $2 "\" appears " $1 " times"}'

echo "Check complete!"
exit 0 