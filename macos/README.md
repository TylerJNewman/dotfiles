# macOS Configuration

This directory contains configuration files and scripts specific to macOS.

## Contents

- `Brewfile` - Defines packages to be installed via Homebrew
- `defaults.sh` - Sets macOS system defaults and preferences

## Brewfile

The `Brewfile` is used with Homebrew's bundle command to install a set of packages, applications, and fonts. To use it:

```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install everything in the Brewfile
brew bundle install --file=~/dotfiles/macos/Brewfile
```

You can edit the `Brewfile` to add or remove packages according to your needs.

## defaults.sh

The `defaults.sh` script sets various macOS system preferences and defaults to improve usability and performance. It includes settings for:

- Finder behavior and appearance
- Dock configuration
- System UI preferences
- Security settings
- Application-specific settings

To run the script:

```bash
# Review the script first to understand what changes it will make
less ~/dotfiles/macos/defaults.sh

# Run the script
~/dotfiles/macos/defaults.sh
```

**Note:** It's recommended to review the script before running it, as it makes significant changes to your macOS configuration. You may want to customize it to match your preferences.

## Adding New macOS Configuration

When adding new macOS-specific configuration:

1. For Homebrew packages, add them to the `Brewfile`
2. For system preferences, add them to the `defaults.sh` script
3. For application-specific settings, consider creating a separate script in this directory

## Best Practices

- Group related settings together in the `defaults.sh` script
- Add comments explaining what each setting does
- Test changes on a clean system when possible
- Keep the `Brewfile` organized by category (CLI tools, applications, fonts, etc.) 