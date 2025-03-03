# General utility functions

# Create a new React app from template
function crapp { cp -R ~/.crapp "$@"; }

# Create a new React app from mobile template
function mcrapp { cp -R ~/.mcrapp "$@"; }

# Enable thefuck command correction
eval $(thefuck --alias)
