#!/bin/bash
#
# File: zsh-time.sh
# Purpose: Simple wrapper for measure-startup-time.sh
# Dependencies: measure-startup-time.sh
# Last updated: 2024-03-05
# Author: Tyler Newman
# Usage: ./bin/zsh-time.sh [iterations]
#
# This is a simple wrapper for measure-startup-time.sh for backward compatibility.
# For more detailed output, use measure-startup-time.sh directly.

# Get the directory of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Call measure-startup-time.sh with all arguments
"$SCRIPT_DIR/measure-startup-time.sh" "$@" 