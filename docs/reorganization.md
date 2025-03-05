# Dotfiles Reorganization

This document summarizes the reorganization of the dotfiles repository to improve its structure and maintainability.

## Directory Structure Changes

The repository has been reorganized to follow a more logical structure:

```
~/dotfiles/
├── bin/               # Utility scripts
│   ├── cleanup.sh
│   ├── check-duplicates.sh
│   ├── install-git-hooks.sh
│   ├── lint-scripts.sh
│   ├── measure-startup-time.sh
│   ├── setup-links.sh
│   ├── setup-on-login.sh
│   ├── test-paths.sh
│   ├── update.sh
│   └── zsh-time.sh
├── config/            # Configuration files
│   ├── ripgrep/
│   │   └── ripgreprc
│   └── starship/
│       └── starship.toml
├── docs/              # Documentation
│   ├── SIMPLE-INSTALL.md
│   └── reorganization.md
├── git/               # Git configuration
│   ├── gitconfig
│   ├── gitconfig.local
│   ├── gitignore_global
│   └── hooks/
├── macos/             # macOS-specific files
│   ├── Brewfile
│   └── defaults.sh
├── on-login/          # Scripts to run on login
├── zsh/               # ZSH configuration
│   ├── aliases.zsh
│   ├── configs/
│   ├── functions.zsh
│   ├── prompt.zsh
│   ├── secrets/
│   └── zshrc
├── .cursorrules       # Cursor editor rules
├── .editorconfig      # Editor configuration
├── .gitignore         # Git ignore rules
├── install.sh         # Installation script
└── README.md          # Main documentation
```

## File Relocations

The following files have been moved to more appropriate directories:

1. `Brewfile` → `macos/Brewfile`
2. `starship.toml` → `config/starship/starship.toml`
3. `ripgreprc` → `config/ripgrep/ripgreprc`
4. `setup-links.sh` → `bin/setup-links.sh`
5. `setup-on-login.sh` → `bin/setup-on-login.sh`
6. `dotfiles-improvements.md` → `docs/dotfiles-improvements.md`

## File Updates

The following files have been updated to reference the new locations:

1. `install.sh`:
   - Updated to reference the new Brewfile location (`macos/Brewfile`)
   - Updated to reference the new starship.toml location (`config/starship/starship.toml`)
   - Added a call to `bin/setup-links.sh` to create additional symlinks

2. `bin/setup-links.sh`:
   - Updated to reference the new ripgreprc location (`config/ripgrep/ripgreprc`)
   - Fixed the DOTFILES_DIR path to account for it being in the bin directory
   - Updated to reference the new setup-on-login.sh location (`bin/setup-on-login.sh`)

3. `bin/cleanup.sh`:
   - Updated to reference the new setup-links.sh and setup-on-login.sh locations

4. `bin/setup-on-login.sh`:
   - Updated the DOTFILES_DIR path to account for it being in the bin directory

## Benefits of Reorganization

This reorganization provides several benefits:

1. **Cleaner Root Directory**: The root directory is now less cluttered, making it easier to find important files.

2. **Better Organization**: Files are now grouped by purpose, making it easier to find and manage related files.

3. **Easier Maintenance**: With a more logical structure, it's easier to maintain and update the repository.

4. **Improved Discoverability**: New users can more easily understand the repository structure.

5. **Standard Practices**: The new structure follows common practices for organizing dotfiles repositories.

## Testing

A test script (`bin/test-paths.sh`) has been created to verify that the directory paths are correct. This script checks if the directories and files exist in their expected locations.

## Next Steps

1. **Update Documentation**: Update the README.md and other documentation to reflect the new structure.

2. **Test Installation**: Test the installation process to ensure it works with the new structure.

3. **Consider Further Improvements**: Consider additional improvements to the repository structure and organization. 

## Documentation Updates

The following documentation files have been updated to reflect the new file locations:

1. `README.md`:
   - Updated the directory structure section
   - Updated the installation instructions to reference the new Brewfile location
   - Updated the Starship configuration section to reference the new location

2. `docs/dotfiles-improvements.md`:
   - Updated references to ripgreprc to reflect its new location

3. `docs/guides/starship-guide.md`:
   - Updated all references to starship.toml to reflect its new location
   - Updated command examples to use the new path

4. `docs/guides/faq.md`:
   - Updated references to starship.toml to reflect its new location

5. `zsh/zshrc`:
   - Updated the RIPGREP_CONFIG_PATH to reference the new location of ripgreprc 