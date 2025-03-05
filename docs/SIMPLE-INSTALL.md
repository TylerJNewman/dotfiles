# Simple Installation Guide

This guide provides straightforward instructions for installing and setting up the dotfiles.

## Prerequisites

- Git
- Zsh
- A terminal that supports Nerd Fonts (optional, but recommended)

## Installation Steps

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
   ```

2. **Run the installation script**

   ```bash
   cd ~/dotfiles
   ./install.sh
   ```

3. **Restart your terminal or source your zshrc**

   ```bash
   source ~/.zshrc
   ```

## Verifying the Installation

To verify that everything is working correctly:

1. Check that your prompt appears correctly
2. Run a few aliases to make sure they work
3. Check the shell startup time:

   ```bash
   ./bin/zsh-time.sh
   ```

## Troubleshooting

If you encounter any issues:

1. Check the installation log (if available)
2. Make sure all dependencies are installed
3. Try running the installation script again
4. Check for error messages in your terminal

## Updating

To update your dotfiles:

```bash
cd ~/dotfiles
./bin/update.sh
```

## Uninstalling

To uninstall:

1. Remove any symlinks created during installation
2. Remove the dotfiles directory:

   ```bash
   rm -rf ~/dotfiles
   ```

3. Restore any backup files that were created during installation 