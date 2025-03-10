# Optimized Zsh Configuration for 2025

This directory contains a carefully organized set of Zsh configuration files designed to work together harmoniously, following the best practices recommended for 2025.

## Key Components

Our setup combines these powerful tools in a complementary way:

1. **zsh-completions** - Rich completion definitions
2. **fzf-tab** - Fuzzy completion menu using fzf
3. **zsh-autosuggestions** - Fish-like history suggestions as you type
4. **fast-syntax-highlighting** - Command syntax highlighting (faster alternative to zsh-syntax-highlighting)
5. **zoxide** - Smart directory jumping (modern alternative to z/autojump)
6. **fzf** - General-purpose fuzzy finder with keybindings
7. **starship** - Cross-shell prompt with minimal configuration

## Loading Order

The loading order is critical for these tools to work together without conflicts:

1. **Basic options and history** - Loaded first (`options.zsh`, `history.zsh`)
2. **Completion system** - Loaded before plugins (`completion.zsh`)
3. **Plugins** - Loaded in specific order:
   - zsh-completions (before compinit)
   - fzf-tab (after compinit, but before other TAB-binding widgets)
   - zsh-autosuggestions
   - fast-syntax-highlighting
4. **FZF configuration** - Loaded after plugins for proper integration with fzf-tab
5. **Zoxide** - Loaded after plugins to avoid conflicts
6. **Starship** - Loaded with proper quoting to avoid macOS issues
7. **Prompt** - Additional prompt customization if needed
8. **User customizations** - Aliases, functions, and other user-specific settings

## Key Features

### Fuzzy Completion with fzf-tab

The TAB key now brings up a fuzzy-searchable menu of completions, powered by fzf. This works for commands, files, directories, and more.

### Smart Directory Navigation with zoxide

Zoxide tracks your most frequently used directories and allows you to jump to them with the `z` command:

- `z project` - Jump to your most frequently used directory containing "project"
- `zi` - Interactive selection with fzf
- `zl` - List frequently visited directories

### FZF Keybindings

- `Ctrl+R` - Fuzzy search through command history
- `Ctrl+T` - Fuzzy find files in current directory
- `Alt+C` - Fuzzy find and cd into subdirectories

### Command History Suggestions

As you type, you'll see suggestions from your command history in a subtle gray color. Press the right arrow key to accept a suggestion.

### Syntax Highlighting

Commands are highlighted as you type, showing errors in red and valid commands in green.

### Modern Cross-Shell Prompt with Starship

Starship provides a beautiful, informative prompt with minimal configuration:

- Shows current directory and git status
- Displays command execution time for long-running commands
- Changes prompt character color based on last command status
- Works across different shells (Zsh, Bash, Fish, etc.)

## Installation

### Prerequisites

- Zsh (v5.8 or later recommended)
- git
- fzf
- zoxide
- Zinit (for plugin management)
- Starship (for the prompt)

### Installing Zinit

```bash
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
```

### Installing fzf

```bash
# macOS
brew install fzf
$(brew --prefix)/opt/fzf/install

# Ubuntu/Debian
sudo apt install fzf

# Arch Linux
sudo pacman -S fzf
```

### Installing zoxide

```bash
# macOS
brew install zoxide

# Ubuntu/Debian
sudo apt install zoxide

# Using cargo
cargo install zoxide
```

### Installing Starship

```bash
# macOS (recommended for macOS users)
brew install starship

# All platforms
curl -sS https://starship.rs/install.sh | sh
```

## Performance Considerations

This configuration is designed to be fast and efficient:

- Uses `fast-syntax-highlighting` instead of `zsh-syntax-highlighting` for better performance
- Loads plugins with `wait lucid` where appropriate to improve startup time
- Optimizes completion system to rebuild cache only once a day
- Uses zoxide which is faster than traditional directory jumpers

## Customization

You can customize this setup by:

1. Modifying `fzf.zsh` to change FZF options and keybindings
2. Adjusting `zoxide.zsh` to customize directory jumping behavior
3. Editing `completion.zsh` to fine-tune completion behavior
4. Adding or removing plugins in `plugins.zsh`
5. Customizing `starship.toml` to change your prompt appearance

## Troubleshooting

If you encounter issues:

1. **Completion not working**: Ensure compinit is called before fzf-tab but after zsh-completions
2. **Key bindings conflicts**: Check for duplicate key bindings in your configuration
3. **Slow startup**: Use `zprof` to profile your Zsh startup time and identify bottlenecks
4. **Plugin conflicts**: Adjust the loading order in `plugins.zsh`
5. **Starship not working on macOS**: Ensure the eval statement is properly quoted as in our `starship.zsh` file

### Fixing Starship Issues on macOS

Some users have reported issues with Starship not working correctly on macOS with Zsh. Our configuration addresses this by:

1. Using proper quoting in the eval statement: `eval "$(starship init zsh)"`
2. Installing Starship via Homebrew on macOS for better integration
3. Creating the necessary configuration directories
4. Setting up a cache directory to improve performance

If you still encounter issues, try:
- Ensuring your terminal is using a compatible font (preferably a Nerd Font)
- Checking that your `TERM` environment variable is set correctly
- Verifying that Starship is in your PATH

## References

- [Zinit Documentation](https://github.com/zdharma-continuum/zinit)
- [fzf-tab Documentation](https://github.com/Aloxaf/fzf-tab)
- [zoxide Documentation](https://github.com/ajeetdsouza/zoxide)
- [FZF Documentation](https://github.com/junegunn/fzf)
- [zsh-autosuggestions Documentation](https://github.com/zsh-users/zsh-autosuggestions)
- [fast-syntax-highlighting Documentation](https://github.com/zdharma-continuum/fast-syntax-highlighting)
- [Starship Documentation](https://starship.rs/guide/) 