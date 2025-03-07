# ZSH Configuration

This directory contains ZSH shell configuration files and scripts.

## Main Files

- `zshrc` - Main ZSH configuration file (symlinked to `~/.zshrc`)
- `aliases.zsh` - Shell aliases for common commands
- `functions.zsh` - Custom shell functions
- `prompt.zsh` - Prompt configuration (using Starship)
- `local.zsh` - Machine-specific configuration (not committed)

## Directories

- `aliases/` - Modular alias files organized by category
- `functions/` - Modular function files organized by category
- `configs/` - Configuration files for specific tools and workflows
- `path.zsh` - Centralized PATH management (see [PATH Management](#path-management) below)
- `secrets/` - Secret environment variables and tokens (not committed)

## Loading Order

Files are loaded in the following order:

1. `zshrc` - Main configuration file
2. All `.zsh` files in the `zsh` directory
3. All `.zsh` files in subdirectories

## PATH Management

Our PATH management follows a minimalist approach in `configs/path.zsh`:

1. Simple, direct PATH modifications with clear organization
2. Automatic deduplication with `typeset -U PATH`
3. Fast node_modules resolution (8 levels deep)
4. Tool directories defined for lazy loading

Key features:
- System and user bin directories
- Package manager paths
- Tool directories for lazy loading
- Node.js project paths
- Built-in PATH deduplication

To add a new PATH entry:
1. Edit `configs/path.zsh`
2. Add your entry in the appropriate section
3. No need to worry about duplicates - they're automatically removed

## Customization

### Adding Aliases

To add new aliases:

1. Edit `aliases.zsh` for general aliases
2. Or create/edit a file in the `aliases/` directory for category-specific aliases

### Adding Functions

To add new functions:

1. Edit `functions.zsh` for general functions
2. Or create/edit a file in the `functions/` directory for category-specific functions

### Machine-Specific Configuration

For machine-specific settings:

1. Edit `local.zsh` (this file is not committed to the repository)
2. Or create files in the `secrets/` directory (these files are not committed)

## Common Issues and Solutions

### Alias Conflicts with Functions

If you see errors like `defining function based on alias` or `parse error near '()'`, you likely have a function name that conflicts with an existing alias:

```bash
# This will cause an error if 'kl' is already an alias
kl() {
  kubectl logs -f "$1"
}
```

To fix this:

1. **Use a different function name** that doesn't conflict with any aliases
   ```bash
   kube_logs() {
     kubectl logs -f "$1"
   }
   ```

2. **Use the `command` prefix** when calling commands that might be aliased
   ```bash
   function git_checkout() {
     command git checkout "$1"
   }
   ```

3. **Use the explicit `function` keyword** for function definitions
   ```bash
   function my_function() {
     # function body
   }
   ```

## Best Practices

- Keep related functionality together
- Use descriptive names for functions and aliases
- Add comments explaining complex functions
- Test changes before committing
- Avoid hardcoding paths or machine-specific details in shared files
- Use the modular system to organize code by purpose

## Performance Considerations

- Avoid slow operations in the main `zshrc` file
- Use lazy loading for heavy tools (see `configs/lazy-tools.zsh`)
- Run `bin/measure-startup-time.sh` to check the impact of changes
- Consider using `bin/optimize-shell.sh` for performance improvements 