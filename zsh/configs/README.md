# ZSH Lazy Loading

This directory contains configuration files for ZSH, including lazy loading implementations for various tools to improve shell startup time.

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