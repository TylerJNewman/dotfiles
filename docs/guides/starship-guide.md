# Starship Prompt Guide

This guide explains how to use and customize the Starship prompt configuration included in this dotfiles repository.

## Table of Contents

- [Overview](#overview)
- [Prompt Elements](#prompt-elements)
- [Git Status Symbols](#git-status-symbols)
- [Common Scenarios](#common-scenarios)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)

## Overview

[Starship](https://starship.rs/) is a minimal, blazing-fast, and infinitely customizable prompt for any shell. Our configuration provides a clean, informative prompt that shows you exactly what you need to know about your environment.

The current configuration format is:

```toml
format = """
$directory\
$git_branch\
$git_status\
$cmd_duration\
$line_break\
$shell\
$character"""
```

## Prompt Elements

### Directory Display

```
~/projects/my-repo
```

- Shows your current directory path
- Truncated to 5 levels deep by default
- Home directory is shown as `~`
- Read-only directories are marked with a lock symbol: ` 󰌾`

### Git Branch

```
 󰘬 main
```

- The ` 󰘬 ` symbol indicates you're in a git repository
- Followed by the current branch name (e.g., `main`, `develop`, `feature/new-feature`)
- Displayed in purple by default

### Git Status

```
[+!⇡✘]
```

- Shows the current state of your git repository
- Displayed in red by default
- Multiple symbols can appear together to indicate different states
- See [Git Status Symbols](#git-status-symbols) for a complete reference

### Command Duration

```
took 5s
```

- Shows the execution time for commands that take longer than 2 seconds
- Helps identify slow commands in your workflow
- Displayed in yellow by default

### Shell Indicator

```
zsh
```

- Displays which shell you're currently using
- Useful when switching between different shells
- Displayed in cyan by default

### Prompt Character

```
❯
```

- Green when the previous command succeeded
- Red when the previous command failed
- Provides immediate visual feedback on command success/failure

## Git Status Symbols

The Git status section of your prompt shows the state of your repository with these minimal symbols:

| Symbol | Meaning | Description |
|--------|---------|-------------|
| `+` | Staged changes | You have changes staged for commit |
| `!` | Modified files | You have unstaged modified files |
| `?` | Untracked files | You have new files not yet tracked by git |
| `x` | Deleted files | You have deleted files in your working directory |
| `↑` | Ahead of remote | Your local branch is ahead of the remote (needs push) |
| `↓` | Behind remote | Your local branch is behind the remote (needs pull) |
| `↕` | Diverged | Your branch has diverged from the remote (needs merge/rebase) |
| `r` | Renamed files | You have renamed files in your working directory |
| `=` | Conflicted files | You have merge conflicts that need resolution |
| `s` | Stashed changes | You have changes saved in git stash |

## Common Scenarios

### 1. Clean Repository

```
~/projects/my-repo master >
```

This indicates:
- You're in the `~/projects/my-repo` directory
- You're on the `master` branch
- The repository is clean (no changes)
- You're using the `zsh` shell
- The previous command succeeded (green prompt character)

### 2. Working on Changes

```
~/projects/my-repo master ! >
```

This indicates:
- You're on the `master` branch
- You have unstaged modifications (`!`)

### 3. Ready to Commit

```
~/projects/my-repo master + >
```

This indicates:
- You have staged changes ready to commit (`+`)

### 4. Need to Sync with Remote

```
~/projects/my-repo master ↑ >
```

This indicates:
- Your branch is ahead of the remote (`↑`)

### 5. Merge Conflict

```
~/projects/my-repo master =! >
```

This indicates:
- You have merge conflicts that need resolution (`=`)
- You also have unstaged modifications (`!`)

### 6. After a Failed Command

```
~/projects/my-repo master
zsh ❯ git push
fatal: The current branch master has no upstream branch.
~/projects/my-repo master
zsh ❯
```

Note that the prompt character is now red, indicating the previous command failed.

### 7. Complex State (Multiple Indicators)

```
~/projects/my-repo feature/new-feature +!↑? >
```

This indicates:
- You're on the `feature/new-feature` branch
- You have staged changes (`+`)
- You have unstaged modifications (`!`)
- You have commits that need to be pushed (`↑`)
- You have untracked files (`?`)

## Customization

To modify your Starship prompt, edit `~/.config/starship.toml`. Here's the current minimal configuration:

```toml
# Use a single line prompt
add_newline = false

# Minimal format with essential modules
format = """
$directory\
$git_branch\
$git_status\
$character"""

# Directory configuration
[directory]
truncation_length = 5
truncate_to_repo = true
style = "blue bold"
home_symbol = "~"
read_only = " 󰌾"

# Git branch configuration - minimal
[git_branch]
format = "[$branch]($style) "
style = "purple"
symbol = ""

# Git status - simplified and minimal
[git_status]
format = '([$all_status$ahead_behind]($style) )'
style = "yellow"
conflicted = "="
ahead = "↑"
behind = "↓"
diverged = "↕"
untracked = "?"
stashed = "s"
modified = "!"
staged = "+"
renamed = "r"
deleted = "x"

# Character prompt - minimal
[character]
success_symbol = "[>](green)"
error_symbol = "[>](red)"
```

This configuration provides a clean, minimal prompt that still shows all the essential information you need.

## Troubleshooting

### Missing Symbols

If you see boxes, question marks, or missing symbols in your prompt:

1. Verify a Nerd Font is installed:
   ```bash
   ls ~/Library/Fonts/*Nerd* || ls /Library/Fonts/*Nerd*
   ```

2. Configure your terminal to use the Nerd Font:
   - **iTerm2**: Preferences → Profiles → Text → Font → Change Font
   - **VS Code**: Settings → Terminal › Integrated: Font Family → Add a Nerd Font (e.g., "Hack Nerd Font")

### Git Status Not Showing

If git status information isn't appearing:

1. Make sure you're in a git repository:
   ```bash
   git status
   ```

2. Check if git is installed and in your PATH:
   ```bash
   which git
   ```

3. Verify your Starship configuration includes the git modules:
   ```bash
   grep "git_" ~/.config/starship.toml
   ```

### Slow Prompt

If your prompt is slow to appear:

1. Increase the command timeout in your configuration:
   ```toml
   command_timeout = 1000  # Increase timeout to 1000ms
   ```

2. Consider disabling some modules you don't use frequently.

### Reset to Default

If you want to reset to the default Starship configuration:

1. Backup your current configuration:
   ```bash
   cp ~/.config/starship.toml ~/.config/starship.toml.bak
   ```

2. Create a minimal configuration:
   ```bash
   echo "# Using Starship defaults" > ~/.config/starship.toml
   ```

## Further Resources

- [Official Starship Documentation](https://starship.rs/guide/)
- [Starship Configuration Reference](https://starship.rs/config/)
- [Nerd Fonts Website](https://www.nerdfonts.com/) 