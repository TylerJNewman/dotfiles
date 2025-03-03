# My Dotfiles

A thoughtfully organized collection of my development environment configuration files.

## Guiding Principles

1. **Modularity First**: Keep configurations separate and focused on specific tools.
2. **Security Conscious**: Never commit sensitive data like API keys or tokens.
3. **Self-documenting**: Maintain clear comments and organization to understand each configuration.
4. **Cross-platform Compatible**: Support both macOS and Linux when possible.
5. **Version Controlled**: Track changes systematically with meaningful commit messages.
6. **Idempotent**: Installation should be repeatable without side effects.
7. **Minimally Invasive**: Avoid changing system defaults unless necessary.
8. **Performance Focused**: Optimize for shell startup time and responsiveness.

## Structure

```
dotfiles/
├── bin/                  # Custom executable scripts
├── zsh/                  # ZSH configuration
│   ├── aliases/          # Command aliases by category
│   ├── functions/        # Shell functions
│   ├── configs/          # Tool-specific configurations
│   ├── secrets/          # Git-ignored directory for sensitive data
│   └── zshrc             # Main ZSH configuration file
├── git/                  # Git configuration
│   ├── gitconfig         # Git settings
│   └── gitignore_global  # Global gitignore patterns
├── vim/                  # Vim configuration
├── install.sh            # Installation script
└── README.md             # This file
```

## Installation

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Best Practices for Maintaining This Repository

### For Contributors (Including LLMs)

1. **File Organization**:
   - Place new aliases in the appropriate category file in `zsh/aliases/`
   - Create new category files when needed (5+ related aliases)
   - Keep functions in `zsh/functions/` with descriptive names

2. **Documentation**:
   - Comment complex functions with usage examples
   - Maintain a consistent comment style (# for comments, ## for section headers)
   - Update this README when adding major features

3. **Security**:
   - Never commit API keys, tokens, or passwords
   - Use environment variables sourced from `zsh/secrets/env.zsh` (git-ignored)
   - Provide example configuration files with placeholder values

4. **Performance**:
   - Check shell startup time before/after changes: `time zsh -i -c exit`
   - Lazy-load heavy or infrequently used functions
   - Profile for bottlenecks: `zmodload zsh/zprof` at top, `zprof` at bottom

5. **Testing**:
   - Test changes in a clean environment when possible
   - Check compatibility across different systems (macOS/Linux)
   - Validate with `shellcheck` for bash/sh scripts

6. **Version Control**:
   - Use meaningful commit messages with the format: `[component] Brief description`
   - Group related changes in a single commit
   - Update version history in this README for significant changes

7. **Machine-specific Customization**:
   - Use `zsh/local.zsh` (git-ignored) for machine-specific settings
   - Detect OS and adapt configurations when necessary

8. **Dependencies**:
   - Document all external dependencies in this README
   - Consider providing installation instructions or fallbacks

9. **Cleanup**:
   - Regularly review for obsolete configurations
   - Remove commented-out code that's no longer needed
   - Consolidate similar functions and aliases

### Automating Maintenance

Consider these automation opportunities:
- Periodic linting with shellcheck in CI
- Automated backup of dotfiles to private storage
- Scheduled review reminders to clean up unused aliases/functions

## External Dependencies

- [Oh-My-Zsh](https://ohmyz.sh/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [fzf](https://github.com/junegunn/fzf)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)

## Version History

- **2025-03-03**: Initial repository setup