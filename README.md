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
├── Brewfile              # Homebrew dependencies
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
1. Install Homebrew (if not already installed)
2. Install dependencies from the Brewfile
3. Set up Oh-My-Zsh plugins
4. Install Starship, Atuin, and other tools
5. Create symlinks for configuration files

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
| **vscode** | VS Code integration |

### Terminal Enhancements

| Tool | Description |
|------|-------------|
| **Starship** | Modern, fast, cross-shell prompt with minimal configuration |
| **Atuin** | Magical shell history that synchronizes across machines and provides advanced search |
| **zoxide** | Smarter cd command that remembers your most used directories |
| **fzf** | General-purpose fuzzy finder for files, history, and more |

#### Starship Configuration

A custom Starship configuration is included in this repository. The configuration provides:

- Ultra-minimal prompt showing only the current directory and prompt character
- Clean, distraction-free terminal experience
- Git branch and status information when in a git repository
- Customizable prompt character that changes color based on last command status

The configuration is automatically installed to `~/.config/starship.toml` during setup. You can customize it further by editing this file directly.

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

### Homebrew Bundle

The included Brewfile manages all dependencies and applications through Homebrew. It includes:

- **Shell tools**: zsh, fzf, zoxide, starship, atuin, etc.
- **Development tools**: git, node, yarn, pnpm, bun, python, etc.
- **Fonts**: Fira Code, JetBrains Mono, Hack Nerd Font
- **Applications**: VS Code, iTerm2, Rectangle, Alfred

To install or update all dependencies:

```bash
brew bundle
```

To add a new dependency, edit the Brewfile and run the command above.

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

- **Customize Starship**: Edit the provided `~/.config/starship.toml` configuration to match your preferences
  ```bash
  # Edit the Starship configuration
  nano ~/.config/starship.toml
  
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

- **v1.0.0** (2023-10-01): Initial setup with basic ZSH configuration
- **v1.1.0** (2023-11-15): Added custom plugins for PNPM and Bun
- **v1.2.0** (2023-12-20): Integrated Homebrew bundle and improved documentation
- **v1.3.0** (2024-01-10): Switched from Powerlevel10k to Starship prompt
- **v1.3.1** (2024-01-15): Added custom Starship configuration file
- **v1.3.2** (2024-03-03): Fixed zsh-abbr installation to properly initialize git submodules
- **v1.3.3** (2024-03-03): Updated Starship configuration to use an ultra-minimal prompt