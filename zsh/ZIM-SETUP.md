# Optimized Zsh Setup with Zim Framework

This directory contains an installation script for a feature-rich yet optimized Zsh setup using the Zim framework and Starship prompt. This setup is designed to be fast, efficient, and user-friendly.

## Why Zim?

[Zim](https://github.com/zimfw/zimfw) is a Zsh configuration framework with blazing speed and modular extensions. Compared to other frameworks like Oh-My-Zsh or plugin managers like Zinit, Zim offers:

- **Faster startup times** (typically 50-100ms)
- **Simpler configuration** with fewer files to manage
- **Modular design** that makes it easy to add or remove features
- **Sensible defaults** that work well out of the box
- **Lightweight footprint** with minimal dependencies

## Key Components

Our Zim-based setup includes:

1. **zsh-autosuggestions** - Fish-like history suggestions as you type
2. **fast-syntax-highlighting** - Command syntax highlighting (faster alternative to zsh-syntax-highlighting)
3. **fzf-tab** - Fuzzy completion menu using fzf
4. **zsh-autopair** - Automatically pair brackets, quotes, etc.
5. **zsh-history-substring-search** - Search history based on what you've typed
6. **zsh-direnv** - Automatically load/unload environment variables based on directory
7. **fzf** - General-purpose fuzzy finder with keybindings
8. **zoxide** - Smart directory jumping (modern alternative to z/autojump)
9. **starship** - Cross-shell prompt with minimal configuration

## Potential Conflicts and Solutions

### Known Plugin Conflicts

1. **fzf-tab & zsh-autosuggestions**
   - **Issue**: Text suggestions can visually interfere with fzf-tab's menu
   - **Solution**: We load fzf-tab before zsh-autosuggestions to minimize conflicts

2. **FZF keybindings**
   - **Issue**: Ctrl+R, Ctrl+T, and Alt+C may override existing keybindings
   - **Solution**: Custom keybindings can be configured in your .zshrc (commented examples provided)

3. **Directory navigation tools**
   - **Issue**: Conflicts with other tools like z, autojump, j
   - **Solution**: We use zoxide with enhanced completion and alias it to replace the standard cd command
   - **Action needed**: Uninstall other directory jumpers if installed

4. **Completion systems**
   - **Issue**: Multiple completion enhancers can conflict
   - **Solution**: Our setup carefully orders the loading of completion-related plugins

### Resolving Conflicts

If you encounter conflicts:

1. **Keybinding conflicts**: Uncomment and customize the keybinding section in your .zshrc
2. **Visual conflicts**: Adjust the styling of fzf-tab or autosuggestions
3. **Command conflicts**: Check for duplicate command definitions with `which command_name`

## Installation

To install this optimized setup:

```bash
# Run the installation script
./zsh/install-zim-setup.sh
```

The script will:
1. Install Zsh if not already installed
2. Install the Zim framework
3. Configure Zim modules
4. Install Starship prompt
5. Install supporting tools (zoxide, fzf, fd, bat)
6. Create a new .zshrc file (backing up any existing one)
7. Measure shell startup time

## Key Features

### Fish-like Autosuggestions

As you type, you'll see suggestions from your command history in a subtle gray color. Press the right arrow key to accept a suggestion.

### Syntax Highlighting

Commands are highlighted as you type, showing errors in red and valid commands in green.

### Fuzzy Completion with fzf-tab

The TAB key brings up a fuzzy-searchable menu of completions, powered by fzf. This works for commands, files, directories, and more.

### Smart Directory Navigation with zoxide

Zoxide tracks your most frequently used directories and allows you to jump to them with the `z` command:

- `z project` - Jump to your most frequently used directory containing "project"
- `zi` - Interactive selection with fzf

### FZF Keybindings

- `Ctrl+R` - Fuzzy search through command history
- `Ctrl+T` - Fuzzy find files in current directory
- `Alt+C` - Fuzzy find and cd into subdirectories

### Modern Cross-Shell Prompt with Starship

Starship provides a beautiful, informative prompt with minimal configuration:

- Shows current directory and git status
- Displays command execution time for long-running commands
- Changes prompt character color based on last command status
- Works across different shells (Zsh, Bash, Fish, etc.)

## Performance Optimizations

This setup includes several performance optimizations:

- **Disables magic functions** that can slow down command line operations
- **Optimizes autosuggestions** with manual rebinding and buffer size limits
- **Uses fast-syntax-highlighting** with turbo mode and advanced optimizations:
  - `use_brackets=1` - Enables efficient bracket matching
  - `use_pattern_search=1` - Uses faster pattern search algorithms
  - `use_async=1` - Enables asynchronous processing
  - `use_shortcut_patterns=1` - Uses shortcut patterns for common syntax
- **Configures Starship** with performance-focused settings
- **Properly quotes eval statements** to avoid issues on macOS

## Customization

You can customize this setup by:

1. Editing `~/.zimrc` to add or remove Zim modules
2. Modifying `~/.zshrc` to change FZF options, aliases, or other settings
3. Editing `~/.config/starship.toml` to customize your prompt appearance

## Updating

To update your Zim-based setup:

```bash
# Option 1: Manual update
zimfw update && zimfw upgrade
starship upgrade
brew upgrade zoxide fzf fd bat  # On macOS
```

```bash
# Option 2: Use the automated update script
./zsh/update-zim-setup.sh
```

The update script will:
1. Update Zim and its modules
2. Update Starship, Zoxide, and other tools
3. Check for performance optimizations
4. Add zsh-defer for slow-initializing tools
5. Measure your shell startup time

## Performance Optimization

For detailed guidance on optimizing your setup:

1. **Keep Starship modules minimal** - See our [Starship Optimization Guide](STARSHIP-OPTIMIZATION.md)
2. **Use zsh-defer for slow tools** - The update script can add this for you
3. **Disable unused Zim modules** - Edit your `~/.zimrc` and remove modules you don't use

### Using zsh-defer

For tools that slow down your shell startup (like nvm, pyenv, etc.), use zsh-defer to load them asynchronously:

```zsh
# Add to your .zimrc
zmodule romkatv/zsh-defer

# Then in your .zshrc
zsh-defer source "$HOME/.nvm/nvm.sh"  # Example for nvm
```

### Disabling Unused Modules

Edit your `~/.zimrc` file and comment out or remove modules you don't use:

```zsh
# Keep these essential modules
zmodule zsh-users/zsh-autosuggestions
zmodule zdharma-continuum/fast-syntax-highlighting
zmodule Aloxaf/fzf-tab

# Comment out unused modules
# zmodule git        # Remove if you don't use git
# zmodule python     # Remove if you don't use python
```

Run `zimfw install` after making changes to apply them.

## Troubleshooting

If you encounter issues:

1. **Slow startup**: Run `time zsh -i -c exit` to measure startup time and identify bottlenecks
2. **Missing modules**: Run `zimfw install` to reinstall Zim modules
3. **Starship issues**: Ensure the eval statement is properly quoted in your .zshrc
4. **FZF not working**: Check that FZF is installed and its keybindings are loaded

## Comparison with Other Approaches

| Feature | Zim | Oh-My-Zsh | Zinit |
|---------|-----|-----------|-------|
| Startup Time | 50-100ms | 200-500ms | 100-300ms |
| Configuration Complexity | Low | Medium | High |
| Plugin Management | Built-in | Built-in | Advanced |
| Customization Options | Moderate | Extensive | Very Extensive |
| Learning Curve | Low | Medium | High |

## References

- [Zim Documentation](https://github.com/zimfw/zimfw)
- [Starship Documentation](https://starship.rs/guide/)
- [zoxide Documentation](https://github.com/ajeetdsouza/zoxide)
- [FZF Documentation](https://github.com/junegunn/fzf)
- [fzf-tab Documentation](https://github.com/Aloxaf/fzf-tab)
- [zsh-autosuggestions Documentation](https://github.com/zsh-users/zsh-autosuggestions)
- [fast-syntax-highlighting Documentation](https://github.com/zdharma-continuum/fast-syntax-highlighting) 