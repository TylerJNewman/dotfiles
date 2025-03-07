#!/usr/bin/env zsh
# General ZSH options

# Directory navigation
setopt AUTO_CD              # Change directory without cd

# Globbing and pattern matching
setopt EXTENDED_GLOB        # Extended globbing
setopt NO_CASE_GLOB         # Case insensitive globbing
setopt NUMERIC_GLOB_SORT    # Sort filenames numerically

# Command correction and completion
setopt CORRECT              # Command correction
setopt COMPLETE_IN_WORD     # Complete from both ends of a word 