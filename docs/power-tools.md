# Command Line Power Tools

## Most Commonly Used Tools

These are the tools you'll likely use dozens of times daily:

| Tool | Purpose | Essential Command |
|------|---------|------------------|
| **Zoxide (z)** | Smart directory jumping | `z project` - Jump to directory |
| **Ripgrep (rg)** | Fast text search | `rg pattern` - Search in files |
| **Fd** | Fast file finding | `fd pattern` - Find files/dirs |
| **FZF** | Fuzzy finder | `Ctrl+R` - Search command history |
| **Eza** | Modern file listing | `ls` - List files with icons |

---

## Complete Power Tools List

### 1. Ripgrep (rg) - Modern Search Tool
- **Why master it**: 5-10x faster than grep, with better defaults and features
- **Key commands to learn**:
  - `rg pattern` - Basic search with smart case sensitivity
  - `rgt js 'function'` - Search in specific file types (your custom function)
  - `rgr 'old' 'new' src/` - Search and replace (your custom function)
  - `rgh` - Include hidden files in search
  - `rgf` - Literal string search (no regex)

### 2. Fd - Modern File Finding
- **Why master it**: Much faster than find, with intuitive syntax and smart defaults
- **Key commands to learn**:
  - `fd pattern` - Find files/directories matching pattern
  - `fdt js` - Find files by extension (your custom function)
  - `fdr 3` - Find files modified in last 3 days (your custom function)
  - `fdd` - Find only directories
  - `fdx '\.js$' 'wc -l'` - Find and execute command on results

### 3. Zoxide (z) - Smart Directory Navigation
- **Why master it**: Eliminates the need to type long paths
- **Key commands to learn**:
  - `z project` - Jump to most frequently used directory containing "project"
  - `zi` - Interactive directory selection with fuzzy finder
  - `zl` - List frequently visited directories
  - `zrm path` - Remove a directory from the database

### 4. FZF - Fuzzy Finder
- **Why master it**: Transforms how you select files, commands, and more
- **Key commands to learn**:
  - `Ctrl+R` - Fuzzy search command history
  - `Ctrl+T` - Fuzzy find files in current directory
  - `Alt+C` - Fuzzy find and cd into subdirectories
  - `fz` - Your custom alias to find files and open in code

### 5. Eza - Modern File Listing
- **Why master it**: Better, more informative ls replacement
- **Key commands to learn**:
  - `ls` - Basic listing with icons (aliased to eza)
  - `ll` - Long listing with hidden files
  - `lg` - List with git status
  - `lss` - Sort by file size
  - `lsm` - Sort by modification time

### 6. Bat - Modern File Viewer
- **Why master it**: Syntax highlighting, line numbers, git integration
- **Key commands to learn**:
  - `cat file` - View file with syntax highlighting (aliased to bat)
  - `cath file` - Show with headers and grid
  - `catp file` - No paging
  - `bathelp command` - View command help with syntax highlighting

### 7. Git Aliases
- **Why master it**: Streamlines common git workflows
- **Key commands to learn**:
  - `gs` - Git status
  - `glog` - Pretty git log with graph
  - `gcm "message"` - Commit with message
  - `gco branch` - Checkout branch
  - `lg` - Launch lazygit (interactive git UI)

### 8. Docker/Kubernetes Shortcuts
- **Why master it**: Simplifies container management
- **Key commands to learn**:
  - `d`, `dc` - Docker and docker-compose shortcuts
  - `dps` - List running containers
  - `k`, `kg`, `kgp` - Kubernetes shortcuts
  - `lzd` - Launch lazydocker (interactive docker UI)

## Learning Strategy

1. **Start with search tools** (ripgrep and fd) - These will immediately boost productivity
2. **Then master navigation** (zoxide and fzf) - These transform how you move around
3. **Learn visualization tools** (eza and bat) - These improve how you view content
4. **Finally, learn workflow tools** (git and docker aliases) - These streamline complex tasks

