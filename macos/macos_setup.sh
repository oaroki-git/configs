#!/usr/bin/env bash

# ~/.macos — https://mths.be/macos

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Disable transparency in the menu bar and elsewhere on Yosemite
defaults write com.apple.universalaccess reduceTransparency -bool true

# Set highlight color to green
#defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Disable the over-the-top focus ring animation
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

# Adjust toolbar title rollover delay
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Display ASCII control characters using caret notation in standard text views
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# Disable Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Disable the crash reporter
#defaults write com.apple.CrashReporter DialogType -string "none"

# Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true


# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Disable Notification Center and remove the menu bar icon
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Set a custom wallpaper image. `DefaultDesktop.jpg` is already a symlink, and
# all wallpapers are in `/Library/Desktop Pictures/`. The default is `Wave.jpg`.
#rm -rf ~/Library/Application Support/Dock/desktoppicture.db
#sudo rm -rf /System/Library/CoreServices/DefaultDesktop.jpg
#sudo ln -s /path/to/your/image /System/Library/CoreServices/DefaultDesktop.jpg

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
# Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true


# Show language menu in the top right corner of the boot screen
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

# Set the timezone; see `sudo systemsetup -listtimezones` for other values
#sudo systemsetup -settimezone "Europe/Brussels" > /dev/null

# Stop iTunes from responding to the keyboard media keys
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

###############################################################################
# Energy saving                                                               #
###############################################################################

# Enable lid wakeup
sudo pmset -a lidwake 1

# Restart automatically on power loss
sudo pmset -a autorestart 1

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

# Sleep the display after 15 minutes
sudo pmset -a displaysleep 15

# Disable machine sleep while charging
sudo pmset -c sleep 0

# Set machine sleep to 5 minutes on battery
sudo pmset -b sleep 5

# Set standby delay to 24 hours (default is 1 hour)
sudo pmset -a standbydelay 86400

# Never go into computer sleep mode
sudo systemsetup -setcomputersleep Off > /dev/null

# Hibernation mode
# 0: Disable hibernation (speeds up entering sleep mode)
# 3: Copy RAM to disk so the system state can still be restored in case of a
#    power failure.
# sudo pmset -a hibernatemode 0

# Remove the sleep image file to save disk space
sudo rm /private/var/vm/sleepimage
# Create a zero-byte file instead…
sudo touch /private/var/vm/sleepimage
# …and make sure it can’t be rewritten
sudo chflags uchg /private/var/vm/sleepimage

###############################################################################
# Screen                                                                      #
###############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the desktop
#defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
#defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 1

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
#defaults write com.apple.finder QuitMenuItem -bool true

# Finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
#defaults write com.apple.finder NewWindowTarget -string "PfDe"
#defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show hidden files by default
#defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
#defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Show the ~/Library folder
chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Remove Dropbox’s green checkmark icons in Finder
file=/Applications/Dropbox.app/Contents/Resources/emblem-dropbox-uptodate.icns
[ -e "${file}" ] && mv -f "${file}" "${file}.bak"

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36

# Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "scale"

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array

# Show only open applications in the Dock
defaults write com.apple.dock static-only -bool true

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Don’t group windows by application in Mission Control
# (i.e. use the old Exposé behavior instead)
defaults write com.apple.dock expose-group-by-app -bool false

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 2000
# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Disable the Launchpad gesture (pinch with thumb and three fingers)
defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

# Reset Launchpad, but keep the desktop wallpaper intact
find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete


###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Allow hitting the Backspace key to go to the previous page in history
#defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Hide Safari’s sidebar in Top Sites
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# Disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Enable continuous spellchecking
#defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true
# Disable auto-correct
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Disable AutoFill
#defaults write com.apple.Safari AutoFillFromAddressBook -bool false
#defaults write com.apple.Safari AutoFillPasswords -bool false
#defaults write com.apple.Safari AutoFillCreditCardData -bool false
#defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# Warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Disable plug-ins
#defaults write com.apple.Safari WebKitPluginsEnabled -bool false
#defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false

# Disable Java
#defaults write com.apple.Safari WebKitJavaEnabled -bool false
#defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
#defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles -bool false

# Block pop-up windows
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Enable “Do Not Track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

###############################################################################
# Time Machine                                                                #
###############################################################################

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups
hash tmutil &> /dev/null && sudo tmutil disablelocal

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Address Book, Dashboard, iCal, TextEdit, and Disk Utility                   #
###############################################################################

# Enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

###############################################################################
# Photos                                                                      #
###############################################################################

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

###############################################################################
# Things here will turn off some core features of MacOS!! be really careful!!!#
###############################################################################

