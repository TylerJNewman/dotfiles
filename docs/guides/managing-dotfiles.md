# Managing Your Dotfiles

This guide covers the complete workflow for managing your dotfiles repository, from making simple changes to syncing across multiple machines.

## Table of Contents

- [Making Changes](#making-changes)
- [Testing Changes](#testing-changes)
- [Committing Changes](#committing-changes)
- [Syncing Across Machines](#syncing-across-machines)
- [Adding New Configuration Files](#adding-new-configuration-files)
- [Managing Secrets](#managing-secrets)
- [Handling Conflicts](#handling-conflicts)
- [Example: Adding a New Alias](#example-adding-a-new-alias)

## Making Changes

To modify your dotfiles, edit the appropriate file in your repository:

```bash
# Example: Edit your git aliases
vim ~/dotfiles/zsh/aliases/git.zsh

# Or add a new function
vim ~/dotfiles/zsh/functions/general.zsh
```

## Testing Changes

After making changes, you can apply them without restarting your terminal:

```bash
# Source your updated zshrc to test changes
source ~/.zshrc
```

## Committing Changes

Once you're satisfied with your changes, commit them to your repository:

```bash
cd ~/dotfiles
git add .
git commit -m "[component] Brief description of changes"
```

Use a consistent commit message format:
- `[zsh/aliases]` for changes to aliases
- `[zsh/functions]` for changes to functions
- `[git]` for changes to git configuration
- etc.

## Syncing Across Machines

When you want to update another machine with your latest dotfiles:

```bash
# Pull the latest changes
cd ~/dotfiles
git pull

# Run the install script (to create any new symlinks)
./install.sh

# Or use the update option for a complete update
./install.sh update

# Source your updated configuration
source ~/.zshrc
```

## Adding New Configuration Files

If you're adding entirely new configuration files:

1. **Add the file to your dotfiles structure**:
   ```bash
   # Example: Adding tmux configuration
   mkdir -p ~/dotfiles/tmux
   cp ~/.tmux.conf ~/dotfiles/tmux/tmux.conf
   ```

2. **Update your install script** to create the necessary symlink:
   ```bash
   # Edit install.sh to add:
   ln -sf $HOME/dotfiles/tmux/tmux.conf $HOME/.tmux.conf
   ```

3. **Commit and push these changes**:
   ```bash
   cd ~/dotfiles
   git add .
   git commit -m "[tmux] Add tmux configuration"
   git push
   ```

## Managing Secrets

For secret environment variables stored in your `secrets/env.zsh` file:

1. **Edit your secrets file directly**:
   ```bash
   vim ~/dotfiles/zsh/secrets/env.zsh
   ```

2. **Source to apply changes**:
   ```bash
   source ~/.zshrc
   ```

3. **No need to commit** - these files are (and should remain) gitignored

## Handling Conflicts

If you've made changes on multiple machines and encounter conflicts:

1. **Pull with merge strategy**:
   ```bash
   cd ~/dotfiles
   git pull --rebase
   ```

2. **Resolve any conflicts**:
   ```bash
   # Edit the conflicting files
   vim [conflicting-file]
   
   # Mark as resolved
   git add [conflicting-file]
   
   # Continue the rebase
   git rebase --continue
   ```

3. **Push the resolved changes**:
   ```bash
   git push
   ```

## Example: Adding a New Alias

Here's a complete walkthrough of adding a new alias to your dotfiles:

### Step 1: Navigate to the appropriate aliases file

```bash
# Go to your dotfiles directory
cd ~/dotfiles

# Open the relevant aliases file
# For example, if adding a git alias:
vim zsh/aliases/git.zsh
# Or for navigation aliases:
vim zsh/aliases/navigation.zsh
```

### Step 2: Add your new alias

For example, let's add an alias to quickly navigate to your projects directory:

```bash
# Inside zsh/aliases/navigation.zsh, add:
alias proj="cd ~/projects"
```

Save and close the file.

### Step 3: Test your new alias

```bash
# Source your zshrc to apply changes without restarting your terminal
source ~/.zshrc

# Test your new alias
proj
# This should take you to your projects directory
```

### Step 4: Commit your changes to the repository

```bash
# Go to your dotfiles directory (if you're not already there)
cd ~/dotfiles

# Check what files have changed
git status

# Add your modified file
git add zsh/aliases/navigation.zsh

# Commit with a descriptive message
git commit -m "[aliases] Add proj alias for quick navigation to projects directory"
```

### Step 5: Push to your remote repository

```bash
git push
```

### Step 6: Sync to other machines (when needed)

On your other machines:

```bash
# Navigate to your dotfiles directory
cd ~/dotfiles

# Pull the latest changes
git pull

# Source your zshrc to apply the changes
source ~/.zshrc

# Test your new alias
proj
```

### Creating a New Alias File (if needed)

If you're adding aliases for a completely new category:

```bash
# Create a new file for the category
touch ~/dotfiles/zsh/aliases/new_category.zsh

# Add your aliases to this file
vim ~/dotfiles/zsh/aliases/new_category.zsh

# Ensure the main zshrc loads all files in the aliases directory
# This should already be set up in your main zshrc file
```

This workflow ensures your dotfiles stay synchronized, secure, and well-organized across all your development environments. 