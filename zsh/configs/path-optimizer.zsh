# PATH optimizer - removes duplicate entries from PATH

# Function to remove duplicates from PATH
dedupe_path() {
  # Convert PATH to an array
  typeset -a paths
  typeset -a result
  
  # Split PATH by colon
  IFS=: read -A paths <<< "$PATH"
  
  # Loop through each path and add to result if not already there
  for path in "${paths[@]}"; do
    if [[ -n "$path" && ! " ${result[@]} " =~ " $path " ]]; then
      result+=("$path")
    fi
  done
  
  # Join the array back into a colon-separated string
  export PATH="${(j.:.)result}"
}

# Run the function to clean up PATH
dedupe_path 