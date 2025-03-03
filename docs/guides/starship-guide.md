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

| Symbol | Meaning | Description |
|--------|---------|-------------|
| `+` | Staged changes | You have changes staged for commit |
| `!` | Modified files | You have unstaged modified files |
| `?` | Untracked files | You have new files not yet tracked by git |
| `✘` | Deleted files | You have deleted files in your working directory |
| `⇡` | Ahead of remote | Your local branch is ahead of the remote (needs push) |
| `⇣` | Behind remote | Your local branch is behind the remote (needs pull) |
| `⇕` | Diverged | Your branch has diverged from the remote (needs merge/rebase) |
| `»` | Renamed files | You have renamed files in your working directory |
| `=` | Conflicted files | You have merge conflicts that need resolution |
| `S` | Stashed changes | You have changes saved in git stash |

## Common Scenarios

### 1. Clean Repository

```
~/projects/my-repo 󰘬 main
zsh ❯
```

This indicates:
- You're in the `~/projects/my-repo` directory
- You're on the `main` branch
- The repository is clean (no changes)
- You're using the `zsh` shell
- The previous command succeeded (green prompt character)

### 2. Working on Changes

```
~/projects/my-repo 󰘬 feature/new-feature [!?]
zsh ❯
```

This indicates:
- You're on the `feature/new-feature` branch
- You have unstaged modifications (`!`)
- You have untracked files (`?`)

### 3. Ready to Commit

```
~/projects/my-repo 󰘬 feature/new-feature [+]
zsh ❯
```

This indicates:
- You have staged changes ready to commit (`+`)

### 4. Need to Sync with Remote

```
~/projects/my-repo 󰘬 main [⇡3⇣2]
zsh ❯
```

This indicates:
- Your branch is 3 commits ahead of the remote (`⇡3`)
- Your branch is 2 commits behind the remote (`⇣2`)
- You should consider pushing your changes and pulling from the remote

### 5. Merge Conflict

```
~/projects/my-repo 󰘬 main [=!]
zsh ❯
```

This indicates:
- You have merge conflicts that need resolution (`=`)
- You also have unstaged modifications (`!`)

### 6. After a Failed Command

```
~/projects/my-repo 󰘬 main
zsh ❯ git push
fatal: The current branch main has no upstream branch.
~/projects/my-repo 󰘬 main
zsh ❯
```

Note that the prompt character is now red, indicating the previous command failed.

## Customization

To modify your Starship prompt, edit `~/.config/starship.toml`. Here are some common customizations:

### Change Colors

```toml
[directory]
style = "cyan bold"    # Change directory color

[git_branch]
style = "green bold"   # Change branch color

[git_status]
style = "yellow bold"  # Change git status color
```

### Change Symbols

```toml
[git_branch]
symbol = "🌿 "         # Use a different branch symbol

[character]
success_symbol = "[➜](bold green)"  # Different success symbol
error_symbol = "[✗](bold red)"      # Different error symbol

[git_status]
ahead = "↑"            # Different ahead symbol
behind = "↓"           # Different behind symbol
```

### Adjust Directory Display

```toml
[directory]
truncation_length = 3  # Show fewer directory levels
truncate_to_repo = false  # Don't truncate to the repo root
```

### Add More Modules

To add more modules to your prompt, modify the `format` string in your `starship.toml`:

```toml
format = """
$username\
$hostname\
$directory\
$git_branch\
$git_status\
$nodejs\
$python\
$cmd_duration\
$line_break\
$shell\
$character"""
```

This adds:
- Username and hostname display
- Node.js and Python version indicators when in relevant projects

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