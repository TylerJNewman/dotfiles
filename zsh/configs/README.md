# ZSH Configuration Files

This directory contains modular ZSH configuration files that are loaded by the main `.zshrc` file.

## Simplified Structure

To improve maintainability and readability, we've organized the configuration files into these categories:

1. **Core Settings**
   - `path.zsh` - PATH and environment variable configuration
   - `theme.zsh` - Terminal appearance settings

2. **Tool Configuration**
   - `tools.zsh` - Basic development tool configuration
   - `dev-workflow.zsh` - Development workflow enhancements
   - `productivity.zsh` - Productivity tools and functions

3. **Performance Optimization**
   - `lazy-tools.zsh` - Lazy loading for better shell startup time
   - `nvm-lazy.zsh` - Optimized Node.js version manager loading

## Adding New Configurations

When adding new configurations:

1. Decide which category your configuration belongs to
2. If it fits in an existing file, add it there
3. If it needs a new file, follow the naming convention: `purpose.zsh`
4. Add a clear header comment explaining the file's purpose
5. Group related settings together with section comments

## Best Practices

- Keep files small and focused on a single purpose
- Use comments to explain non-obvious configurations
- Avoid duplicating functionality across files
- Test changes to ensure they don't slow down shell startup
- Run `bin/measure-startup-time.sh` to check performance impact

## Avoiding Alias Conflicts

When defining functions, be careful about conflicts with existing aliases:

1. **Check for existing aliases** before defining a function with the same name
   ```bash
   # Bad: Will cause errors if 'kl' is already an alias
   kl() {
     kubectl logs -f "$1"
   }
   
   # Good: Use a different name to avoid conflicts
   kube_logs() {
     kubectl logs -f "$1"
   }
   ```

2. **Use the `command` prefix** when calling commands that might be aliased
   ```bash
   # Bad: Will cause errors if 'git' is aliased
   function branch_checkout() {
     git checkout "$1"
   }
   
   # Good: Use 'command' to bypass aliases
   function branch_checkout() {
     command git checkout "$1"
   }
   ```

3. **Use the explicit `function` keyword** for function definitions
   ```bash
   # Good: Explicit function declaration
   function my_function() {
     # function body
   }
   ```

## Loading Order

Files are loaded in alphabetical order by the main `.zshrc` file. If you need to control loading order, prefix filenames with numbers (e.g., `01-path.zsh`, `02-theme.zsh`).

## Lazy Loading Implementation

The following tools are now lazy loaded:

1. **NVM (Node Version Manager)** - Implemented in `nvm-lazy.zsh`
   - Loads NVM only when `node`, `npm`, `npx`, `yarn`, or `pnpm` commands are used
   - Automatically detects and uses `.nvmrc` files when changing directories

2. **Various Tools** - Implemented in `lazy-tools.zsh`
   - **Zoxide** - Loads only when `z` or `zi` commands are used
   - **GitHub Copilot** - Loads only when `gh-copilot` command is used
   - **Atuin** - Loads only when `atuin` command is used or Ctrl+R is pressed
   - **Google Cloud SDK** - Loads only when `gcloud`, `gsutil`, or `bq` commands are used
   - **Deno** - Loads only when `deno` command is used
   - **Bun** - Loads only when `bun` or `bunx` commands are used
   - **FZF** - Loads only when `fzf` command is used
   - **Docker** - Loads only when `docker` command is used
   - **Docker Compose** - Loads only when `docker-compose` command is used

## Performance Measurement

Performance measurement tools are available in `../functions/performance.zsh`:

- `zsh-time` - Measures shell startup time
- `zsh-profile` - Profiles zsh startup using zprof
- `zsh-debug` - Toggles debug mode for shell startup

## Fast Syntax Highlighting

This configuration uses `fast-syntax-highlighting` instead of the standard `zsh-syntax-highlighting` for significantly improved performance:

- Up to 50x faster than standard syntax highlighting
- More advanced highlighting features
- Reduced impact on shell startup time
- Better performance during interactive use

### Installation

To install fast-syntax-highlighting, run:

```bash
./bin/install-fast-syntax-highlighting.sh
```

This will:
1. Back up your existing zsh-syntax-highlighting installation
2. Clone the fast-syntax-highlighting repository
3. Update your zshrc to use fast-syntax-highlighting

## How Lazy Loading Works

Lazy loading works by defining shell functions with the same names as the commands they replace. When a command is first invoked, the function:

1. Removes itself and any related functions
2. Loads the actual tool
3. Executes the original command with the provided arguments

This approach significantly improves shell startup time by deferring the loading of tools until they are actually needed.

## Customization

To add lazy loading for additional tools, follow the pattern in `lazy-tools.zsh`. The general approach is:

```zsh
# Lazy load example-tool
if command -v example-tool &> /dev/null; then
  function __example_tool_load() {
    unfunction example-tool related-command
    # Load the tool
    eval "$(example-tool init)"
  }
  
  function example-tool() {
    __example_tool_load
    example-tool "$@"
  }
  
  function related-command() {
    __example_tool_load
    related-command "$@"
  }
fi
``` 