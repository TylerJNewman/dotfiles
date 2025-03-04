#!/usr/bin/env bash

# Modern macOS System Defaults
# Inspired by Kent C. Dodds' dotfiles and mathiasbynens/dotfiles
# https://github.com/kentcdodds/dotfiles/blob/main/.macos

# Set up colors for output
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to check if a defaults setting is already set
is_default_set() {
  local domain="$1"
  local key="$2"
  local expected_value="$3"
  local current_value
  
  # Get the current value
  current_value=$(defaults read "$domain" "$key" 2>/dev/null)
  
  # Check if the current value matches the expected value
  if [ "$current_value" = "$expected_value" ]; then
    return 0  # Already set
  else
    return 1  # Not set or different
  fi
}

# Function to set a defaults value if not already set
set_default() {
  local domain="$1"
  local key="$2"
  local value="$3"
  local value_type="$4"
  
  if is_default_set "$domain" "$key" "$value"; then
    echo -e "${BLUE}✓ $domain $key is already set to $value${NC}"
  else
    echo -e "${YELLOW}Setting $domain $key to $value${NC}"
    defaults write "$domain" "$key" "$value_type" "$value"
  fi
}

# Close any open System Preferences panes to prevent them from overriding settings
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo -e "${BLUE}Setting up macOS defaults...${NC}"

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Set computer name (as done via System Preferences → Sharing)
# Uncomment and modify to set your computer name
# sudo scutil --set ComputerName "YourComputerName"
# sudo scutil --set HostName "YourHostName"
# sudo scutil --set LocalHostName "YourLocalHostName"

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Expand save panel by default
set_default NSGlobalDomain NSNavPanelExpandedStateForSaveMode true -bool
set_default NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 true -bool

# Expand print panel by default
set_default NSGlobalDomain PMPrintingExpandedStateForPrint true -bool
set_default NSGlobalDomain PMPrintingExpandedStateForPrint2 true -bool

# Save to disk (not to iCloud) by default
set_default NSGlobalDomain NSDocumentSaveNewDocumentsToCloud false -bool

# Automatically quit printer app once the print jobs complete
set_default com.apple.print.PrintingPrefs "Quit When Finished" true -bool

# Disable the "Are you sure you want to open this application?" dialog
set_default com.apple.LaunchServices LSQuarantine false -bool

# Disable automatic capitalization
set_default NSGlobalDomain NSAutomaticCapitalizationEnabled false -bool

# Disable smart dashes
set_default NSGlobalDomain NSAutomaticDashSubstitutionEnabled false -bool

# Disable automatic period substitution
set_default NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled false -bool

# Disable smart quotes
set_default NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled false -bool

# Disable auto-correct
set_default NSGlobalDomain NSAutomaticSpellingCorrectionEnabled false -bool

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Trackpad: enable tap to click for this user and for the login screen
set_default com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking true -bool
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
set_default NSGlobalDomain com.apple.mouse.tapBehavior 1 -int

# Enable three finger drag on trackpad
set_default com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag 1 -int
set_default com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag 1 -int

# Disable press-and-hold for keys in favor of key repeat
set_default NSGlobalDomain ApplePressAndHoldEnabled false -bool

# Set a blazingly fast keyboard repeat rate
set_default NSGlobalDomain KeyRepeat 1 -int
set_default NSGlobalDomain InitialKeyRepeat 10 -int

# Use scroll gesture with the Ctrl (^) modifier key to zoom
set_default com.apple.universalaccess closeViewScrollWheelToggle true -bool
set_default com.apple.universalaccess HIDScrollZoomModifierMask 262144 -int

###############################################################################
# Screen                                                                      #
###############################################################################

# Require password immediately after sleep or screen saver begins
set_default com.apple.screensaver askForPassword 1 -int
set_default com.apple.screensaver askForPasswordDelay 0 -int

# Save screenshots to the desktop
set_default com.apple.screencapture location "${HOME}/Desktop" -string

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
set_default com.apple.screencapture type "png" -string

# Enable subpixel font rendering on non-Apple LCDs
set_default NSGlobalDomain AppleFontSmoothing 1 -int

###############################################################################
# Finder                                                                      #
###############################################################################

# Set Desktop as the default location for new Finder windows
set_default com.apple.finder NewWindowTarget "PfDe" -string
set_default com.apple.finder NewWindowTargetPath "file://${HOME}/Desktop/" -string

# Show icons for hard drives, servers, and removable media on the desktop
set_default com.apple.finder ShowExternalHardDrivesOnDesktop true -bool
set_default com.apple.finder ShowHardDrivesOnDesktop false -bool
set_default com.apple.finder ShowMountedServersOnDesktop false -bool
set_default com.apple.finder ShowRemovableMediaOnDesktop true -bool

# Finder: show all filename extensions
set_default NSGlobalDomain AppleShowAllExtensions true -bool

# Finder: show status bar
set_default com.apple.finder ShowStatusBar true -bool

# Finder: show path bar
set_default com.apple.finder ShowPathbar true -bool

