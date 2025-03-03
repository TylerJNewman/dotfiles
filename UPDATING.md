# Updating Your Dotfiles Repository

When you make changes to your dotfiles, here's the workflow to update your repository and keep everything in sync:

## Regular Updates

1. **Edit the appropriate files**:
   ```bash
   # Example: Edit your git aliases
   vim ~/dotfiles/zsh/aliases/git.zsh
   
   # Or add a new function
   vim ~/dotfiles/zsh/functions/general.zsh
   ```

2. **Test your changes**:
   ```bash
   # Source your updated zshrc to test changes without restarting your terminal
   source ~/.zshrc
   ```

3. **Commit your changes**:
   ```bash
   cd ~/dotfiles
   git add .
   git commit -m "[zsh/aliases] Add new git shortcut for stashing"
   ```

4. **Push to your remote repository** (if you're using one):
   ```bash
   git push
   ```

## Syncing Across Multiple Machines

When you want to update another machine with your latest dotfiles:

1. **Pull the latest changes**:
   ```bash
   cd ~/dotfiles
   git pull
   ```

2. **Run the install script** (to create any new symlinks):
   ```bash
   ./install.sh
   ```

3. **Source your updated configuration**:
   ```bash
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

## Managing Secret Changes

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

## Handling Conflicting Changes

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

This workflow ensures your dotfiles stay synchronized, secure, and well-organized across all your development environments.