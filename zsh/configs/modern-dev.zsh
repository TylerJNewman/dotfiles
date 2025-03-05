# Modern Development Environment Configuration

# Rust-based CLI replacements
if command -v bat &> /dev/null; then
  # Enhanced bat configuration
  export BAT_THEME="Dracula"
  export BAT_STYLE="plain"
  
  # Basic bat aliases
  alias cat="bat --style=plain"
  alias cath="bat --style=header,grid"
  alias catp="bat --style=plain --paging=never"
  alias catl="bat --style=numbers,grid"
  
  # Use bat for man pages with syntax highlighting
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  
  # Use bat for help pages
  alias bathelp='bat --plain --language=help'
  help() {
    "$@" --help 2>&1 | bathelp
  }
  
  # Preview files with bat in fzf
  export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
fi

# First try eza (maintained fork of exa), then fall back to exa if available
if command -v eza &> /dev/null; then
  # Enhanced eza configuration with icons and git integration
  alias ls="eza --group-directories-first"
  alias l="eza -la --group-directories-first --icons"
  alias ll="eza -l --group-directories-first --icons"
  alias la="eza -a --group-directories-first --icons"
  alias lt="eza -T --level=2 --icons"
  alias llt="eza -lT --level=3 --icons"
  alias lg="eza -la --group-directories-first --git --icons"
  alias llg="eza -l --group-directories-first --git --icons"
  
  # Sort by various attributes
  alias lss="eza -la --sort=size --icons"
  alias lsm="eza -la --sort=modified --icons"
  
  # Grid view
  alias lsg="eza -a --grid --icons"
elif command -v exa &> /dev/null; then
  # Fall back to exa if eza is not available
  alias ls="exa --group-directories-first"
  alias l="exa -la --group-directories-first"
  alias ll="exa -l --group-directories-first"
  alias la="exa -a --group-directories-first"
  alias lt="exa -la --tree --level=2"
  alias llt="exa -la --tree --level=3"
else
  # Fall back to standard ls with colors if neither eza nor exa is available
  alias ls="ls -G"  # Colorized output on macOS
  alias l="ls -la"
  alias ll="ls -l"
  alias la="ls -a"
fi

if command -v fd &> /dev/null; then
  alias find="fd"
fi

if command -v rg &> /dev/null; then
  alias grep="rg"
fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
  alias cd="z"
fi

if command -v delta &> /dev/null; then
  export GIT_PAGER="delta"
fi

# Modern package managers
if command -v pnpm &> /dev/null; then
  alias pn="pnpm"
  alias pni="pnpm install"
  alias pna="pnpm add"
  alias pnr="pnpm remove"
  alias pnx="pnpm exec"
  alias pnd="pnpm dev"
  alias pnb="pnpm build"
  alias pnt="pnpm test"
fi

if command -v bun &> /dev/null; then
  alias b="bun"
  alias bi="bun install"
  alias ba="bun add"
  alias br="bun remove"
  alias bx="bun x"
  alias bd="bun dev"
  alias bb="bun build"
  alias bt="bun test"
fi

# Turborepo
if command -v turbo &> /dev/null; then
  alias tb="turbo build"
  alias td="turbo dev"
  alias tt="turbo test"
  alias tl="turbo lint"
fi

# Modern container tools
if command -v podman &> /dev/null; then
  alias docker="podman"
fi

if command -v lazydocker &> /dev/null; then
  alias lzd="lazydocker"
fi

# Database tools
if command -v pgcli &> /dev/null; then
  alias psql="pgcli"
fi

if command -v mycli &> /dev/null; then
  alias mysql="mycli"
fi

# Git enhancements
if type lazygit &> /dev/null; then
  alias lg="lazygit"
fi

# Terminal multiplexer
if command -v zellij &> /dev/null; then
  alias zj="zellij"
  alias zja="zellij attach"
  alias zjl="zellij list-sessions"
fi 