# Display full POSIX path as Finder window title
set_default com.apple.finder _FXShowPosixPathInTitle true -bool

# Keep folders on top when sorting by name
set_default com.apple.finder _FXSortFoldersFirst true -bool

# When performing a search, search the current folder by default
set_default com.apple.finder FXDefaultSearchScope "SCcf" -string

# Disable the warning when changing a file extension
set_default com.apple.finder FXEnableExtensionChangeWarning false -bool

# Avoid creating .DS_Store files on network or USB volumes
set_default com.apple.desktopservices DSDontWriteNetworkStores true -bool
set_default com.apple.desktopservices DSDontWriteUSBStores true -bool

# Use column view in all Finder windows by default
set_default com.apple.finder FXPreferredViewStyle "clmv" -string

# Show the ~/Library folder
if [ ! -d ~/Library ] || [ "$(ls -la ~/Library | grep -c hidden)" -gt 0 ]; then
  echo -e "${YELLOW}Showing ~/Library folder${NC}"
  chflags nohidden ~/Library
else
  echo -e "${BLUE}✓ ~/Library folder is already visible${NC}"
fi

# Show the /Volumes folder
if [ ! -d /Volumes ] || [ "$(ls -la /Volumes | grep -c hidden)" -gt 0 ]; then
  echo -e "${YELLOW}Showing /Volumes folder${NC}"
  sudo chflags nohidden /Volumes
else
  echo -e "${BLUE}✓ /Volumes folder is already visible${NC}"
fi

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# Set the icon size of Dock items to 16 pixels
set_default com.apple.dock tilesize 16 -int

# Change minimize/maximize window effect
set_default com.apple.dock mineffect "scale" -string

# Minimize windows into their application's icon
set_default com.apple.dock minimize-to-application true -bool

# Show indicator lights for open applications in the Dock
set_default com.apple.dock show-process-indicators true -bool

# Don't animate opening applications from the Dock
set_default com.apple.dock launchanim false -bool

# Speed up Mission Control animations
set_default com.apple.dock expose-animation-duration 0.1 -float

# Automatically hide and show the Dock
set_default com.apple.dock autohide true -bool

# Make Dock icons of hidden applications translucent
set_default com.apple.dock showhidden true -bool

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Privacy: don't send search queries to Apple
set_default com.apple.Safari UniversalSearchEnabled false -bool
set_default com.apple.Safari SuppressSearchSuggestions true -bool

# Press Tab to highlight each item on a web page
set_default com.apple.Safari WebKitTabToLinksPreferenceKey true -bool
set_default com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks true -bool

# Show the full URL in the address bar
set_default com.apple.Safari ShowFullURLInSmartSearchField true -bool

# Enable the Develop menu and the Web Inspector in Safari
set_default com.apple.Safari IncludeDevelopMenu true -bool
set_default com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey true -bool
set_default com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled true -bool

# Add a context menu item for showing the Web Inspector in web views
set_default NSGlobalDomain WebKitDeveloperExtras true -bool

###############################################################################
# Terminal                                                                    #
###############################################################################

# Only use UTF-8 in Terminal.app
set_default com.apple.terminal StringEncodings -array 4

# Enable Secure Keyboard Entry in Terminal.app
set_default com.apple.terminal SecureKeyboardEntry true -bool

# Disable the annoying line marks
set_default com.apple.Terminal ShowLineMarks 0 -int

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
set_default com.apple.ActivityMonitor OpenMainWindow true -bool

# Show all processes in Activity Monitor
set_default com.apple.ActivityMonitor ShowCategory 0 -int

# Sort Activity Monitor results by CPU usage
set_default com.apple.ActivityMonitor SortColumn "CPUUsage" -string
set_default com.apple.ActivityMonitor SortDirection 0 -int

###############################################################################
# TextEdit                                                                    #
###############################################################################

# Use plain text mode for new TextEdit documents
set_default com.apple.TextEdit RichText 0 -int

# Open and save files as UTF-8 in TextEdit
set_default com.apple.TextEdit PlainTextEncoding 4 -int
set_default com.apple.TextEdit PlainTextEncodingForWrite 4 -int

###############################################################################
# Google Chrome                                                               #
###############################################################################

# Disable the all too sensitive backswipe on trackpads
set_default com.google.Chrome AppleEnableSwipeNavigateWithScrolls false -bool

# Disable the all too sensitive backswipe on Magic Mouse
set_default com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls false -bool

###############################################################################
# Kill affected applications                                                  #
###############################################################################

echo -e "${YELLOW}Restarting affected applications...${NC}"
for app in "Activity Monitor" \
  "Address Book" \
  "Calendar" \
  "cfprefsd" \
  "Contacts" \
  "Dock" \
  "Finder" \
  "Google Chrome" \
  "Mail" \
  "Messages" \
  "Photos" \
  "Safari" \
  "SystemUIServer" \
  "Terminal" \
  "iCal"; do
  killall "${app}" &> /dev/null
done

echo -e "${GREEN}Done. Note that some of these changes require a logout/restart to take effect.${NC}" 