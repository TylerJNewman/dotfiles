#!/usr/bin/env zsh

# Python configuration file
# Contains settings for Python development tools and environments

# Python aliases (already defined in path.zsh)
# alias python=python3
# alias pip=pip3

# UV - Python package installer and resolver
# https://github.com/astral-sh/uv

# Set UV as the default pip command if available
if command -v uv &> /dev/null; then
  # UV environment variables
  export UV_SYSTEM_PYTHON=1  # Use system Python by default
  export UV_CACHE_DIR="$HOME/.cache/uv"  # Set cache directory

  # UV aliases
  alias pip="uv pip"
  alias uvp="uv pip"
  alias uvi="uv pip install"
  alias uvid="uv pip install --dev"
  alias uvr="uv pip uninstall"
  alias uvl="uv pip list"
  alias uvs="uv pip search"
  alias uvshow="uv pip show"
  alias uvreq="uv pip freeze > requirements.txt"
  alias uvvenv="uv venv"
  alias uvcvenv="uv venv .venv && source .venv/bin/activate"
  
  # Create and activate a virtual environment
  function pyvenv() {
    local venv_name="${1:-.venv}"
    uv venv "$venv_name" && source "$venv_name/bin/activate"
  }
  
  # Install requirements.txt with UV
  function uvinstall() {
    local req_file="${1:-requirements.txt}"
    if [ -f "$req_file" ]; then
      uv pip install -r "$req_file"
    else
      echo "Error: $req_file not found"
      return 1
    fi
  }
fi

# Python virtual environment helpers
function venv() {
  local venv_name="${1:-.venv}"
  if [ -d "$venv_name" ]; then
    source "$venv_name/bin/activate"
  else
    echo "Virtual environment $venv_name not found."
    echo "Create it with: uv venv $venv_name"
    return 1
  fi
}

# Check if we're in a virtual environment
function in_venv() {
  if [ -n "$VIRTUAL_ENV" ]; then
    echo "Active virtual environment: $VIRTUAL_ENV"
    return 0
  else
    echo "No active virtual environment"
    return 1
  fi
}

# Only define deactivate alias if we're not in a virtual environment
# This prevents conflicts with the deactivate function in virtual environments
if [ -z "$VIRTUAL_ENV" ]; then
  alias deactivate="echo 'No virtual environment active'"
fi 