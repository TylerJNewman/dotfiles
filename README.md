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
│   │   ├── bun.zsh       # Bun package manager aliases
│   │   ├── docker.zsh    # Docker and container aliases
│   │   ├── git.zsh       # Git version control aliases
│   │   ├── navigation.zsh # File system navigation aliases
│   │   ├── package_managers.zsh # NPM and Yarn aliases
│   │   └── pnpm.zsh      # PNPM package manager aliases
│   ├── functions/        # Shell functions
│   ├── configs/          # Tool-specific configurations
│   │   ├── path.zsh      # PATH environment variables
│   │   ├── theme.zsh     # Terminal theme settings
│   │   └── tools.zsh     # Development tools configuration
│   ├── secrets/          # Git-ignored directory for sensitive data
│   │   ├── env.zsh       # Private environment variables (git-ignored)
│   │   └── env.zsh.example # Example template for env.zsh
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

## Features

### ZSH Plugins

This configuration includes several powerful ZSH plugins to enhance your terminal experience:

| Plugin | Description |
|--------|-------------|
| **git** | Git integration and shortcuts |
| **zsh-autosuggestions** | Fish-like autosuggestions based on command history |
| **zsh-syntax-highlighting** | Syntax highlighting for commands as you type |
| **node** | Node.js version and environment management |
| **npm** | NPM completions and shortcuts |
| **yarn** | Yarn completions and shortcuts |
| **pnpm** | PNPM completions and shortcuts (custom plugin) |
| **bun** | Bun completions and shortcuts (custom plugin) |
| **docker** | Docker command completions |
| **docker-compose** | Docker Compose completions |
| **fzf** | Fuzzy finder integration |
| **vscode** | VS Code integration |

### Package Manager Aliases

The configuration includes consistent aliases across different JavaScript package managers:

| NPM | Yarn | PNPM | Bun | Description |
|-----|------|------|-----|-------------|
| `ni` | - | `pi` | `bi` | Install dependencies |
| - | `ya` | `pa` | `ba` | Add a package |
| - | - | `pad` | `bad` | Add a dev dependency |
| `nrd` | `yad` | `pdev` | `bdev` | Run dev script |
| `nrb` | `yab` | `pbuild` | `bbuild` | Run build script |
| `nrs` | `yas` | `pstart` | `bstart` | Run start script |
| `nrt` | `yat` | `ptest` | `btest` | Run test script |

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
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

## Next Steps

Here are some recommended enhancements to further improve your development environment:

### 1. Terminal Productivity Enhancements

- **Add [Starship](https://starship.rs/) support**: A fast, customizable cross-shell prompt
  ```bash
  # Add to install.sh
  curl -sS https://starship.rs/install.sh | sh
  # Add to zsh/configs/theme.zsh as an alternative to Powerlevel10k
  # eval "$(starship init zsh)"
  ```

- **Integrate [atuin](https://github.com/ellie/atuin)**: Enhanced shell history with search, sync, and statistics
  ```bash
  # Add to install.sh
  bash <(curl https://raw.githubusercontent.com/ellie/atuin/main/install.sh)
  # Add to zsh/configs/tools.zsh
  # eval "$(atuin init zsh)"
  ```

- **Add [zsh-abbr](https://github.com/olets/zsh-abbr)**: Abbreviation expansion for frequently used commands
  ```bash
  # Add to install.sh
  git clone https://github.com/olets/zsh-abbr ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-abbr
  # Add to plugins list in zsh/zshrc
  ```

### 2. Development Workflow Improvements

- **Create language-specific configurations**:
  - Add `zsh/configs/python.zsh` for Python development settings
  - Add `zsh/configs/node.zsh` for Node.js version management
  - Add `zsh/configs/rust.zsh` for Rust toolchain configuration

- **Add Git hooks management**:
  - Integrate [husky](https://github.com/typicode/husky) for JavaScript projects
  - Create reusable git hooks in `git/hooks/` directory

- **Implement dotfiles sync mechanism**:
  - Create a script to periodically check for and apply updates
  - Add a mechanism to sync settings across multiple machines

### 3. System Configuration

- **Add macOS defaults script**:
  - Create `macos/defaults.sh` with preferred system settings
  - Include options for development-focused macOS configuration

- **Create Homebrew bundle**:
  - Add `Brewfile` to manage dependencies with Homebrew
  - Include development tools, applications, and fonts

- **Add container development setup**:
  - Create Docker development environment configurations
  - Add devcontainer.json templates for VS Code

### 4. Documentation and Maintenance

- **Create a command cheatsheet**:
  - Document all custom aliases and functions
  - Generate an HTML or Markdown reference page

- **Implement automated testing**:
  - Add GitHub Actions workflow to test installation on different platforms
  - Create tests for critical shell functions

- **Add version management**:
  - Create a versioning scheme for your dotfiles
  - Add changelog generation

## Version History

- **2025-03-03**: Initial repository setup
- **2025-03-03**: Added ZSH plugins and package manager configurations