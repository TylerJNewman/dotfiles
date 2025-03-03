# Modern Development Environment Configuration

# Rust-based CLI replacements
if command -v bat &> /dev/null; then
  alias cat="bat --style=plain"
  alias cath="bat --style=header,grid"
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

if command -v exa &> /dev/null; then
  alias ls="exa"
  alias l="exa -la"
  alias ll="exa -l"
  alias lt="exa -la --tree --level=2"
  alias llt="exa -la --tree --level=3"
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
if command -v lazygit &> /dev/null; then
  alias lg="lazygit"
fi

# Terminal multiplexer
if command -v zellij &> /dev/null; then
  alias zj="zellij"
  alias zja="zellij attach"
  alias zjl="zellij list-sessions"
fi 