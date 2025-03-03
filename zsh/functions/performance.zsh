# Shell performance measurement functions

# Function to measure shell startup time
measure_startup_time() {
  local start_time=$(date +%s.%N)
  zsh -i -c exit
  local end_time=$(date +%s.%N)
  local elapsed=$(echo "$end_time - $start_time" | bc)
  printf "Shell startup time: %.3f seconds\n" $elapsed
}

# Function to profile zsh startup
profile_zsh_startup() {
  # Create a temporary file
  local tmpfile=$(mktemp)
  
  # Run zsh with profiling enabled
  ZPROF_ENABLED=1 zsh -i -c "
  # Load zprof module
  zmodload zsh/zprof
  # Exit immediately
  exit
  " 2>/dev/null
  
  # Display results
  echo "Top 20 slowest operations during shell startup:"
  zprof | head -n 20
}

# Function to toggle debug mode for shell startup
toggle_startup_debug() {
  if [[ -f ~/.zshrc.debug ]]; then
    rm ~/.zshrc.debug
    echo "Shell startup debug mode disabled"
  else
    touch ~/.zshrc.debug
    echo "Shell startup debug mode enabled"
    echo "Add this to the top of your ~/.zshrc file to see timing information:"
    echo 'if [[ -f ~/.zshrc.debug ]]; then'
    echo '  zmodload zsh/datetime'
    echo '  setopt PROMPT_SUBST'
    echo '  PS4="+\$EPOCHREALTIME \${(l:${(#)EPOCHREALTIME}::0:):-} %N:%i> "'
    echo '  exec 3>&2 2>~/zsh_startup.log'
    echo '  setopt XTRACE'
    echo '  trap "unsetopt XTRACE; exec 2>&3" EXIT'
    echo 'fi'
  fi
}

# Alias for convenience
alias zsh-time='measure_startup_time'
alias zsh-profile='profile_zsh_startup'
alias zsh-debug='toggle_startup_debug' 