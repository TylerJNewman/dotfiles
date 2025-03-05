# Git Configuration

This directory contains Git configuration files and hooks.

## Files

- `gitconfig` - Main Git configuration with aliases, settings, and defaults
- `gitconfig.local` - Local Git configuration for user-specific settings (not committed)
- `gitignore_global` - Global Git ignore patterns
- `hooks/` - Git hooks for the repository

## Git Configuration

The `gitconfig` file contains various Git settings, including:

- Useful aliases for common commands
- Default behavior settings
- UI preferences
- Diff and merge tool configurations
- Helper settings

This file is symlinked to `~/.gitconfig` during installation.

## Local Git Configuration

The `gitconfig.local` file contains user-specific settings that shouldn't be committed to the repository, such as:

- User name and email
- GitHub tokens or credentials
- Work-specific configurations

This file is included by the main `gitconfig` file and is symlinked to `~/.gitconfig.local` during installation.

## Global Git Ignore

The `gitignore_global` file defines patterns for files that should be ignored by Git across all repositories, such as:

- Operating system files (e.g., `.DS_Store`)
- Editor temporary files (e.g., `.swp`, `.swo`)
- Build artifacts and dependencies
- Log files and caches

This file is symlinked to `~/.gitignore_global` during installation.

## Git Hooks

The `hooks/` directory contains Git hooks for the repository:

- `pre-commit` - Runs before committing to ensure code quality
- Other hooks as needed

These hooks are installed by running `bin/install-git-hooks.sh`.

## Customizing Git Configuration

To customize your Git configuration:

1. Edit the main `gitconfig` file for changes that should be shared
2. Edit the `gitconfig.local` file for user-specific settings
3. Add patterns to `gitignore_global` for files to ignore globally
4. Create or modify hooks in the `hooks/` directory for custom behavior

## Best Practices

- Keep sensitive information in `gitconfig.local`
- Use descriptive aliases for common commands
- Document non-obvious settings with comments
- Test hooks before installing them
- Keep the global ignore list focused on truly global patterns 