# My Dotfiles

A thoughtfully organized collection of my development environment configuration files.

## Quick Start Guide

```bash
# Clone the repository
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles

# Run the installation script
cd ~/dotfiles
./install.sh

# Restart your terminal or source your zshrc
source ~/.zshrc
```

> **Note**: This setup requires a [Nerd Font](https://www.nerdfonts.com/) for proper symbol display in the terminal.

## Simple Maintenance Commands

This repository includes several simple scripts to help maintain your dotfiles:

```bash
# Update your dotfiles
./bin/update.sh

# Clean up temporary files
./bin/clean-backups.sh

# Check for duplicate functions and aliases
./bin/check-duplicates.sh

# Measure shell startup time
./bin/zsh-time.sh
```

## Organization

The repository follows a simple, maintainable structure:

```
dotfiles/
├── bin/                  # Utility scripts
├── config/               # Configuration files
│   ├── ripgrep/          # Ripgrep configuration
│   └── starship/         # Starship prompt configuration
├── docs/                 # Documentation
├── git/                  # Git configuration
│   ├── gitconfig         # Git settings
│   └── gitignore_global  # Global gitignore patterns
├── macos/                # macOS-specific files
│   ├── Brewfile          # Homebrew dependencies
│   └── defaults.sh       # macOS system defaults
├── on-login/             # Scripts to run on login
├── zsh/                  # ZSH configuration
│   ├── aliases/          # Command aliases by category
│   ├── functions/        # Shell functions by category
│   ├── configs/          # Tool-specific configurations
│   └── zshrc             # Main ZSH configuration file
├── install.sh            # Installation script
└── README.md             # This file
```

## Guiding Principles

1. **Simplicity**: Keep configurations simple and easy to understand
2. **Modularity**: Organize related settings into separate files
3. **Readability**: Use clear comments and consistent formatting
4. **Maintainability**: Make it easy to update and extend
5. **Performance**: Optimize for shell startup time

## Recommended Versions

| Tool | Minimum Version |
|------|-----------------|
| Starship | 1.16.0+ |
| Zsh | 5.8+ |
| Node.js | 18.0.0+ |
| Git | 2.30.0+ |
| Homebrew | 4.0.0+ |

## Documentation

Comprehensive documentation for this dotfiles repository is available in the [docs](docs) directory:

- [Managing Your Dotfiles](docs/guides/managing-dotfiles.md) - Complete workflow for managing, updating, and syncing your dotfiles
- [Starship Guide](docs/guides/starship-guide.md) - Detailed documentation for customizing your Starship prompt
- [Frequently Asked Questions](docs/guides/faq.md) - Answers to common questions about the dotfiles system

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
├── macos/                # macOS-specific files
│   ├── Brewfile          # Homebrew dependencies
│   └── defaults.sh       # macOS system defaults
├── install.sh            # Installation script
└── README.md             # This file
```

## Installation

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The installation script will:
1. Create a backup of existing dotfiles
2. Install Homebrew (if not already installed)
3. Install dependencies from the Brewfile in the macos directory
4. Install Oh-My-Zsh (if not already installed)
5. Set up Oh-My-Zsh plugins
6. Install Starship, Atuin, and other tools
7. Create symlinks for configuration files
8. Verify tool versions and Nerd Font installation

### Updating

To update your dotfiles and all dependencies:

```bash
cd ~/dotfiles
./install.sh update
```

This will:
1. Pull the latest changes from the repository
2. Update Homebrew dependencies
3. Update Oh-My-Zsh plugins
4. Update Starship to the latest version

## Features

### ZSH Plugins

This configuration includes several powerful ZSH plugins to enhance your terminal experience:

| Plugin | Description |
|--------|-------------|
| **git** | Git integration and shortcuts |
| **zsh-autosuggestions** | Fish-like autosuggestions based on command history |
| **zsh-syntax-highlighting** | Syntax highlighting for commands as you type |
| **zsh-abbr** | Abbreviation expansion for frequently used commands |
| **node** | Node.js version and environment management |
| **npm** | NPM completions and shortcuts |
| **yarn** | Yarn completions and shortcuts |
| **pnpm** | PNPM completions and shortcuts (custom plugin) |
| **bun** | Bun completions and shortcuts (custom plugin) |
| **docker** | Docker command completions |
| **docker-compose** | Docker Compose completions |
| **fzf** | Fuzzy finder integration |

### Terminal Enhancements

| Tool | Description |
|------|-------------|
| **Starship** | Modern, fast, cross-shell prompt with minimal configuration |
| **Atuin** | Magical shell history that synchronizes across machines and provides advanced search |
| **zoxide** | Smarter cd command that remembers your most used directories |
| **fzf** | General-purpose fuzzy finder for files, history, and more |

#### Starship Configuration

A custom Starship configuration is included in this repository. The configuration provides:

- Enhanced prompt showing directory, git information, and command duration
- Git branch and status information with Nerd Font symbols
- Shell indicator showing which shell you're using
- Command duration for long-running commands
- Customizable prompt character that changes color based on last command status
- Improved directory display with better truncation settings

The configuration is stored in `config/starship/starship.toml` and is automatically installed to `~/.config/starship.toml` during setup. You can customize it further by editing either file.

```toml
# Example of the current Starship configuration
format = """
$directory\
$git_branch\
$git_status\
$cmd_duration\
$line_break\
$shell\
$character"""
```

> **Note**: This configuration requires a Nerd Font to display special symbols correctly. The installation script installs Hack Nerd Font, but you'll need to configure your terminal to use it.

> **Detailed Documentation**: For a comprehensive guide on using and customizing Starship, see [docs/guides/starship-guide.md](docs/guides/starship-guide.md)

###### Git Status Symbols
```
[+!⇡✘]
```

These symbols show the state of your git repository:

| Symbol | Meaning | Description |
|--------|---------|-------------|
| `+N` | Staged changes | You have N changes staged for commit |
| `!N` | Modified files | You have N unstaged modified files |
| `?N` | Untracked files | You have N new files not yet tracked by git |
| `✘N` | Deleted files | You have N deleted files in your working directory |
| `⇡N` | Ahead of remote | Your local branch is N commits ahead of the remote (needs push) |
| `⇣N` | Behind remote | Your local branch is N commits behind the remote (needs pull) |
| `⇕N` | Diverged | Your branch has diverged N commits from the remote (needs merge/rebase) |
| `»N` | Renamed files | You have N renamed files in your working directory |
| `=N` | Conflicted files | You have N merge conflicts that need resolution |
| `SN` | Stashed changes | You have N changes saved in git stash |

### Python Development with UV

The dotfiles include support for [uv](https://github.com/astral-sh/uv), a modern Python package installer and resolver that's significantly faster than pip:

- Automatic installation via Homebrew
- Configuration in `zsh/configs/python.zsh`
- Aliases for common uv commands:
  - `pip` is aliased to `uv pip` for seamless integration
  - `uvi` for `uv pip install`
  - `uvvenv` for `uv venv`
  - `pyvenv` function to create and activate a virtual environment
  - `uvinstall` function to install from requirements.txt

UV is configured to use the system Python by default, but you can easily create isolated environments with the included helper functions.

## External Dependencies

- [Oh-My-Zsh](https://ohmyz.sh/)
- [Starship](https://starship.rs/)
- [Atuin](https://github.com/ellie/atuin)
- [zsh-abbr](https://github.com/olets/zsh-abbr)
  - Requires [zsh-job-queue](https://github.com/olets/zsh-job-queue) (installed automatically as a git submodule)
- [fzf](https://github.com/junegunn/fzf)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [Homebrew](https://brew.sh/)

## Next Steps

Here are some recommended enhancements to further improve your development environment:

### 1. Terminal Productivity Enhancements

- **Customize Starship**: Edit the provided Starship configuration to match your preferences
  ```bash
  # Edit the Starship configuration
  nano ~/dotfiles/config/starship/starship.toml
  
  # Test changes immediately
  source ~/.zshrc
  ```

- **Integrate [atuin](https://github.com/ellie/atuin)**: Enhanced shell history with search, sync, and statistics
  ```bash
  # Add to install.sh
  bash <(curl https://raw.githubusercontent.com/ellie/atuin/main/install.sh)
  # Add to zsh/configs/tools.zsh
  # eval "$(atuin init zsh)"
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

- **Enhance Homebrew bundle**:
  - Update `macos/Brewfile` with additional development tools
  - Organize dependencies by category (development, productivity, fonts)
  - Add comments explaining the purpose of each tool

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

- **v1.0.0** (2023-10-01): Initial setup with basic ZSH configuration
- **v1.1.0** (2023-11-15): Added custom plugins for PNPM and Bun
- **v1.2.0** (2023-12-20): Integrated Homebrew bundle and improved documentation
- **v1.3.1** (2024-01-15): Added custom Starship configuration file
- **v1.3.2** (2024-03-03): Fixed zsh-abbr installation to properly initialize git submodules
- **v1.3.3** (2024-03-03): Updated Starship configuration to use an ultra-minimal prompt
- **v1.4.0** (2024-06-01): Enhanced Starship configuration with Nerd Font symbols and improved format
- **v1.4.1** (2024-06-01): Added version checks and Nerd Font verification to installation script

## Troubleshooting

### Common Issues

#### Missing Nerd Font Symbols

If you see boxes, question marks, or missing symbols in your prompt:

1. Verify a Nerd Font is installed:
   ```bash
   ls ~/Library/Fonts/*Nerd* || ls /Library/Fonts/*Nerd*
   ```

2. Configure your terminal to use the Nerd Font:
   - **iTerm2**: Preferences → Profiles → Text → Font → Change Font
   - **VS Code**: Settings → Terminal › Integrated: Font Family → Add a Nerd Font (e.g., "Hack Nerd Font")

#### Slow Shell Startup

If your shell is starting slowly:

1. Profile your startup time:
   ```bash
   time zsh -i -c exit
   ```

2. Identify slow plugins or configurations:
   ```bash
   # Add to top of .zshrc
   zmodload zsh/zprof
   
   # Add to bottom of .zshrc
   zprof
   ```

3. Consider lazy-loading rarely used tools or disabling unused plugins

#### Tool Version Mismatches

If you see version warnings during installation:

1. Update the specific tool:
   ```bash
   # For Homebrew packages
   brew upgrade [package-name]
   
   # For Starship
   curl -sS https://starship.rs/install.sh | sh
   ```

2. If you can't update, check if your configuration is compatible with your current version

## Performance Optimizations

This dotfiles repository includes several performance optimizations to improve shell startup time:

### Lazy Loading

Many tools are lazy loaded, meaning they are only initialized when actually needed. This significantly improves shell startup time. The following tools are lazy loaded:

- **NVM (Node Version Manager)** - Only loaded when Node.js commands are used
- **Zoxide** - Only loaded when directory jumping commands are used
- **GitHub Copilot** - Only loaded when Copilot commands are used
- **Atuin** - Only loaded when history commands are used
- **Google Cloud SDK** - Only loaded when gcloud commands are used
- **Deno** - Only loaded when Deno commands are used
- **Bun** - Only loaded when Bun commands are used
- **FZF** - Only loaded when fuzzy finding is used
- **Docker** - Only loaded when Docker commands are used
- **Docker Compose** - Only loaded when Docker Compose commands are used

See `zsh/configs/lazy-tools.zsh` and `zsh/configs/nvm-lazy.zsh` for implementation details.

### Fast Syntax Highlighting

This configuration uses `fast-syntax-highlighting` instead of the standard `zsh-syntax-highlighting` for significantly improved performance:

- Up to 50x faster than standard syntax highlighting
- More advanced highlighting features
- Reduced impact on shell startup time
- Better performance during interactive use

To install fast-syntax-highlighting, run:

```bash
./bin/install-fast-syntax-highlighting.sh
```

### Performance Measurement

The repository includes tools to measure and optimize shell performance:

- `zsh-time` - Measures shell startup time
- `zsh-profile` - Profiles zsh startup using zprof
- `zsh-debug` - Toggles debug mode for shell startup

These commands are available after sourcing `zsh/functions/performance.zsh`.

## Utility Scripts

This repository includes several utility scripts to help you maintain and optimize your dotfiles:

### Shell Optimization

- `bin/measure-startup-time.sh`: Measures your shell startup time and provides optimization recommendations
- `bin/optimize-shell.sh`: Automatically applies optimizations to improve shell startup time
- `bin/test-lazy-loading.sh`: Tests the impact of lazy loading on shell startup time

### Development Tools

- `bin/lint-scripts.sh`: Lints shell scripts for errors and style issues using shellcheck and shfmt
- `bin/install-git-hooks.sh`: Installs git hooks for the repository
- `bin/install-modern-tools.sh`: Installs modern replacements for common command-line tools
- `bin/switch-to-zinit.sh`: Migrates from Oh My Zsh to Zinit for faster shell startup

## Maintenance

To ensure your dotfiles remain well-maintained:

1. Run `bin/measure-startup-time.sh` periodically to check shell performance
2. Use `bin/lint-scripts.sh` before committing changes to ensure code quality
3. Keep your tools updated with `brew upgrade` regularly
4. Review and clean up unused aliases and functions periodically
5. Run `bin/cleanup.sh` before committing to perform all maintenance tasks automatically

### Cleanup Script

The `bin/cleanup.sh` script automates the cleanup process by:

- Removing temporary files (*.swp, *~, _tmp_*)
- Ensuring all scripts have proper executable permissions
- Verifying configuration files are properly formatted
- Running linting tools to check for issues
- Measuring shell startup time

Run it before committing changes to ensure your dotfiles repository remains clean and well-maintained.