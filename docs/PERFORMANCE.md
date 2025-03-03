# Shell Performance Optimizations

This document provides detailed information about the performance optimizations implemented in this dotfiles repository to improve shell startup time.

## Lazy Loading Implementation

Lazy loading is a technique that defers the initialization of a tool until it is actually needed. This significantly improves shell startup time by avoiding the loading of tools that may not be used in every session.

### How Lazy Loading Works

The lazy loading implementation works by:

1. Defining shell functions with the same names as the commands they replace
2. When a command is first invoked, the function:
   - Removes itself and any related functions
   - Loads the actual tool
   - Executes the original command with the provided arguments

### Lazy Loaded Tools

The following tools are lazy loaded:

#### NVM (Node Version Manager)

- **Implementation**: `zsh/configs/nvm-lazy.zsh`
- **Commands**: `node`, `npm`, `npx`, `yarn`, `pnpm`
- **Features**:
  - Loads NVM only when Node.js commands are used
  - Automatically detects and uses `.nvmrc` files when changing directories

#### Various Tools

- **Implementation**: `zsh/configs/lazy-tools.zsh`
- **Tools**:
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

The repository includes tools to measure and optimize shell performance:

- **Implementation**: `zsh/functions/performance.zsh`
- **Commands**:
  - `zsh-time` - Measures shell startup time
  - `zsh-profile` - Profiles zsh startup using zprof
  - `zsh-debug` - Toggles debug mode for shell startup

## Additional Optimizations

### Path Optimization

- **Implementation**: `zsh/configs/path-optimizer.zsh`
- **Features**:
  - Removes duplicate entries from PATH
  - Improves command lookup performance

### Plugin Optimization

- Removed unnecessary Oh-My-Zsh plugins
- Only load plugins that are actually needed
- Removed VSCode plugin and configuration completely

### Syntax Highlighting Optimization

- **Implementation**: Replaced `zsh-syntax-highlighting` with `fast-syntax-highlighting`
- **Features**:
  - Significantly faster syntax highlighting
  - More advanced highlighting features
  - Reduced impact on shell startup time
  - Better performance during interactive use

#### About fast-syntax-highlighting

fast-syntax-highlighting is a feature-rich syntax highlighting for Zsh that provides:

- Significantly faster performance than zsh-syntax-highlighting
- More advanced highlighting features
- Better handling of complex commands
- Theme support for customizing colors
- Highlighting of brackets, quotes, command substitutions, and more

To install fast-syntax-highlighting, run:

```bash
./bin/install-fast-syntax-highlighting.sh
```

## Testing

You can test the lazy loading implementation using the provided script:

```bash
./bin/test-lazy-loading.sh
```

This script will test the lazy loading of various tools and confirm that they are only loaded when needed.

## Benchmarks

Here are some benchmark results comparing shell startup time before and after implementing lazy loading:

| Configuration | Startup Time |
|---------------|--------------|
| Before Optimization | ~0.6 seconds |
| After Optimization | ~0.3 seconds |
| With fast-syntax-highlighting | ~0.25 seconds |
| With Docker lazy loading and VSCode removed | ~0.2 seconds |

Your results may vary depending on your system and installed tools.

## Further Optimization Ideas

1. **Use zinit or antibody** instead of Oh-My-Zsh for faster plugin loading
2. **Use zsh-defer** to defer loading of non-critical plugins
3. **Profile your specific configuration** to identify other slow-loading components 