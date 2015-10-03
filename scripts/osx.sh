#!/bin/sh
sudo -v
echo ""
echo "Disabling system-wide resume"
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false
echo ""
echo "Disable the sudden motion sensor as itâ€™s not useful for SSDs"
sudo pmset -a sms 0
echo ""
echo "Speeding up wake from sleep to 24 hours from an hour"
# http://www.cultofmac.com/221392/quick-hack-speeds-up-retina-macbooks-wake-from-sleep-os-x-tips/
sudo pmset -a standbydelay 86400
###############################################################################
# Dock & Mission Control
###############################################################################
# Wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array
echo ""
echo "Disabling Mission Control animations and grouping windows by application"
defaults write com.apple.dock expose-animation-duration -int 0
defaults write com.apple.dock "expose-group-by-app" -bool true

echo ""
echo "Setting Dock to auto-hide and removing the auto-hiding delay"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
###############################################################################
# Finder
###############################################################################
echo ""
echo "Showing all filename extensions in Finder by default"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
echo ""
echo "Showing status bar in Finder by default"
defaults write com.apple.finder ShowStatusBar -bool true
echo ""
echo "Disabling the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
echo ""
echo "Use column view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle Clmv
echo ""
echo "Avoiding the creation of .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

###############################################################################
# Screen
###############################################################################
echo ""
echo "Requiring password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo ""
echo "Enabling subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2

echo ""
echo "Enabling HiDPI display modes (requires restart)"
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true
###############################################################################
# Keyboard
###############################################################################
echo ""
echo "Setting a blazingly fast keyboard repeat rate (ain't nobody got time fo special chars while coding!)"
defaults write NSGlobalDomain KeyRepeat -int 0