## thankfully apple's naming conventions are pretty straightforward, the name tells you more or less what it does ##
## turning off many of these may cause slower time to return to nomal function after reboot ##

# these are the ones i added on top, they are much more intrusive, as you can see in the names of the agents lol
launchctl unload  -w /System/Library/LaunchAgents/com.apple.findmy.findmylocateagent.plist 2> /dev/null
launchctl unload  -w /System/Library/LaunchAgents/com.apple.iCloudNotificationAgent.plist 2> /dev/null
launchctl unload  -w /System/Library/LaunchAgents/com.apple.itunescloudd.plist 2> /dev/null
launchctl unload  -w /System/Library/LaunchAgents/com.apple.icloud.fmfd 2> /dev/null
launchctl unload  -w /System/Library/LaunchAgents/com.apple.AirPlayUIAgent.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.cloudd.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.ScreenTimeAgent.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.cloudphotod.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.spotlightknowledged.updater.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.corespotlightd 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.Spotlight 2> /dev/null

launchctl unload -w /System/Library/LaunchAgents/com.apple.geoanalyticsd.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.universalaccessd.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.universalaccesscontrol.plist 2> /dev/null

# these ones are from wyvern's optimizations, the most affecting changes are mostly some icloud stuff, siri and findmy
launchctl unload -w /System/Library/LaunchAgents/com.apple.diagnostics_agent.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.diagnosticextensionsd.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.symptomsd-diag.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.spindump_agent.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.ReportCrash.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.ReportPanic.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.sysdiagnose_agent.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.generativeexperiencesd.plist  2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.UsageTrackingAgent.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.parentalcontrols.check.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.photoanalysisd.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.financed.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.ensemble.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.ndoagent.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.icloud.searchpartyuseragent.plist  2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.assistantd.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.transparencyd.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.peopled.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.familycircled.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.familycontrols.useragent.plist  2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.familynotificationd.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.progressd.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.macos.studentd.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.routined.plist  2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.homed.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.homeenergyd.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.newsd.plist  2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.gamed.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.siriinferenced.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.corespeechd.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.siriknowledged.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.siriactionsd.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.amsengagementd.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.mediaanalysisd.plist  2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.ContextStoreAgent.plist  2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.FollowUpUI.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.followupd.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.suggestd.plist  2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.lockdownmoded.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.knowledge-agent.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.intelligenceplatformd.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.BiomeAgent.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.WiFiVelocityAgent.plist  2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.triald.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.rapportd-user.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.voicebankingd.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.accessibility.axassetsd.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.accessibility.heard.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.helpd.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.textunderstandingd.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.coreservices.useractivityd.plist 2> /dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.duetexpertd.plist 2> /dev/null


sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.ReportCrash.Root.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.ReportMemoryException.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.symptomsd-diag.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.symptomsd.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.CrashReporterSupportHelper.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.DumpPanic.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.DumpGPURestart.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.icloud.findmydeviced.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.findmymac.plist  2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.findmymacmessenger.plist  2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.spindump.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.tailspind.plist  2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.SubmitDiagInfo.plist  2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.awdd.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.rapportd.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.diagnosticd.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.aslmanager.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.triald.system.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.familycontrols.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.sysdiagnose.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.analyticsd.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.wifianalyticsd.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.wifivelocityd.plist  2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.systemstats.analysis.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.systemstats.daily.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.audioanalyticsd.plist  2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.osanalytics.osanalyticshelper.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.watchdogd.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.ocspd.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.contextstored.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.biomed.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.mobileassetd.plist  2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.PerfPowerServices.plist  2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.powerlogHelperd.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.applessdstatistics.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.icloud.searchpartyd.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.GameController.gamecontrollerd.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.dprivacyd.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.coreduetd.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.modelcatalogd.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.modelmanagerd.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.rtcreportingd.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.mediaremoted.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.nearbyd.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.sandboxd.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.aneuserd.plist  2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.aned.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.periodic-*.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.systemstats.microstackshot_periodic.plist 2> /dev/null

sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.logd.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.syslogd.plist 2> /dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.newsyslog.plist 2> /dev/null

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Activity Monitor" \
	"Address Book" \
	"Calendar" \
	"cfprefsd" \
	"Contacts" \
	"Dock" \
	"Finder" \
	"Google Chrome Canary" \
	"Google Chrome" \
	"Mail" \
	"Messages" \
	"Opera" \
	"Photos" \
	"Safari" \
	"SizeUp" \
	"Spectacle" \
	"SystemUIServer" \
	"Terminal" \
	"Transmission" \
	"Tweetbot" \
	"Twitter" \
	"iCal"; do
	killall "${app}" &> /dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
