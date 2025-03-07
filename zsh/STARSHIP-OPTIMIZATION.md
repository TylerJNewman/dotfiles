# Optimizing Your Starship Prompt

Starship is a powerful cross-shell prompt, but it can impact shell startup time if not configured properly. This guide provides tips for keeping your Starship configuration minimal and performant.

## Performance-Focused Configuration

Here's a minimal yet informative Starship configuration that prioritizes performance:

```toml
# Performance optimizations
command_timeout = 500  # Milliseconds before timing out
add_newline = false    # Disable extra newlines

# Format - only include what you need
format = """
$directory\
$git_branch\
$git_status\
$cmd_duration\
$character"""

# Prompt character
[character]
success_symbol = "[➜](bold green)"
error_symbol = "[➜](bold red)"

# Directory
[directory]
truncation_length = 3
truncate_to_repo = true
style = "blue bold"

# Git branch - minimal configuration
[git_branch]
format = "[$symbol$branch]($style) "
symbol = "🌱 "
style = "purple"

# Git status - minimal configuration
[git_status]
format = '([\[$all_status$ahead_behind\]]($style) )'
style = "yellow"

# Command duration - only show for commands that take longer than 2 seconds
[cmd_duration]
format = "[$duration]($style) "
style = "yellow"
min_time = 2000
```

## Key Optimization Principles

1. **Limit Enabled Modules**
   - Only enable modules you actually use
   - Disable modules for tools you don't use (python, nodejs, rust, etc.)
   - Comment out unused modules with `disabled = true`

2. **Set Appropriate Timeouts**
   - Use `command_timeout` to prevent hanging on slow commands
   - Default is 500ms, but you can adjust based on your system

3. **Minimize Format String**
   - Only include elements you actually need in your prompt
   - Remove newlines and spacing for a more compact prompt
   - Consider using a single-line prompt for maximum performance

4. **Optimize Git Status**
   - Git operations can be slow in large repositories
   - Consider using `git_status.disabled = true` in large repos
   - Or set `git_status.max_queued_files` to a lower value

5. **Use Caching**
   - Set `STARSHIP_CACHE` environment variable to enable caching
   - This reduces disk I/O and improves performance

## Example Optimizations

### Before (Slow)

```toml
format = """
$username\
$hostname\
$directory\
$git_branch\
$git_state\
$git_status\
$git_metrics\
$fill\
$cmd_duration\
$jobs\
$battery\
$time\
$status\
$os\
$container\
$shell\
$character"""

[git_status]
ahead = "⇡${count}"
diverged = "⇕⇡${ahead_count}⇣${behind_count}"
behind = "⇣${count}"
```

### After (Fast)

```toml
format = """$directory$git_branch$git_status$character"""

[git_status]
format = '([\[$all_status$ahead_behind\]]($style) )'
```

## Module-Specific Optimizations

### Directory Module

```toml
[directory]
truncation_length = 1        # Show only the current directory name
truncate_to_repo = true      # When in a git repo, show path relative to repo root
```

### Git Module

```toml
[git_branch]
symbol = ""                  # Remove symbol for less visual clutter
[git_status]
max_queued_files = 1000      # Limit the number of files to check
```

### Command Duration

```toml
[cmd_duration]
min_time = 2000              # Only show for commands that take longer than 2 seconds
```

## Using zsh-defer for Slow Tools

If you have tools that slow down your shell startup (like nvm, pyenv, etc.), use zsh-defer to load them asynchronously:

1. Add zsh-defer to your Zim modules:
   ```
   zmodule romkatv/zsh-defer
   ```

2. Use it in your .zshrc:
   ```zsh
   # Defer loading of nvm
   zsh-defer source "$HOME/.nvm/nvm.sh"
   
   # Defer loading of pyenv
   zsh-defer eval "$(pyenv init -)"
   
   # Defer loading of any slow command
   zsh-defer source "$HOME/.slow-tool-config.sh"
   ```

## Disabling Unused Zim Modules

Review your `~/.zimrc` file and comment out or remove modules you don't use:

```zsh
# Essential modules - keep these
zmodule zsh-users/zsh-autosuggestions
zmodule zdharma-continuum/fast-syntax-highlighting
zmodule Aloxaf/fzf-tab

# Optional modules - remove if unused
# zmodule git        # Remove if you don't use git
# zmodule python     # Remove if you don't use python
# zmodule ruby       # Remove if you don't use ruby
# zmodule node       # Remove if you don't use node.js
```

## Measuring Performance

To check if your optimizations are working:

```bash
# Measure shell startup time
time zsh -i -c exit

# Profile Zsh startup
zsh -xv

# Use the update script to check performance
./zsh/update-zim-setup.sh
```

## Automated Maintenance

Run the update script regularly to keep your setup optimized:

```bash
# Update and optimize your Zim setup
./zsh/update-zim-setup.sh
```

This script will:
1. Update Zim and its modules
2. Update Starship, Zoxide, and other tools
3. Check for performance optimizations
4. Add zsh-defer for slow-initializing tools
5. Measure your shell startup time

By following these optimization tips, you can maintain a fast and responsive shell experience while still enjoying the features of Starship and Zim. 