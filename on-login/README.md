# On-Login Scripts

This directory contains scripts that run automatically when you log in to your macOS system.

## How It Works

1. Scripts in this directory are configured to run at login using macOS LaunchAgents
2. The `bin/setup-on-login.sh` script creates the necessary LaunchAgent configuration files
3. Each script is run independently when you log in

## Current Scripts

- `setup-environment.sh` - Sets up your development environment, checks for updates, and performs maintenance tasks

## Adding New Login Scripts

To add a new script that runs at login:

1. Create a new `.sh` file in this directory
2. Make it executable: `chmod +x your-script.sh`
3. Run `bin/setup-on-login.sh` to create the LaunchAgent for your new script

## Best Practices

- Keep login scripts focused on a single purpose
- Add clear comments explaining what the script does
- Use the standard header format for consistency:

```bash
#!/usr/bin/env bash
#
# File: script-name.sh
# Purpose: Brief description of what this script does
# Dependencies: List any dependencies
# Last updated: YYYY-MM-DD
# Author: Your Name
```

- Add error handling to prevent login issues
- Keep scripts lightweight to avoid slowing down login
- Use the standard color variables for consistent output:

```bash
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color
``` 