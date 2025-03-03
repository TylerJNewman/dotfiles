# Frequently Asked Questions

## How does the dotfiles system work?

The dotfiles repository uses a symlink system to manage your configuration files. When you run the installation script, it creates symbolic links from your home directory to the files in your dotfiles repository.

For example, your actual `~/.zshrc` file is a symlink that points to `~/dotfiles/zsh/zshrc`. This means when your shell loads `.zshrc`, it's actually loading the file from your dotfiles repository.

## Do I need to update my `.zshrc` file directly?

No, you don't need to update your `.zshrc` file directly - that's one of the main benefits of this dotfiles organization approach!

Here's how it works behind the scenes:

### The Symlink System

1. Your actual `.zshrc` file in your home directory (~/.zshrc) is a **symlink** that points to `~/dotfiles/zsh/zshrc`.

2. When you ran the install script, it created this symlink:
   ```bash
   ln -sf $HOME/dotfiles/zsh/zshrc $HOME/.zshrc
   ```

3. This means when your shell loads `.zshrc`, it's actually loading the file from your dotfiles repository.

### The Modular Loading System

Inside your main `~/dotfiles/zsh/zshrc` file, there's code that automatically loads all the component files:

```bash
# Load all alias files
for alias_file in ${ZDOTDIR:-$HOME}/dotfiles/zsh/aliases/*.zsh; do
  source $alias_file
done

# Load all function files 
for function_file in ${ZDOTDIR:-$HOME}/dotfiles/zsh/functions/*.zsh; do
  source $function_file
done

# Other similar loading blocks for configs, etc.
```

This means:

1. When you add or modify an alias in `~/dotfiles/zsh/aliases/navigation.zsh`
2. And then run `source ~/.zshrc`
3. Your main zshrc file automatically loads all .zsh files in the aliases directory
4. Your new/modified alias becomes available immediately

## What are the benefits of this modular approach?

This modular approach gives you these benefits:
- Keep related configurations together (all git aliases in one file)
- Make changes without editing a massive monolithic .zshrc file
- Easily disable specific components by renaming files (e.g., `git.zsh` to `git.zsh.disabled`)
- Maintain organization as your configuration grows

## How do I add a new plugin to Oh-My-Zsh?

To add a new plugin to Oh-My-Zsh:

1. Edit your `~/dotfiles/zsh/zshrc` file
2. Find the `plugins=( ... )` line
3. Add the name of the plugin to the list
4. Save the file and source your zshrc:
   ```bash
   source ~/.zshrc
   ```

For custom plugins that aren't included in Oh-My-Zsh by default:

1. Clone the plugin repository to the custom plugins directory:
   ```bash
   git clone https://github.com/username/plugin-name ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/plugin-name
   ```
2. Add the plugin name to your plugins list in zshrc
3. Source your zshrc to apply the changes

## How do I update all my tools and configurations?

The dotfiles repository includes an update mechanism. Simply run:

```bash
cd ~/dotfiles
./install.sh update
```

This will:
1. Pull the latest changes from the repository
2. Update Homebrew dependencies
3. Update Oh-My-Zsh plugins
4. Update Starship to the latest version

## How do I customize my Starship prompt?

To customize your Starship prompt, edit the configuration file:

```bash
vim ~/.config/starship.toml
```

For detailed information on customizing Starship, see the [Starship Guide](../starship-guide.md).

## What if I want to add machine-specific configurations?

For machine-specific configurations that shouldn't be committed to the repository:

1. Create a `local.zsh` file in your zsh directory:
   ```bash
   touch ~/dotfiles/zsh/local.zsh
   ```

2. Add your machine-specific configurations to this file

3. Ensure your main zshrc sources this file (it should already be set up):
   ```bash
   # In zshrc
   [ -f "$HOME/dotfiles/zsh/local.zsh" ] && source "$HOME/dotfiles/zsh/local.zsh"
   ```

4. Add `local.zsh` to your `.gitignore` file to prevent it from being committed

## How do I troubleshoot issues with my dotfiles?

If you encounter issues with your dotfiles:

1. **Check for syntax errors**:
   ```bash
   zsh -n ~/.zshrc
   ```

2. **Debug by sourcing files individually**:
   ```bash
   source ~/dotfiles/zsh/aliases/git.zsh
   ```

3. **Check for conflicts between plugins or configurations**:
   ```bash
   # Temporarily disable plugins by commenting them out in zshrc
   # plugins=(git) # other plugins commented out
   ```

4. **Profile your shell startup time**:
   ```bash
   # Add to top of .zshrc
   zmodload zsh/zprof
   
   # Add to bottom of .zshrc
   zprof
   ```

5. **Check the Troubleshooting section in the README** for common issues and solutions 