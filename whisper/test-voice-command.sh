#!/usr/bin/env bash
#
# File: test-voice-command.sh
# Purpose: Test the voice command to bash script converter
# Dependencies: None
# Last updated: 2024-03-06
# Author: Tyler Newman
# Description: This script demonstrates how the voice command to bash script converter works
#              by simulating a voice command and showing the converted bash script.

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
  "update the system and clean up unused packages"
  "clone the get repository at github dot com slash user slash repo and install dependencies"
  "find all Python files in the projects directory modified in the last week and copy them to a backup folder"
  "check the weather in San Francisco then send an email to john at example dot com with the forecast"
  "run the Docker container called web app on port eighty and mount the current directory as slash app"
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
  
  echo -e "${GREEN}Converted Bash Script:${NC}"
  
  # Here we would normally call the actual conversion API
  # For demonstration, we'll manually convert some examples
  
  case "$voice_command" in
    "list all files in the current directory and sort them by size")
      echo '```bash
ls -la --sort=size
```'
      ;;
    "find all JavaScript files in the projects directory that contain the word API")
      echo '```bash
cd ~/projects && rg "API" --type js
```'
      ;;
    "create a new directory called test project and change into it")
      echo '```bash
mkd "test project"
```'
      ;;
    "check git status then commit all changes with the message fixed bug in authentication")
      echo '```bash
gs && gcam "Fixed bug in authentication"
```'
      ;;
    "kill the process running on port three thousand")
      echo '```bash
killport 3000
```'
      ;;
    "extract the archive file data dot tar dot gz to the temp directory")
      echo '```bash
extract data.tar.gz /tmp
```'
      ;;
    "update the system and clean up unused packages")
      echo '```bash
update
```'
      ;;
    "clone the get repository at github dot com slash user slash repo and install dependencies")
      echo '```bash
git clone https://github.com/user/repo && cd repo && ni
```'
      ;;
    "find all Python files in the projects directory modified in the last week and copy them to a backup folder")
      echo '```bash
cd ~/projects && fd -e py -t f --changed-within 1w -x cp {} ~/backup/
```'
      ;;
    "check the weather in San Francisco then send an email to john at example dot com with the forecast")
      echo '```bash
get_weather "San Francisco" > /tmp/forecast.txt && mail -s "Weather Forecast" john@example.com < /tmp/forecast.txt
```'
      ;;
    "run the Docker container called web app on port eighty and mount the current directory as slash app")
      echo '```bash
d run -p 80:80 -v "$(pwd):/app" web-app
```'
      ;;
    *)
      # For any other command, try to generate a reasonable conversion
      # This would be handled by the actual AI model in production
      echo "No predefined conversion available for this example."
      echo "In a real implementation, the AI model would generate a custom script."
      ;;
  esac
  
  echo
}

# Main function
main() {
  echo -e "${BLUE}Voice Command to Bash Script Converter Test${NC}"
  echo "This script demonstrates how voice commands are converted to bash scripts."
  echo "The converter is customized for your dotfiles environment."
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