Each of these tools has excellent documentation and many more features than listed here, but mastering just these few commands for each tool will dramatically improve your command line efficiency.

## Addendum: Common Flags for the `fd` Command

The `fd` command is a modern alternative to `find`. Here are the most useful flags you'll use regularly:

### Type Filters
- `-t d` or `--type directory`: Find only directories
- `-t f` or `--type file`: Find only files
- `-t l` or `--type symlink`: Find only symbolic links
- `-t x` or `--type executable`: Find only executable files

### Search Scope Control
- `-H` or `--hidden`: Include hidden files and directories
- `-I` or `--no-ignore`: Include files/directories ignored by `.gitignore`
- `-g PATTERN` or `--glob PATTERN`: Filter results using a glob pattern
- `--max-depth N`: Limit search depth to N levels

### Time Filters
- `--changed-within TIME`: Find files changed within TIME (e.g., `24h`, `2d`, `1w`)
- `--changed-before TIME`: Find files changed before TIME

### Output Control
- `-l` or `--list-details`: Show more details (similar to `ls -l`)
- `-0` or `--print0`: Separate results with null characters (for piping to `xargs`)
- `-c` or `--color always`: Always colorize output

### Execution
- `-x COMMAND` or `--exec COMMAND`: Execute a command for each search result
  - Example: `fd -t f -e js -x wc -l` (count lines in all JavaScript files)

### Common Usage Examples
```bash
# Find all JavaScript files
fd -e js

# Find all directories containing "config" in their name
fd -t d config

# Find all files modified in the last 24 hours
fd --changed-within 24h

# Find all markdown files and count their lines
fd -e md -x wc -l

# Find all empty directories
fd -t d -e "^$"

# Find all Python files and show details
fd -e py -l
```

These flags make `fd` extremely versatile for quickly finding what you need in your filesystem. 

## Addendum: Common Flags for the `rg` (Ripgrep) Command

Ripgrep is a modern search tool that's significantly faster than grep. Here are the most useful flags you'll use regularly:

### Search Control
- `-i` or `--ignore-case`: Case insensitive search
- `-s` or `--case-sensitive`: Force case sensitive search
- `-w` or `--word-regexp`: Match whole words only
- `-F` or `--fixed-strings`: Treat pattern as literal string, not regex (same as `rgf`)
- `-e PATTERN`: Specify pattern (can use multiple times for OR search)

### File Filtering
- `-t TYPE` or `--type TYPE`: Only search files of TYPE (e.g., `-t js`, `-t py`)
- `-T TYPE` or `--type-not TYPE`: Don't search files of TYPE
- `-g GLOB` or `--glob GLOB`: Include/exclude files matching glob pattern
- `--hidden`: Search hidden files and directories (same as `rgh`)
- `--no-ignore`: Don't respect `.gitignore` files

### Context Control
- `-A NUM` or `--after-context NUM`: Show NUM lines after each match
- `-B NUM` or `--before-context NUM`: Show NUM lines before each match
- `-C NUM` or `--context NUM`: Show NUM lines before and after each match

### Output Control
- `-l` or `--files-with-matches`: Only show filenames with matches
- `-c` or `--count`: Only show count of matching lines per file
- `--no-filename`: Don't show filenames
- `--no-line-number`: Don't show line numbers
- `--no-heading`: Don't group matches by file
- `-o` or `--only-matching`: Show only the matching part of the line

### Common Usage Examples
```bash
# Case insensitive search for "error" in all files
rg -i error

# Search for "function" only in JavaScript files
rg -t js function

# Search for "TODO" with 2 lines of context
rg -C 2 TODO

# Find files containing "config" in their content
rg -l config

# Count occurrences of "import" in Python files
rg -t py -c import

# Search for multiple patterns (OR search)
rg -e error -e warning -e critical

# Search for whole word "test" (not "testing" or "contest")
rg -w test

# Search for literal string "app.get()" (not as regex)
rg -F "app.get()"
```

These flags make Ripgrep an extremely powerful tool for searching through codebases and text files. 