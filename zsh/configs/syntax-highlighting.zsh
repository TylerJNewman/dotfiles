#!/usr/bin/env zsh
#
# File: syntax-highlighting.zsh
# Purpose: Configure Fast-Syntax-Highlighting plugin
# Last updated: 2025

# Initialize the FAST_HIGHLIGHT array properly
typeset -gA FAST_HIGHLIGHT

# Enable async mode for better performance
FAST_HIGHLIGHT[use_async]=1

# Set git commit message length limit
FAST_HIGHLIGHT[git_cmsg_len]=72

# Custom styling for git commands
FAST_HIGHLIGHT[chroma-git]="fg=cyan"

# Workaround for paste issue
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# Additional optimizations
# Reduce the number of highlighters for better performance
FAST_HIGHLIGHT[chroma-man]=0
FAST_HIGHLIGHT[chroma-whatis]=0
FAST_HIGHLIGHT[chroma-example]=0

# Disable highlighting for large files (>100KB)
FAST_HIGHLIGHT[use_brackets]=1 