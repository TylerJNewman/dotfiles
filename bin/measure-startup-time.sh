#!/bin/bash
#
# File: measure-startup-time.sh
# Purpose: Measures zsh startup time
# Dependencies: zsh
# Last updated: 2024-03-05
# Author: Tyler Newman
# Usage: ./bin/measure-startup-time.sh [iterations]
# Description: This script measures the startup time of zsh with the current
#              configuration. It runs multiple iterations and calculates the
#              average startup time.

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Default number of iterations
ITERATIONS=${1:-5}

echo -e "${BLUE}Measuring zsh startup time (${ITERATIONS} iterations)...${NC}"

# Initialize variables
total_time=0
min_time=9999
max_time=0

# Run the test multiple times
for i in $(seq 1 $ITERATIONS); do
  echo -e "${BLUE}Iteration $i/${ITERATIONS}${NC}"
  
  # Measure the time it takes to start zsh and exit
  start_time=$(date +%s.%N)
  zsh -i -c exit
  end_time=$(date +%s.%N)
  
  # Calculate the elapsed time
  elapsed=$(echo "$end_time - $start_time" | bc)
  elapsed_ms=$(echo "$elapsed * 1000" | bc | awk '{printf "%.2f", $0}')
  
  echo -e "  Time: ${YELLOW}${elapsed_ms}ms${NC}"
  
  # Update total time
  total_time=$(echo "$total_time + $elapsed" | bc)
  
  # Update min and max times
  min_time=$(echo "$elapsed < $min_time" | bc -l)
  if [ "$min_time" -eq 1 ]; then
    min_time=$elapsed
  fi
  
  max_time=$(echo "$elapsed > $max_time" | bc -l)
  if [ "$max_time" -eq 1 ]; then
    max_time=$elapsed
  fi
done

# Calculate average time
average=$(echo "scale=6; $total_time / $ITERATIONS" | bc)
average_ms=$(echo "$average * 1000" | bc | awk '{printf "%.2f", $0}')
min_ms=$(echo "$min_time * 1000" | bc | awk '{printf "%.2f", $0}')
max_ms=$(echo "$max_time * 1000" | bc | awk '{printf "%.2f", $0}')

# Print results
echo -e "\n${GREEN}Results:${NC}"
echo -e "  Average startup time: ${GREEN}${average_ms}ms${NC}"
echo -e "  Minimum startup time: ${GREEN}${min_ms}ms${NC}"
echo -e "  Maximum startup time: ${GREEN}${max_ms}ms${NC}"

# Provide recommendations based on startup time
if (( $(echo "$average > 0.5" | bc -l) )); then
  echo -e "\n${YELLOW}Your shell startup time is quite high (>500ms).${NC}"
  echo -e "${YELLOW}Consider optimizing your configuration:${NC}"
  echo -e "  - Use lazy loading for heavy tools (nvm, pyenv, etc.)"
  echo -e "  - Profile your zshrc with 'zprof' (add 'zmodload zsh/zprof' at the top and 'zprof' at the bottom of your zshrc)"
  echo -e "  - Consider using zinit's turbo mode for plugin loading"
  echo -e "  - Run ./bin/optimize-shell.sh for automatic optimizations"
elif (( $(echo "$average > 0.2" | bc -l) )); then
  echo -e "\n${YELLOW}Your shell startup time is acceptable but could be improved.${NC}"
  echo -e "${YELLOW}Consider minor optimizations if needed.${NC}"
else
  echo -e "\n${GREEN}Your shell startup time is excellent!${NC}"
fi

exit 0 