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