#!/usr/bin/env bash
#
# File: test-whisper.sh
# Purpose: Test the SuperWhisper voice command to bash script converter
# Dependencies: None
# Last updated: 2024-03-06
# Author: Tyler Newman
# Description: This script demonstrates how the SuperWhisper voice command to bash script converter works
#              by simulating a voice command and showing the converted command.
#              The prompt used is defined in prompt.md and uses XML tags for clear structure.

# Set colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Example voice commands to test
EXAMPLES=(
  "list all files in the current directory and sort them by size"
  "find all JavaScript files in the projects directory that contain the word API"
  "create a new directory called test project and change into it"
  "check git status then commit all changes with the message fixed bug in authentication"
  "kill the process running on port three thousand"
  "extract the archive file data dot tar dot gz to the temp directory"
  "update homebrew and clean up unused packages"
  "copy all log files from var slash log slash apache to home slash username slash backups"
  "run python script dot py dash dash verbose and redirect output to results dot txt"
  "find all files modified in the last seven days and create a tar archive"
  "show disk usage for the current directory sorted by size"
  "list all running processes and grep for node"
)

# Function to simulate the voice command to bash script conversion
simulate_conversion() {
  local voice_command="$1"
  
  echo -e "${YELLOW}Voice Command:${NC}"
  echo "$voice_command"
  echo
  
  echo -e "${BLUE}Converting...${NC}"
  echo
  
  # Simulate processing time
  sleep 1
  
  echo -e "${GREEN}Converted Command:${NC}"
  
  # Here we would normally call the actual conversion API
  # For demonstration, we'll manually convert some examples
  
  case "$voice_command" in
    "list all files in the current directory and sort them by size")
      echo 'eza -la --sort=size'
      ;;
    "find all JavaScript files in the projects directory that contain the word API")
      echo 'fd -e js "API" ~/projects'
      ;;
    "create a new directory called test project and change into it")
      echo 'mkdir -p "test project" && cd "test project"'
      ;;
    "check git status then commit all changes with the message fixed bug in authentication")
      echo 'git status && git commit -am "Fixed bug in authentication"'
      ;;
    "kill the process running on port three thousand")
      echo 'lsof -ti :3000 | xargs kill -9'
      ;;
    "extract the archive file data dot tar dot gz to the temp directory")
      echo 'tar -xzf data.tar.gz -C /tmp'
      ;;
    "update homebrew and clean up unused packages")
      echo 'brew update && brew upgrade && brew cleanup'
      ;;
    "copy all log files from var slash log slash apache to home slash username slash backups")
      echo 'cp /var/log/apache/*.log ~/backups/'
      ;;
    "run python script dot py dash dash verbose and redirect output to results dot txt")
      echo 'python3 script.py --verbose > results.txt'
      ;;
    "find all files modified in the last seven days and create a tar archive")
      echo 'fd --changed-within 7d | tar -czvf last_week_files.tar.gz -T -'
      ;;
    "show disk usage for the current directory sorted by size")
      echo 'du -sh * | sort -hr'
      ;;
    "list all running processes and grep for node")
      echo 'ps aux | rg node'
      ;;
    *)
      # For any other command, try to generate a reasonable conversion
      # This would be handled by the actual AI model in production
      echo "No predefined conversion available for this example."
      echo "In a real implementation, the AI model would generate a custom command."
      ;;
  esac
  
  echo
}

# Main function
main() {
  echo -e "${BLUE}SuperWhisper: Voice Command to Command Converter Test${NC}"
  echo "This script demonstrates how voice commands are converted to shell commands."
  echo "The converter uses structured XML tags for clear AI communication."
  echo
  
  # If an argument is provided, use it as the voice command
  if [ $# -gt 0 ]; then
    simulate_conversion "$*"
  else
    # Otherwise, use a random example
    random_index=$((RANDOM % ${#EXAMPLES[@]}))
    simulate_conversion "${EXAMPLES[$random_index]}"
  fi
}

# Run the main function
main "$@" 