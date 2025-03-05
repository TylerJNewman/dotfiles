# Utility Scripts

This directory contains utility scripts for managing and maintaining your dotfiles.

## Installation Scripts

- `install-git-hooks.sh` - Installs git hooks for the repository
- `install-fast-syntax-highlighting.sh` - Installs fast-syntax-highlighting for ZSH
- `install-modern-tools.sh` - Installs modern CLI tools and utilities

## Setup Scripts

- `setup-links.sh` - Sets up symbolic links for dotfiles
- `setup-on-login.sh` - Configures scripts in the `on-login` directory to run at login

## Maintenance Scripts

- `cleanup.sh` - Performs comprehensive cleanup tasks for the dotfiles repository
- `clean-backups.sh` - Focused script that removes backup and temporary files (subset of cleanup.sh)
- `check-duplicates.sh` - Checks for duplicate functions and aliases
- `check-alias-conflicts.sh` - Identifies potential conflicts between aliases and functions
- `update.sh` - Updates the dotfiles repository

## Performance Scripts

- `measure-startup-time.sh` - Comprehensive tool to measure ZSH startup time with detailed statistics
- `zsh-time.sh` - Simple wrapper for measure-startup-time.sh (for backward compatibility)
- `optimize-shell.sh` - Comprehensive script that applies multiple performance optimizations
- `optimize-zshrc.sh` - Focused script that optimizes plugin loading in zshrc
- `test-lazy-loading.sh` - Tests lazy loading functionality for various tools

## Development Scripts

- `lint-scripts.sh` - Lints shell scripts for errors and style issues
- `test-paths.sh` - Tests that directory paths are correct
- `switch-to-zinit.sh` - Converts from Oh-My-Zsh to Zinit plugin manager

## Usage

Most scripts can be run directly from the command line:

```bash
./bin/script-name.sh
```

Some scripts accept arguments. Check the script header for usage information:

```bash
# At the top of each script
# Usage: ./bin/script-name.sh [arguments]
```

## Adding New Scripts

When adding new scripts:

1. Follow the standard header format
2. Make the script executable: `chmod +x bin/your-script.sh`
3. Add appropriate error handling
4. Document the script in this README.md file